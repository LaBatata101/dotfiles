if not pcall(require, "luasnip") then
  return
end

local M = {}

local ls = require("luasnip")
local types = require("luasnip.util.types")
local fmt = require("luasnip.extras.fmt").fmt
local events = require("luasnip.util.events")

ls.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },
})

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local insert_text = false

ls.add_snippets("python", {
  s("dataclass", {
    t({ "@dataclass", "class " }),
    i(1),
    t({ ":", "\t" }),
    i(0),
    f(function(_, _, _)
      -- function nodes get executed in previews, e.g. nvim-cmp's documentation preview
      -- this code prevents the text from being inserted when the function node is executed in previews
      if insert_text then
        insert_text = false
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(0, 0, 0, true, { "from dataclasses import dataclass" })
        end)
      end

      insert_text = true
      return ""
    end, {}),
  }),

  s(
    "from",
    fmt(
      [[
  from {1} import 
  ]],
      {
        i(1),
      }
    )
  ),

  s("class", {
    t("class "),
    i(1),
    t({ ":", "\t" }),
    t({ "def __init__(self):", "\t\t" }),
    i(0),
  }),
})

ls.add_snippets("rust", {
  s("tests", { t("#[cfg(test)]"), t({ "", "mod tests {", "\t" }), i(1), t({ "", "}" }) }),
  s("test", { t({ "#[test]", "fn " }), i(1), t({ "() {", "\t" }), i(0), t({ "", "}" }) }),
})

function M.change_choice()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end

return M
