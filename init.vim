lua require('basic')
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
set cmdheight=2
set clipboard+=unnamedplus
set cmdheight=3
set t_Co=256

" :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'
Plug 'neovim/nvim-lspconfig'

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
:map <F4> :term devenv w:\build\win32_handmade.exe<CR>
:map <F5> :term w:\handmade\code\build<CR>
:map <F8> :!py %<CR>
:map <F9> :vsplit term://python %<CR>
:map <F12> :e ~/AppData/Local/nvim/init.vim<CR>
:map <Leader>j :b#<CR>
:map <Leader>pv :Ex<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" lsp for cpp, 'choco install llvm' is necesary if in windows,
" this is the language server
lua << EOF
require'lspconfig'.clangd.setup{
    on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
    end,
}
EOF
