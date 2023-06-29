-- COLORIZER
local telescope = require "telescope"
local actions = telescope.actions
-- local action_state = telescope.actions.state
local pickers = telescope.pickers
local finders = telescope.finders
local sorters = telescope.sorters
local themer = require("themer.base")

function Colorizer()
	themer.colors:find()
end

