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

" vim-plug: vim plugin manager
" ============================
"
" download plug.vim and put it in ~/.vim/autoload, more information: https://github.com/junegunn/vim-plug
"
" Copyright (c) 2017, Junegunn Choi, MIT License.

call plug#begin(EkvcCoreBundleDir(""))

  for $bundle_group in g:ekvc_bundle_groups
    source $ekvc_home/plugs/$bundle_group/$bundle_group.bundles
  endfor

call plug#end()

for $bundle_group in g:ekvc_bundle_groups
  call EkvcCoreBundleConf($ekvc_home . "/plugs/" . $bundle_group)
endfor
