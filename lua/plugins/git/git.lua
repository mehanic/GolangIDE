-- Git key mappings using Fugitive
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>gs', ':G<CR>', opts)
map('n', '<leader>gd', ':Gdiffsplit<CR>', opts)
map('n', '<leader>gc', ':Gcommit<CR>', opts)
map('n', '<leader>gp', ':Git push<CR>', opts)
map('n', '<leader>gP', ':Git pull<CR>', opts)
map('n', '<leader>gb', ':Gblame<CR>', opts)
map('n', '<leader>gl', ':Git log<CR>', opts)
map('n', '<leader>ga', ':Gwrite<CR>', opts)
map('n', '<leader>gr', ':Gread<CR>', opts)

require("diffview").setup({
    use_icons = true, -- Включение иконок (требуются nerd-fonts)
    enhanced_diff_hl = true, -- Использовать улучшенную подсветку различий
  
    -- Общие настройки представления
    view = {
      default = {
        layout = "diff2_horizontal",  -- Параметры: "diff2_horizontal", "diff2_vertical", "diff3"
        disable_diagnostics = true, -- Отключить диагностику во время слияния
      },
      merge_tool = {
        layout = "diff3_mixed",   -- Используем "diff3_mixed" для тройного слияния
        disable_diagnostics = true,
      },
    },
  
    -- Настройки панели файлов (список файлов)
    file_panel = {
      listing_style = "tree", -- Стиль списка файлов: "tree" или "list"
      tree_options = {
        flatten_dirs = true, -- Плоская структура директорий
        folder_status = "icon", -- Показывать иконку папки
      },
      win_config = {
        position = "left",  -- Позиция панели: "left" или "right"
        width = 35,         -- Ширина панели
        height = 30,        -- Высота панели
      },
    },
  
    -- Настройки панели с diff (сравнение файлов)
    diff_panel = {
      win_config = {
        position = "bottom",  -- Позиция панели с разницей
        height = 15,          -- Высота панели с разницей
      },
      auto_refresh = true, -- Автоматическое обновление при переключении веток
    },
  
    -- История файлов
    file_history_panel = {
      win_config = {
        position = "bottom",  -- Позиция истории
        height = 20,          -- Высота истории
      },
    },
  
    -- Поведение для разных типов диффов
    diff_args = {
      git = {
        args = { "--color=always", "--diff-algorithm=minimal" }, -- Сложность алгоритма diff
      },
    },
  
    -- Цвета и стили diff
    color_scheme = "auto", -- Автоопределение темы
    highlight = {
      additions = "DiffAdd", -- Добавления
      deletions = "DiffDelete", -- Удаления
      changes = "DiffChange", -- Изменения
      context = "DiffContext", -- Контекстные строки
    },
  
    -- Конфигурация для отображения меток и иконок в панелях
    icons = {
      added = "",    -- Иконка для добавленных строк
      modified = "", -- Иконка для измененных строк
      removed = "",  -- Иконка для удаленных строк
    },
  
    -- Конфигурация для merge-видов (слияния)
    merge_tool = {
      disable_diagnostics = true, -- Отключение диагностики
      diff3 = {
        layout = "diff3_mixed", -- Использование diff3 для слияний
      },
    },
  
    -- Глобальные параметры для сравнения двух коммитов
    compare = {
      auto_open_diff = true, -- Открытие окна diff при сравнении
    },
  })

  
  require('gitsigns').setup({
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame = true,
  })
  
  require('litee.lib').setup()
  require('litee.gh').setup()

  
  vim.api.nvim_create_augroup("ValidateGitlabCIfiles", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      require("validate-gitlab-ci.validate-gitlab-ci").validate()
    end,
    group = "ValidateGitlabCIfiles",
    desc = "Validate Gitlab CI file on save",
    pattern = ".gitlab-ci.yml",
  })


  vim.keymap.set("n", "<leader>gC", "<cmd>CoAuthor<CR>", {
    noremap = true,
    silent = true,
    desc = "Git: Set Co-Author",
  })
  