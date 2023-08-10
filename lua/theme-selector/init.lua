-- COLORIZER
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local M = {}

local function enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	-- print(vim.inspect(selected))
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
end

local function next_color(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
end

local function prev_color(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
end

M.default_opts = {
	prompt_title = "Which color?",
	layout_strategy = "vertical",
	layout_config = {
		height = 0.45,
		width = 0.25,
		prompt_position = "top",
	},
	sorting_strategy = "ascending",
	finder = finders.new_table { "" },
	sorter = sorters.get_generic_fuzzy_sorter({}),
	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<C-k>", prev_color)
		map("i", "<C-j>", next_color)
		return true
	end,
}

-- function colorizer()
-- 	colors:find()
-- end
M.setup = function(user_opts)
	M.config = vim.tbl_deep_extend("force", M.default_opts, user_opts or {})
	local colors = pickers.new(M.setup)
	vim.api.nvim_create_user_command("ThemerTest", function()
		colors:find()
	end, {})
end

return M
