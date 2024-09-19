local wezterm = require 'wezterm'
local localconfig = require 'local'
local config = wezterm.config_builder()

config.initial_cols = 128;
config.initial_rows = 40;

config.colors = {
  foreground = '#E6EDF3',
  background = '#010409',

  selection_fg = '#264F78',
  selection_bg = '#E6EDF3',

  ansi = {
    '#484F59',
    '#F37B72',
    '#3FB850',
    '#E1D330',
    '#58A6FF',
    '#BC8CFF',
    '#4BC4CF',
    '#B1BAC3',
  },
  brights = {
    '#6E7680',
    '#F15F50',
    '#56D364',
    '#E3B341',
    '#79C0FF',
    '#D2A8FF',
    '#56D4DD',
    '#FFFFFF',
  },
}

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.keys = {
  {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.QuickSelect
  }
}

localconfig.apply_to_config(config)
return config
