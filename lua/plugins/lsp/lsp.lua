-- Mason: менеджер LSP и внешних инструментов
require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
  
  -- Установка LSP через mason-lspconfig
  require("mason-lspconfig").setup({
    ensure_installed = {
      "terraformls",
      "pyright",
      "gopls",
      "groovyls",
      "sqls",
      "yamlls",
      "bashls",
      "jsonls",
      "lua_ls",
      "dockerls",
    },
    automatic_installation = true,
  })
  
  -- Установка и обновление CLI-инструментов через mason-tool-installer
  require("mason-tool-installer").setup({
    ensure_installed = {
      "gofumpt",
      "golangci-lint",
      "revive",
    },
    auto_update = true,
    run_on_start = true,
  })
  