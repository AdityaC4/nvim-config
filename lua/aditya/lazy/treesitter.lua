return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local install_dir = vim.fn.stdpath("data") .. "/site"
    vim.opt.runtimepath:prepend(install_dir)

    require("nvim-treesitter").setup({
      install_dir = install_dir,
    })

    require("nvim-treesitter").install({
      "vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust",
      "python", "jsdoc", "bash", "vim", "query", "markdown",
      "markdown_inline", "json", "yaml", "toml", "html", "css", "zig",
    })

    -- Highlighting is NOT automatic on main. You turn it on yourself.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- Indentation is also manual on main, and still experimental.
    -- Note the exact quoting -- it matters.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua", "python", "rust", "c", "cpp", "javascript", "typescript" },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
