local status, dap = pcall(require, "dap")
if not status then
  vim.notify("没有找到 dap")
  return
end

require('config.keybindings').dap.functionKeys();

-- language setting
require("plugins.dap.config.cpp")
require("plugins.dap.config.python")

local dapui = require('plugins.dap.ui')
require('plugins.dap.virtual-text')

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
