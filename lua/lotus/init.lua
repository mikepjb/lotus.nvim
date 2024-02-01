local util = require("lotus.util")
local theme = require("lotus.theme")

local M = {}

function M.colorscheme()
  util.load(theme.setup())
end

return M
