require('plugins')
vim.cmd([[ so $HOME/.config/nvim/legacy.vim ]])
vim.cmd([[ colorscheme catppuccin-macchiato ]])

require('lsp')
require('cmp_config')

lsp_signature_config = {
	hint_prefix = "",
	floating_window = false
}
require "lsp_signature".setup(lsp_signature_config)

require('nvim-autopairs').setup {}

require('luasnip.loaders.from_snipmate').lazy_load()
