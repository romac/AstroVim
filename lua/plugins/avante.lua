---@type LazySpec
return {
  "yetone/avante.nvim",
  opts = {
    provider = "copilotclaude",
    hints = { enabled = false },
    providers = {
      copilotclaude = {
        __inherited_from = "copilot",
        api_key_name = "GITHUB_TOKEN",
        model = "claude-4-sonnet",
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 8192,
        },
      },
    },
  },
}
