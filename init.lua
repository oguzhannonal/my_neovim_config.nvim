---@diagnostic disable: missing-fields
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
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
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
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
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
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
    'hrsh7th/cmp-nvim-lsp',
  },
  'tpope/vim-sleuth',
  { 'folke/which-key.nvim', opts = {} },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup()
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
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
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  { import = 'custom.plugins' },
}, {})

require 'custom.after.options'
require 'custom.after.autocmds'
require 'custom.after.keymaps'
