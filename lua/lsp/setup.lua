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
  clangd = require("lsp.config.clangd"),
  cmake = require("lsp.config.cmake"),
  lua_ls = require("lsp.config.lua"),
  rust_analyzer = require("lsp.config.rust");
  -- bashls = require("lsp.config.bash"),
  dockerls = require("lsp.config.docker"),
  pyright = require("lsp.config.pyright"),
  jsonls = require("lsp.config.json"),
  yamlls = require("lsp.config.yamlls"),
  -- jdtls = require("lsp.config.jdtls"),
  -- remark_ls = require("lsp.config.markdown"),
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
    require("keybindings").mapLSP(buf_set_keymap)

  end,
})

