return {
  -- "olimorris/onedarkpro.nvim",
  -- priority = 1000,
  -- config = function()
  --   vim.o.background = 'dark' -- or "light" for light mode
  --
  --   vim.cmd.colorscheme 'onedark'
  -- end,
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup {
      dark_variant = 'moon',
    }
    vim.cmd.colorscheme 'rose-pine'
  end,
}
