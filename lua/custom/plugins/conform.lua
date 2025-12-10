return {
  'stevearc/conform.nvim',
  opts = {
    quiet = false,
    formatters_by_ft = {
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      markdown = { 'prettier' },
      yaml = { 'prettier' },
      sh = { 'beautysh' },
      zsh = { 'beautysh' },
      vue = { 'prettier' },
      lua = { 'stylua' },
    },
    formatters = {
      prettier = {
        command = "/home/ogz/.config/nvim/utils/node_modules/.bin/prettier",
        args = {
          '--config',
          '/home/ogz/.config/nvim/utils/prettierrc.cjs',
          '--stdin-filepath',
          '$FILENAME',
        },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    config = function(_, opts)
      require('conform').setup(opts)
    end,
  },
}