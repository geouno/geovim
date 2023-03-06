return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- use { 'morhetz/gruvbox', cond = function()
	-- 	return os.getenv("TERM") == "xterm-kitty"
	-- end
	-- }
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use 'sainnhe/everforest'
	use 'sainnhe/edge'
	use 'itchyny/lightline.vim'
	use 'tpope/vim-commentary'
	use 'junegunn/goyo.vim'

	use 'neovim/nvim-lspconfig'
	use 'ray-x/lsp_signature.nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	--[[use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}]]--
	use 'windwp/nvim-autopairs'
	use 'preservim/nerdtree'

	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use 'othree/html5.vim'
	use 'pangloss/vim-javascript'
	use 'evanleck/vim-svelte'
	
	use ({
		'iamcco/markdown-preview.nvim',
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		setup = function()
			vim.g.mkdp_filetypes = { 'markdown' }
		end,
		ft = { 'markdown' }
	})

	use 'dhruvasagar/vim-table-mode'
end)
