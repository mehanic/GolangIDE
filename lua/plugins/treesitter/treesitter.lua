require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "go",
      "python",
      "javascript",
      "sql",
      "lua",
      "html",
      "css",
      "typescript",
      "bash",
      "yaml",
      "gotmpl",
    },
  
    sync_install = false,
    auto_install = true,
  
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  
    indent = {
      enable = true,
    },
  
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        node_decremental = "<C-s>",
        scope_incremental = "<TAB>",
      },
    },
  
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@struct.outer",    -- для Go
          ["ic"] = "@struct.inner",    -- для Go
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
  
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@struct.outer",  -- для Go
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@struct.outer",  -- для Go
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@struct.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@struct.outer",
        },
      },
    },
  }
  


-- Настройка nvim-treesitter
require'nvim-treesitter.configs'.setup {
    -- Устанавливаем поддерживаемые языки
    ensure_installed = { "go", "bash", "python" }, -- Указываем языки для установки
    
    -- Включаем подсветку синтаксиса
    highlight = { 
      enable = true, 
      additional_vim_regex_highlighting = false,  -- Отключаем старую подсветку Vim
    },
    
    -- Включаем поддержку контекстных комментариев (например, для Python и Go)
    context_commentstring = { 
      enable = true, 
    },
    
    -- Включаем инкрементальный выбор
    incremental_selection = { 
      enable = true,
    },
    
    -- Включаем индентацию с помощью treesitter
    indent = { 
      enable = true,
    },
    
    -- Включаем работу с текстовыми объектами
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",  -- Выбор всей функции
          ["if"] = "@function.inner",  -- Выбор тела функции
          ["ac"] = "@class.outer",     -- Выбор класса
          ["ic"] = "@class.inner",     -- Выбор тела класса
          ["am"] = "@method.outer",    -- Выбор метода
          ["im"] = "@method.inner",    -- Выбор тела метода
          ["at"] = "@type.outer",      -- Выбор типа
          ["it"] = "@type.inner",      -- Выбор типа внутри
          ["ap"] = "@parameter.outer", -- Выбор параметра (например, аргумент функции)
          ["ip"] = "@parameter.inner", -- Выбор имени параметра
        },
      },
    },
  }
  
  -- Настройка treesitter-context
  require'treesitter-context'.setup{
    enable = true,  -- Включаем контекст
    max_lines = 0,  -- Показываем контекст без ограничений по строкам
  }
  
  