local entry_display = require "telescope.pickers.entry_display"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local grapple = require "grapple"
local Path = require "plenary.path"

local function prepare_results(list)
  local next = {}
  for idx = 1, #list do
    if list[idx].filename ~= "" then
      list[idx].index = idx
      table.insert(next, list[idx])
    end
  end

  return next
end

local generate_new_finder = function()
  return finders.new_table {
    results = prepare_results(grapple.tags()),
    entry_maker = function(entry)
      local file_path = Path:new(entry.file_path):make_relative(vim.loop.cwd())
      local row = entry.cursor[1]
      local col = entry.cursor[2]
      local line = file_path .. ":" .. row .. ":" .. col
      local displayer = entry_display.create {
        separator = " - ",
        items = {
          { width = 2 },
          { remaining = true },
        },
      }
      local make_display = function()
        return displayer {
          tostring(entry.index),
          line,
        }
      end
      return {
        value = entry,
        ordinal = line,
        display = make_display,
        lnum = row,
        col = col,
        filename = file_path,
      }
    end,
  }
end

return function(opts)
  opts = opts or {}

  pickers
    .new(opts, {
      prompt_title = "grapple marks",
      finder = generate_new_finder(),
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function(_, map)
        return true
      end,
    })
    :find()
end
