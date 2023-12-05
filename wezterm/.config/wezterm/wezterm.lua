local wezterm = require("wezterm")

return {
	font_size = 12.0,
	cell_width = 0.85,
	font = wezterm.font_with_fallback({
		{
			family = "Monaspace Neon Var",
			-- family='Monaspace Argon Var',
			-- family='Monaspace Xenon Var',
			-- family='Monaspace Radon Var',
			-- family='Monaspace Krypton Var',
			weight = "DemiBold",
			harfbuzz_features = {
				"calt",
				"liga",
				"dlig",
				"ss01",
				"ss02",
				"ss03",
				"ss04",
				"ss05",
				"ss06",
				"ss07",
				"ss08",
			},
		},
		{ family = "JetBrains Mono NF", weight = "Light" },
		"MesloLGS NF",
	}),
	font_rules = {
		--
		-- Italic (comments)
		--
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "Monaspace Argon Var",
				weight = "Regular",
				stretch = "Normal",
				style = "Normal",
				harfbuzz_features = {
					"calt",
					"liga",
					"dlig",
					"ss01",
					"ss02",
					"ss03",
					"ss04",
					"ss05",
					"ss06",
					"ss07",
					"ss08",
				},
			}),
		},

		--
		-- -- Bold (highlighting)
		-- --
		-- {
		-- 	intensity = "Bold",
		-- 	italic = false,
		-- 	font = wezterm.font({
		-- 		family = "Monaspace Krypton Var",
		-- 		weight = "Black",
		-- 		stretch = "Normal",
		-- 		style = "Normal",
		-- 		harfbuzz_features = {
		-- 			"calt",
		-- 			"liga",
		-- 			"dlig",
		-- 			"ss01",
		-- 			"ss02",
		-- 			"ss03",
		-- 			"ss04",
		-- 			"ss05",
		-- 			"ss06",
		-- 			"ss07",
		-- 			"ss08",
		-- 		},
		-- 	}),
		-- },
	},

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

	---- Melange colors
	--colors = {
	--	foreground = "#ECE1D7",
	--	background = "#292522",
	--	cursor_bg = "#ECE1D7",
	--	cursor_border = "#ECE1D7",
	--	cursor_fg = "#292522",
	--	selection_bg = "#403A36",
	--	selection_fg = "#ECE1D7",
	--	ansi = {
	--		"#34302C",
	--		"#BD8183",
	--		"#78997A",
	--		"#E49B5D",
	--		"#7F91B2",
	--		"#B380B0",
	--		"#7B9695",
	--		"#C1A78E",
	--	},
	--	brights = {
	--		"#867462",
	--		"#D47766",
	--		"#85B695",
	--		"#EBC06D",
	--		"#A3A9CE",
	--		"#CF9BC2",
	--		"#89B3B6",
	--		"#ECE1D7",
	--	},
	--},
	keys = {
		{ key = "w", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
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
