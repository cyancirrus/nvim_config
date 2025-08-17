syntax on

set number relativenumber
call plug#begin()
	" *** Theme  ***
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	" *** Syntax Parser ***
	Plug 'google/vim-jsonnet'
	Plug 'dense-analysis/ale'
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'tpope/vim-commentary'
	Plug 'neovim/nvim-lspconfig'
	" Collection of common configurations for the Nvim LSP client
	Plug 'neovim/nvim-lspconfig'
	" Visualize lsp progress
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	" *** Homebrew External Depends ***	
	Plug 'BurntSushi/ripgrep'
	Plug 'sharkdp/fd'
	" Plug 'nvim-tree/nvim-web-devicons'
	" Plug 'nvim-tree/nvim-tree.lua'
	" *** Quick Menu ***
	" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
	" Folding for python language
	Plug 'Konfekt/FastFold'
	Plug 'tmhedberg/SimpylFold'
	" Filesystem lovlies
	Plug 'tpope/vim-eunuch'
	" Surround visual block
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	" Plug 'nvim-lsp-inlayhints'
	" Plug 'mrcjkb/rustaceanvim'
call plug#end()

lua require("init")
exec 'source ~/.config/nvim/vim_script/options.vim'
