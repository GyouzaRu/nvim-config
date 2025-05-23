local lsp_status, lspconfig = pcall(require, "lspconfig")
if not lsp_status then
  vim.notify("没有找到 lspconfig")
  return
end

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  clangd = require("plugins.lsp.config.clangd"),
  neocmake = require("plugins.lsp.config.cmake"),
  lua_ls = require("plugins.lsp.config.lua"),
  rust_analyzer = require("plugins.lsp.config.rust"),
  pylsp = require("plugins.lsp.config.pylsp"),
  marksman = require("plugins.lsp.config.markdown"),
  -- bashls = require("plugins.lsp.config.bash"),
  -- dockerls = require("plugins.lsp.config.docker"),
  -- jsonls = require("plugins.lsp.config.json"),
  -- yamlls = require("plugins.lsp.config.yamlls"),
  -- jdtls = require("plugins.lsp.config.jdtls"),
  -- remark_ls = require("plugins.lsp.config.markdown"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    lspconfig[name].setup(config)
  else
    lspconfig[name].setup({})
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    local function buf_set_keymap(mode, keys, func)
      vim.keymap.set(mode, keys, func, opts)
    end
    -- 绑定快捷键
    require("config.keybindings").mapLSP(buf_set_keymap)
  end,
})
