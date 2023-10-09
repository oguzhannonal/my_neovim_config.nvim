return {
  'sainnhe/gruvbox-material',
  priority = 1000,
  config = function()
    vim.o.background = 'dark' -- or "light" for light mode

    vim.cmd.colorscheme 'gruvbox-material'
    vim.cmd "let g:gruvbox_material_background= 'hard'"
    vim.cmd 'let g:gruvbox_material_transparent_background=0'
  end,
}
