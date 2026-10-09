local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.default_domain = 'WSL:Ubuntu'
config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.0
-- Mica backdrop at zero opacity: wallpaper tint renders cleanly, no DWM
-- gray patches (partial alpha alongside a backdrop is what caused them)
config.win32_system_backdrop = "Mica"
-- Text cells stay fully opaque so background bleed never hurts readability
config.text_background_opacity = 1.0
-- Borderless with working resize border; DWM re-adds dead min/max/close
-- buttons while any system backdrop is set (upstream wezterm#3598, still open)
config.window_decorations = "RESIZE"
-- Tab bar back on as the visible drag handle
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
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
