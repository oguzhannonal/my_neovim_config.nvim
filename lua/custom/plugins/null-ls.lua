-- local null_ls = require("null-ls")
--
--
-- local function hasPrettierConfig()
--   local current_dir = vim.fn.expand("%:p:h") -- Get the current file's directory
--   while current_dir ~= "/" do                -- Keep moving up until root directory is reached
--     local config_file = current_dir .. "/.prettierrc.js"
--     if vim.fn.filereadable(config_file) == 1 then
--       return true
--     end
--     current_dir = vim.fn.fnamemodify(current_dir, ":h")
--   end
--   return false
-- end
-- local function hasEslintConfig()
--   local current_dir = vim.fn.expand("%:p:h") -- Get the current file's directory
--   while current_dir ~= "/" do                -- Keep moving up until root directory is reached
--     local config_file = current_dir .. "/.eslintrc.cjs"
--     if vim.fn.filereadable(config_file) == 1 then
--       return true
--     end
--     current_dir = vim.fn.fnamemodify(current_dir, ":h")
--   end
--   return false
-- end
-- local sources = {
--   null_ls.builtins.formatting.stylua,
--   null_ls.builtins.formatting.prettier,
-- }
-- -- if hasPrettierConfig() and not hasEslintConfig() then
-- --   table.insert(sources, null_ls.builtins.formatting.prettierd)
-- -- end
-- null_ls.setup({
--   sources = sources, })
--
return {}