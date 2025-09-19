return {
	"whoissethdaniel/mason-tool-installer.nvim",
	-- event = "VeryLazy",
	config = function()
		-- Функция проверки архитектуры для установки cpptools
		local packet = function()
			local handle = io.popen("uname -m", "r")
			if handle then
				local arch = handle:read("*a")
				handle:close()
				-- Delete all unnesary symbols
				arch = arch:gsub("\n", "")
				if arch == "aarch64" then
					return
				else
					-- Перечислить нужные пакеты здесь в фроматее
					-- return "cpptools", "beautysh"
					return "cpptools"
				end
			end
		end

		require("mason-tool-installer").setup({
			            ensure_installed = {
			                "prettier", -- ts/js formatter
			                "stylua", -- lua formatter
			                "eslint_d", -- ts/js linter
			                "clang-format", -- C formater
			                "shfmt", -- Shell formatter
			                "shellcheck", -- Shell linter
							packet(),
						},			auto_update = true,
			run_on_start = true,
		})
	end,
}
