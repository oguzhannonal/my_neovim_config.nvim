return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    vim.o.background = 'dark' -- or "light" for light mode

    vim.cmd.colorscheme 'onedark'
  end,
}
