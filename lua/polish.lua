-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local dark_mode = vim.trim(vim.fn.system { "dark-mode", "status" })
if dark_mode == "off" then
  vim.o.background = "light"
else
  vim.o.background = "dark"
end

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    qnt = "quint",
    wit = "wit",
  },
  filename = {
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
  },
}

local aliases = {
  -- Set :W as an alias for :w
  { "W", "w" },
}

for _, alias in ipairs(aliases) do
  vim.api.nvim_create_user_command(alias[1], alias[2], { nargs = 0 })
end
