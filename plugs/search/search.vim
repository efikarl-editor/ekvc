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


" => 各种查找
if EkvcCoreBundleExist("leaderf")
  let g:Lf_RootMarkers = ['.root', '.git', '.svn']
  let g:Lf_GtagsAutoGenerate = 1
  " 弹窗模式
  let g:Lf_WindowPosition = 'popup'
  let g:Lf_PreviewInPopup = 1
  let g:Lf_StlSeparator   = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': g:ekvc_font_family }
  let g:Lf_PreviewResult  = {'Function': 0, 'BufTag': 0 }

  " 按键映射 {
  let g:Lf_ShortcutF = '<C-P>'
  noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
  noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru    %s", "")<CR><CR>

  " 对其它tags插件集成不友好，无法明确GTAGSDBPATH，现在临时方案：g:Lf_GtagsStoreInProject
  " 同时请设置.gitignore忽略gtags数据文件
  let g:Lf_GtagsStoreInProject = 1
  noremap gr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
  noremap gd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
  noremap gj :<C-U><C-R>=printf("Leaderf  gtags --next      %s", "")<CR><CR>
  noremap gk :<C-U><C-R>=printf("Leaderf  gtags --previous  %s", "")<CR><CR>
  " }
endif
