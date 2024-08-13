local wezterm = require 'wezterm'
local localconfig = require 'local'
local config = wezterm.config_builder()

config.color_scheme = 'Tomorrow Night Bright'

config.window_decorations = 'RESIZE'

localconfig.apply_to_config(config)
return config
