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

"注：按键映射不将注释写命令后面"

" 重映射<esc>到"jk"
inoremap <silent>jk <esc>
" 重置<leader>键为";"，默认是"\"
let mapleader = "\<space>"

" 重定义屏幕滚动
map <silent><left>  <c-b>
map <silent><right> <c-f>
map <silent><up>    <c-u>
map <silent><down>  <c-d>

" <esc> 取消高亮
nnoremap <silent><esc> :nohlsearch<cr>

" 强制写只读文件
cnoremap <silent>w!! w !sudo tee % >/dev/null

" 切换粘贴方式
set pastetoggle=<leader>tp
