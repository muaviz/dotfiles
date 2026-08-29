return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.black,
      }
    end,
  },
}
