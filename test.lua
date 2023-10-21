local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local colors =  function(opts)
  local opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Colors?",
    finder = finders.new_table ({
      results = { "red", "green", "blue" }
    }),
    sorter = conf.generic_sorter(opts),
  }):find()
end

colors()
