return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    require('which-key').register {
      ['<leader>p'] = { '<cmd>Telescope neoclip<cr>', 'Browse Register' },
      ['<leader>ss'] = { '<cmd>Telescope live_grep_args<cr>', 'Live grep args' },
      ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
      ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = 'Harpoon', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
    }
  end,
}
