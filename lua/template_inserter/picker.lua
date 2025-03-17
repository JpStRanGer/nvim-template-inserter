-- template_inserter/picker.lua
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local M = {}

function M.open(templates)
	local keys = vim.tbl_keys(templates)

	pickers
		.new({}, {
			prompt_title = "Choose Template",
			finder = finders.new_table({ results = keys }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selection = action_state.get_selected_entry().value
					local mod = require(templates[selection])
					local lines = mod.get()

					-- Insert template into buffer
					vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

					-- Set filetype based on the template name (e.g., "html", "cpp")
					vim.bo.filetype = selection

					-- Trigger LSP and Tree-sitter (syntax highlighting, autocommands, etc.)
					vim.cmd("filetype detect")
					vim.cmd("doautocmd BufRead")
				end)
				return true
			end,
		})
		:find()
end

return M
