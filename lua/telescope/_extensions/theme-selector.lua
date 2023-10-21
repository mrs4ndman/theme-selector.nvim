local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error "This extension requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)"
end

-- COLORIZER
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
-- local conf = require("telescope.config").values

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

local opts = {
  prompt_title = "Which color?",
  layout_strategy = "vertical",
  layout_config = {
    height = 0.45,
    width = 0.25,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
  finder = finders.new_table({
    "tokyodark",
    "tokyonight",
    "oxocarbon",
    "catppuccin",
    "github_dark_high_contrast",
    "rose-pine",
    "enfocado",
    "material-deep-ocean",
    "fluoromachine",
  }),
  sorter = sorters.get_generic_fuzzy_sorter({}),
---@diagnostic disable-next-line: unused-local
  attach_mappings = function(prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("i", "<C-k>", prev_color)
    map("i", "<C-j>", next_color)
    return true
  end,
}

local colors = pickers.new(opts)
-- last-color plugin
local theme = require("last-color").recall() or "tokyonight"
vim.cmd(("colorscheme %s"):format(theme))


-- local colorschemes = "habamax" or setup.user_opts
-- ---Creates the default picker options from the provided
-- ---options. If the `theme` field with a string value is added,
-- ---the system theme identified by that value is added to the options
-- ---@param opts table
-- setup.setup = function(opts)
--   errors = {}
--   if type(opts) ~= "table" then
--     local msg = "The list of colorschemes must be a table"
--     table.insert(errors, msg)
--     vim.notify(msg)
--   end
--   setup.config = vim.tbl_deep_extend("force", setup.default_opts, user_opts or {})
-- end
--
-- vim.api.nvim_create_user_command("ThemerTest", function()
--   local colors = pickers.new(setup.setup)
--   colors:find()
-- end, {})
--
local colorschemes = opts
M.default_opts = {
  prompt_title = "Which color?",
  layout_strategy = "vertical",
  layout_config = {
    height = 0.45,
    width = 0.25,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
  finder = finders.new_table(colorschemes),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  attach_mappings = function(prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("i", "<C-k>", prev_color)
    map("i", "<C-j>", next_color)
    return true
  end,
}

return require("telescope").register_extension({
  setup = function(config)
  end
})
