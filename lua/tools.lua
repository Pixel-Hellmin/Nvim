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
    local lineNumberPattern = "%((%d+)%)"
    local pathPattern = "(%w+:\\.+%.%a+)%("
    local line = vim.api.nvim_get_current_line()

    local _, _, lineNumber = string.find(line, lineNumberPattern)
    local _, _, path = string.find(line, pathPattern)

    if lineNumber ~= nil and path ~= nil then
        vim.api.nvim_set_current_win(vim.api.nvim_eval("win_getid(winnr('#'))"))
        vim.cmd(':e ' ..path) 
        vim.cmd(':' ..lineNumber) 
    end
end

return M
