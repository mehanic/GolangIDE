require('dap-go').setup {
    dap_configurations = {
      {
        type = "go",
        name = "Debug file",
        request = "launch",
        program = "${file}",
      },
      {
        type = "go",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      {
        type = "go",
        name = "Attach to process",
        request = "attach",
        processId = require('dap.utils').pick_process,
      },
      {
        type = "go",
        name = "Debug with CPU profile",
        request = "launch",
        mode = "test",
        program = "${file}",
        args = { "-test.cpuprofile=cpu.out" },
        buildFlags = "-gcflags=all=-N -l",
      },
    },
    delve = {
      path = "dlv",
      initialize_timeout_sec = 20,
      port = "${port}",
      args = {},
      build_flags = "-gcflags=all=-N -l",
      detached = vim.fn.has("win32") == 0,
    },
    tests = {
      verbose = true,
    },
  }
  
  -- Клавиши для удобного запуска отладки
  vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").continue()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader>dt', ':lua require("dap-go").debug_test()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader>pp', ':!go tool pprof -http=:8080 cpu.out<CR>', { noremap = true, silent = true })

  
  require("gopher").setup {
    -- Уровень логирования
    log_level = vim.log.levels.INFO,
  
    -- Таймаут для выполнения команд
    timeout = 2000,
  
    -- Определение путей к командам
    commands = {
      go = "go",
      gomodifytags = "gomodifytags",
      gotests = "gotests",
      impl = "impl",
      iferr = "iferr",
    },
  
    -- Настройки для gotests
    gotests = {
      template = "default",  -- Шаблон для генерации тестов
      template_dir = nil,    -- Путь к папке с пользовательскими шаблонами (если есть)
      named = false,         -- Использование карты вместо слайса в тестах
    },
  
    -- Настройки для тэгов
    gotag = {
      transform = "snakecase",  -- Преобразование имен в snake_case
      default_tag = "json",     -- Тег по умолчанию для полей структур
    },
  
    -- Настройки для iferr
    iferr = {
      message = nil,  -- Сообщение об ошибке (если нужно)
    },
  }
--:GoTest Для генерации тестов Go:
--:GoModifyTags Для изменения тегов Go:
--:GoIfErr Для вставки обработки ошибок:
--:GoImpl Для генерации методов для интерфейсов:


  