return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
        jack = { "jack_format" },
      },
      formatters = {
        jack_format = {
          command = vim.fn.executable("jack-format") == 1 and "jack-format"
            or (vim.fn.stdpath("config") .. "/bin/jack-format.py"),
          stdin = true,
        },
      },
    },
  },
}

