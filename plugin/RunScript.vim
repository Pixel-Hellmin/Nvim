if exists('g:loaded_RunScript') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

hi def link RunScriptHeader      Number
hi def link RunScriptSubHeader   Identifier

command! RunScript lua require'plugins.RunScript'.RunScript()
nnoremap <leader>rs :RunScript<cr>

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_RunScript = 1
