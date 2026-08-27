-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 12
wezterm.font("Fira Code", {weight="Medium", stretch="Normal", style="Normal"})

config.window_background_opacity = 0.5

config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
