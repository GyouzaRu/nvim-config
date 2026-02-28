-- vim.api.nvim_create_user_command('CmakeBuild', function()
--     local cmd = "cmake -B build && cmake --build build"
--     -- 异步执行并指定根目录
--     vim.cmd(string.format('AsyncRun -cwd=<root> %s', cmd))
-- end, { desc = 'Run asynchronous CMake build' })

vim.api.nvim_create_user_command('CmakeBuild', function(opts)
    -- 获取参数，如果没传则默认为 Debug
    local build_type = (opts.args ~= "") and opts.args or "Debug"
    
    -- 构造命令：配置并编译
    -- -DCMAKE_BUILD_TYPE 定义构建类型
    local cmd = string.format(
        "AsyncRun -cwd=<root> cmake -B build -DCMAKE_BUILD_TYPE=%s -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build", 
        build_type
    )
    
    vim.cmd(cmd)
end, { 
    nargs = "?", -- 允许 0 或 1 个参数
    complete = function()
        return { "Debug", "Release", "RelWithDebInfo", "MinSizeRel" } -- 补全建议
    end,
    desc = "Async CMake Build with Type"
})

vim.api.nvim_create_user_command('ColconBuild', function(opts)
    -- 获取参数，如果没传则默认为 Debug
    local build_type = (opts.args ~= "") and opts.args or "Debug"
    
    -- 构造命令：配置并编译
    -- -DCMAKE_BUILD_TYPE 定义构建类型
    local cmd = string.format(
        "AsyncRun -cwd=<root> colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=%s", 
        build_type
    )
    
    vim.cmd(cmd)
end, { 
    nargs = "?", -- 允许 0 或 1 个参数
    complete = function()
        return { "Debug", "Release"} -- 补全建议
    end,
    desc = "Async Colcon Build with Type"
})

