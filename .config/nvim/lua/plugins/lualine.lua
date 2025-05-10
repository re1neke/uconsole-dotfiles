return {
	"nvim-lualine/lualine.nvim",
	requires = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		options = {
			theme = "gruvbox_dark",
			section_separators = {
				left = "",
				right = "",
			},
			component_separators = {
				left = "",
				right = "",
			}
		},
		extensions = {
			"nvim-tree",
			"trouble",
		},
	}
}
