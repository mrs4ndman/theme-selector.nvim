local M = {}
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local colorschemes = require("theme-selector.colorschemes")

local function on_escape(prompt_bufnr)
  actions.close(prompt_bufnr)
end

local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
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

if vim.tbl_isempty(colorschemes.userlist) then
  M.colorschemes = {
    "default",
    "habamax",
    "retrobox",
  }
else
  M.colorschemes = colorschemes.userlist
end

local color_opts = {
  prompt_title = "Which color?",
  layout_strategy = "vertical",
  layout_config = {
    height = 0.45,
    width = 0.25,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
  finder = finders.new_table(M.colorschemes),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  ---@diagnostic disable-next-line: unused-local
  attach_mappings = function(prompt_bufnr, map)
    local escape = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    map("i", escape, on_escape)
    map("i", "<C-c>", on_escape)
    map("i", "<CR>", enter)
    map("i", "<C-k>", prev_color)
    map("i", "<C-j>", next_color)
    return true
  end,
}

local colors = pickers.new(color_opts)

vim.api.nvim_create_user_command("Themer", function()
  colors:find()
end, {})

return M
