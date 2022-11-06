vim.cmd([[
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
]])
