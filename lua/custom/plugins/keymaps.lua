local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end
nmap('<leader>e', "<Cmd>:NvimTreeToggle<cr>", 'File Explorer')
return {}
