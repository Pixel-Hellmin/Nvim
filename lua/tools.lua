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
    local pathPattern = "(%w+\\.+%.%a+)"
    local line = vim.api.nvim_get_current_line()

    local _, _, lineNumberParenthesis = string.find(line, lineNumberPatternParenthesis)
    local _, _, lineNumberColon = string.find(line, lineNumberPatternColon)
    local _, _, path = string.find(line, pathPattern)

    if path ~= nil then
        if lineNumberParenthesis ~= nil then
            -- NOTE(Fermin): Go to compile errors
            vim.api.nvim_set_current_win(vim.api.nvim_eval("win_getid(winnr('#'))"))
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
        vim.api.nvim_set_current_win(vim.api.nvim_eval("win_getid(winnr('#'))"))
        vim.cmd(':e ' ..path) 
    end
end

return M
