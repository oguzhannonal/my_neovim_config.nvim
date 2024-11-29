return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },
    { "<leader>h", "<cmd><cr>", desc = "Harpoon"  },
    { "<leader>c", "<cmd><cr>",desc = "Code" },
    { "<leader>x", "<cmd><cr>", desc = "Trouble" },
    { "<leader>d", "<cmd><cr>", desc = "Document" },
    { "<leader>g", "<cmd><cr>", desc = "Git" },
    { "<leader>ss", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep Args" },
    { "<leader>r", "<cmd><cr>", desc = "Rename" },
    { "<leader>p", "<cmd>Telescope neoclip<cr>", desc = "Clipboard History" },
    { "<leader>w", "<cmd><cr>", desc = "Workspace" },
    { "<leader>s", "<cmd><cr>", desc = "Search" },
  },
}
