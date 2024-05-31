local status, aerial = pcall(require, "aerial")
if not status then
  vim.notify("没有找到 aerial")
  return
end

local keybindings = require('keybindings').aerial

aerial.setup({
  on_attach = keybindings.functionKeys_onattach()
})

keybindings.functionKeys()
