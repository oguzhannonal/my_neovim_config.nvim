local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end
local imap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
end
nmap('<leader>e', "<Cmd>:NvimTreeToggle<cr>", 'File Explorer')
-- save file
nmap('<C-s>', "<Cmd>:w<cr>", 'Save File')
nmap('<C-h>', "<C-w>h", 'Resize Left')
nmap('<C-j>', "<C-w>j", 'Resize Down')
nmap('<C-k>', "<C-w>k", 'Resize Up')
nmap('<C-l>', "<C-w>l", 'Resize Right')
imap('jj', "<Esc>", 'Exit Insert Mode')
return {}
