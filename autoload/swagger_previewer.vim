
function! swagger_previewer#Generate(pluginPath)
  let tmpDir = "/tmp/vim-swagger-preview/"
  call system("mkdir " . tmpDir)
  if exists( "g:swagger_preview_verbose_log" ) 
    execute "!" . "swagger_preview " . bufname("%")
  else
    if has('nvim')
      silent execute "!" . "swagger_preview " . bufname("%") . "> /dev/null 2>&1"
    else
      execute "!" . "swagger_preview " . bufname("%") . "> /dev/null 2>&1"
    endif
  endif

  let log = tmpDir . "validate.log"
  if getfsize(log) > 0
    let l:lines = readfile(log)
    for l:line in l:lines
        echoerr l:line
    endfor
  else
    if has('mac')
      call system("osascript " . a:pluginPath . '/applescript/active.scpt')
    else
      call system("xdg-open " . "http://localhost:8017")
    endif
  endif
endfunctio
