-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 12
config.font = wezterm.font {
    family="Fira Code",
    weight="Medium", stretch="Normal", style="Normal",
    harfbuzz_features = {"ss05", "ss02", "ss09"},
  }


config.window_background_opacity = 0.5

config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
