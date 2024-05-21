local status, dap = pcall(require, "dap")
if not status then
  vim.notify("没有找到 dap")
  return
end

require('keybindings').dap.functionKeys();

require("dap.config.cpp")
require("dap.config.python")

local status_ui, dapui = pcall(require, "dapui")
if not status_ui then
  vim.notify("没有找到 dapui")
  return
end
-- require('dap.virtual-text')

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  dap.repl.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
  dap.repl.close()
end


