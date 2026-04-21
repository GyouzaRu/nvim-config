local status, fzf = pcall(require, "fzf-lua")
if not status then
  vim.notify("没有找到 fzf-lua")
  return
end

local keybindings = require("config.keybindings").fzf_lua
keybindings.functionKeys()

local builtinKeys = keybindings.builtinKeys(fzf)

fzf.setup({
  defaults = {
    -- These setting is for all pickers
    formatter = "path.filename_first",
    actions = builtinKeys.actions,
  },
  winopts = {
    preview = {
      -- default = 'bat',
      layout = "vertical",
    },
  },
  keymap = {
    builtin = builtinKeys.builtin,
    fzf = builtinKeys.fzf,
  },
})

