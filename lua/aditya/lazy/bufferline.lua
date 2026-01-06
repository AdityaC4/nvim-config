return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers", -- "tabs" also works, but buffers is the common choice
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        local icons = { error = " ", warning = " ", info = " ", hint = "󰌵 " }
        local out = {}
        for name, n in pairs(diag) do
          if n > 0 and icons[name] then
            table.insert(out, icons[name] .. n)
          end
        end
        return #out > 0 and (" " .. table.concat(out, " ")) or ""
      end,

      separator_style = "thin", -- "thin" | "thick" | "slant" | { '…', '…' }
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false, -- avoids clutter
      always_show_bufferline = true,
      enforce_regular_tabs = false,

      -- nicer UX when buffers are deleted
      persist_buffer_sort = true,

      -- sidebar integrations
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
        {
          filetype = "aerial",
          text = "Symbols",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },

      -- optional: keep the bar clean
      custom_filter = function(bufnr)
        local bt = vim.bo[bufnr].buftype
        if bt == "terminal" then return false end
        return true
      end,

      -- recommended: makes selecting buffers fast
      numbers = function(opts)
        return string.format("%s", opts.ordinal)
      end,

      hover = {
        enabled = true,
        delay = 150,
        reveal = { "close" },
      },
    },
  },

  -- handy default keymaps
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
    { "<leader>bD", "<cmd>BufferLinePickClose<cr>", desc = "Pick close buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
    { "<leader>bs", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
    { "<leader>bS", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by extension" },
  },
}

