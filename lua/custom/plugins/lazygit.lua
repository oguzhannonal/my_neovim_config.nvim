local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
end
local imap = function(keys, func, desc)
  vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
end

function _lazygit_toggle()
  lazygit:toggle()
end

nmap('<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', 'Lazygit')
return {}
