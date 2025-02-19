local status, none_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 none-ls")
  return
end

local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics
local completion = none_ls.builtins.completion

none_ls.setup({
  sources = {
    -- lua
    formatting.stylua,
    -- diagnostics.eslint,
    -- completion.spell,

    -- c/cpp
    formatting.clang_format,
    -- diagnostics.cppcheck,
  }
})
