-- template_inserter/picker.lua
local uv = vim.uv or vim.loop
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")

local M = {}

-- ✨ Path to user-defined template folder
local user_template_dir = vim.fn.stdpath("config") .. "/templates/"

-- 🔍 Scan folder for available user templates (filenames without extension)
local function get_user_templates()
	local templates = {}
	local handle = uv.fs_scandir(user_template_dir)
	if handle then
		while true do
			local name, typ = uv.fs_scandir_next(handle)
			if not name then
				break
			end
			if typ == "file" then
				local file = user_template_dir .. name
				local key = name:match("(.+)%.%w+$") or name -- remove extension
				templates[key] = file
			end
		end
	end
	return templates
end

function M.open(builtin_templates)
	local user_templates = get_user_templates()
	local merged = vim.tbl_extend("force", builtin_templates, user_templates)
	local keys = vim.tbl_keys(merged)

	pickers
		.new({}, {
			prompt_title = "Choose Template",

			finder = finders.new_table({
				results = keys,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
						filename = (type(merged[entry]) == "string") and merged[entry] or nil,
						modpath = (type(merged[entry]) ~= "string") and merged[entry] or nil,
					}
				end,
			}),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					local val = merged[entry.value]

					-- User file: read from disk
					if type(val) == "string" and vim.fn.filereadable(val) == 1 then
						putils.job_maker({ "cat", val }, self.state.bufnr, {
							value = entry.value,
							bufname = self.state.bufname,
						})
					else
						-- Builtin Lua template: call .get() and show it
						local ok, mod = pcall(require, val)
						if ok and type(mod.get) == "function" then
							local lines = mod.get()
							vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
						else
							vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
								"Unable to load preview for: " .. entry.value,
							})
						end
					end
				end,
			}),

			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selection = action_state.get_selected_entry().value
					local target = merged[selection]

					-- 🔁 Load from Lua module or disk
					local lines = {}

					-- Is it a file path (absolute)?
					if type(target) == "string" and target:sub(1, 1) == "/" then
						if vim.fn.filereadable(target) == 1 then
							for line in io.lines(target) do
								table.insert(lines, line)
							end
						else
							vim.notify("User template file not found: " .. target, vim.log.levels.ERROR)
							return
						end

						-- Otherwise treat it as a Lua module path
					else
						local ok, mod = pcall(require, target)
						if not ok or type(mod.get) ~= "function" then
							vim.notify("Failed to load builtin template module: " .. target, vim.log.levels.ERROR)
							return
						end
						lines = mod.get()
					end

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
