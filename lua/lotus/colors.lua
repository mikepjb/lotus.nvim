local util = require("lotus.util")

local M = {}

-- TODO delete this
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

local lotus = {
    base03 = "#1c1c1c",
    base02 = "#2c2c2c", -- regular background, matching terminal
    base01 = "#3c3c3c",
    base00 = "#444444",
    base0  = "#5e5e5e",
    base1  = "#cdcdcd",
    base2  = "#e5e5e5",
    base3  = "#eeeeee", -- regular text color, matching terminal

    red = "#FF8C8C",
    light_red = "#FFB2B2",
    green = "#8BFF95",
    light_green = "#CBFFB2",
    yellow = "#FFD08D",
    light_yellow = "#FFDFB2",
    blue = "#4FA7FF",
    light_blue = "#B3CCFF",
    magenta = "#FF8DFF",
    light_magenta = "#FFB3FF",
    cyan = "#8DFFF0",
    light_cyan = "#B2FFF5",
}

---@param config Config
---@return ColorScheme
function M.setup(config)
  config = config or require("lotus.config")

  -- Color Palette
  ---@class ColorScheme
  local colors = {}

  colors = {
    base03 = lotus.base03,
    base02 = lotus.base02,
    base01 = lotus.base01,
    base00 = lotus.base00,
    base0  = lotus.base0,
    base1  = lotus.base1,
    base2  = lotus.base2,
    base3  = lotus.base3, -- regular text color, matching terminal

    red = lotus.red,
    light_red = lotus.light_red,
    green = lotus.green,
    light_green = lotus.light_green,
    yellow = lotus.yellow,
    light_yellow = lotus.light_yellow,
    blue = lotus.blue,
    light_blue = lotus.light_blue,
    magenta = lotus.magenta,
    light_magenta = lotus.light_magenta,
    cyan = lotus.cyan,
    light_cyan = lotus.light_cyan,

    none = "NONE",
    bg_highlight = tailwind.stone_100,
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
    green1 = "#73daca",
    green2 = "#41a6b5",
    red1 = "#db4b4b",
    git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
    gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
  }
  if config.style == "night" or config.style == "day" or vim.o.background == "light" then
    colors.bg = "#1a1b26"
    colors.bg_dark = "#16161e"
  end
  util.bg = lotus.base02
  util.day_brightness = config.dayBrightness

  colors.diff = {
    add = util.darken(lotus.green, 0.15), -- errors here
    delete = util.darken(lotus.red, 0.15),
    change = util.darken(lotus.blue, 0.15),
    text = lotus.blue,
  }

  colors.gitSigns = {
    add = util.brighten(colors.gitSigns.add, 0.2),
    change = util.brighten(colors.gitSigns.change, 0.2),
    delete = util.brighten(colors.gitSigns.delete, 0.2),
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.base02, 0.8, "#000000")
  colors.border_highlight = tailwind.stone_400
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.base01

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = (config.transparentSidebar and colors.none) or config.darkSidebar and colors.bg_dark or colors.bg
  colors.bg_float = config.darkFloat and colors.bg_dark or colors.bg

  colors.bg_visual = util.darken(colors.base01, 0.7)
  colors.bg_search = tailwind.stone_400
  colors.fg_sidebar = colors.fg_dark

  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  colors.status = colors.light_cyan

  util.color_overrides(colors, config)

  if config.transform_colors and (config.style == "day" or vim.o.background == "light") then
    return util.light_colors(colors)
  end

  return colors
end

return M
