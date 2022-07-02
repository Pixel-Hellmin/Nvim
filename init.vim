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

Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'nvim-lua/plenary.nvim'

" Telescope
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


lua << EOF
  -- ================================================
  -- =============== native LSP ===============
  -- 'choco install llvm' is necesary if in windows (language server)
  -- ================================================

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require'lspconfig'.clangd.setup{
      capabilities = capabilities,
      on_attach = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer = 0})
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer = 0})
      end,
  }

 
  -- ================================================
  -- =============== LSP autocomplete ===============
  -- ================================================

  -- this is like doing: set completeopt=menu,menuone,noselect
  vim.opt.completeopt={"menu", "menuone", "noselect"}

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })
EOF
