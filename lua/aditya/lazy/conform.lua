local function format_with_prompt()
  local conform = require("conform")
  local bufnr = vim.api.nvim_get_current_buf()
  local formatters = conform.list_formatters(bufnr)

  if not vim.tbl_isempty(formatters) then
    conform.format({ async = true, lsp_format = "never" })
    return
  end

  local choice =
    vim.fn.confirm("No formatters available. Use LSP formatting?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.lsp.buf.format({ async = true })
  end
end

return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  init = function()
    vim.g.conform_format_on_save = false
    vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
      vim.g.conform_format_on_save = not vim.g.conform_format_on_save
      if vim.g.conform_format_on_save then
        print("Format on save enabled")
      else
        print("Format on save disabled")
      end
    end, {})
  end,
  keys = {
    {
      "<leader>f",
      format_with_prompt,
      mode = "",
      desc = "[F]ormat buffer (Conform first, prompt for LSP)",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if not vim.g.conform_format_on_save then
        return
      end
      return {
        timeout_ms = 500,
        lsp_format = "never",
        bufnr = bufnr,
      }
    end,
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
