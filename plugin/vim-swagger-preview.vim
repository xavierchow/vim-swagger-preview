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
"default nmap is <leader>z, 'n' means normal mode
if ( !hasmapto( '<Plug>PreviewSwagger', 'n' ) ) 
  nmap <unique> <leader>z <Plug>PreviewSwagger
endif 
autocmd FileType yaml nmap <silent> <buffer> <Plug>PreviewSwagger
      \ :call swagger_previewer#Generate(swagger_preview_plugin_path)<CR>


