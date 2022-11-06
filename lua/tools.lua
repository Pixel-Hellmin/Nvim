local M = {}

function M.build()
    --print(vim.api.nvim_buf_get_name(0))
    print("build function in lua module tools")
    vim.cmd('9sp term://w:\\handmade\\code\\build')
end

return M
