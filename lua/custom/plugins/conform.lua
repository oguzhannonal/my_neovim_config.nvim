return {
  'stevearc/conform.nvim',
  opts = {
    quiet = true,
    formatters_by_ft = {
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      json = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      scss = { 'prettierd' },
      markdown = { 'prettierd' },
      yaml = { 'prettierd' },
      sh = { 'beautysh' },
      zsh = { 'beautysh' },
      vue = { 'prettier' },
      lua = { 'stylua' },
    },
    format_on_save = function(bufnr)
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match '/node_modules/' then
        return
      end

      return { lsp_fallback = true, async = true }
    end,
    format_after_save = { lsp_fallback = true },
  },
}
