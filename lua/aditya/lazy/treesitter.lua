return {
    "nvim-treesitter/nvim-treesitter",
    build = "TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                "jsdoc", "bash",
            },

            sync_install = false,
            -- Automatically install missing parsers when entering buffer
            -- needs tree-sitter CLI installed locally
            auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end
}
