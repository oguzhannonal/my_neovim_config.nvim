return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      open_mapping = [[<c-\>]],
    }

    local nmap = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
    end
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    nmap('<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', 'Lazygit')
  end,
}
