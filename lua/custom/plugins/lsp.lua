return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
          for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
          end
          local on_attach = function(client, bufnr)
            local nmap = function(keys, func, desc)
              if desc then
                desc = 'LSP: ' .. desc
              end

              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end
            -- if client name is volar, disable formattingOptions
            -- if client.name == 'volar' then
            --   client.server_capabilities.documentRangeFormattingProvider = false
            --   client.server_capabilities.documentFormattingProvider = false
            -- end
            -- if client.name == 'eslint' then
            --   print 'eslint'
            --   vim.api.nvim_create_autocmd('BufWritePost', {
            --     buffer = bufnr,
            --     pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.vue' },
            --     command = 'EslintFixAll',
            --   })
            -- end
            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
              vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
          end

          local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- tsserver = {},
            -- html = { filetypes = { 'html', 'twig', 'hbs'} },
            marksman = {
              filetypes = { 'markdown' },
            },
            tailwindcss = {
              filetypes = { 'py' },
            },
            lua_ls = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
            astro = {},
            rust_analyzer = {}
          }

          -- Setup neovim lua configuration
          require('neodev').setup()

          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers

          -- Ensure the servers above are installed
          local mason_lspconfig = require 'mason-lspconfig'

          mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
          }
          local lspconfig = require('lspconfig')

          lspconfig.tsserver.setup {
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = '/home/oguz/.local/share/nvim/mason/bin/vue-language-server',
                  languages = { 'vue' },
                },
              },
            },

            lspconfig.volar.setup {
              init_options = {
                vue = {
                  hybridMode = false,
                },
              },
            }, }
          mason_lspconfig.setup_handlers {

            function(server_name)
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
              require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
              }
            end,
          }
        end,
      },
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },
}
