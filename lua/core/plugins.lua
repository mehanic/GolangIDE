-- lua/core/plugins.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Better Syntax Support
  { "sheerun/vim-polyglot" },
  { "scrooloose/syntastic" },
  { "davidhalter/jedi-vim" },
  { "bling/vim-airline" },
  -- { "vim-airline/vim-airline-themes" }, -- закомментировано, как у тебя

  -- JSON visualizer
  { "gennaro-tedesco/nvim-jqx" },

  -- Surround text easily
  { "tpope/vim-surround" },

  -- Emmet for HTML/CSS
  { "mattn/emmet-vim" },

  -- Snippets
  { "honza/vim-snippets" },

  -- FAR: find and replace
  { "brooth/far.vim" },

  -- Terraform
  { "hashivim/vim-terraform" },

  -- Вторая запись syntastic (в Plug тоже была)
  { "vim-syntastic/syntastic" },

  -- Git conflict helper
  { "akinsho/git-conflict.nvim" },

  -- UI plugin от Ardan Labs
  { "ardanlabs/ardango.nvim" },

  -- Highlight active block
  { "koenverburg/peepsight.nvim" },

  -- YAML parser
  { "cuducos/yaml.nvim" },

  -- Цветовая схема
  { "fisadev/fisa-vim-colorscheme" },

  -- Git signs
  { "mhinz/vim-signify" },

  -- File tree
  { "preservim/nerdtree" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter" },

  {
    -- Go development
    "ray-x/go.nvim"
  },
  
  {
    -- Buffer line
    "akinsho/bufferline.nvim",
    version = "*"
  },
  
  -- Автокомплит и LSP
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  
  {
    -- coc.nvim (автокомплит и LSP альтернатива)
    "neoclide/coc.nvim",
    branch = "release"
  },
  { "neoclide/coc-snippets" },
  
  {
    -- vim-go
    "fatih/vim-go",
    build = ":GoUpdateBinaries"
  },

-- fzf и зависимости
{
  "nvim-lua/plenary.nvim"
},
{
  "nvim-lua/popup.nvim"
},
{
  "junegunn/fzf",
  build = "./install --all"
},
{
  "junegunn/fzf.vim"
},

-- Telescope и расширения
{
  "nvim-telescope/telescope.nvim"
},
{
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make"
},
{
  "venc0r/telescope-k8s.nvim"
},

-- Иконки
{
  "kyazdani42/nvim-web-devicons"
},
{
  "nvim-tree/nvim-web-devicons"
},
{
  "ryanoasis/vim-devicons"
},

-- Автоматическое закрытие скобок
{
  "windwp/nvim-autopairs"
},

-- Альтернатива lspsaga (можно раскомментировать)
-- {
--   "nvimdev/lspsaga.nvim"
-- },

-- Neo-tree файловый менеджер
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x"
},
{
  "MunifTanjim/nui.nvim"
},


-- 🔍 Отладка
{ "mfussenegger/nvim-dap" },

-- 🔔 Уведомления
{ "rcarriga/nvim-notify" },

-- ⚡ LeaderF (альтернатива fzf)
{
  "Yggdroot/LeaderF",
  build = ":LeaderfInstallCExtension",
},

-- 📝 Markdown
{ "preservim/vim-markdown" },
{
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
},
{ "dhruvasagar/vim-table-mode" },
{ "plasticboy/vim-markdown" },

--  Терминал
{ "akinsho/toggleterm.nvim" },

--  Ansible и YAML
{ "pearofducks/ansible-vim" },
{ "stephpy/vim-yaml" },

--  Скроллбар
{ "petertriho/nvim-scrollbar" },

--  Вертикальные линии отступов
{ "lukas-reineke/indent-blankline.nvim" },

--  REST API playground
{ "rest-nvim/rest.nvim" },

--  UI индикаторы LSP-загрузки и т.п.
{ "j-hui/fidget.nvim" },

-- 🌲 Treesitter
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  
  -- 🛢️ Работа с базами данных
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },
  
  -- 🎨 Форматирование кода
  { "stevearc/conform.nvim" },
  
  -- 🔧 Git по SSH
  { "tpope/vim-fugitive" },
  
  -- 🔎 Поиск через ripgrep (удалённо)
  { "jremmen/vim-ripgrep" },
  
  -- 🗂️ Монтирование удалённых файлов по SSH
  { "DanielWeidinger/nvim-sshfs" },
  
  -- 📤 Синхронизация файлов через rsync + SSH
  { "coffebar/transfer.nvim" },
  
  -- 📏 Подсветка отступов и блоков
  { "shellRaining/hlchunk.nvim" },
  
  -- 🔁 goimpl (для Go)
  { "edolphin-ydf/goimpl.nvim" },
  
  -- 🐹 Gopher и инструменты для Go
{ "olexsmir/gopher.nvim" },
{ "maxandron/goplements.nvim" },

-- 📦 UI зависимости
{
  "ray-x/guihua.lua",
  build = "cd lua/fzy && make",
},
{ "rcarriga/nvim-dap-ui" },

-- 🧾 YAML Companion
{ "someone-stole-my-name/yaml-companion.nvim" },

-- 🚀 Skipper
{ "beargruug/skipper.nvim" },

-- 📝 Typst preview
{
  "chomosuke/typst-preview.nvim",
  version = "v1.*",
},

-- 🧠 Мини сниппеты
{ "echasnovski/mini.snippets" },
{ "abeldekat/cmp-mini-snippets" },

-- 🪄 UltiSnips
{ "SirVer/ultisnips" },
{ "quangnguyen30192/cmp-nvim-ultisnips" },

-- Snippy support
{ "dcampos/nvim-snippy" },
{ "dcampos/cmp-snippy" },

--  Go debugging
{ "leoluz/nvim-dap-go" },

--  Neotest dependencies
{ "nvim-neotest/nvim-nio" },

-- DAP UI (повторно указан, не проблема)
{ "rcarriga/nvim-dap-ui" },

-- GUI для баз данных
{ "kndndrj/nvim-dbee" },

-- Контекст Treesitter
{ "nvim-treesitter/nvim-treesitter-context" },

--  CSV support
{ "chrisbra/csv.vim" },

--  Go структура
{ "crusj/structrue-go.nvim" },

-- Git изменения
{ "lewis6991/gitsigns.nvim" },

-- Lens для поиска
{ "kevinhwang91/nvim-hlslens" },

-- Null-ls (aka none-ls)
{ "nvimtools/none-ls.nvim" },

-- Тестирование
{ "vim-test/vim-test" },
{ "nvim-neotest/neotest" },

-- Telescope (повтор)
{ "nvim-telescope/telescope.nvim" },

-- Структура кода
{ "stevearc/aerial.nvim" },

--  Генерация тестов для Go
{ "cweill/gotests" },

--  Neotest адаптер для Go
{ "nvim-neotest/neotest-go" },

-- Go Playground Integration + Async build
{ "tpope/vim-dispatch" },

--  Подсказки клавиш
{ "folke/which-key.nvim" },

--  TODO/FIXME и др. важные комментарии
{ "folke/todo-comments.nvim" },

-- Рабочие пространства
{ "natecraddock/workspaces.nvim" },

-- Терминал внутри Neovim (повтор, но допустим)
{ "akinsho/toggleterm.nvim" },

-- Ещё один асинхронный терминал
{ "kassio/neoterm" },

-- Структура кода (outline)
{ "stevearc/aerial.nvim" },

--  Breadcrumbs / контекст LSP
{ "SmiteshP/nvim-navic" },

--  UI-интерфейс к LSP
{ "glepnir/lspsaga.nvim" },

-- Lualine статусбар
{ "nvim-lualine/lualine.nvim" },

-- Цветовая схема Nord
{ "arcticicestudio/nord-vim" },

-- 📈 Навигация по символам (Vista)
{ "liuchengxu/vista.vim" },

-- Обязательно для diffview
{ "nvim-lua/plenary.nvim" },

-- Diff UI
{ "sindrets/diffview.nvim" },

-- Работа с базами данных
{ "tpope/vim-dadbod" },
{ "kristijanhusak/vim-dadbod-ui" },

-- Go Tools (VSCode extension, может не работать напрямую)
{ "golang/vscode-go" },

-- Mason (менеджер LSP/Tools)
{ "williamboman/mason.nvim" },
{ "williamboman/mason-lspconfig.nvim" },

-- Автоматическое закрытие тегов
{ "windwp/nvim-ts-autotag" },

-- UI для calltree и других LSP функций
{ "ldelossa/litee.nvim" },
{ "ldelossa/litee-calltree.nvim" },

--  Lua LSP улучшения
{ "folke/neodev.nvim" },

-- Подсветка изменений в гите
{ "sindrets/gitsigns.nvim" },
{ "lewis6991/gitsigns.nvim" }, -- Повтор (можешь оставить один из них)

-- GitHub CLI интеграция
{ "ldelossa/gh.nvim" },

-- JSON Viewer для Neovim
{ "gennaro-tedesco/nvim-jqx" },

-- Редактирование файловой системы как буфер
{ "stevearc/oil.nvim" },

-- Helm Charts для Neovim
{ "towolf/vim-helm" },

-- Подсветка синтаксиса TOML
{ "cespare/vim-toml" },

-- FZF Lua интерфейс
{ "ibhagwan/fzf-lua" },

-- Валидация GitLab CI конфигурации
{ "sbulav/validate-gitlab-ci.nvim" },

-- Схемы для JSON (например, для Kubernetes, Docker, etc.)
{ "b0o/schemastore.nvim" },

-- Автокомплит для Jenkinsfile
{ "joshzcold/cmp-jenkinsfile" },

-- Линтер для Jenkinsfile
{ "ckipp01/nvim-jenkinsfile-linter" },

-- Terraform поддержка
{ "hashivim/vim-terraform" },

-- KubeUtils для работы с Kubernetes
{ "edwardtheharris/kube-utils-nvim" },

-- Dropbar — UI для быстрого переключения буферов
{ "Bekaboo/dropbar.nvim" },

-- Форматирование Python через Black
{ "psf/black", branch = "stable" },

-- Форматирование Python через Black
{ "psf/black", branch = "stable" },

-- Анализ кода с помощью flake8
{ "dense-analysis/ale" },

-- Улучшение quickfix для логов
{ "kevinhwang91/nvim-bqf" },

-- Включение работы с текстом (закомментирован)
-- { "andymass/vim-matchup" },

-- Выбор виртуального окружения для Python
{ "linux-cultist/venv-selector.nvim", branch = "regexp" },

-- Для работы с текстовыми объектами в Treesitter
{ "nvim-treesitter/nvim-treesitter-textobjects" },

-- Плагин для работы с файловым браузером в Telescope
{ "nvim-telescope/telescope-file-browser.nvim" },

-- Snippets для работы с текстом
{ "folke/snacks.nvim" },

-- Превью Markdown в браузере
{ "iamcco/markdown-preview.nvim", ft = "markdown", build = "mkdp#util#install()" },

-- Вики-система для Neovim
{ "vimwiki/vimwiki" },

-- Плагин для решения задач на LeetCode
{ "kawre/leetcode.nvim" },

-- Настройка LSP-значков
{ "onsails/lspkind.nvim" },

-- Плагин для интеграции с Exercism
{ "2kabhishek/exercism.nvim" },

-- Зависимости
{ "2kabhishek/utils.nvim" },
{ "2kabhishek/termim.nvim" },

-- Синтаксис и выделение для Terraform
{ "mvaldes14/terraform.nvim" },

-- Плагин для установки инструментов через Mason
{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

-- Плагин для совместной работы (Co-Author)
{ "2KAbhishek/co-author.nvim" },

-- Плагин для работы с окнами кода
{ "gorbit99/codewindow.nvim" },

-- Плагин для работы с GitHub Issues и Pull Requests
{ "pwntester/octo.nvim" },

{ "kiyoon/telescope-insert-path.nvim"},

-- Плагин для работы с Copilot
{ "zbirenbaum/copilot.lua" },

{ "zbirenbaum/copilot-cmp" },

-- Плагин для работы с подписью LSP
{ "ray-x/lsp_signature.nvim" },

-- Плагин для отображения использования символов
{ "Wansmer/symbol-usage.nvim" },

-- Плагин для работы с Go знаками
{ "Yu-Leo/gosigns.nvim" },

-- Плагин для автодополнения Go пакетов
{ "Yu-Leo/cmp-go-pkgs" }


})
