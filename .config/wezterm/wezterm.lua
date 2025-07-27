local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrainsMono-Bold")
config.color_scheme = 'Tokyo Night Storm (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 14
config.audible_bell = "Disabled"
config.use_ime = false
config.enable_kitty_keyboard = false
config.window_background_opacity = 0.97
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.window_padding = {
  left = 1,
  right = 1,
  top = 0,
  bottom = 0,
}
return config
