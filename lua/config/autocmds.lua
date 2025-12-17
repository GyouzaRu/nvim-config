local api = vim.api

local pluginAutocmd = {}

-- set vifmrc filetype as vim when read it
-- api.nvim_create_autocmd(
--   { "BufNewFile", "BufRead" },
--   { pattern = { "vifmrc" }, command = [[:set filetype=vim]] }
-- )

-- add cursorline
-- api.nvim_create_autocmd(
--   {"WinEnter"},
--   {pattern = {"*"}, command = [[:set cursorline]]}
-- )
-- api.nvim_create_autocmd(
--   {"WinLeave"},
--   {pattern = {"*"}, command = [[:set nocursorline]]}
-- )

-- tags
-- api.nvim_create_autocmd(
--   {"BufNewFile", "BufRead"},
--   {pattern = {"*"}, command = [[:set tags=./.tags;,.tags]]}
-- )

-- auto delete space at the end of line
-- api.nvim_create_autocmd(
--   { "BufWritePre" },
--   { callback = function()
--     if vim.bo.filetype == "markdown" then
--       return
--     end
--     vim.cmd(':%s/\\s\\+$//e')
--   end}
-- )

-- different autoindent
api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = { "*.lua,.gitconfig" }, callback = function ()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end}
)

-- Terminal
api.nvim_create_autocmd(
  { "TermEnter", "TermOpen"},
  {callback = function ()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end}
)

api.nvim_create_autocmd(
  { "TermLeave"},
  {callback = function ()
    vim.opt_local.number = true
  end}
)

-- save and load fold
api.nvim_create_autocmd(
  { "BufWinLeave" },
  { pattern = { "*.*" }, callback = function ()
    vim.cmd.mkview({mods = {emsg_silent = true}})
  end}
)
api.nvim_create_autocmd(
  { "BufWinEnter" },
  { pattern = { "*.*" }, callback = function ()
    vim.cmd.loadview({mods = {emsg_silent = true}})
  end}
)

-- auto inlay hints
api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { callback = function()
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, {0})
      end
    end}
)

-- auto change input method --
local input_toggle = 0
local en = 1033
local zh = 2052
local im_select_wsl = "/mnt/c/Software/im-select/im-select.exe "
local im_select_windows = "C:/Software/im-select/im-select.exe "

local function Is_chinese()
  local col = api.nvim_win_get_cursor(0)[2];
  local charactor = string.sub(vim.api.nvim_get_current_line(), col, col)
  -- return when empty under cursor
  if charactor == "" then
    return false
  end
  local charactor_ascii = string.byte(charactor)
  -- print(charactor .. " " .. charactor_ascii)
  if (charactor_ascii >= 32 and charactor_ascii <= 126) then
    return false
  else
    return true
  end
end

local function To_en()
  if vim.fn.has("wsl") == 1 then
    local input_method = tonumber(vim.fn.system(im_select_wsl))
    if input_method ~= en then
      input_toggle = 1
      vim.fn.system(im_select_wsl .. en)
    else
      input_toggle = 0
    end
  elseif vim.fn.has("Linux") == 1 then
    local input_method = tonumber(vim.fn.system("fcitx5-remote"))
    if input_method ~= 1 then
      input_toggle = 1
      vim.fn.system("fcitx5-remote -c")
    else
      input_toggle = 0
    end
  else
    local input_method = tonumber(vim.fn.system(im_select_windows))
    if input_method ~= en then
      input_toggle = 1
      vim.fn.system(im_select_windows .. en)
    else
      input_toggle = 0
    end
  end
end

local function To_zh()
  if vim.fn.has("wsl") == 1 then
    if input_toggle == 1 then
      vim.fn.system(im_select_wsl .. zh)
    end
  elseif vim.fn.has("Linux") == 1 then
    if input_toggle == 1 or Is_chinese() then
      vim.fn.system("fcitx5-remote -o")
    end
  else
    if input_toggle == 1 then
      vim.fn.system(im_select_windows .. zh)
    end
  end
end

local ime_input = api.nvim_create_augroup("im_input", { clear = true })
api.nvim_create_autocmd(
  { "InsertLeave" },
  {
    pattern = { "*.*" },
    group = ime_input,
    callback = To_en
  }
)
api.nvim_create_autocmd(
  { "InsertEnter" },
  {
    pattern = { "*.*" },
    group = ime_input,
    callback = To_zh
  }
)

-- minifiles
pluginAutocmd.minifiles = function ()
  local minifiles = api.nvim_create_augroup("mini-files", { clear = true })
  -- split
  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local new_target_window
      vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
        vim.cmd(direction .. ' split')
        new_target_window = vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target_window)
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    group = minifiles,
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak keys to your liking
      map_split(buf_id, '<leader>-', 'belowright horizontal')
      map_split(buf_id, '<leader>=', 'belowright vertical')
      map_split(buf_id, '<leader>t', 'tab')
    end,
  })

  -- show dotfiles
  local show_dotfiles = true

  local filter_show = function(fs_entry) return true end

  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
  end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    group = minifiles,
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak left-hand side of mapping to your liking
      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
    end,
  })
end

return pluginAutocmd
