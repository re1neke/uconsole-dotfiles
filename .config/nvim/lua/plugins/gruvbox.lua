return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = true,
	opts = {
		terminal_colors = true, -- add neovim terminal colors
		undercurl = true,
		underline = true,
		bold = true,
		italic = {
			strings = false,
			emphasis = false,
			comments = false,
			operators = false,
			folds = false,
		},
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "hard", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
		palette_overrides = {
			dark0_hard = "#111111",
		},
	},
}
