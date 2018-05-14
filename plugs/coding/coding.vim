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

" => 语言服务协议客户端
if EkvcCoreBundleExist("nvim-lsp")
lua << EOF
lsp_lang_1 = 'clangd'                   -- c/c++
lsp_lang_2 = 'pyls_ms'                  -- python
lsp_lang_3 = 'rls'                      -- rust
lsp_lang_4 = 'vimls'                    -- nvim
EOF
  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.declaration()<cr>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>

" => 代码补全
if EkvcCoreBundleExist("completion-nvim")
  let g:completion_enable_auto_popup    = 1
  let g:completion_auto_change_source   = 1
  let g:completion_chain_complete_list  = {
    \ 'vim': [
    \    {'mode': '<c-n>'},
    \    {'mode': '<c-p>'}
    \],
    \ 'lua': [
    \    {'mode': '<c-n>'},
    \    {'mode': '<c-p>'}
    \],
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet']},
    \    {'complete_items': ['path'], 'triggered_only': ['/']},
    \    {'mode': '<c-n>'},
    \    {'mode': '<c-p>'}
    \]
  \}
  " 支持制表补全
  inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
  inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
endif

" => 代码诊断
if EkvcCoreBundleExist("diagnostic-nvim")
  " todo
endif


lua << EOF
local on_attach_vim = function()
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
end
require'nvim_lsp'[lsp_lang_1].setup{on_attach=on_attach_vim}
require'nvim_lsp'[lsp_lang_2].setup{on_attach=on_attach_vim}
require'nvim_lsp'[lsp_lang_3].setup{on_attach=on_attach_vim}
require'nvim_lsp'[lsp_lang_4].setup{on_attach=on_attach_vim}
EOF
endif "if EkvcCoreBundleExist("nvim-lsp")

" => 代码快速注释
if EkvcCoreBundleExist("tcomment_vim")
  let g:tcomment_maps = 1
endif

" => 代码彩虹括号
if EkvcCoreBundleExist("rainbow")
  let g:rainbow_active = 1

  " 按键映射 {
  nnoremap <Leader>rb :RainbowToggle<cr>
  " }
endif

" => 代码修改提示
if EkvcCoreBundleExist("vim-signify")
  let g:signify_vcs_list = [ "git", "svn" ]
endif

