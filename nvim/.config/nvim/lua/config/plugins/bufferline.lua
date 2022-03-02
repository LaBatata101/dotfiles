local ok, bufferline = pcall(require, "bufferline")

if not ok then
  return
end

bufferline.setup({
  options = {
    separator_style = "slant",
    diagnostics = "nvim_lsp",

    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      -- local icon = level:match("error") and "" or " "
      -- return " " .. icon .. count
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or " ")
        s = s .. n .. sym
      end
      return s
    end,

    offsets = {
      { filetype = "NvimTree", text = "File Explorer", highlight = "Directory" },
      { filetype = "Outline", text = "LSP Symbols", highlight = "Directory" },
      { filetype = "toggleterm", text = "Terminal", highlight = "Directory" },
    },
  },
})
