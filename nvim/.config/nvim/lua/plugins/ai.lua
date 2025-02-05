-- Codeium

-- return {
-- 	"Exafunction/codeium.vim",
-- 	event = "InsertEnter",
-- 	-- after the commit :wq stop responding
-- 	-- commit = "3cc779d",
-- 	keys = {
-- 		{ "<C-x>", ":CodeiumToggle<CR>", desc = "Codeium toggle" },
-- 	},
-- 	config = function()
-- 		vim.keymap.set("i", "<C-a>", function()
-- 			return vim.fn["codeium#Accept"]()
-- 		end, { expr = true, silent = true })
-- 		vim.keymap.set("i", "<C-c>", function()
-- 			return vim.fn["codeium#CycleCompletions"](1)
-- 		end, { expr = true, silent = true })
-- 		-- Disable TAB
-- 		vim.g.codeium_no_map_tab = 1
-- 	end,
-- }

-- NeoCodeium

return {
	"monkoose/neocodeium",
	event = "InsertEnter",
	keys = {
		{ "<C-x>", ":NeoCodeium toggle<CR>", desc = "NeoCodeium toggle" },
	},
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup({
			-- enabled = false,
			-- show_label = false,
			silent = true,
		})
		vim.keymap.set("i", "<C-a>", neocodeium.accept)
		vim.keymap.set("i", "<C-c>", neocodeium.cycle)
	end,
}

-- return {
-- 	"supermaven-inc/supermaven-nvim",
-- 	-- event = "InsertEnter",
-- 	config = function()
-- 		require("supermaven-nvim").setup({
-- 			-- keymaps = {
-- 			-- 	accept_suggestion = "<Tab>",
-- 			-- 	clear_suggestion = "<C-]>",
-- 			-- 	accept_word = "<C-j>",
-- 			-- },
-- 			-- ignore_filetypes = { cpp = false }, -- or { "cpp", }
-- 			-- color = {
-- 			-- 	suggestion_color = "#DDDDDD",
-- 			-- 	cterm = 244,
-- 			-- },
-- 			-- log_level = "info", -- set to "off" to disable logging completely
-- 			-- disable_inline_completion = false, -- disables inline completion for use with cmp
-- 			-- disable_keymaps = false, -- disables built in keymaps for more manual control
-- 			-- condition = function()
-- 			-- 	return false
-- 			-- end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
-- 		})
-- 	end,
-- }
