local aliases = {
  -- Set :W as an alias for :w
  { "W", "w" },
}

local function open_on_github(opts)
  local git_root = vim.fn.system { "git", "rev-parse", "--show-toplevel" }

  local file_path = vim.fn.expand("%:" .. git_root .. ":.")
  -- local file_path = vim.fn.expand "%:."
  if opts.range == 2 then file_path = file_path .. ":" .. opts.line1 end

  local git_branch = vim.fn.system { "git", "rev-parse", "--abbrev-ref", "HEAD" }
  git_branch = string.gsub(git_branch, "\n", "")

  vim.fn.system { "gh", "browse", file_path, "--branch", git_branch }
end

local commands = {
  {
    "GHOpen",
    open_on_github,
    { nargs = 0, range = true },
  },
}

return {
  load = function()
    for _, alias in ipairs(aliases) do
      vim.api.nvim_create_user_command(alias[1], alias[2], { nargs = 0 })
    end

    for _, command in ipairs(commands) do
      local name = command[1]
      local cmd = command[2]
      local opts = command[3] or {}

      vim.api.nvim_create_user_command(name, cmd, opts)
    end
  end,
}
