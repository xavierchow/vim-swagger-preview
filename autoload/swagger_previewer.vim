let s:vimSwaggerPreviewDir = expand('<sfile>:p:h:h')

function! swagger_previewer#Generate(pluginPath)
  let tmpDir = "/tmp/vim-swagger-preview/"
  call system("mkdir " . tmpDir)

  let s:cmd = "!'" . s:vimSwaggerPreviewDir . "/script.sh' '" . bufname("%") . "'"

  silent execute "!echo Please wait..."

  if exists( "g:swagger_preview_verbose_log" )
    execute s:cmd
  else
    let s:cmd = s:cmd . "> /dev/null 2>&1"
    silent execute s:cmd
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
