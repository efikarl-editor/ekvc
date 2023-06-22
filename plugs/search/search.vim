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
if EkvcCoreBundleExist("telescope.nvim")
lua << EOF
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers   , {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep , {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags , {})
EOF
endif
