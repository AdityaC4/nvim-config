-- colors.lua
-- Persisted colorscheme picker (survives across sessions)

local state = require("aditya.state")

-- theme-agnostic overrides: `Type` exists in every colorscheme, so linking
-- to it (instead of a scheme-specific group) keeps this working across all
-- 4 themes without per-scheme branches.
local function apply_semantic_overrides()
  vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.namespace.python", { link = "Type" })
  -- soften the colorcolumn guide: CursorLine's subtle bg reads better than
  -- each scheme's raw ColorColumn default across all 4 themes.
  vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })
end

local function ColorMyPencils(color)
  color = color or "gruvbox"
  if color == "rose-pine-light" then
    require("rose-pine").setup({
      variant = "dawn",
      styles = { italic = false },
    })
    vim.cmd.colorscheme("rose-pine")
  else
    vim.cmd.colorscheme(color)
  end
  apply_semantic_overrides()
  -- lualine's own "auto" theme detection self-heals on ColorScheme, but
  -- doesn't reliably win the race against our very first startup apply --
  -- force a re-setup so the statusline always matches on launch too.
  local ok_lualine, lualine = pcall(require, "lualine")
  if ok_lualine then
    lualine.setup()
  end
end

-- re-apply after any colorscheme load (colorscheme cmd wipes all highlight groups)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_semantic_overrides,
})

local colorschemes = {
  "gruvbox",
  "rose-pine",
  "tokyonight",
  "rose-pine-light",
  "kanagawa",
  "catppuccin",
  "everforest",
  "github_dark_default",
  "vscode",
}

-- fuzzy-searchable picker (renders via telescope-ui-select, already wired up)
vim.keymap.set("n", "<leader>cc", function()
  vim.ui.select(colorschemes, { prompt = "Colorscheme" }, function(choice)
    if not choice then
      return
    end
    ColorMyPencils(choice)
    state.set("colorscheme", choice)
  end)
end, { desc = "Pick Colorscheme" })

-- apply the last-picked scheme once everything is loaded, so ordering
-- between the 4 colorscheme plugins never matters
-- "VeryLazy" is lazy.nvim's own signal that eager (non-lazy) plugins have
-- finished loading -- safer than VimEnter, which can race lazy's scheduler.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    ColorMyPencils(state.get("colorscheme", "gruvbox"))
  end,
})

return {
  -- 1) Gruvbox as the startup default
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000, -- load first
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false, -- opaque background
      })
    end,
  },
  -- 2) Rose-Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = { italic = false },
      })
    end,
  },
  -- 3) Tokyo Night
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "moon",
      })
    end,
  },
  -- 4) Kanagawa
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      require("kanagawa").setup({})
    end,
  },
  -- 5) Catppuccin (mocha flavour)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "stable", -- avoids main-branch has("nvim-0.12") checks that outrun nightly builds
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
    end,
  },
  -- 6) Everforest
  {
    "neanias/everforest-nvim",
    name = "everforest",
    config = function()
      require("everforest").setup({})
    end,
  },
  -- 7) GitHub Dark Default
  {
    "projekt0n/github-nvim-theme",
    name = "github-nvim-theme",
    config = function()
      require("github-theme").setup({})
    end,
  },
  -- 8) VS Code Dark
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    config = function()
      require("vscode").setup({
        style = "dark",
      })
    end,
  },
}

