-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ~/.config/nvim/lua/plugins/keymaps.lua
return {
  {
    "nvimtools/none-ls.nvim",
    keys = {
      { "<leader>gf", vim.lsp.buf.format, desc = "Format with LSP" },
    },
  },
}
