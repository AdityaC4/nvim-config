return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")

			-- Load VSCode-style snippets lazily (includes many languages)
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Optional: small tweaks
			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = false,
			})

			-- Extend js with jsdoc if you like
			ls.filetype_extend("javascript", { "jsdoc" })

			-- No <Tab>/<S-Tab> here! Those are handled by nvim-cmp mapping.
			-- Keep a choice switcher if you want:
			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "LuaSnip: next choice" })

			-- (Optional) A manual expand key if you ever need it:
			-- vim.keymap.set({ "i" }, "<C-k>", function()
			--   if ls.expandable() then ls.expand() end
			-- end, { silent = true, desc = "LuaSnip: expand" })
		end,
	},
}

