local util = require("lotus.util")

local M = {}

local tailwind = {
  stone_050 = "#fafaf9",
  stone_100 = "#f5f5f4",
  stone_200 = "#e7e5e4",
  stone_300 = "#d6d3d1",
  stone_400 = "#a8a29e",
  stone_500 = "#78716c",
  stone_600 = "#57534e",
  stone_700 = "#44403c",
  stone_800 = "#292524",
  stone_900 = "#1c1917",
  stone_950 = "#191615", -- unofficial
  
  amber_400 = "#fbbf24",

  orange_400 = "#fb923c",

  cyan_100 = "#cffafe",
  cyan_200 = "#a5f3fc",
  cyan_300 = "#67e8f9",
  cyan_400 = "#22d3ee",
  cyan_500 = "#06b6d4",
  cyan_800 = "#155e75",

  pink_300 = "#f9a8d4",
  pink_400 = "#f472b6",
  pink_500 = "#ec4899",


  violet_400 = "#a78bfa",
  violet_500 = "#8b5cf6",
  violet_600 = "#7c3aed"

}

---@param config Config
---@return ColorScheme
function M.setup(config)
  config = config or require("lotus.config")

  -- Color Palette
  ---@class ColorScheme
  local colors = {}

  colors = {
    none = "NONE",
    bg_dark = tailwind.stone_950,
    bg = tailwind.stone_900,
    bg_highlight = tailwind.stone_100,
    terminal_black = tailwind.stone_950,
    fg = tailwind.stone_050,
    fg_dark = tailwind.stone_400,
    fg_gutter = tailwind.stone_600,
    dark3 = tailwind.stone_950, -- NonText?
    comment = tailwind.stone_500,
    dark5 = tailwind.stone_600,
    blue = tailwind.cyan_400,
    cyan = tailwind.cyan_500,
    blue1 = tailwind.cyan_300,
    blue2 = tailwind.cyan_300,
    blue5 = tailwind.cyan_200,
    blue6 = tailwind.cyan_100,
    blue7 = tailwind.cyan_800,
    magenta = tailwind.violet_400,
    magenta2 = tailwind.violet_600,
    purple = tailwind.violet_400,
    orange = tailwind.orange_400,
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b",
    git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
    gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
  }
  if config.style == "night" or config.style == "day" or vim.o.background == "light" then
    colors.bg = "#1a1b26"
    colors.bg_dark = "#16161e"
  end
  util.bg = colors.bg
  util.day_brightness = config.dayBrightness

  colors.diff = {
    add = util.darken(colors.green2, 0.15),
    delete = util.darken(colors.red1, 0.15),
    change = util.darken(colors.blue7, 0.15),
    text = colors.blue7,
  }

  colors.gitSigns = {
    add = util.brighten(colors.gitSigns.add, 0.2),
    change = util.brighten(colors.gitSigns.change, 0.2),
    delete = util.brighten(colors.gitSigns.delete, 0.2),
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = tailwind.stone_400
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = (config.transparentSidebar and colors.none) or config.darkSidebar and colors.bg_dark or colors.bg
  colors.bg_float = config.darkFloat and colors.bg_dark or colors.bg

  colors.bg_visual = util.darken(tailwind.stone_800, 0.7)
  colors.bg_search = tailwind.stone_400
  colors.fg_sidebar = colors.fg_dark

  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  colors.user1 = tailwind.amber_400

  util.color_overrides(colors, config)

  if config.transform_colors and (config.style == "day" or vim.o.background == "light") then
    return util.light_colors(colors)
  end

  return colors
end

return M
