vim.opt.clipboard = "unnamedplus"

local has = vim.fn.has
local exe = vim.fn.executable

local is_wsl = has("wsl") == 1
local is_win = (has("win32") == 1) or (has("win64") == 1) or (vim.loop.os_uname().sysname == "Windows_NT")
local is_mac = (has("mac") == 1) or (vim.loop.os_uname().sysname == "Darwin")
local is_wayland = (os.getenv("WAYLAND_DISPLAY") ~= nil)
local has_display = (os.getenv("DISPLAY") ~= nil) or is_wayland

if is_wsl then
  -- WSL2 -> bridge to Windows clipboard
  if exe("win32yank.exe") == 1 then
    vim.g.clipboard = {
      name          = "WslClipboard",
      copy          = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
      paste         = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
      cache_enabled = 0,
    }
  elseif exe("clip.exe") == 1 and exe("powershell.exe") == 1 then
    vim.g.clipboard = {
      name          = "WslClipboard",
      copy          = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
      paste         = { ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard", ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard" },
      cache_enabled = 0,
    }
  end
elseif is_win then
  if exe("win32yank.exe") == 1 then
    vim.g.clipboard = {
      name          = "win32yank",
      copy          = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
      paste         = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
      cache_enabled = 0,
    }
  elseif exe("clip.exe") == 1 and exe("powershell.exe") == 1 then
    vim.g.clipboard = {
      name          = "windows-clipboard",
      copy          = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
      paste         = { ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard", ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard" },
      cache_enabled = 0,
    }
  end
elseif is_mac then
  -- macOS -> built-in tools
  vim.g.clipboard = {
    name          = "macOS-clipboard",
    copy          = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    paste         = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 0,
  }
else
  -- Native Linux
  -- Prefer Wayland tools if on Wayland, else xclip (X11)
  if is_wayland and exe("wl-copy") == 1 and exe("wl-paste") == 1 then
    vim.g.clipboard = {
      name          = "wl-clipboard",
      copy          = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
      paste         = { ["+"] = "wl-paste -n", ["*"] = "wl-paste -n" },
      cache_enabled = 0,
    }
  elseif has_display and exe("xclip") == 1 then
    vim.g.clipboard = {
      name          = "xclip",
      copy          = { ["+"] = "xclip -selection clipboard", ["*"] = "xclip -selection primary" },
      paste         = { ["+"] = "xclip -selection clipboard -o", ["*"] = "xclip -selection primary -o" },
      cache_enabled = 0,
    }
  elseif has_display and exe("xsel") == 1 then
    vim.g.clipboard = {
      name          = "xsel",
      copy          = { ["+"] = "xsel --clipboard --input", ["*"] = "xsel --primary --input" },
      paste         = { ["+"] = "xsel --clipboard --output", ["*"] = "xsel --primary --output" },
      cache_enabled = 0,
    }
  end
end

if not vim.g.clipboard then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  if ok then
    vim.g.clipboard = {
      name          = "osc52",
      copy          = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
      paste         = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
      cache_enabled = 0,
    }
  end
end
