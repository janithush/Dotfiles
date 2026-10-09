local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.default_domain = 'WSL:Ubuntu'
config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.0
-- Tabbed system backdrop renders the wallpaper tint cleanly at zero opacity;
-- partial alpha (e.g. 0.98) alongside a DWM backdrop causes gray-patch artifacts
config.win32_system_backdrop = "Tabbed"
-- Text cells stay fully opaque so background bleed never hurts readability
config.text_background_opacity = 1.0
-- Full borderless: no titlebar, no buttons (NONE also drops the resize border,
-- so resizing uses OS shortcuts; move via CTRL-SHIFT + Left-drag)
config.window_decorations = "NONE"
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
