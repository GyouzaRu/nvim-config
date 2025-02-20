local status, conform= pcall(require, "conform")
if not status then
  vim.notify("没有找到 conform")
  return
end

conform.setup({
  formatters_by_ft = {
    cpp = { "clang-format" },
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort"},
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})
