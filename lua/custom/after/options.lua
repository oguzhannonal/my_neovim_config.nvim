local options = vim.opt
vim.o.hlsearch = true
local ok_osc52, osc52 = pcall(require, 'osc52')
if ok_osc52 then
  vim.keymap.set('n', '<leader>c', osc52.copy_operator, { expr = true })
  vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
  vim.keymap.set('x', '<leader>c', osc52.copy_visual)
  -- TODO: show return status in command line without popup
end
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Make line numbers default
vim.wo.number = true
vim.opt.wrap = false
vim.opt.swapfile = false
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- coq
