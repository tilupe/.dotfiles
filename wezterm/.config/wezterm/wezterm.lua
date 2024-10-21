local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

return {
	font_size = 17,
	cell_width = 0.95,
	--line_height = 0.95,
	font = wezterm.font_with_fallback({
		{ family = "Iosevka Term" },
		{ family = "CommitMono" },
		--{ family = "JetBrainsMono NFM"},
		--{ family = "InconsolataGoNerdFont", weight = "Medium" },
		--"MesloLGS NF",
	}),
	font_rules = {},

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
	window_background_opacity = 0.96,
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
	leader = { key = "a", mods = "ALT", timeout_milliseconds = 1000 },
	keys = {
		{ mods = "LEADER", key = "m", action = wezterm.action.TogglePaneZoomState },
		-- rotate panes
		{
			mods = "LEADER",
			key = "Space",
			action = wezterm.action.RotatePanes("Clockwise"),
		},
		-- show the pane selection mode, but have it swap the active and selected panes
		{
			mods = "LEADER",
			key = "0",
			action = wezterm.action.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		{
			key = "Enter",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},
		{
			key = "w",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
		{
			key = "y",
			mods = "LEADER",
			action = act.SwitchToWorkspace({
				name = "default",
			}),
		},
		{
			mods = "ALT",
			key = "w",
			action = wezterm.action_callback(function(window, pane)
				-- Here you can dynamically construct a longer list if needed
				local home = wezterm.home_dir
				local workspaces = {
					{ id = home, label = "Home" },
					{ id = home .. "/Development/Dg.Sales", label = "Sales" },
					{ id = home .. "/Development/devinite", label = "devinite" },
					{ id = home .. "/Documents/notes", label = "Notes" },
					{ id = home .. "/.dotfiles", label = "Dotfiles" },
					{ id = home .. "/.config/nvim", label = "Neovim" },
				}
				window:perform_action(
					act.InputSelector({
						action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
							if not id and not label then
								wezterm.log_info("cancelled")
							else
								wezterm.log_info("id = " .. id)
								wezterm.log_info("label = " .. label)
								inner_window:perform_action(
									act.SwitchToWorkspace({
										name = label,
										spawn = {
											label = "Workspace: " .. label,
											cwd = id,
										},
									}),
									inner_pane
								)
							end
						end),
						title = "Choose Workspace",
						choices = workspaces,
						fuzzy = true,
						-- Nightly version only: https://wezfurlong.org/wezterm/config/lua/keyassignment/InputSelector.html?h=input+selector#:~:text=These%20additional%20fields%20are%20also%20available%3A
						-- fuzzy_description = "Fuzzy find and/or make a workspace",
					}),
					pane
				)
			end),
		},
		{
			key = "q",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
	},

	color_scheme = "Everforest Dark (Gogh)",

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

	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},

	-- default_prog = { 'zellij', '-l', 'welcome' }
}
