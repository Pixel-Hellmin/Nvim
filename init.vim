lua require'settings'

" :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

" Themes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'EdenEast/nightfox.nvim'

" Config for native LSP
Plug 'neovim/nvim-lspconfig'

" LSP autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Smooth scrolling
Plug 'karb94/neoscroll.nvim'

" LuaLine
Plug 'nvim-lualine/lualine.nvim'
" For icons in lualine, installing nerd fonts is also necesary
Plug 'kyazdani42/nvim-web-devicons' 

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

lua require('lsp')
lua require('neoscroll').setup()
lua require('nvim-web-devicons').setup()
lua require('lualine').setup()

command! Build lua require'tools'.Build()
command! GoTo lua require'tools'.GoTo()
command! Grep lua require'tools'.Grep()
command! FindFile lua require'tools'.FindFile()
command! RunScript lua require'tools'.RunScript()

:let mapleader = "\<Space>"
:map <Leader><F4> :term devenv build\main.exe<CR>
:map <F4> :! devenv w:\build\win32_handmade.exe<CR>
:map <F5> :Build<CR>
:map <F8> :!py %<CR>
:map <F9> :vsplit term://python %<CR>
:map <F12> :e ~/AppData/Local/nvim/init.vim<CR>
:map <Leader>j :b#<CR>
:map <Leader>q :b#\|bd #\|q<CR>
:map <Leader>pv :Ex<CR>
:map <leader>fg :Grep<cr>
:map <leader>ff :FindFile<cr>
:map <leader>kj :GoTo<CR>
:map <leader>rs :RunScript<CR>
" :map <leader>nf <cmd>:e %:h\\<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
