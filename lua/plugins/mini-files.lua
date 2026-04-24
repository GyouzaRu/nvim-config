local status, minifiles = pcall(require, "mini.files")
if not status then
  vim.notify("没有找到 minifiles")
  return
end

local keymap = require('config.keybindings').minifiles
keymap.functionKeys(minifiles);

-- local autocmd = require('config.autocmds').minifiles

minifiles.setup({
  mappings = keymap.builtinKeys,
})
