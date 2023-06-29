local telescope = require("telescope")
local actions = telescope.actions
local action_state = telescope.actions.state
local pickers = telescope.pickers
local finders = telescope.finders
local sorters = telescope.sorters

local M = {}

function M.enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. selected[1]
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
end

function M.next_color(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. selected[1]
	vim.cmd(cmd)
end

function M.prev_color(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. selected[1]
	vim.cmd(cmd)
end

M.opts = {
	-- TODO: Optimise the sorting and make it more responsive
	prompt_title = "Which color?",
	layout_strategy = "vertical",
	layout_config = {
		height = 0.45,
		width = 0.25,
		prompt_position = "top",
	},
	sorting_strategy = "ascending",
	finder = finders.new_table {
		"rose-pine",
		"catppuccin",
		"onedark_dark",
		"tokyonight",
		"carbonfox",
		"oxocarbon",
		"material",
		"vscode",
		"nord",
		"nordic",
		"fluoromachine",
		"dracula",
		"onenord",
		"nightfox",
		"nordfox",
		"neon",
		"tokyonight-moon"
	},
	sorter = sorters.get_generic_fuzzy_sorter({}),
	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<C-k>", prev_color)
		map("i", "<C-j>", next_color)
		return true
	end,
}

M.colors = pickers.new(M.opts)

return M