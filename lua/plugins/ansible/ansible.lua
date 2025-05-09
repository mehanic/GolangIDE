local lspconfig = require('lspconfig')

lspconfig.ansiblels.setup({
  cmd = { "ansible-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },

root_dir = lspconfig.util.root_pattern(
  "ansible.cfg",
  "requirements.yml",
  "inventory.ini",
  "hosts",
  "roles",                  -- корень с ролями
  "meta/main.yml",
  "tasks/main.yml",
  "handlers/main.yml",
  "defaults/main.yml",
  "vars/main.yml",
  "test/main.yml",
  "meta/main.yml",         -- molecule конфиг
  "molecule/main.yml",
  "meta",
  "tasks",
  "handlers",
  "defaults",
  "vars",
  "test",
  "molecule"
),

  settings = {
    ansible = {
      ansible = {
        path = "ansible",         -- путь к бинарнику ansible
      },
      ansibleLint = {
        path = "ansible-lint",    -- путь к ansible-lint
      },
      python = {
        interpreterPath = "python3", -- или путь к твоей venv
      },
    },
  },

  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Автоформат при сохранении
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })
    end
  end
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.yml",
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, 50, false)
      for _, line in ipairs(lines) do
        if line:match("hosts:") or line:match("tasks:") or line:match("roles:") or line:match("gather_facts:") or line:match("ansible_") then
          vim.bo.filetype = "ansible"
          return
        end
      end
      vim.bo.filetype = "yaml"
    end,
  })
  