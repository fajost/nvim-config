local plugins = {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local default_conf = require "plugins.configs.nvimtree"
      local nvim_tree_api = require "nvim-tree.api"

      local function my_on_attach(bufnr)
        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        nvim_tree_api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "l", nvim_tree_api.node.open.edit, opts "open")
      end

      default_conf.on_attach = my_on_attach
      default_conf.renderer.group_empty = true
      return require "plugins.configs.nvimtree"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "html",
        "javascript",
        "css",
        "python",
        "rust",
        "go",
        "markdown",
        "bash",
        "fish",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, mode = "n", desc = "Open harpoon window" },
      { "<leader>A", function() require("harpoon"):list():append() end, mode = "n", desc = "Harpoon file" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, mode = "n", desc = "Harpoon to file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, mode = "n", desc = "Harpoon to file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, mode = "n", desc = "Harpoon to file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, mode = "n", desc = "Harpoon to file 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, mode = "n", desc = "Harpoon to file 5" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "plugins.configs.telescope"
      conf.defaults.mappings.i = {
        ["<Esc>"] = require("telescope.actions").close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      }
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}

return plugins
