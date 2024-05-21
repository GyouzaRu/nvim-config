local status, minifiles = pcall(require, "mini.files")
if not status then
  vim.notify("没有找到 minifiles")
  return
end

minifiles.setup({})

require('keybindings').minifiles.functionKeys()
