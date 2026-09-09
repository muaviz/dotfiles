-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_python_lsp = "pyright"

-- Use xclip to interface with Xwayland clipboard bridge, eliminating Wayland window restacking flicker
vim.g.clipboard = "xclip"
