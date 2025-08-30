return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "codelldb",
        "clang-format",
        "black",
      },
    },
  },
}
