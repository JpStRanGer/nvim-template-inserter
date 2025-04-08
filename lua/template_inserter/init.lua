-- myplugin/init.lua
local M = {}

-- Function to print a greeting
function M.hello()
	print("Hello from Remote MyPlugin!")
end

M.config = {
	keymap = "<leader>tt", -- user-defined key
	templates = {
		html = "template_inserter.templates.html",
		css = "template_inserter.templates.css",
		cpp = "template_inserter.templates.cpp",
		arduino = "template_inserter.templates.arduino",
		cmake = "template_inserter.templates.cmake",
		qt = "template_inserter.templates.qt",
		vue = "template_inserter.templates.vue",
	},
}

-- Function to create a command
function M.setup(opts)
	M.config = vim.tbl_extend("force", M.config, opts or {})

	-- Set test function as executble function in nvim. ( this is just for testing that the plugin works)
	vim.api.nvim_create_user_command("SayHello", function()
		M.hello()
	end, {})

	vim.keymap.set("n", M.config.keymap, function()
		print("keymap recognised.")
		M.trigger()
	end, { desc = "Insert template", noremap = true, silent = true })
end

-- Check if current buffer is empty
local function buffer_is_empty()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	return #lines == 1 and lines[1] == ""
end

-- Trigger template selection if file is empty
function M.trigger()
	if not buffer_is_empty() then
		vim.notify("Buffer not empty.. (not a clean page)", vim.log.levels.WARN)
		return
	end
	require("template_inserter.picker").open(M.config.templates)

	-- After a short delay, re-apply filetype detection and syntax highlighting
	vim.defer_fn(function()
		vim.cmd("filetype detect")
		vim.cmd("doautocmd BufRead")
		vim.cmd("syntax enable") -- Optional: if needed
	end, 50)
end

return M
