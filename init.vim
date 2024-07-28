lua require'settings'

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-utils/vim-man'

" colorscheme
Plug 'rebelot/kanagawa.nvim'
Plug '/morhetz/gruvbox'

" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'andymass/vim-matchup'

call plug#end()

colorscheme amber

"lua require('lualine').setup()
lua require('treesitter')

command! Build lua require'tools'.Build()
command! GoTo lua require'tools'.GoTo()
command! Grep lua require'tools'.Grep()
command! RunScript lua require'tools'.RunScript()

:let mapleader = "\<Space>"
:map <F5> :silent make!\|copen<CR>
":map <F5> :Build<CR>
:map <F12> :e ~/AppData/Local/nvim/init.vim<CR>
:map <Leader>j :b#<CR>
:map <Leader>q :b#\|bd #\|q<CR>
:map <Leader>pv :Ex<CR>
:map <leader>fg :Grep<cr>
:map <leader>kj :GoTo<CR>
:map <leader>rs :RunScript<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'\' : '%%'
