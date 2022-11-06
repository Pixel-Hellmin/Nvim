local M = {}

function M.build()
    local result = vim.fn.system('dir build.bat /s/b')
    if string.find(result, " ") then
        -- 'File Not Found' would be the return value in this case
        print("No build script found.")
        return
    end
    result = '9sp term://'..result
    vim.cmd(result) 
end

return M
