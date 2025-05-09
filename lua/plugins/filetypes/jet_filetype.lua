-- Установка filetype для *.jet файлов
vim.api.nvim_create_augroup("jet_filetype", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.jet",
  command = "set filetype=gotmpl"
})
