---@type LazySpec
return {
  "yetone/avante.nvim",
  opts = {
    provider = "copilotclaude",
    hints = { enabled = false },
    vendors = {
      copilotclaude = {
        __inherited_from = "copilot",
        api_key_name = "GITHUB_TOKEN",
        model = "claude-3.5-sonnet",
        max_tokens = 4096,
      },
    },
  },
}
