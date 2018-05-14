"++ @file
"
"  Copyright ©2018 efikarl, https://efikarl.com.
"
"  This program is just made available under the terms and conditions of the
"  MIT license: https://efikarl.com/mit-license.html.
"
"  THE PROGRAM IS DISTRIBUTED UNDER THE MIT LICENSE ON AN "AS IS" BASIS,
"  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
"
"--

" 签名源文件
function! EkvcFuncSignOff()
  if expand("%:e") == "asm"
    let l:comment = ";"
  elseif expand("%:e") == "sh"
    let l:comment = "#"
  elseif expand("%:e") == "vim"
    let l:comment = """
  else
    let l:comment = ""
  endif
  call setline(line("."), l:comment."++ @file")
  call  append(line("$"), l:comment."")
  call  append(line("$"), l:comment."  Copyright ©".strftime("%Y")." efikarl, https://efikarl.com.")
  call  append(line("$"), l:comment."")
  call  append(line("$"), l:comment."  This program is just made available under the terms and conditions of the")
  call  append(line("$"), l:comment."  MIT license: https://efikarl.com/mit-license.html.")
  call  append(line("$"), l:comment."")
  call  append(line("$"), l:comment."  THE PROGRAM IS DISTRIBUTED UNDER THE MIT LICENSE ON AN \"AS IS\" BASIS,")
  call  append(line("$"), l:comment."  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.")
  call  append(line("$"), l:comment."")
  call  append(line("$"), l:comment."--")
  call  append(line("$"), "")
  if expand("%:e") == "c" || expand("%:e") == "h"
    call setline(line("."),   "/*++ @file")
    call setline(line("$")-1, "--*/")
  elseif expand("%:e") == "lua"
    call setline(line("."),   "--[[ @file")
    call setline(line("$")-1, "--]]")
  endif
  call append(line("$"), "")
endfunction

" 移除行尾空白符
function! EkvcFuncStripEolWs()
  let l:last_pos = getcurpos()
  let l:last_search=@/
  %s/\s\+$//ge
  let @/=l:last_search
  call setpos(".", l:last_pos)
endfunction
nnoremap <silent> <leader><space> :call EkvcFuncStripEolWs()<cr>

" 追加VIM方式行
function! EkvcFuncAppendModeLine()
  set modeline
  let l:modeline = printf(
                     \ " vim: set%s ts=%d sw=%d: ",
                     \ &expandtab ? " et" : "" , &tabstop, &shiftwidth
                     \ )
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  let l:modeline = substitute(l:modeline, " $", "", "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>m :call EkvcFuncAppendModeLine()<cr>
