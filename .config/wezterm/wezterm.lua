local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrainsMono-Bold")
config.color_scheme = "tokyonight_moon"
config.font_size = 12
config.audible_bell = "Disabled"
config.use_ime = false
config.enable_kitty_keyboard = false
config.window_background_opacity = 1.00
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0,
}
-- disable wezterm shortcuts so things like CTRL+^ work in vim
config.disable_default_key_bindings = true
config.keys = {
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
}

if  os.getenv("PC_PROFILE") == "WORK" then
    -- i might need to see the other configs
    config.hide_tab_bar_if_only_one_tab = true
    -- WSL domain
    config.wsl_domains = {
        {
            name = "WSL:Ubuntu",
            distribution = "Ubuntu",
        },
    }

    -- Default shell: PowerShell
    config.default_prog = { "pwsh.exe", "-NoLogo" }

    -- Launch menu entries
    config.launch_menu = {
        {
            label = "PowerShell",
            args = { "pwsh.exe", "-NoLogo" },
        },
        {
            label = "Command Prompt",
            args = { "cmd.exe" },
        },
    }
    end
return config
