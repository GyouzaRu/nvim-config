local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("keybindings").telescope.windowKeys,
    path_display = {
      "filename_first",
    },
  },
  -- replace edit with drop
  pickers = {
    buffers = {
      mappings = {
        i = { ["<CR>"] = actions.select_drop }
      },
    },
    find_files = {
      mappings = {
        i = { ["<CR>"] = actions.select_drop }
      },
    },
    git_files = {
      mappings = {
        i = { ["<CR>"] = actions.select_drop }
      },
    },
    old_files = {
      mappings = {
        i = { ["<CR>"] = actions.select_drop }
      },
    },
  },
  extensions = {
    -- 扩展插件配置
  },
})

require("keybindings").telescope.functionKeys(builtin)
