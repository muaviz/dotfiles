return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "codelldb",
        "clang-format",
        "black",
        "debugpy",
      },
    },
  },
}
