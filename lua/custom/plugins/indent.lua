return {
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    opts = {
      symbol = '|',
      options = {
        try_as_border = true,
      },
    },
    config = function()
      require('mini.indentscope').setup()
    end,
  },
}
