return {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      -- javascript = { 'eslint_d' },
      -- typescript = { 'eslint_d' },
      -- javascriptreact = { 'eslint_d' },
      -- typescriptreact = { 'eslint_d' },
      -- svelte = { 'eslint_d' },
      python = { 'pylint' },
      -- vue = { 'eslint_d' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    local eslint_augroup = vim.api.nvim_create_augroup('eslintfix', { clear = true })
    local eslint = require('lint').linters.eslint_d
    eslint.args = {
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
      '--cache',
    }
    -- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
    --   group = lint_augroup,
    --   callback = function()
    --     lint.try_lint()
    --   end,
    -- })
  end,
}
