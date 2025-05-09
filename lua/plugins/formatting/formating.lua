vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.py", "*.go" },
    command = [[:%s/\s\+$//e]],
  })


  require('dropbar').setup {

    -- Стили отображения
    style = 'simple',  -- Это может быть изменено на 'minimal' или 'full', в зависимости от предпочтений
  
    -- Разделитель для отображения путей в dropbar
    separator = ' | ',  -- Разделитель между различными метками в файле
  
    -- Конфигурация для отображения файлов Go в dropbar
    filetypes = {
      go = {
        enabled = true,  -- Включаем Go в список поддерживаемых типов файлов
        icon = '',  -- Добавляем иконку Go-файла
        color = '#00ADD8',  -- Выбираем цвет для файлов Go (можно настроить под свои предпочтения)
      },
      -- Добавляем поддержку Go-шаблонов
      ['go.tmpl'] = {
        enabled = true,  -- Включаем поддержку Go-шаблонов
        icon = '',  -- Иконка для Go-шаблонов (например, иконка для шаблонов или HTML)
        color = '#FFA500',  -- Цвет для Go-шаблонов (оранжевый, можно настроить)
      },
      html = {
        enabled = true,  -- Включаем поддержку HTML (которые могут использовать Go-шаблоны)
        icon = '',  -- Иконка для HTML-файлов
        color = '#E34C26',  -- Цвет для HTML-файлов
      },
  
      -- Добавляем поддержку Helm
      helm = {
        enabled = true,
        icon = '⚓',  -- Иконка для Helm 
        color = '#0000FF',  -- Цвет для Helm
      },
      -- Добавляем поддержку GitLab CI
      ['gitlab-ci.yml'] = {
        enabled = true,
        icon = '󰭘',  -- Иконка для GitLab CI файлов
        color = '#E14E47',  -- Цвет для GitLab CI файлов
      },
  
      -- Поддержка Python
      python = {
        enabled = true,
        icon = '',
        color = '#3572A5',
      },
      -- Поддержка JavaScript
      javascript = {
        enabled = true,
        icon = '',
        color = '#f7df1e',
      },
      -- Поддержка Node.js (можно использовать для файлов `.js` или `.ts`)
      nodejs = {
        enabled = true,
        icon = '',  -- Используется иконка для Node.js
        color = '#8CC84B',  -- Зеленый для Node.js
      },
      -- Поддержка Groovy
      groovy = {
        enabled = true,
        icon = '',  -- Иконка для Groovy
        color = '#4298B8',  -- Голубой цвет для Groovy
      },
      -- Поддержка Lua
      lua = {
        enabled = true,
        icon = '',  -- Иконка для Lua
        color = '#000080',  -- Синий цвет для Lua
      },
      -- Поддержка SQL
      sql = {
        enabled = true,
        icon = '',  -- Иконка для SQL
        color = '#E34F26',  -- Оранжевый для SQL
      },
      -- Поддержка MongoDB (например, для `.json` или `.mongo`)
      mongodb = {
        enabled = true,
        icon = '',  -- Иконка для MongoDB
        color = '#47A248',  -- Зеленый для MongoDB
      },
      -- Поддержка PostgreSQL
      postgresql = {
        enabled = true,
        icon = '',  -- Более подходящая иконка для PostgreSQL
        color = '#336791',  -- Синий для PostgreSQL
      },
      -- Поддержка MySQL
      mysql = {
        enabled = true,
        icon = '',  -- Иконка для MySQL
        color = '#F29111',  -- Оранжевый для MySQL
      },
    },
  
    -- Настройка разделителей в названии для разных частей
    components = {
      file_name = {
        enabled = true,  -- Показывать имя файла
        truncate = 40,    -- Ограничиваем количество символов в имени файла
      },
      lsp_diagnostics = {
        enabled = true,  -- Включаем отображение диагностики LSP
      },
      line_column = {
        enabled = true,  -- Включаем отображение строки и столбца
      },
  
      file_status = {
        enabled = true,  -- Включаем отображение статуса файла
        format = function()
           return vim.bo.modified and '' or (vim.bo.readonly and '' or '')
        end,
  }
    },
  
    -- Выбор поведения при навигации по буферам
    navigation = {
      enable = true,  -- Включаем навигацию по буферам через dropbar
      jump_to_file = true,  -- Позволяет переходить к файлу при клике
    },
  
    -- Другие настройки отображения
    highlight = {
      enable = true,  -- Включаем подсветку активного элемента
      active_color = '#FFD700',  -- Выбираем цвет для активных элементов
    },
  }
  
  -- Пример настройки для других типов файлов или проектов
  -- Можешь добавлять сюда другие настройки для работы с другими языками
  
  