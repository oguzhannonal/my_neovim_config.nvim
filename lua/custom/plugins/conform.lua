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
      vue = { 'prettierd' },
      lua = { 'stylua' },
    },
    format_on_save = false,
    --   -- Disable autoformat for files in a certain path
    --   local bufname = vim.api.nvim_buf_get_name(bufnr)
    --   if bufname:match '/node_modules/' then
    --     return
    --   end
    --
    --   return { lsp_fallback = true, async = false, timeout_ms = 500 }
    -- end,
    config = function(_, opts)
      require('conform').setup(opts)
    end,
  },
}
