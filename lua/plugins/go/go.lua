-- Goplements config (if still used — NOTE: this is a Vim plugin, not Lua)
vim.g.goplements_enabled = 1
vim.g.goplements_autocomplete = 1
vim.g.goplements_lint_on_save = 1
vim.g.goplements_gopls_path = '/home/mehanic/.gvm/pkgsets/go1.23.0/global/bin/gopls'

-- Format on save for Go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  command = "silent! CocCommand editor.action.formatDocument"
})

-- Format on save for Python
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  command = ":Black"
})

-- Allow editing in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal modifiable"
})

vim.opt.runtimepath:append("~/.config/nvim/autoload/plugged/goplements.nvim")
package.path = package.path .. ";/home/mehanic/.config/nvim/autoload/plugged/goplements.nvim/lua/?.lua"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set("i", "<Tab>", [[<C-r>=coc#rpc#request('doKeymap', ['snippets-expand', ''])<CR>]], { noremap = true, silent = true, expr = false })
  end
})


-- Настройки для Go: отступы с табами
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    command = "setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8 colorcolumn=100",
  })
  
  -- Форматирование перед сохранением
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    command = "silent! lua vim.lsp.buf.format({ async = false })",
  })

-- Подключаем файловые типы для gotmpl/helm
require("go-template-plugin.filetype").setup()

-- Настройка Treesitter для Go Templates
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "gotmpl",
}

-- Команда для генерации тестов через gotests
vim.api.nvim_create_user_command("GenerateTests", function(opts)
    local args = opts.args
    local filepath = vim.fn.expand("%:p")
    vim.cmd("!" .. "gotests -w -only " .. args .. " " .. filepath)
  end, {
    nargs = 1,
    desc = "Generate Go tests using gotests",
  })
  
  -- Команда для генерации интерфейсов через goimpl.nvim
  vim.api.nvim_create_user_command("GenerateImpl", function()
    vim.cmd("GoImpl")
  end, {
    desc = "Generate Go interface implementation",
  })
  
  -- Команда для запуска в Go Playground через Dispatch
  vim.api.nvim_create_user_command("GoPlayground", function()
    vim.cmd("Dispatch go run %")
  end, {
    desc = "Run current file in Go Playground using Dispatch",
  })
  

  require("todo-comments").setup({
    signs = true,  -- Показывать иконки для комментариев в строках
    highlight = {
      keyword = "TODO",  -- Или можно настроить по своему, например, для FIXME
      pattern = [[\b(KEYWORDS)\b]],  -- Поиск слов в комментариях (можно добавить дополнительные ключевые слова)
    },
    search = {
      command = "grep -r",  -- Можно указать команду поиска для быстрого поиска в проекте
    },
  })
  
  -- Интеграция с Telescope для быстрого поиска TODO комментариев
  require('telescope').load_extension('todo-comments')

  

  require('aerial').setup({
    on_attach = function(bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>o', ':AerialToggle<CR>', { noremap = true, silent = true })
    end,
  })



  local cmp = require('cmp')

  -- Настройка nvim-cmp
  cmp.setup({
    sources = {
      { name = 'go_pkgs' },  -- Источник для автодополнения Go пакетов
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'luasnip' },   -- Добавьте этот источник для сниппетов

    },
    formatting = {
      format = require('lspkind').cmp_format({
        menu = {
          go_pkgs = "󰏖 [pkgs]",  -- Иконка для пакетов Go
        },
      }),
    },
  })

  -- Добавляем автокоманду для инициализации пакетов Go при подключении LSP
  vim.api.nvim_create_autocmd("LspAttach", {
    pattern = { "*.go" },  -- Для Go файлов
    callback = function(args)
      -- Инициализация пакетов для автодополнения
      require("cmp_go_pkgs").init_items(args)
    end,
  })
