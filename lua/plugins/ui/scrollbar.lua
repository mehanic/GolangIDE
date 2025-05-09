require("scrollbar").setup({
    show = true,                         -- Показывать полосу прокрутки
    show_in_active_only = false,         -- Показывать полосу прокрутки во всех буферах, не только в активных
    set_highlights = true,               -- Включить подсветку для полосы прокрутки
    folds = 1000,                        -- Полоса прокрутки для файлов с более чем 1000 строк
    max_lines = false,                   -- Полоса прокрутки отключена, если буфер превышает максимальное количество строк
    hide_if_all_visible = false,         -- Не скрывать полосу прокрутки, если все строки видны
    throttle_ms = 100,                   -- Ожидание перед обновлением (можно увеличить для улучшения производительности)
    
    -- Настройки для внешнего вида
    handle = {
        text = " ",                       -- Текст для обработки полосы прокрутки
        blend = 20,                       -- Прозрачность (0 = непрозрачный, 100 = полностью прозрачный)
        color = nil,                      -- Цвет для обработки полосы
        highlight = "CursorColumn",       -- Подсветка для обработки полосы
        hide_if_all_visible = true,       -- Скрывать обработку полосы, если все строки видны
    },

    -- Настройки маркеров
     marks = {
    -- Курсор
    Cursor = {
        text = "ᚦ",                 
        priority = 0,                 
        highlight = "Normal",         
    },
    
    -- Поиск
    Search = {
        text = { "ᚱ", "ᛗ" },          
        priority = 1,                 
        highlight = "Search",         
    },
    
    -- Ошибки
    Error = {
        text = { "ᚲ", "ᚷ" },        
        priority = 2,                 
        highlight = "DiagnosticVirtualTextError",  
    },

    -- Предупреждения
    Warn = {
        text = { "ᛒ", "ᛖ" },         
        priority = 3,                 
        highlight = "DiagnosticVirtualTextWarn",  
    },

    -- Информация
    Info = {
        text = { "ᛏ", "ᛃ" },         
        priority = 4,                 
        highlight = "DiagnosticVirtualTextInfo",  
    },

    -- Подсказки
    Hint = {
        text = { "ᛗ", "ᚨ" },        
        priority = 5,                 
        highlight = "DiagnosticVirtualTextHint",  
    },

    -- Разные маркеры
    Misc = {
        text = { "ᛟ", "ᛍ" },           
        priority = 6,                 
        highlight = "Normal",         
    },

    -- Git добавления
    GitAdd = {
        text = "ᛓ",                    
        priority = 7,                 
        highlight = "GitSignsAdd",    
    },

    -- Git изменения
    GitChange = {
        text = "ᛋ",                   
        priority = 7,                 
        highlight = "GitSignsChange", 
    },

    -- Git удаление
    GitDelete = {
        text = "ᛞ",                   
        priority = 7,                 
        highlight = "GitSignsDelete", 
    },

    -- Дополнительные маркеры:

    -- Маркер для кастомных изменений
    CustomChange = {
        text = "ᛘ",                   
        priority = 8,                 
        highlight = "Normal",        
    },

    -- Отладка
    Debug = {
        text = "ᛦ",                   
        priority = 9,                 
        highlight = "DiagnosticVirtualTextDebug",  
    },

    -- Маркеры для других типов кода (например, для SQL, HTML, JS)
    SQLQuery = {
        text = "ᛉ",                   
        priority = 10,                 
        highlight = "Normal",         
    },
    HTMLTag = {
        text = "ᛖ",                   
        priority = 11,                 
        highlight = "Normal",        
    },

    -- Прочее состояние буфера
    BufferModified = {
        text = "ᛘ",                   
        priority = 12,                 
        highlight = "Normal",        
    },

    -- Сохранение буфера
    BufferSaved = {
        text = "᛫",                   
        priority = 13,                 
        highlight = "Normal",        
    },

    -- Маркер для новых файлов
    NewFile = {
        text = "ᛝ",                   
        priority = 14,                 
        highlight = "Normal",        
    },

    -- Работа с тестами
    TestFailed = {
        text = "ᛞ",                   
        priority = 15,                 
        highlight = "DiagnosticVirtualTextError",  
    },

    TestPassed = {
        text = "ᛋ",                   
        priority = 16,                 
        highlight = "DiagnosticVirtualTextInfo",  
    },

    -- Функции, классы или методы
    Function = {
        text = "ᛊ",                   
        priority = 17,                 
        highlight = "Normal",        
    },

    -- Закрытие неактивных панелей
    InactivePanel = {
        text = "ᛚ",                   
        priority = 18,                 
        highlight = "Normal",        
    },

    -- Для предупреждений, связанных с внешними плагинами или утилитами
    PluginWarning = {
        text = "ᛏ",                   
        priority = 19,                 
        highlight = "DiagnosticVirtualTextWarn",  
    },
    },

    -- Исключения для буферов
    excluded_buftypes = {
        "terminal",                         -- Исключить терминальные буферы
    },
    excluded_filetypes = {
        "dropbar_menu", "dropbar_menu_fzf", -- Исключить специфичные типы файлов
        "DressingInput", "cmp_docs", "cmp_menu",
        "noice", "prompt", "TelescopePrompt",
    },

    -- Автокоманды
    autocmd = {
        render = {
            "BufWinEnter", "TabEnter", "TermEnter", "WinEnter", 
            "CmdwinLeave", "TextChanged", "VimResized", "WinScrolled",
        },
        clear = {
            "BufWinLeave", "TabLeave", "TermLeave", "WinLeave",
        },
    },

    -- Обработчики
    handlers = {
        cursor = true,                     -- Показывать маркер для курсора на полосе прокрутки
        diagnostic = true,                  -- Показывать диагностические маркеры (ошибки, предупреждения) на полосе
        gitsigns = true,                   -- Включить поддержку Git маркеров с помощью gitsigns
        handle = true,                      -- Показывать саму полосу прокрутки
        search = true,                     -- Включить поддержку маркеров для поиска с помощью hlslens
        ale = false,                        -- Отключить поддержку ALE (если используется)
    },
})


-- Словарь рун с названиями и описаниями
local rune_descriptions = {
    ["ᚦ"] = { name = "runa Thurisaz", description = "Rune of giants, defense, or reaction" },
    ["ᚱ"] = { name = "runa Raido", description = "Rune of travel, movement, and journeys" },
    ["ᛗ"] = { name = "runa Mannaz", description = "Rune of humanity and self-awareness" },
    ["ᚲ"] = { name = "runa Kenaz", description = "Rune of knowledge and creativity" },
    ["ᚷ"] = { name = "runa Gebo", description = "Rune of gift, partnership, and balance" },
    ["ᛒ"] = { name = "runa Berkano", description = "Rune of growth, fertility, and renewal" },
    ["ᛖ"] = { name = "runa Ehwaz", description = "Rune of horse, movement, and transition" },
    ["ᛏ"] = { name = "runa Tiwaz", description = "Rune of justice, leadership, and honor" },
    ["ᛃ"] = { name = "runa Jera", description = "Rune of harvest, cycles, and rewards" },
    ["ᛗ"] = { name = "runa Mannaz", description = "Rune of humanity, self-awareness, and community" },
    ["ᚨ"] = { name = "runa Ansuz", description = "Rune of wisdom, communication, and the divine" },
    ["ᛟ"] = { name = "runa Odal", description = "Rune of inheritance, ancestry, and heritage" },
    ["ᛍ"] = { name = "runa Sowilo", description = "Rune of sun, success, and vitality" },
    ["ᛓ"] = { name = "runa Hagalaz", description = "Rune of disruption, storms, and destruction" },
    ["ᛋ"] = { name = "runa Sowilo", description = "Rune of sun, vitality, and success" },
    ["ᛞ"] = { name = "runa Dagaz", description = "Rune of day, enlightenment, and transformation" },
    ["ᛘ"] = { name = "runa Perthro", description = "Rune of fate, chance, and secrets" },
    ["ᛦ"] = { name = "runa Isa", description = "Rune of ice, stillness, and blocking" },
    ["ᛉ"] = { name = "runa Algiz", description = "Rune of protection, defense, and spirituality" },
    ["ᛖ"] = { name = "runa Ehwaz", description = "Rune of horse, transition, and partnership" },
    ["ᛝ"] = { name = "runa Inguz", description = "Rune of fertility, new beginnings, and growth" },
    ["ᛚ"] = { name = "runa Laguz", description = "Rune of water, intuition, and flow" },
}


-- Отображение описания руны
local function show_rune_description(buf, line, col, rune)
    local desc = rune_descriptions[rune]
    if desc then
      vim.api.nvim_buf_set_virtual_text(buf, 0, line, {
        { desc.name .. ": ", "Comment" },
        { desc.description, "Comment" },
      }, {})
    end
  end
  
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved" }, {
    callback = function()
      local buf = 0
      local line = vim.fn.line('.') - 1
      local col = vim.fn.col('.') - 1
      local rune = vim.fn.expand("<cword>")
      show_rune_description(buf, line, col, rune)
    end,
  })

