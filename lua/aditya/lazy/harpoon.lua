return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    local km = vim.keymap.set

    harpoon:extend({
      UI_CREATE = function(cx)
        km("n", "d", function()
          local idx = vim.fn.line(".")
          harpoon:list():remove_at(idx)
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { buffer = cx.bufnr })
      end,
    })

    km("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
    km("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

    km("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon to 1" })
    km("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon to 2" })
    km("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon to 3" })
    km("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon to 4" })

    km("n", "]h", function() harpoon:list():next() end, { desc = "Harpoon next" })
    km("n", "[h", function() harpoon:list():prev() end, { desc = "Harpoon prev" })

    km("n", "<leader>r", function() harpoon:list():remove() end, { desc = "Harpoon remove current" })
  end,
}
