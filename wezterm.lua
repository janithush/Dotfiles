local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.default_domain = 'WSL:Ubuntu'
return config
