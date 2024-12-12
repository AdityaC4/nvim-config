vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- diagnostic keymaps
local diagnostic_enabled = true

function ToggleInlineDiagnostics()
	diagnostic_enabled = not diagnostic_enabled
	vim.diagnostic.config({
		virtual_text = diagnostic_enabled,
	})
	if diagnostic_enabled then
		print("Inline diagnostics enabled")
	else
		print("Inline diagnostics disabled")
	end
end

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>E", ToggleInlineDiagnostics, { desc = "Toggle inline diagnostics" })

-- basic movement keys for splits
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y"]])
vim.keymap.set("n", "<leader>Y", [["+Y"]])

-- move text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vertical movement
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- stupid semicolon hack
vim.keymap.set("n", "<leader>;", function()
	local line = vim.api.nvim_get_current_line()
	if not line:match(";$") then
		vim.api.nvim_set_current_line(line .. ";")
	end
end, { desc = "Append `;` at the end of the line if missing", silent = true })
