-- vim-dadbod UI
vim.g.db_ui_use_telescope = 1          -- Использовать Telescope
vim.g.db_ui_save_location = "session"  -- Сохранять подключения в сессии
vim.g.db_ui_auto_select = 1            -- Автоматически выбирать подключение
vim.g.db_ui_force_mappings = 0         -- Не перезаписывать клавиши

-- Пример подключения к PostgreSQL
vim.g.db_ui_connections = {
  my_postgres = "postgresql://postgres:new_password@localhost:5432/my_database"
}

-- MongoDB
vim.g.vim_mongo_connection = "mongodb://localhost:27017"

-- SQL filetype settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Telescope-dadbod bindings
vim.keymap.set("n", "<leader>db", "<cmd>Telescope db<CR>", { desc = "Telescope DB" })
