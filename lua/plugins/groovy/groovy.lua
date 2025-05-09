local null_ls = require("null-ls")
local h = require("null-ls.helpers")

-- Линтер
local groovy_diagnostics = {
  name = "npm-groovy-lint",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "groovy", "jenkinsfile" },
  generator = h.generator_factory({
    command = "npm-groovy-lint",
    args = {
      "--ext", "groovy,jenkinsfile",
      "-c", "/home/mehanic/.config/nvim/lua/groovy",
      "$FILENAME",
      "--format", "json",
    },
    to_stdin = false,
    from_stderr = true,
    format = "json",
    check_exit_code = function(code)
      return code == 0 or code == 1
    end,
    on_output = function(params)
      local diagnostics = {}
      local result = vim.fn.json_decode(params.output)

      if result and type(result) == "table" then
        for _, issue in ipairs(result) do
          table.insert(diagnostics, {
            row = issue.line or 1,
            col = issue.column or 1,
            message = issue.message or "Unknown issue",
            severity = vim.diagnostic.severity[(issue.severity or "error"):upper()] or vim.diagnostic.severity.ERROR,
          })
        end
      end

      return diagnostics
    end,
  }),
}

-- Форматтер (автофикс)
local groovy_formatter = {
  name = "npm-groovy-lint-fix",
  method = null_ls.methods.FORMATTING,
  filetypes = { "groovy", "jenkinsfile" },
  generator = {
    fn = function(params)
      return {
        command = "npm-groovy-lint",
        args = {
          "--ext", "groovy,jenkinsfile",
          "-c", "/home/mehanic/.config/nvim/lua/groovy",
          params.bufname,
          "--fix",
        },
        to_stdin = false,
      }
    end,
  },
}

-- Подключение
null_ls.setup({
  sources = {
    groovy_diagnostics,
    groovy_formatter,
  },
})

-- Подключение сниппетов для Jenkinsfile
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

local lspconfig = require("lspconfig")

lspconfig.groovyls.setup({
  cmd = {
    "java",
    "-jar",
    "/home/mehanic/.config/nvim/lua/groovy/groovy-language-server-all.jar"
  },
  filetypes = { "groovy", "jenkinsfile" },
  root_dir = lspconfig.util.root_pattern(".git", "settings.gradle", "Jenkinsfile"),
})

vim.cmd [[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre *.groovy,*.jenkinsfile lua vim.lsp.buf.format()
  augroup END
]]
