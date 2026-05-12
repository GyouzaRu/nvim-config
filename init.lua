if vim.fn.has('nvim-0.12') == 1 then
  require('vim._core.ui2').enable()
end

-- basic
require('config.basic')
-- keybindings
require('config.keybindings')
-- custom commands
require('config.autocmds')
require('config.usercmds')

-- lazy.nvim plugins management
require('config.lazy-nvim')

-- GUI support
require('config.gui')
