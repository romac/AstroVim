return {
  -- "jackMort/ChatGPT.nvim",
  "thehunmonkgroup/ChatGPT.nvim",
  branch = "edit-with-instructions-using-openai-functions",
  config = function()
    require("chatgpt").setup({})
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
