return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    require('which-key').add {
      { '<leader>p', '<cmd>Telescope neoclip<cr>', desc = 'Browse Register' },
      { '<leader>ss', '<cmd>Telescope live_grep_args<cr>', desc = 'Live grep args' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Document' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Harpoon' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>x', group = 'Trouble' },
    }
  end,
}
