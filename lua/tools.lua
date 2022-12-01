local M = {}

function M.Build()
    local result = vim.fn.system('dir build.bat /s/b')
    if string.find(result, " ") then
        -- 'File Not Found' would be the return value in this case
        print("No build script found.")
        return
    end
    result = '9sp term://'..result
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
        vim.cmd(':9sp | :term findstr -snil ' ..input) 
    end)
end

function M.FindFile()
    vim.ui.input({ prompt = 'Find file: ' }, function(input)
        --[[
        TODO(Fermin): if no entry print message, if one entry edit buffer,
        if more than one entry list view
        local result = vim.fn.system('dir '..input ..' /b/s | findstr /v/i "vs node_modules" 2>nul')
        if string.find(result, " ") then
            -- 'File Not Found' would be the return value in this case
            print("File not found")
            return
        end
        print(result)
        --]]
        local command = 'dir '..input ..' /b/s | findstr /v/i "git vs node_modules" 2>nul'
        vim.cmd(':9sp | :term ' ..command) 
    end)
end


return M
