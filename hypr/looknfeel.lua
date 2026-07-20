-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

--------------------------------------------------------------------------------
-- COLOR PALETTES & GRADIENTS
--------------------------------------------------------------------------------
-- Theme Presets:
-- 1. Catppuccin Sunset: Mauve -> Sapphire -> Flamingo
local catppuccin_sunset = { colors = { "rgba(cba6f7ee)", "rgba(89b4faee)", "rgba(f2cdcdee)" }, angle = 45 }
-- 2. Cyberpunk Neon: Electric Pink -> Cyan
local cyberpunk_neon = { colors = { "rgba(ff007fee)", "rgba(00f0ffee)" }, angle = 45 }
-- 3. Tokyo Night: Vibrant Blue -> Soft Purple
local tokyo_night = { colors = { "rgba(7aa2f7ee)", "rgba(bb9af7ee)" }, angle = 45 }
-- 4. Emerald Aurora: Teal -> Mint
local emerald_aurora = { colors = { "rgba(81e6d9ee)", "rgba(38b2acee)" }, angle = 45 }

-- Active window border gradient selection (Change this to any preset above or customize)
local active_border_color = catppuccin_sunset

-- Inactive window border (Subtle frosted dark dual-tone outline)
local inactive_border_color = { colors = { "rgba(313244aa)", "rgba(45475aaa)" }, angle = 45 }

--------------------------------------------------------------------------------
-- GENERAL LOOK & FEEL
--------------------------------------------------------------------------------
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 2,

		col = {
			active_border = active_border_color,
			inactive_border = inactive_border_color,
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	-- Group / Tabbed window border colors
	group = {
		col = {
			border_active = active_border_color,
			border_inactive = inactive_border_color,
		},
	},

	decoration = {
		rounding = 12,
		rounding_power = 2,

		-- Transparency of focused and unfocused windows
		active_opacity = 0.98,
		inactive_opacity = 0.92,

		-- Soft ambient drop shadows
		shadow = {
			enabled = true,
			range = 12,
			render_power = 3,
			color = "rgba(1a1a1aee)",
			color_inactive = "rgba(10101099)",
		},

		-- Glassmorphism background blur
		blur = {
			enabled = true,
			size = 6,
			passes = 2,
			vibrancy = 0.1696,
			new_optimizations = true,
			popups = true,
		},
	},

	animations = {
		enabled = false,
	},
})

--------------------------------------------------------------------------------
-- ANIMATIONS & BEZIER CURVES
--------------------------------------------------------------------------------
-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 10, bezier = "linear" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

--------------------------------------------------------------------------------
-- LAYOUTS & RULES
--------------------------------------------------------------------------------
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})
