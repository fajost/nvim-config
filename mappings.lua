local M = {}

M.abc = {
  n = {
    ["<A-j>"] = { ":m .+1<CR>==", "move line down" },
    ["<A-k>"] = { ":m .-2<CR>==", "move line up" },
    ["<leader>rf"] = {":w<CR>:!python3 %<CR>"},
  },

  i = {
    ["jj"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
    ["<A-j>"] = { "<ESC>:m .+1<CR>==gi", "move line down" },
    ["<A-k>"] = { "<ESC>:m .-2<CR>==gi", "move line up" },
  },

  v = {
    ["<A-j>"] = { ":m '>+1<cr>gv", "move line down" },
    ["<A-k>"] = { ":m '<-2<cr>gv", "move line up" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
