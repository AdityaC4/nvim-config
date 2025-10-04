return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    -- 	-- Disable "format_on_save lsp_fallback" for languages that don't
    -- 	-- have a well standardized coding style. You can add additional
    -- 	-- languages here or re-enable it for the disabled ones.
    -- 	local disable_filetypes = { c = false, cpp = false }
    -- 	return {
    -- 		timeout_ms = 500,
    -- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    -- 	}
    -- end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      zig = { "zig_fmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
      zig_fmt = {
        command = "zig",
        args = { "fmt", "--stdin" },
        stdin = true,
      },
    },
  },
}
