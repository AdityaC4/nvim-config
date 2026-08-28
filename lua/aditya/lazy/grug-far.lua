return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "Search/Replace (grug-far)",
    },
  },
  config = function()
    require("grug-far").setup({})
  end,
}
