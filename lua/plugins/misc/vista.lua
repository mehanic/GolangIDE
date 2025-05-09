-- Открытие Vista автоматически при старте
vim.api.nvim_create_augroup("VistaAutoOpen", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = "VistaAutoOpen",
  command = "silent! Vista!!"
})

-- Основные настройки Vista
vim.g.vista_split = "vertical"                      -- Открытие справа
vim.g.vista_width = 30                              -- Ширина панели
vim.g.vista_default_executive = "nvim_lsp"          -- Использовать LSP
vim.g.vista_lsp_fallback = 1                         -- Фолбэк для Go
vim.g.vista_fzf_preview = { "right:50%" }           -- Предпросмотр FZF
vim.g.vista_ctags_cmd = {
  go = "ctags -R --languages=Go --exclude=.git --exclude=node_modules ."
}
