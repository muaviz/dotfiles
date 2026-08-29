return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://localhost:11434",
            },
            schema = {
              model = {
                default = "deepseek-coder", -- Put your model here
              },
            },
          })
        end,
      },
    })

    -- Keymaps similar to your old setup
    vim.keymap.set({ "n", "v" }, "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>e", "<cmd>CodeCompanion /explain<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>r", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true })
  end,
}
