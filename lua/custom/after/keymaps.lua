local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
end
local imap = function(keys, func, desc)
  vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
end
nmap('<leader>e', '<Cmd>:NvimTreeToggle<cr>', 'File Explorer')
-- save file
nmap('<C-s>', '<Cmd>:w<cr>', 'Save File')
nmap('<C-h>', '<C-w>h', 'Resize Left')
nmap('<C-j>', '<C-w>j', 'Resize Down')
nmap('<C-k>', '<C-w>k', 'Resize Up')
nmap('<C-l>', '<C-w>l', 'Resize Right')
imap('jj', '<Esc>', 'Exit Insert Mode')
-- close buffer
nmap('<leader>q', '<Cmd>:bd<cr>', 'Close Buffer')
-- :noh
nmap('<leader>n', '<Cmd>:noh<cr>', 'No Highlight')
-- harpoon keymaps
nmap('<A-1>', '<Cmd>:lua require("harpoon.ui").nav_file(1)<cr>', 'Harpoon Nav File 1')
nmap('<A-2>', '<Cmd>:lua require("harpoon.ui").nav_file(2)<cr>', 'Harpoon Nav File 2')
nmap('<A-3>', '<Cmd>:lua require("harpoon.ui").nav_file(3)<cr>', 'Harpoon Nav File 3')
nmap('<A-4>', '<Cmd>:lua require("harpoon.ui").nav_file(4)<cr>', 'Harpoon Nav File 4')
function _G.git_diff(opts)
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local current_branch = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
  local cmd = string.format('git diff --name-only %s', current_branch)
  local list = vim.fn.systemlist(cmd)
  pickers
    .new(opts, {
      prompt_title = 'git diff',
      finder = finders.new_table { results = list },
      sorter = conf.generic_sorter(opts),
    })
    :find()
end
nmap('<leader>gd', ':lua git_diff()<CR>', 'Changed Files')
-- trouble

nmap('<leader>xx', function()
  require('trouble').open()
end, 'Trouble Toggle')
nmap('<leader>xw', function()
  require('trouble').open 'workspace_diagnostics'
end, 'Trouble Workspace Diagnostics')
nmap('<leader>xd', function()
  require('trouble').open 'document_diagnostics'
end, 'Trouble Document Diagnostics')
nmap('<leader>xq', function()
  require('trouble').open 'quickfix'
end, 'Trouble Quickfix')
nmap('<leader>xl', function()
  require('trouble').open 'loclist'
end, 'Trouble Loclist')
nmap('gR', function()
  require('trouble').open 'lsp_references'
end, 'Trouble LSP References')

-- diffview keymaps
nmap('<leader>gv', function()
  require('diffview').open()
end, 'Diffview Open')
