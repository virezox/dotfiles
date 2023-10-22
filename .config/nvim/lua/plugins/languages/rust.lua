return {
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = { "rust" },
    dependencies = {
      "rust-lang/rust.vim",
      "mfussenegger/nvim-dap",
      "saecki/crates.nvim",
    },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
      local codelldb_adapter = {
        type = "server",
        port = "${port}",
        executable = {
          command = mason_path .. "bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      local opts = {
        tools = {
          on_initialized = function()
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
              pattern = { "*.rs" },
              callback = function()
                local clients = vim.lsp.get_active_clients()
                for _, client in pairs(clients) do
                  if client.supports_method "textDocument/codeLens" then
                    pcall(vim.lsp.codelens.refresh)
                    return
                  end
                end
              end,
            })
          end,
        },
        dap = {
          adapter = codelldb_adapter,
        },
        server = {
          on_attach = require("util").on_attach(function(client, buffer)
            require("plugins.lsp.keymaps").on_attach(client, buffer)
          end),
          capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
          settings = {
            ["rust-analyzer"] = {
              lens = {
                enable = true,
              },
              checkOnSave = {
                enable = true,
                command = "clippy",
              },
            },
          },
        },
      }

      require("rust-tools").setup(opts)

      local dap = require "dap"
      dap.adapters.codelldb = codelldb_adapter
      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    lazy = true,
    tag = "v0.4.0",
    event = { "BufRead Cargo.toml" },
    opts = {
      popup = {
        -- border = "rounded",
      },
      src = {
        cmp = {
          enabled = true,
        },
      },
    },
  },
}
