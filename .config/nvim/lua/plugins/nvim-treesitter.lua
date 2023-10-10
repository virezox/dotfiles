local load_textobjects = false
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "css",
        "csv",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "graphql",
        "html",
        "http",
        "java",
        "javascript",
        "json",
        "kotlin",
        "lua",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "proto",
        "python",
        "query",
        "regex",
        "requirements",
        "ron",
        "rust",
        "scss",
        "sql",
        "ssh_config",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vimdoc",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml",
        "zig",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      autopairs = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}