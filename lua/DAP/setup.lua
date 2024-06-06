local status, dap = pcall(require, "dap")
if not status then
  vim.notify("没有找到 dap")
  return
end

require('keybindings').dap.functionKeys();

-- language setting
require("DAP.config.cpp")
require("DAP.config.python")

local dapui = require('DAP.ui')
require('DAP.virtual-text')

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
