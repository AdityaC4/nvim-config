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
          max_width = 0.9,
          max_height = 0.9,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          preview_split = "right",
        },
      })

      -- auto-open preview when oil float opens
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilEnter",
        callback = function()
          local oil = require("oil")
          if vim.api.nvim_win_get_config(0).relative == "" then return end
          if oil.get_cursor_entry() then
            oil.open_preview()
          end
        end,
      })

      -- -- Open parent directory in current window
      -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "-", require("oil").toggle_float, { desc = "Open Oil" })
    end,
  },
}
