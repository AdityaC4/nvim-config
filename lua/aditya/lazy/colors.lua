function ColorMyPencils(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local colorschemes = { "rose-pine", "gruvbox", "tokyonight" }
local index = 1

vim.keymap.set("n", "<leader>cc", function()
	index = (index % #colorschemes) + 1
	local scheme = colorschemes[index]
	vim.notify("Switching to colorscheme: " .. scheme)
	ColorMyPencils(scheme)
end, { desc = "Cycle Colorschemes" })

return {
	-- Rose Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})
			ColorMyPencils("rose-pine")
		end,
	},
	-- Gruvbox colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				contrast = "hard", -- Options: 'hard', 'soft', 'medium'
				transparent_mode = true,
			})
		end,
	},
	-- Tokyo Night colorscheme
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		config = function()
			require("tokyonight").setup({
				style = "moon", -- Options: 'storm', 'night', 'day', 'moon'
				transparent = true,
			})
		end,
	},
}
