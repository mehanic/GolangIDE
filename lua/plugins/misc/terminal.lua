local toggleterm = require("toggleterm")

toggleterm.setup({
  size = 20,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  direction = "horizontal", -- can be "vertical" or "float"
  close_on_exit = true,
  shell = vim.o.shell,
})

-- Key mappings
vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>1", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>2", "<cmd>ToggleTerm direction=float cmd='htop'<CR>", { noremap = true, silent = true })

-- Optional: autocmd to always start in insert mode (though toggleterm handles this)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})
