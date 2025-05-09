
-- Load the conform plugin configuration
local conform = require("conform")

-- Setup for conform plugin
conform.setup({
  -- Define formatters by file type
  formatters_by_ft = {
    sql = { "sql-formatter" },         -- Use sql-formatter for SQL files
    go = { "gofmt", "goimports" },     -- Use gofmt for Go, goimports for imports cleanup
    python = { "black", "isort", "ruff"},              -- Use black for Python files pipx install black flake8 isort ruff
    javascript = { "prettier" },       -- Use prettier for JavaScript files
    lua = { "stylua" },                -- Use stylua for Lua files
    -- Add more file types and formatters as necessary
  },

  -- Enable async installation of formatters
  sync_install = false,
  auto_install = true,  -- Automatically install missing formatters when a file is opened

  highlight = {
    enable = true,  -- Enable syntax highlighting with treesitter
    additional_vim_regex_highlighting = false,  -- Disable additional regex-based highlighting
  },

  indent = {
    enable = true,  -- Enable indentation based on Treesitter
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",   -- Initial selection with Enter
      node_incremental = "<CR>", -- Incremental selection with Enter
      node_decremental = "<BS>", -- Decremental selection with Backspace
      scope_incremental = "<TAB>", -- Incremental selection for scope with Tab
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,  -- Smart selection (lookahead feature)
      keymaps = {
        ["af"] = "@function.outer",  -- Select entire function
        ["if"] = "@function.inner",  -- Select only function body
        ["ac"] = "@class.outer",     -- Select entire class
        ["ic"] = "@class.inner",     -- Select class body
        ["aa"] = "@parameter.outer", -- Select entire parameter
        ["ia"] = "@parameter.inner", -- Select parameter name
      },
    },
  },

  -- Add error handling (safe call for formatting)
  error_handling = {
    -- Display errors in Neovim if something goes wrong
    display_error = function(err)
      vim.api.nvim_err_writeln("Formatting error: " .. err)
    end
  }
})

-- Auto-command to format SQL files before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.sql",  -- Apply to SQL files
  callback = function()
    -- Safe call to format the file
    local success, err = pcall(function()
      require('conform').format()
    end)
    if not success then
      vim.api.nvim_err_writeln("Error formatting SQL file: " .. err)
    end
  end,
})

-- Кастомное форматирование по <leader>f
vim.keymap.set("n", "<leader>f", function()
    require("conform").format()
  end, { noremap = true, silent = true, desc = "Format file with Conform" })