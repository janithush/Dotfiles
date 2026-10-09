local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.default_domain = 'WSL:Ubuntu'
config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.98
-- Text cells stay fully opaque so background bleed never hurts readability
config.text_background_opacity = 1.0
-- Borderless clean look: no titlebar, no min/max/close buttons by design
config.window_decorations = "RESIZE"
-- Tab bar disabled: move via CTRL-SHIFT + Left-drag (no buttons by design)
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- CTRL-SHIFT + Left-drag anywhere moves the window across monitors
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL|SHIFT",
    action = wezterm.action.StartWindowDrag,
  },
}
return config
