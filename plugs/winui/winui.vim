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

" => 状态栏与标签栏
if EkvcCoreBundleExist("vim-airline")
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled          = 1
  let g:airline#extensions#tabline#buffer_idx_mode  = 1
endif

" => 启动画面
if EkvcCoreBundleExist("vim-startify")
  hi link StartifyHeader Function
  let g:startify_custom_header = [
          \'                                                                             ',
          \'                      _/_/_/_/  _/    _/  _/      _/    _/_/_/               ',
          \'                     _/        _/  _/    _/      _/  _/                      ',
          \'                    _/_/_/    _/_/      _/      _/  _/                       ',
          \'                   _/        _/  _/      _/  _/    _/                        ',
          \'                  _/_/_/_/  _/    _/      _/        _/_/_/                   ',
          \'   ||======================================================================||',
          \'                     Welcome to EEI KARL VIM CONFIGURATION.                  ',
          \'   ||----------------------------------------------------------------------||']


  let g:startify_files_number = 5

  let g:startify_commands = [
          \ {'c': ['编辑配置', 'call EkvcCoreConfEdit()']},
          \ {'s': ['重载配置', 'call EkvcCoreConfSource()']},
          \ {'u': ['更新配置', 'call EkvcCoreConfUpdate()']},
          \ ]

  autocmd Filetype startify setlocal nofoldenable
endif

" => 目录功能增强
if EkvcCoreBundleExist("defx.nvim")
  let g:ekvc_defx_command="Defx -columns=indent:icons:filename:type"
  call defx#custom#option('_', {
    \ 'winwidth' : 40, 'split' : 'vertical', 'direction' : 'topleft', 'show_ignored_files' : 0, 'toggle' : 1, 'resume' : 1
    \ })

  call defx#custom#column('icon', {
    \ 'root_icon'                 : '',
    \ 'directory_icon'            : '',
    \ 'opened_icon'               : '',
    \ })
  call defx#custom#column('mark', {
    \ 'readonly_icon'             : '✗',
    \ 'selected_icon'             : '✓',
    \ })

  augroup plugin_defx
    autocmd!
    autocmd FileType        defx    call s:ekvc_defx_settings()
    autocmd BufEnter        *       call s:open_defx_if_isdir()
    autocmd BufWritePost    *       call defx#redraw()
  augroup END

  " 如果编辑的是目录，则打开defx
  function! s:open_defx_if_isdir()
    try
      let l:full_path = expand(expand('%:p'))
    catch
      return
    endtry
    if isdirectory(l:full_path)
      execute "bd" . expand('%:r') | execute g:ekvc_defx_command . l:full_path
    endif
  endfunction

  " 按键映射
  nmap <silent> <leader>e :execute g:ekvc_defx_command<cr>
  function! s:ekvc_defx_settings() abort
    nnoremap <silent><buffer><expr> <2-LeftMouse>
    \ defx#is_directory() ? defx#do_action('open_tree', 'toggle') : defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> <CR>
    \ defx#is_directory() ? defx#do_action('open_tree', 'toggle') : defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> n
    \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> R
    \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> P
    \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> h
    \ defx#do_action('open_tree', 'recursive', 'toggle')
    nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> l
    \ defx#is_directory() ? defx#do_action('open_tree', 'toggle') : defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')
  endfunction

  if EkvcCoreBundleExist("defx-icons")
    let g:defx_icons_directory_symlink_icon     = ''
    let g:defx_icons_mark_icon                  = '*'
    let g:defx_icons_copy_icon                  = ''
    let g:defx_icons_move_icon                  = ''
  endif

  if EkvcCoreBundleExist("defx-git")
    call defx#custom#column('git', 'indicators', {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Ignored'   : '☒',
      \ 'Deleted'   : '✖',
      \ 'Unknown'   : '?'
      \ })
  endif
endif

" => 窗口选择增强
if EkvcCoreBundleExist("vim-choosewin")
  let g:choosewin_overlay_enable = 1

  " 按键映射 {
  nmap  -  <Plug>(choosewin)
  " }
endif
