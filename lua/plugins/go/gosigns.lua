-- Настройка плагина gosigns.nvim
require('gosigns').setup({
    signs = {
      Interface =  "",  -- Иконка для интерфейса
      Struct    =  "󰌗",  -- Иконка для структуры
      Method    =  "",  -- Иконка для метода
    },
    show_interfaces = true,
    show_methods = true,
    show_comments = true,
  })
  
  -- Виртуальные строки над структурами, интерфейсами и методами
  _G.gosigns_overlay = {}
  
  local kind_labels = {
    [vim.lsp.protocol.SymbolKind.Interface] = "", --"интерфейс"
    [vim.lsp.protocol.SymbolKind.Struct] = "󰌗",  -- "структура реализует интерфейс"
    [vim.lsp.protocol.SymbolKind.Method] = "",  -- "метод реализует метод интерфейса"
  }
  
  -- Создание группы подсветки для цвета вишни
  vim.api.nvim_set_hl(0, 'GosignCherry', { fg = '#9B111E', bg = 'NONE', bold = true })  -- Вишневый цвет для знаков
  
  function _G.gosigns_overlay.add_comments()
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    local ns = vim.api.nvim_create_namespace("gopls_struct_tags")
    local bufnr = vim.api.nvim_get_current_buf()
  
    vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, _, _)
      if err or not result then return end
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  
      for _, item in ipairs(result) do
        local kind = item.kind
        local range = item.range
  
        if kind_labels[kind] then
          local line = range.start.line
          vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
            virt_lines = {
              { { kind_labels[kind], 'GosignCherry' } }  -- Используем группу подсветки
            },
            virt_lines_above = true,
          })
        end
      end
    end)
  end
  
  -- Автокоманда для запуска добавления комментариев
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
    pattern = "*.go",
    callback = function()
      _G.gosigns_overlay.add_comments()
    end,
  })
  
  