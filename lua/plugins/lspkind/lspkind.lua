-- Инициализация lspkind
require("lspkind").init({
    mode = "symbol_text",
    preset = "codicons",
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "",
      Class =  "",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit =  "",
      Value = "",
      Enum = "" ,
      Keyword = "",
      Color = "󰏘",
      File = "󰀫",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",  
      Snippet = "",
      TypeParameter = "󰆩",
  
      -- Расширенные для Go
      Array = "",           -- массивы
      Slice = "󰅪",           -- слайсы
      Map = "󰘦",             -- map[string]int
      Channel = "󰖂",         -- chan
      Argument = "󰘳",        -- аргументы функции
      Package = "󰏖",         -- пакеты
      Boolean = "",         -- true/false
      Number = "󰎠",          -- int, float
      String = "",          -- строка
      Nil = "",            -- nil
      Builtin = "󰨊",        -- make, new, len, cap, append, copy
      Import = "",          -- import
      Return = "󰁋",          -- return
      Loop = "",         -- for, range
      Condition = "",       -- if, else, switch
      KeywordGo = "",       -- defer, go, select
      Goroutine = "󱈅",
      Mutex = "",
  
    },
  })
  
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  
  cmp.setup({
    -- Окна с рамками
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true,
      }),
    },
  
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
  
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
    }),
  
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }),
  })
  
  -- Цвет рамки (зелёная)
  vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#00FF00" })     -- окно автодополнения
  vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#00FF00" })  -- окно документации
  
  -- Цветовая схема для nvim-cmp kind-иконок и источников
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet",   { fg = "#ff9e64" })  -- оранжевый для сниппетов
  vim.api.nvim_set_hl(0, "CmpItemKindFunction",  { fg = "#b4f9f8" })
  vim.api.nvim_set_hl(0, "CmpItemKindVariable",  { fg = "#e3e3e3" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword",   { fg = "#c792ea" })
  vim.api.nvim_set_hl(0, "CmpItemKindText",      { fg = "#9ece6a" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass",     { fg = "#f9d849" })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",     { fg = "#569CD6", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemMenu",          { fg = "#aaaaaa" })
  
  -- Функция, которая обновляет стили после загрузки плагинов
  vim.cmd("autocmd VimEnter * lua SetCmpColors()")
  
  -- Функция для установки цветов
  function SetCmpColors()
    -- Цвет рамки автодополнения и документации (зелёная)
    vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#00FF00" })     -- окно автодополнения
    vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#00FF00" })  -- окно документации
  -- Цвет текста в окне документации
  --vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#ff9e64", bg = "#1e1e2e" })
  
  -- Рамка документации (если не сработала CmpDocBorder)
  --vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#00ff00", bg = "#1e1e2e" })
  
    -- Цветовая схема для nvim-cmp kind-иконок и источников
    vim.api.nvim_set_hl(0, "CmpItemKindSnippet",   { fg = "#ff9e64" })  -- оранжевый для сниппетов
    vim.api.nvim_set_hl(0, "CmpItemKindFunction",  { fg = "#b4f9f8" })
    vim.api.nvim_set_hl(0, "CmpItemKindVariable",  { fg = "#e3e3e3" })
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword",   { fg = "#c792ea" })
    vim.api.nvim_set_hl(0, "CmpItemKindText",      { fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "CmpItemKindClass",     { fg = "#f9d849" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",     { fg = "#569CD6", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemMenu",          { fg = "#aaaaaa" })
  
    -- Цвет скобок (оранжевые)
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#ff9e64" })  -- если используется treesitter
    vim.api.nvim_set_hl(0, "Delimiter", { fg = "#ff9e64" })             -- если нет
  end
