return {
	"nvimdev/lspsaga.nvim",
	-- event = "VeryLazy",
	ft = { "lua", "python", "sh", "c", "cpp", "arduino", "html", "css" },
	config = function()
		require("lspsaga").setup({
			ui = {
				-- border = "rounded",
				border = "solid",
				-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				devicon = true,
				title = true,
				expand = "⊟",
				code_action = " ",
				actionfix = " ",
				lines = { "╰", "├", "│", "─", "╭" },
				-- kind = {},
				imp_sign = "󰳛",
			},
			diagnostic = {
				show_code_action = true,
				jump_num_shortcut = true,
				max_width = 0.6,
				max_height = 0.6,
				text_hl_follow = true,
				border_follow = true,
				extend_relatedInformation = false,
				show_layout = "float",
				show_normal_height = 10,
				max_show_width = 0.9,
				max_show_height = 0.6,
				diagnostic_only_current = false,
				keys = {
					quit = { "q", "<ESC>" },
					exec_action = "o",
					toggle_or_jump = "<CR>",
					quit_in_show = { "q", "<ESC>" },
				},
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
