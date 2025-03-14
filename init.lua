
-- myplugin/init.lua
local M = {}

-- Function to print a greeting
function M.hello()
    print("Hello from MyPlugin!")
end

-- Function to create a command
function M.setup()
    vim.api.nvim_create_user_command('Hello', function()
        M.hello()
    end, {})
end

return M
