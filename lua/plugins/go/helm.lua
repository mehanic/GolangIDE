local null_ls = require("null-ls")
local h = require("null-ls.helpers")

local helm_lint = {
  name = "helm_lint",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "helm", "yaml" },
  generator = h.generator_factory({
    command = "helm",
    args = function(params)
      return { "lint", params.bufname }
    end,
    to_stdin = false,
    from_stderr = true,
    format = "line",
    check_exit_code = function(code)
      return code <= 1  -- helm lint может возвращать 1 при предупреждениях
    end,
    on_output = function(line)
      return {
        row = 1,
        col = 1,
        message = line,
        severity = vim.diagnostic.severity.WARN,
      }
    end,
  }),
}

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.yamllint,
    helm_lint,
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
      "*/templates/*.yaml",
      "*/templates/*.tpl",
      "*/charts/**/templates/*.yaml",
      "*/charts/**/templates/*.tpl",
      "*/charts/**/Chart.yaml",
      "*/charts/**/*.yaml",  -- This will match all YAML files inside charts/
      "*/charts/**/*.tpl",   -- This will match all tpl files inside charts/
      "*/charts/**/Chart.yaml",
      "*/charts/**/values.yaml",
    },
    callback = function()
      vim.bo.filetype = "helm"
    end,
  })
  

  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier.with({
        filetypes = { "helm" },
        args = { "--parser", "yaml" },
      }),
    },
  })
  
  