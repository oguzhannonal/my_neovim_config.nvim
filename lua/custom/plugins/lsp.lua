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
          local mason_registry = require('mason-registry')
          local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
          lspconfig.volar.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            -- NOTE: Uncomment to enable volar in file types other than vue.
            -- (Similar to Takeover Mode)

            -- filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

            -- NOTE: Uncomment to restrict Volar to only Vue/Nuxt projects. This will enable Volar to work alongside other language servers (tsserver).

            -- root_dir = require("lspconfig").util.root_pattern(
            --   "vue.config.js",
            --   "vue.config.ts",
            --   "nuxt.config.js",
            --   "nuxt.config.ts"
            -- ),
            init_options = {
              vue = {
                hybridMode = false,
              },
              -- NOTE: This might not be needed. Uncomment if you encounter issues.

              typescript = {
                tsdk = '/home/ogz/.nvm/versions/node/v22.11.0/lib/node_modules/typescript/lib', 
              },
            },
            settings = {
              typescript = {
                inlayHints = {
                  enumMemberValues = {
                    enabled = true,
                  },
                  functionLikeReturnTypes = {
                    enabled = true,
                  },
                  propertyDeclarationTypes = {
                    enabled = true,
                  },
                  parameterTypes = {
                    enabled = true,
                    suppressWhenArgumentMatchesName = true,
                  },
                  variableTypes = {
                    enabled = true,
                  },
                },
              },
            },
          })
          local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
          local volar_path = '/home/ogz/.nvm/versions/node/v22.11.0/lib/node_modules/@vue/language-server' 
          lspconfig.ts_ls.setup({
            capabilities = capabilities, 
            on_attach = on_attach,

            -- NOTE: To enable Hybrid Mode, change hybrideMode to true above and uncomment the following filetypes block.
            -- WARN: THIS MAY CAUSE HIGHLIGHTING ISSUES WITHIN THE TEMPLATE SCOPE WHEN TSSERVER ATTACHES TO VUE FILES

            -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = volar_path,
                  languages = { "vue" },
                },
              },
            },
          })
          -- lspconfig.volar.setup {
          --   init_options = {
          --     vue = {
          --       hybridMode = false,
          --     },
          --   },
          --   capabilities = require('cmp_nvim_lsp').default_capabilities(),
          --   on_attach = on_attach,
          -- }



          lspconfig.eslint.setup({
            capabilities=capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
             client.resolved_capabilities.document_formatting = allow_formatting
             client.resolved_capabilities.document_range_formatting = allow_formatting
            end,
          })


          -- lspconfig.ts_ls.setup {
          --   capabilities = require('cmp_nvim_lsp').default_capabilities(),
          --   on_attach = on_attach,
          --   init_options = {
              
          --   },
          --   filetypes = { 'typescript', 'javascript' },
          -- }

          -- No need to set `hybridMode` to `true` as it's the default value
          -- local util = require 'lspconfig.util'
          -- local function get_typescript_server_path(root_dir)
          
          --   local global_ts = '/home/ogz/.nvm/versions/node/v22.11.0/lib/node_modules/typescript/lib'
          --   -- Alternative location if installed as root:
          --   -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
          --   local found_ts = ''
          --   local function check_dir(path)
          --     found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
          --     if util.path.exists(found_ts) then
          --       return path
          --     end
          --   end
          --   if util.search_ancestors(root_dir, check_dir) then
          --     return found_ts
          --   else
          --     return global_ts
          --   end
          -- end
          
          -- lspconfig.volar.setup({
          --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          --   capabilities = require('cmp_nvim_lsp').default_capabilities(),
          --   on_attach = on_attach,
          --   init_options = {
          --     typescript = {
          --       tsdk = get_typescript_server_path(vim.fn.getcwd()),
          --     },
          --   },
          -- })
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
