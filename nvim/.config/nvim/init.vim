let $CFG_DIR = stdpath("config")

source $CFG_DIR/general.vim
source $CFG_DIR/keysbinding.vim

source $CFG_DIR/plugins/plugins.vim

" Improve startup speed
lua require('impatient')

source $CFG_DIR/plugins/configs/lsp.vim
source $CFG_DIR/plugins/configs/lualine.vim
source $CFG_DIR/plugins/configs/nvim_cmp.vim
source $CFG_DIR/plugins/configs/telescope.vim
source $CFG_DIR/plugins/configs/neoscroll.vim
source $CFG_DIR/plugins/configs/bufferline.vim
source $CFG_DIR/plugins/configs/tokyonight.vim
source $CFG_DIR/plugins/configs/lsp_installer.vim
source $CFG_DIR/plugins/configs/lsp_signature.vim
source $CFG_DIR/plugins/configs/nvim_autopairs.vim
source $CFG_DIR/plugins/configs/nvim_lightbulb.vim
source $CFG_DIR/plugins/configs/indent_blankline.vim
source $CFG_DIR/plugins/configs/trouble.vim
source $CFG_DIR/plugins/configs/hop.vim
source $CFG_DIR/plugins/configs/treesitter.vim
source $CFG_DIR/plugins/configs/illuminate.vim
source $CFG_DIR/plugins/configs/comment.vim
