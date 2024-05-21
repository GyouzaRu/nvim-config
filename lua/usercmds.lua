-- set vifmrc filetype as vim when read it
-- local api = vim.api
local term_buf_id = -1
-- local term_win_id = -1
vim.api.nvim_create_user_command(
  'TermToggle',
  function()
    -- tab term
    -- if the cursor is under term buf
    if term_buf_id == vim.api.nvim_get_current_buf() then
      -- check the current tabpage is the last one or not
      if vim.fn.tabpagenr('$') == 1 then
        print("Cannot close the last tabpage!")
      end
      -- check the last access tabpage is exist or not
      if vim.fn.tabpagenr('#') ~= 0 then
        -- exist: jump to the last tabpage and close term tabpage
        vim.cmd.tabnext({ args={'#'}} )
        vim.cmd.tabclose({ args={'#'}} )
      else
        -- not exist: jump to the next tabpage and close term tabpage
        vim.cmd.tabnext()
        vim.cmd.tabclose({ args={'#'}} )
      end

      -- the term is exist but the cursor is not under term buf
    elseif vim.api.nvim_buf_is_valid(term_buf_id) then
      vim.cmd("$tab sbuffer" .. term_buf_id)
      vim.cmd.startinsert()
      -- the term is not exist yet
    else
      vim.cmd("$tabnew term://zsh")
      term_buf_id = vim.api.nvim_get_current_buf()
      vim.opt_local.relativenumber = false
      -- vim.opt_local.number = false
      vim.cmd.startinsert()
    end

    -- vsp term
    -- if term_buf_id == vim.api.nvim_get_current_buf() then
    --   vim.api.nvim_win_close(0,{})
    -- elseif vim.api.nvim_buf_is_valid(term_buf_id) then
    --   local term_win_id = vim.fn.bufwinnr(term_buf_id)
    --   if term_win_id then
    --     -- TODO: jump to bufwinnr
    --     vim.api.nvim_set_current_buf(term_buf_id)
    --   else
    --     vim.cmd("split")
    --     vim.api.nvim_set_current_win(term_win_id)
    --   end
    --   -- vim.cmd("split")
    --   -- vim.api.nvim_set_current_buf(term_buf_id)
    -- else
    --   -- vim.api.nvim_command("sp term://zsh")
    --   vim.cmd("sp term://zsh")
    --   term_buf_id = vim.api.nvim_get_current_buf()
    --   -- term_win_id = vim.api.nvim_get_current_win()
    --   vim.opt_local.relativenumber = false
    --   vim.opt_local.number = false
    -- end
  end,
  {}
)


-- api.nvim_create_user_command('Cmake', function (args)
--   require('usercmds').run(args)
-- end, {nargs =1, desc = "cmake command" })
--
-- local custom_cmake = {}
--
-- function custom_cmake.run(args)
--     local build_dir = "build"
--     if args == "clean" or args == "c" or args == "C" then
--       if vim.fn.isdirectory(build_dir) == 0 then
--         print("-- Folder build is not exist")
--       else
--         vim.cmd("!rm -rf build/*")
--       end
--       return
--     end
--
--     if args == "run" or args == "r" or args == "R" then
--       if vim.fn.isdirectory(build_dir) == 0 then
--         print("-- Folder build is not exist")
--         vim.fn.mkdir("build","p")
--       end
--       vim.cmd("!cmake -B build")
--     end
-- end
--
-- return custom_cmake
