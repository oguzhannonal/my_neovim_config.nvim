require('lspconfig')['volar'].setup {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentRangeFormatting = false
    client.server_capabilities.documentFormatting = false
  end,
}

require('lspconfig')['volar'].setup {
  on_attach = function(client, bufnr)
    -- log "Eslint setup"
    client.server_capabilities.documentRangeFormatting = true
    client.server_capabilities.documentFormatting = true
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

return {}
