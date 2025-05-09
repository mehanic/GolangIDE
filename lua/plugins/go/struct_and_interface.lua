local symbol_map = {
    Function  = "󰊕",
    Method    = "󰆧",
    Interface = "",
    Struct    = "󰌗",
  }
  
  -- Функция для возвращения цвета #ff8800
  local function h()
    return "#ff8800"  -- Возвращаем цвет #ff8800
  end
  
  -- Настройка подсветки для разных типов символов
  vim.api.nvim_set_hl(0, 'SymbolUsageHint', { fg = h(), bold = true })
  
  -- Настройка подсветки для ссылок и других типов, не затрагивая фон
  vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h(), bold = true })  -- только цвет текста
  vim.api.nvim_set_hl(0, 'SymbolUsageRefRound', { fg = h() })  -- только цвет текста
  
  vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h(), bold = true })  -- только цвет текста
  vim.api.nvim_set_hl(0, 'SymbolUsageDefRound', { fg = h() })  -- только цвет текста
  
  vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h(), bold = true })  -- только цвет текста
  vim.api.nvim_set_hl(0, 'SymbolUsageImplRound', { fg = h() })  -- только цвет текста
  
  -- Функция для форматирования текста с подсветкой
  local function text_format(symbol)
    local res = {}
  
    -- Стек символов на той же строке
    local stacked_functions_content = symbol.stacked_count > 0
        and ("+%s"):format(symbol.stacked_count)
        or ''
  
    -- Обработка ссылок
    if symbol.references then
      table.insert(res, { '󰆧 ' .. tostring(symbol.references), 'SymbolUsageRef' })
    end
  
    -- Обработка определений
    if symbol.definition then
      if #res > 0 then
        table.insert(res, { ' ', 'NonText' })
      end
      table.insert(res, { '󰍞', 'SymbolUsageDefRound' })
      table.insert(res, { '󰳽 ' .. tostring(symbol.definition), 'SymbolUsageDef' })
      table.insert(res, { '󰍟', 'SymbolUsageDefRound' })
    end
  
    -- Обработка реализаций
    if symbol.implementation then
      if #res > 0 then
        table.insert(res, { ' ', 'NonText' })
      end
      table.insert(res, { '󰍞', 'SymbolUsageImplRound' })
      table.insert(res, { '󰡱 ' .. tostring(symbol.implementation), 'SymbolUsageImpl' })
      table.insert(res, { '󰍟', 'SymbolUsageImplRound' })
    end
  
    -- Обработка стековых символов
    if stacked_functions_content ~= '' then
      if #res > 0 then
        table.insert(res, { ' ', 'NonText' })
      end
      table.insert(res, { '󰍞', 'SymbolUsageImplRound' })
      table.insert(res, { ' ' .. tostring(stacked_functions_content), 'SymbolUsageImpl' })
      table.insert(res, { '󰍟', 'SymbolUsageImplRound' })
    end
  
    return res
  end
  
  -- Настройка плагина
  require("symbol-usage").setup({
    kinds_filter = vim.tbl_keys(symbol_map), -- использовать ключи из символов
  
    update_events = { "CursorHold", "InsertLeave", "BufWritePost" },
    debounce_ms = 150,
    highlight = "SymbolUsageHint",  -- Применение группы подсветки
  
    text_format = text_format, -- Использование нашей функции форматирования
  })
  
  