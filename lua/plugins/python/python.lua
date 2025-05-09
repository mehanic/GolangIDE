require("venv-selector").setup({
    name = { ".venv", "venv" }, -- имена папок с виртуальным окружением
    auto_refresh = true,       -- автообновление списка при открытии Neovim
    search_venv_managers = true, -- ищет также в pipenv, poetry, etc.
    dap_enabled = true,        -- если ты используешь DAP для Python
  })
  
  -- Пример биндинга (опционально):
  vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>")
  
  