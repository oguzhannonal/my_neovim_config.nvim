vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  {
    'sindrets/diffview.nvim',
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },
  {
    'acksld/nvim-neoclip.lua',
    dependencies = {
      { 'kkharji/sqlite.lua', module = 'sqlite' },
    },
    config = function()
      require('neoclip').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'echasnovski/mini.bracketed',
    version = '*',
    config = function()
      require('mini.bracketed').setup()
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          keymap = {
            jump_next = '<c-j>',
            jump_prev = '<c-k>',
            accept = '<c-l>',
            refresh = 'r',
            open = '<M-CR>',
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<c-l>',
            next = '<c-j>',
            prev = '<c-k>',
            dismiss = '<c-h>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  'tpope/vim-sleuth',
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup()
    end,
  },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       component_separators = '|',
  --       section_separators = '',
  --     },
  --   },
  -- },
  { import = 'custom.plugins' },
}, {})

require 'custom.after'
