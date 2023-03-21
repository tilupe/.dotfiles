local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Macchiato",
	font_size = 13.0,
	window_background_opacity = 0.9,
	font = wezterm.font_with_fallback({
		-- {
		-- 	family = "LeagueMono",
		-- 	weight = 300,
		--
		-- 	harfbuzz_features = { "zero" },
		-- },
		"JetBrains Mono NF",
		"MesloLGS NF",
	}),
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "NONE",
	audible_bell = "Disabled",
}
