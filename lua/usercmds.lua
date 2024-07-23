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
      local shell = 'bash';
      if vim.fn.executable('zsh') == 1 then
        shell = 'zsh'
      end
      vim.cmd("$tabnew term://" .. shell)
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
-- -- 定义一个函数来异步执行 CMake 命令，并将输出解析到 quickfix 列表中
-- local function run_async_task(args)
--   -- 将命令行参数转换为表
--   local task = {}
--   for _, arg in ipairs(args.fargs) do
--     table.insert(task, arg)
--   end
--   -- 打开 quickfix 窗口
--   vim.cmd('copen')
--
--   -- 启动一个异步任务
--   local async_job = vim.fn.jobstart(task, {
--     stdout_buffered = true,
--     stderr_buffered = true,
--     on_stdout = function(_, data, _)
--       -- 将标准输出的数据添加到 quickfix 列表
--       vim.fn.setqflist({}, 'a', {
--         title = 'Async Task',
--         lines = data,
--       })
--     end,
--     on_stderr = function(_, data, _)
--       -- 将标准错误的数据添加到 quickfix 列表
--       vim.fn.setqflist({}, 'a', {
--         title = 'Async Task Errors',
--         lines = data,
--       })
--       -- 打开 quickfix 窗口
--       -- vim.cmd('copen')
--     end,
--     on_exit = function(_, exit_code, _)
--       -- 处理任务退出时的操作
--       if exit_code ~= 0 then
--         print('Async task failed with exit code ' .. exit_code)
--       else
--         print('Async task succeeded')
--       end
--     end,
--   })
--
--   if async_job <= 0 then
--     print('Failed to start async job')
--   end
-- end
--
-- -- 创建一个 :Async 命令来调用上面的函数
-- vim.api.nvim_create_user_command('Async', run_async_task, { nargs = '*' })
--
-- -- 定义一个函数来异步执行 CMake 命令
-- local function run_cmake(args)
--   -- 将命令行参数转换为表
--   local cmake_args = {'cmake', '-B', 'build'}
--   for _, arg in ipairs(args.fargs) do
--     table.insert(cmake_args, arg)
--   end
--   table.insert(cmake_args, '-DCMAKE_EXPORT_COMPILE_COMMANDS=1')
--     vim.cmd('copen')
--
--   -- 启动第一个异步任务来执行 cmake -B build
--   local build_job = vim.fn.jobstart(cmake_args, {
--     stdout_buffered = true,
--     stderr_buffered = true,
--     on_stdout = function(_, data, _)
--       -- 将标准输出的数据添加到 quickfix 列表
--       vim.fn.setqflist({}, 'a', {
--         title = 'CMake Configure',
--         lines = data,
--       })
--     end,
--     on_stderr = function(_, data, _)
--       -- 将标准错误的数据添加到 quickfix 列表
--       vim.fn.setqflist({}, 'a', {
--         title = 'CMake Configure Errors',
--         lines = data,
--       })
--     end,
--     on_exit = function(_, exit_code, _)
--       -- 处理任务退出时的操作
--       if exit_code ~= 0 then
--         print('CMake configure failed with exit code ' .. exit_code)
--       else
--         print('CMake configure succeeded')
--         -- 启动第二个异步任务来执行 cmake --build build
--         local build_args = {'cmake', '--build', 'build'}
--         local build_compile_job = vim.fn.jobstart(build_args, {
--           stdout_buffered = true,
--           stderr_buffered = true,
--           on_stdout = function(_, data, _)
--             -- 将标准输出的数据添加到 quickfix 列表
--             vim.fn.setqflist({}, 'a', {
--               title = 'Make Build',
--               lines = data,
--             })
--           end,
--           on_stderr = function(_, data, _)
--             -- 将标准错误的数据添加到 quickfix 列表
--             vim.fn.setqflist({}, 'a', {
--               title = 'Make Build Errors',
--               lines = data,
--             })
--           end,
--           on_exit = function(_, build_exit_code, _)
--             -- 处理任务退出时的操作
--             if build_exit_code ~= 0 then
--               print('Make build failed with exit code ' .. build_exit_code)
--             else
--               print('Make build succeeded')
--             end
--             vim.cmd('copen')
--           end,
--         })
--
--         if build_compile_job <= 0 then
--           print('Failed to start CMake build job')
--         end
--       end
--     end,
--   })
--
--   if build_job <= 0 then
--     print('Failed to start CMake configure job')
--   end
-- end
--
-- -- 创建一个 :Cmake 命令来调用上面的函数
-- vim.api.nvim_create_user_command('Cmake', run_cmake, { nargs = '*' })
