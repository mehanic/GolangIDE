local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = { enabled = true, suggestions = 20 },  -- Включить поддержку орфографии
  },
  key_labels = {
    ["<leader>"] = "SPC",  -- Замена на "SPC" для удобства
  },
})

wk.register({
  ["<leader>f"] = { name = "File" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
})
