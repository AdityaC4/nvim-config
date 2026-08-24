-- colors.lua
-- Cycle-friendly colorscheme switcher

local function apply_semantic_overrides()
  vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "GruvboxOrange" })
  vim.api.nvim_set_hl(0, "@lsp.type.namespace.python", { link = "GruvboxOrange" })
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
  if color == "tokyonight" then
    -- transparent for Float & Normal
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  elseif color == "rose-pine" then
    -- force pure black
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
  end
  if color == "gruvbox" then
    apply_semantic_overrides()
  end
end

-- and again after any gruvbox load (colorscheme cmd wipes all highlight groups)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "gruvbox",
  callback = apply_semantic_overrides,
})

-- order matters: 1=gruvbox, 2=rose-pine, 3=tokyonight
local colorschemes = {
  "gruvbox",
  "rose-pine",
  "tokyonight",
  "rose-pine-light",
}
local index = 1
vim.keymap.set("n", "<leader>cc", function()
  index = (index % #colorschemes) + 1
  local scheme = colorschemes[index]
  vim.notify("Switching to colorscheme: " .. scheme)
  ColorMyPencils(scheme)
end, { desc = "Cycle Colorschemes" })

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
      ColorMyPencils("gruvbox")
    end,
  },
  -- 2) Rose-Pine (we'll override bg to pure black in the switcher)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_background = false, -- keep its own bg (we'll tweak it)
        styles = { italic = false },
      })
    end,
  },
  -- 3) Tokyo Night, transparent by default
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = true,
      })
    end,
  },
}

