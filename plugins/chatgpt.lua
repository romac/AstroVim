return {
  "jackMort/ChatGPT.nvim",
  config = function()
    require("chatgpt").setup({
      openai_params = {
        model = "gpt-4"
      },
      openai_edit_params = {
        mode = "gpt-4"
      }
    })
  end,
  cmd = {
    "ChatGPT",
    "ChatGPTActAs",
    "ChatGPTCompleteCode",
    "ChatGPTEditWithInstructions",
    "ChatGPTRun"
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
