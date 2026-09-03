-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.filetype.add({
  extension = {
    jack = "jack",
    hdl = "hdl",
    vm = "vm",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "jack",
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.cinwords = "if,else,while,class,constructor,function,method"
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.commentstring = "// %s"
  end,
})
