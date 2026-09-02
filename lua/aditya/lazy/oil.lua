return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },

        -- Floating window appearance
        float = {
          padding = 2,
          max_width = 0.8,
          max_height = 0.8,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          preview_split = "right",
        },
      })

      -- -- Open parent directory in current window
      -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "-", require("oil").toggle_float, { desc = "Open Oil" })
    end,
  },
}
