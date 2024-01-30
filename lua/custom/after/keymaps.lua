local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
end
local imap = function(keys, func, desc)
  vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
end
nmap('<leader>e', '<CMD>:lua MiniFiles.open()<CR>', 'File Explorer')

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
-- function _G.git_diff(opts)
--   local pickers = require 'telescope.pickers'
--   local finders = require 'telescope.finders'
--   local conf = require('telescope.config').values
--   local current_branch = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
--   local cmd = string.format('git diff --name-only %s', current_branch)
--   local list = vim.fn.systemlist(cmd)
--   pickers
--     .new(opts, {
--       prompt_title = 'git diff',
--       finder = finders.new_table { results = list },
--       sorter = conf.generic_sorter(opts),
--     })
--     :find()
-- end
vim.api.nvim_set_keymap('n', '<leader>f',
  ':lua require("conform").format({lsp_fallback = true , timeout_ms = 500 , async = false})<CR>',
  { noremap = true, silent = true })
function _G.git_diff(opts)
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values

  -- Get the current branch
  local current_branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):gsub('\n', '')

  -- Specify the main branch
  local main_branch = 'dev'

  -- Use git diff to get the list of uncommitted changes in the current branch
  local uncommitted_cmd = 'git diff --name-only'
  local uncommitted_list = vim.fn.systemlist(uncommitted_cmd)

  -- use git diff to get new files
  local new_files_cmd = 'git diff --name-only --diff-filter=A'
  local new_files_list = vim.fn.systemlist(new_files_cmd)
  -- Use git diff to get the list of changed files between the current branch and main branch
  local diff_cmd = string.format('git diff --name-only %s..%s', main_branch, current_branch)
  local diff_list = vim.fn.systemlist(diff_cmd)

  -- Create a Set to store unique file names
  local unique_files = {}

  -- Add files from uncommitted_list to the set
  for _, file in ipairs(uncommitted_list) do
    unique_files[file] = true
  end
  for _, file in ipairs(new_files_list) do
    unique_files[file] = true
  end
  -- Add files from diff_list to the set
  for _, file in ipairs(diff_list) do
    unique_files[file] = true
  end

  -- Convert the Set back to a table
  local list = {}
  for file, _ in pairs(unique_files) do
    table.insert(list, file)
  end

  -- Create a telescope picker to display the list of uncommitted changes and changes between branches
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

-- get telescope diagnostics and show in :copen
nmap('<leader>xw', function()
  require('trouble').open 'workspace_diagnostics'
end, 'Trouble Workspace Diagnostics')
nmap('<leader>xx', function()
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
