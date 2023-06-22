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
if EkvcCoreBundleExist("nvim-lspconfig")
lua <<EOF
  lsp_lang_1 = 'clangd'                 -- c/c++
  lsp_lang_2 = 'rust_analyzer'          -- rust
  lsp_lang_3 = 'pylsp'                  -- python
EOF

" => 代码补全
if EkvcCoreBundleExist("nvim-cmp")
lua <<EOF
  local completion = require'cmp'
  completion.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = completion.config.window.bordered(),
    },
    mapping = completion.mapping.preset.insert({
      ['<C-b>']     = completion.mapping.scroll_docs(-4),
      ['<C-f>']     = completion.mapping.scroll_docs( 4),
      ['<C-e>']     = completion.mapping.abort(),
      ['<C-Space>'] = completion.mapping.complete(),
      ['<CR>']      = completion.mapping.confirm({ select = true }),
    }),
    sources = completion.config.sources({
      { name = 'vsnip'    }, -- For vsnip users.
    }, {
      { name = 'buffer'   },
    })
  })
  -- Use buffer source for `/` and `?` (if you enable `native_menu`, this won't work anymore).
  completion.setup.cmdline({ '/', '?' }, {
    mapping = completion.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
  })
  -- Use cmdline & path source for ':' (if you enable `native_menu`, this won't work anymore).
  completion.setup.cmdline(':', {
    mapping = completion.mapping.preset.cmdline(),
    sources = completion.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
  })
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')[lsp_lang_1].setup { capabilities = capabilities }
  require('lspconfig')[lsp_lang_2].setup { capabilities = capabilities }
  require('lspconfig')[lsp_lang_3].setup { capabilities = capabilities }
EOF
else "if EkvcCoreBundleExist("nvim-cmp")
lua <<EOF
  require('lspconfig')[lsp_lang_1].setup { }
  require('lspconfig')[lsp_lang_2].setup { }
  require('lspconfig')[lsp_lang_3].setup { }
EOF
endif "if EkvcCoreBundleExist("nvim-cmp")

endif "if EkvcCoreBundleExist("nvim-lspconfig")

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

