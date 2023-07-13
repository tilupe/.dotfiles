local wezterm = require("wezterm")

return {
	font_size = 15.0,
	line_height = 0.95,
	cell_width = 0.90,
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono NF", weight = "Light" },
		"MesloLGS NF",
	}),

	automatically_reload_config = true,
	adjust_window_size_when_changing_font_size = false,
	hide_tab_bar_if_only_one_tab = true,
	max_fps = 144,
	animation_fps = 1,

	allow_square_glyphs_to_overflow_width = "Never",
	freetype_load_target = "HorizontalLcd",
	freetype_render_target = "HorizontalLcd",
	use_cap_height_to_scale_fallback_fonts = true,
	warn_about_missing_glyphs = false,

	window_decorations = "NONE",
	window_background_opacity = 0.85,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	audible_bell = "Disabled",
	visual_bell = {
		fade_in_duration_ms = 5,
		fade_out_duration_ms = 5,
		target = "CursorColor",
	},

	-- default_cursor_style = "SteadyBlock",
	cursor_blink_rate = 400,
	default_cursor_style = "BlinkingBlock",
	force_reverse_video_cursor = true,
	window_close_confirmation = "NeverPrompt",

	--colors = {
	--	background = "#191b1f",
	--	-- foreground = "#e3e5e8",
	--	foreground = "#d3d5d8",
	--	cursor = "#f2b90d",
	--	cursor_fg = "#191b1f",
	--	cursor_bg = "#ffffff",
	--	cursor_border = "#eeeeee",
	--	selection_bg = "#303233",
	--	selection_fg = "#cacecd",
	--	scrollbar_thumb = "#16161d",
	--	split = "#16161d",
	--	ansi = {
	--		"#282c34",
	--		"#c2290a",
	--		"#66b814",
	--		"#f2b90d",
	--		"#06a8f9",
	--		"#e06ef7",
	--		"#0ac2c2",
	--		"#d5d7dd",
	--	},
	--	brights = {
	--		"#595e68",
	--		"#f2330d",
	--		"#80e619",
	--		"#f5c73d",
	--		"#38b9fa",
	--		"#eb9efa",
	--		"#0df2f2",
	--		"#e3e5e8",
	--	},
	--},
	--
	keys = {
		{ key = "o", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "q", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(8) },
		{ key = "0", mods = "ALT", action = wezterm.action.ActivateTab(9) },
		{ key = "Enter", mods = "ALT", action = wezterm.action.ActivateTab(9) },
	},

	color_scheme = "GruvboxDark",

	wezterm.on("user-var-changed", function(window, pane, name, value)
		local overrides = window:get_config_overrides() or {}
		if name == "ZEN_MODE" then
			local incremental = value:find("+")
			local number_value = tonumber(value)
			if incremental ~= nil then
				while number_value > 0 do
					window:perform_action(wezterm.action.IncreaseFontSize, pane)
					number_value = number_value - 1
				end
				overrides.enable_tab_bar = false
			elseif number_value < 0 then
				window:perform_action(wezterm.action.ResetFontSize, pane)
				overrides.font_size = nil
				overrides.enable_tab_bar = true
			else
				overrides.font_size = number_value
				overrides.enable_tab_bar = false
			end
		end
		window:set_config_overrides(overrides)
	end),
}
