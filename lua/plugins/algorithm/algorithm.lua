-- Автокоманда для открытия Leet, если это пустой Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if #vim.api.nvim_list_bufs() == 1 and vim.api.nvim_buf_get_name(0) == "" then
      vim.cmd("Leet")
    end
  end
})

-- Настройка плагина leetcode.nvim
local leetcode = require("leetcode")

leetcode.setup {
  lang = "golang",  -- Устанавливаем Go как язык по умолчанию
  keymaps = {
    list = "<leader>ll",
    solve = "<leader>ls",
    test = "<leader>lt",
    submit = "<leader>lsb",
  },
  plugins = {
    non_standalone = true,  -- Обязательно для работы Leet в непустой сессии
  },
}

-- Кастомные команды для Leetcode
vim.api.nvim_create_user_command("LeetcodeLL", function()
  vim.cmd("Leet list")
end, {})

vim.api.nvim_create_user_command("LeetcodeLS", function()
  vim.cmd("Leet solve")
end, {})

vim.api.nvim_create_user_command("LeetcodeLT", function()
  vim.cmd("Leet test")
end, {})

vim.api.nvim_create_user_command("LeetcodeLSB", function()
  vim.cmd("Leet submit")
end, {})

-- Для Easy Collection
-- Легкие задачи
vim.api.nvim_create_user_command("LeetcodeEasy", function()
  vim.cmd("Leet list tags=easy")
end, {})

-- Средние задачи
vim.api.nvim_create_user_command("LeetcodeMedium", function()
  vim.cmd("Leet list tags=medium")
end, {})

-- Трудные задачи
vim.api.nvim_create_user_command("LeetcodeHard", function()
  vim.cmd("Leet list tags=hard")
end, {})
-- Для Top Interview Questions
vim.api.nvim_create_user_command("LeetcodeTop", function()
  vim.cmd("Leet list tags=top-interview-questions")
end, {})

-- Проверяем, доступен ли плагин "exercism"
local ok, exercism = pcall(require, "exercism")
if not ok then
  vim.notify("❌ Не удалось загрузить плагин exercism.nvim", vim.log.levels.ERROR)
  return
end

-- Настройка плагина "exercism"
exercism.setup({
  exercism_workspace = vim.fn.expand("~/exercism"),  -- путь к рабочему каталогу
  default_language = "go",  -- язык по умолчанию
  add_default_keybindings = true,  -- можно false, если хочешь свои бинды
  icons = {
    concept = "",
    practice = "",
  },
})
