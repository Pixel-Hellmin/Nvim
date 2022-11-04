syntax on
filetype on

set path+=**
set guicursor=
set wildmenu
set wildignore+=*/node_modules/*
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noerrorbells
set nowrap
set incsearch
set nohlsearch
set signcolumn=yes
set colorcolumn=80
set scrolloff=8
set relativenumber
set nu
set nohlsearch
set hidden
set undodir=~/.vim/undodir
set undofile
set clipboard+=unnamedplus
set cmdheight=2
set t_Co=256
set cursorline
set splitbelow

" :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

" Themes
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'

" Config for native LSP
Plug 'neovim/nvim-lspconfig'

" LSP autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

"set termguicolors     " enable true colors support
"let ayucolor="mirage"
"colorscheme ayu

"let tokyonight_style="storm"
"colorscheme tokyonight

" to use fzf with telescope for better performance
"require('telescope').load_extension('fzf')

:let mapleader = "\<Space>"
:map <Leader><F4> :term devenv build\main.exe<CR>
:map <Leader><F5> :term code\build<CR>
:map <F4> :! devenv w:\build\win32_handmade.exe<CR>
:map <F5> :9sp term://w:\handmade\code\build<CR>
:map <F8> :!py %<CR>
:map <F9> :vsplit term://python %<CR>
:map <F12> :e ~/AppData/Local/nvim/init.vim<CR>
:map <Leader>j :b#<CR>
:map <Leader>q :b#\|bd #\|q<CR>
:map <Leader>pv :Ex<CR>
:map <Leader>t :102vs<CR>
" :map <leader>nf <cmd>:e %:h\\<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua require('lsp')
