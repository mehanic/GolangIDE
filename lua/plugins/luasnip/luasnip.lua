local cmp = require('cmp')
local luasnip = require('luasnip')  -- Подключаем LuaSnip для автодополнения
local lspconfig = require('lspconfig')        -- lspconfig: This is used to configure LSP servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities()  -- capabilities: This is used to enable advanced LSP features: completion and signatures.

-- Snippet setup
local ls = require'luasnip'                      -- These are the basic functions provided by LuaSnip to define and expand snippets:
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

-- Функция для проверки, есть ли слова перед курсором
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Настройка nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)  -- Используем lsp_expand для сниппетов
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- Источник для LSP
    { name = 'luasnip' },   -- Источник для сниппетов
  }, {
    { name = 'buffer' },     -- Источник для буфера
    { name = 'path' },       -- Источник для пути
    { name = 'cmdline' },    -- Для автодополнения в командной строке
  })
})

-- Убедимся, что nvim-cmp подключен и настроен
require('cmp')

-- Настройка LSP для Go с использованием gopls
--local lspconfig = require('lspconfig')  тому що 2 раза

-- Расширение возможностей LSP (например, для nvim-cmp)
--local capabilities = require('cmp_nvim_lsp').default_capabilities()  томущо 2 раза

-- for Golang 
lspconfig.gopls.setup({
  on_attach = function(client, bufnr)
    -- Выводим сообщение, когда LSP успешно подключается
    vim.notify("gopls attached", vim.log.levels.INFO)
  end,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = require('lspconfig.util').root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = { 
        unusedparams = true, -- ругать за неиспользуемые параметры
        shadow = true,       -- ловить затенение переменных
        printf = true,       -- проверять неправильное использование форматирования (можешь поставить false если надо)

        assign = true,
        atomic = true,
        bools = true,
        buildtag = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        errorsas = true,
        ifaceassert = true,
        loopclosure = true,
        nilfunc = true,
        stdmethods = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        unmarshal = true,
        unreachable = true,
        unsafeptr = true,
        unusedwrite = true,
        },
      staticcheck = true,
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
      matcher = "Fuzzy",
      codelenses = {
        generate = true,  -- командочка для генерации методов интерфейсов
        gc_details = true, -- показывать детали сборщика мусора
        test = true, -- "Run Test" прямо над функцией теста
        tidy = true, -- "Go mod tidy"
      },

      hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
     },
      hoverKind = "FullDocumentation", -- Полная документация при наведении
      completionDocumentation = true,  -- Описание при автодополнении
    },
  },
})


local lspconfig = require("lspconfig")

-- on_attach: подключение функций при старте LSP
local on_attach = function(client, bufnr)
  vim.notify("pyright attached", vim.log.levels.INFO)

  -- Форматирование при сохранении
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- Клавиши для LSP
  local bufmap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
end 

-- Для Python
lspconfig.pyright.setup({

on_attach = on_attach,
capabilities = capabilities,
  filetypes = { "python", "pyproject.toml", "setup.py", "requirements.txt", "tox.ini", "mypy.ini", "pylintrc" },
  root_dir = require('lspconfig.util').root_pattern("pyproject.toml", "setup.py", ".git"),
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode = "workspace",  -- Уровень диагностики
        useLibraryCodeForTypes = true,  -- Использование библиотечного кода для проверки типов
        autoSearchPaths = true,         -- Автоматический поиск путей для зависимостей

        autoImportCompletions = true,        -- автодополнение импортов
        reportUnusedImport = "warning",      -- подсветка неиспользуемых импортов
        reportUnusedVariable = "warning",    -- неиспользуемые переменные
        reportMissingImports = true,
        stubPath = "typings",                -- кастомные .pyi файлы, если есть
      },
    },
  },
})




-- Настройка terraform-ls
require('lspconfig').terraformls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.notify("terraformls attached", vim.log.levels.INFO)
  end,
  filetypes = { "terraform", "tf", "tfvars" },
  root_dir = require('lspconfig.util').root_pattern(".terraform", ".git", "*.tf"),
  settings = {
    terraform = {
      format = {
        enable = true, -- включает автоформатирование (через terraform fmt)
      },
      languageServer = {
        externalFormatter = true,
        diagnostics = {
          enable = true,
        },
      },
    }
  }
})


require('lspconfig').sqls.setup({
  on_attach = function(client, bufnr)
    vim.notify("SQLs attached", vim.log.levels.INFO)
    -- Можно добавить keymaps или интеграции с null-ls
  end,
  capabilities = capabilities,
  filetypes = { "sql", "mysql", "plsql" },
  root_dir = require('lspconfig.util').root_pattern(".git", "*.sql"),
  settings = {
    sqls = {

      connections = {
        {
          driver = "postgresql",
          name = "PostgreSQL",
          host = "localhost",
          user = "postgres",
          password = "new_password",
          database = "postgres",
          port = 5432
        },
        {
          driver = "mysql",
          name = "MySQL",
          host = "localhost",
          user = "root",
          password = "new_password",
          database = "mysql",
          port = 3306
        }
      }

    }
  }
})

require("lspconfig").groovyls.setup {
  cmd = { "groovy-language-server" },
  filetypes = { "groovy" },
  root_dir = require("lspconfig.util").root_pattern(".git", "build.gradle", "settings.gradle"),
}

-- Загрузка сниппетов Go
require("luasnip.loaders.from_vscode").load({
  paths = { "/home/mehanic/.config/nvim/snippets/go.json" }
})

-- Загрузка сниппетов для Golang (golang_snippets)
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.expand("~/.config/nvim/snippets/golang_snippets"),
})

-- Загрузка сниппетов для Golang2
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.expand("~/.config/nvim/snippets/golang2_snippets"),
})

-- Проверка сниппетов после их загрузки
vim.defer_fn(function()
  local snippets = require("luasnip").get_snippets()

  -- Проверка Go сниппетов
  if snippets.go then
    vim.notify("Go snippets loaded successfully!", vim.log.levels.INFO)
    vim.notify("Go snippets details: " .. vim.inspect(snippets.go), vim.log.levels.DEBUG)
    for _, snippet in ipairs(snippets.go) do
      snippet.active = true
    end
    vim.notify("Go snippets are now active!", vim.log.levels.INFO)
  else
    vim.notify("Go snippets not found.", vim.log.levels.ERROR)
  end

  -- Проверка Golang2 сниппетов
  if snippets.go then
    -- Проверяем наличие триггера "golang2"
    local found_golang2 = false
    for _, snippet in ipairs(snippets.go) do
      if snippet.trigger == "golang2" then
        found_golang2 = true
        break
      end
    end

    if found_golang2 then
      vim.notify("Golang2 snippet found in go filetype!", vim.log.levels.INFO)
    else
      vim.notify("Golang2 snippet not found in go filetype.", vim.log.levels.ERROR)
    end
  end

  -- Отладка: вывод всех загруженных сниппетов
  vim.notify("All loaded snippets: " .. vim.inspect(snippets), vim.log.levels.DEBUG)
end, 1000)

-- Сообщение после загрузки LuaSnip
vim.cmd("autocmd User LuaSnipLoaded echo 'LuaSnip snippets loaded'")

-- Функция для организации импортов в Go
function goimports(timeout_ms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- Отправляем запрос на сервер LSP для получения доступных действий
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    
    local actions = result[1].result
    if not actions then return end

    -- Выбираем первое найденное действие
    local action = actions[1]

    -- Выполняем найденное действие (организация импортов)
    vim.lsp.buf.execute_command(action)
end

