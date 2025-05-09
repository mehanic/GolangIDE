vim.g["test#strategy"] = "neovim"

local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-go"),
  },
})
