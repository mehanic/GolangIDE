-- Создание группы подсветки для цвета вишни
vim.api.nvim_set_hl(0, 'GosignCherry', { fg = '#9B111E', bg = 'NONE', bold = true })  -- Вишневый цвет для знаков

-- goplements.nvim configuration
require('goplements').setup({
  -- Префиксы, добавляемые к именам типов
  prefix = {
    interface = " interface implemented by: ",
    struct = "struct implements: ",
  },
  -- Будет ли отображаться имя пакета вместе с именем типа
  display_package = true,  -- Показывать полное имя пакета (например, builtins.error вместо просто error)
  
  -- Пространство имён для extmarks (обычно не нужно изменять)
  namespace_name = "goplements",
  
  -- Группа подсветки для визуализации реализованных структур и интерфейсов
  -- Использование 'GosignCherry' для подсветки
  highlight = "GosignCherry",  -- Убедитесь, что используется правильная группа подсветки
  
  -- Использовать nvim-treesitter для лучшего опыта
  treesitter = true,  -- Включить поддержку Treesitter для Go, если он установлен
  
  -- Если хотите отключить отображение имен интерфейсов и структур, установите в false
  show_names = true,  -- Показывать имена интерфейсов и структур рядом с определением
})
