return {
	{
		"Exafunction/windsurf.vim",
		lazy = true,
		cmd = { "CodeiumEnable", "CodeiumToggle" },
		config = function()
			-- Optional: Disable default keybindings
			vim.g.codeium_disable_bindings = 1

			-- Custom keybindings
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
			-- Accept next word from suggestion
			vim.keymap.set("i", "<C-k>", function()
				return vim.fn["codeium#AcceptNextWord"]()
			end, { expr = true, silent = true })

			-- Accept next line from suggestion
			vim.keymap.set("i", "<C-l>", function()
				return vim.fn["codeium#AcceptNextLine"]()
			end, { expr = true, silent = true })
		end,
	},
}
