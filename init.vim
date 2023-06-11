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

if empty($ekvc_home)
if !(has("win32") || has("win64"))
  let $ekvc_home = "~/.ekvc"
else
  let $ekvc_home = "~/AppData/Local/nvim"
endif
endif

" core config
source $ekvc_home/core/core.vim
