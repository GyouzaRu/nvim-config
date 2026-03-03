local status, project = pcall(require, "project")
if not status then
  vim.notify("没有找到 project")
  return
end

project.setup({
  manual_mode = true,
})
require("telescope").load_extension("projects")
