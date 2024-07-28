local M = {}

function M.Build()
    local result = vim.fn.system('dir build.bat /s/b')
    if string.find(result, " ") then
        -- 'File Not Found' would be the return value in this case
        print("No build script found.")
        return
    end
    result = '10sp term://'..result
    vim.cmd(result) 
end

function M.GoTo()
    -- TODO(Fermin): Buffer for file opened is duplicated if it was 
    -- opened already. Try to keep only one buffer open.
        --[[
        local blist = vim.tbl_filter(
            function(buffer)
                return vim.api.nvim_buf_is_loaded(buffer)
            end,
            vim.api.nvim_list_bufs()
        )
        for i,v in pairs(blist) do print(vim.api.nvim_buf_get_name(v)) end
        print(vim.api.nvim_eval("bufexists('"..path.."')"))
        print(path)
        ]]--

    local lineNumberPatternParenthesis = "%((%d+)%)"
    local lineNumberPatternColon = "%:(%d+)%:"
    --local pathPattern = "(%w+:\\.+%.%a+)%("
    local pathPattern = "(%w+%:?\\.+%.%a+)%W?%d*%W?"
    local line = vim.api.nvim_get_current_line()

    local _, _, lineNumberParenthesis = string.find(line, lineNumberPatternParenthesis)
    local _, _, lineNumberColon = string.find(line, lineNumberPatternColon)
    local _, _, path = string.find(line, pathPattern)

    print(path)
    if path ~= nil then
        vim.api.nvim_set_current_win(vim.api.nvim_eval("win_getid(winnr('#'))"))
        if lineNumberParenthesis ~= nil then
            -- NOTE(Fermin): Go to compile errors
            vim.cmd(':e ' ..path) 
            vim.cmd(':' ..lineNumberParenthesis) 
            return
        end
        if lineNumberColon ~= nil then
            -- NOTE(Fermin): Go to grep finds
            vim.cmd(':e ' ..path) 
            vim.cmd(':' ..lineNumberColon) 
            return
        end
        -- NOTE(Fermin): We may get a number from the grep content, CARE
        vim.cmd(':e ' ..path) 
    end
end
    
function M.Grep()
    vim.ui.input({ prompt = 'Grep for: ' }, function(input)
        local command = ':9sp | :term findstr -snil ' 
        local filter = ' | findstr /v/i ".dll .lib .map .exe .pbd logs .git git vs node_modules .obj" 2>nul'
        vim.cmd(command ..input ..filter) 
    end)
end

--[[
function M.FindFile()
    vim.ui.input({ prompt = 'Find file: ' }, function(input)
        local command = 'dir '..input ..' /b/s | findstr /v/i "git vs node_modules" 2>nul'
        local result = vim.fn.systemlist(command)

        if #result == 1 then 
            if result[1] == 'File Not Found\r' then
                print(' --No files found')
            else 
                vim.cmd(':e ' ..vim.split(result[1], '\r', {plain=true, trimempty=true})[1])
            end
        else
            require'plugins.ViewList'.ViewList(result)
        end
    end)
end
--]]

function M.RunScript()
    -- TODO(Fermin): Make enter command a parameter un the view list
    --[[
    local result = vim.fn.systemlist('dir *.bat *.sh /s/b')
    require'plugins.ViewList'.ViewList(result)
    --]]
    print("WIP")
end

return M
