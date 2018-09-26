" Vim plugin file for swagger yaml preview
"
" Maintainer:	Xavier Chow <xiayezhou at gmail dot com>
" Last change:	Sep 27 2018
" Version:     0.1.0

if exists( "g:swagger_preview" ) 
  finish 
endif 
let g:swagger_preview=1 

let swagger_preview_plugin_path = resolve(expand('<sfile>:p:h'))
"default nmap is <leader>e, 'n' means normal mode,
"reusing the same plug name as https://github.com/xavierchow/vim-sequence-diagram
if ( !hasmapto( '<Plug>GenerateDiagram', 'n' ) ) 
  nmap <unique> <leader>e <Plug>GenerateDiagram
endif
autocmd FileType yaml nmap <silent> <buffer> <Plug>GenerateDiagram
      \ :call swagger_previewer#Generate(swagger_preview_plugin_path)<CR>

