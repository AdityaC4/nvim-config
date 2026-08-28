-- tiny persisted key/value store (JSON on disk) for prefs that should
-- survive across nvim sessions: colorscheme choice, inlay hint toggle, etc.
local M = {}

local state_file = vim.fn.stdpath("state") .. "/nvim_prefs.json"

local function read()
  local f = io.open(state_file, "r")
  if not f then
    return {}
  end
  local content = f:read("*a")
  f:close()
  local ok, data = pcall(vim.json.decode, content)
  if ok and type(data) == "table" then
    return data
  end
  return {}
end

local function write(data)
  local f = io.open(state_file, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(data))
  f:close()
end

local cache = read()

function M.get(key, default)
  local v = cache[key]
  if v == nil then
    return default
  end
  return v
end

function M.set(key, value)
  cache[key] = value
  write(cache)
end

return M
