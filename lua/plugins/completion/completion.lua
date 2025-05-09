vim.opt.completeopt:remove("preview")

vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    if vim.fn.pumvisible() == 0 then vim.cmd("pclose") end
  end
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


require("notify").setup({
    stages = "fade_in_slide_out",  
    timeout = 3000,                
    background_colour = "#282828", 
    minimum_width = 50,            
    top_down = false,              
    icons = {
      ERROR = "❌",                 
      WARN  = "⚡",                  
      INFO  = "🔥",                  
      DEBUG = "ℹ️",                 
      TRACE = "🔍",                 
    }
  })
  
  vim.notify = require("notify")
  require("telescope").load_extension("notify")
  
  vim.notify("помилка", "error")
  vim.notify("застереження", "warn")
  vim.notify("Інформація", "info")
  vim.notify("All plugins are downloaded and updated", "info")
  

  require("toggleterm").setup{
    -- General settings
    size = 10,                  -- Default terminal size
    persist_size = true,        -- Persist terminal size across sessions
    start_in_insert = true,     -- Start in insert mode when opening terminal
    open_mapping = [[<C-\>]],    -- Keybinding to toggle terminal

    -- Terminal appearance settings
    direction = 'horizontal',   -- Open terminal in horizontal split
    -- Optional floating window settings (commented out for horizontal split)
    -- float_opts = {
    --   border = "curved",         -- Use a curved border for the floating terminal
    --   winblend = 3,              -- Make the floating terminal semi-transparent
    -- },

    -- Optional horizontal split settings (you can leave these as is for horizontal split)
    -- shade_terminals = true,     -- Enable shading for terminals
  }


  require("neo-tree").setup({
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,  -- Show dotfiles
        hide_gitignored = true, -- Hide git-ignored files
      },
    },
    window = {
      width = 30,  -- Width of the file tree window
      mappings = {
        ["<CR>"] = "open",        -- Open a file or directory
        ["<BS>"] = "close_node",  -- Close the current node
        ["."] = "toggle_hidden",  -- Toggle visibility of hidden files
        ["<C-p>"] = "preview",    -- Preview the file under cursor
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = "▶",  -- Icon for closed folders
        folder_open = "▼",    -- Icon for open folders
      },
    },
  })

  local highlight = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  }
  
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75" }) -- red-ish
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B" }) -- yellow-ish
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#98C379" }) -- green-ish
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#56B6C2" }) -- cyan-ish
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#61AFEF" }) -- blue-ish
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD" }) -- purple-ish
  
  require("ibl").setup {
    indent = {
      char = "│",
      highlight = highlight,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = highlight,
    },
    exclude = {
      filetypes = { "help", "terminal", "dashboard", "NvimTree" },
      buftypes = { "terminal", "nofile" },
    },
  }

  
  -- hlchunk: подсветка блоков, правая визуализация
-- Устанавливаем уникальные цвета, не пересекающиеся с indent-blankline
vim.api.nvim_set_hl(0, "Chunk1", { fg = "#FAB387" }) -- peach
vim.api.nvim_set_hl(0, "Chunk2", { fg = "#A6E3A1" }) -- green pastel
vim.api.nvim_set_hl(0, "Chunk3", { fg = "#F38BA8" }) -- pinkish red
vim.api.nvim_set_hl(0, "Chunk4", { fg = "#89DCEB" }) -- sky blue

require("hlchunk").setup({
  indent = {
    enable = true,
    chars = { "▏" },
    style = {
      { fg = "#FAB387" },
      { fg = "#A6E3A1" },
      { fg = "#F38BA8" },
      { fg = "#89DCEB" },
    },
    use_treesitter = true,
    right_align = true,
  },

  chunk = {
    enable = true,
    support_filetypes = { "*" },
    use_treesitter = true,
    chars = {
      horizontal_line = "━",
      vertical_line = "┃",
      left_top = "┏",
      left_bottom = "┗",
    },
    style = {
      { fg = "#FAB387" },
    },
  },

  line_num = {
    enable = false,
  },

  blank = {
    enable = false,
  },

  exclude = {
    filetypes = { "help", "dashboard", "NvimTree", "terminal" },
    buftypes = { "terminal", "nofile" },
  },
})


-- hlchunk: подсветка блоков, правая визуализация
-- Устанавливаем уникальные цвета, не пересекающиеся с indent-blankline
vim.api.nvim_set_hl(0, "Chunk1", { fg = "#FAB387" }) -- peach
vim.api.nvim_set_hl(0, "Chunk2", { fg = "#A6E3A1" }) -- green pastel
vim.api.nvim_set_hl(0, "Chunk3", { fg = "#F38BA8" }) -- pinkish red
vim.api.nvim_set_hl(0, "Chunk4", { fg = "#89DCEB" }) -- sky blue

require("hlchunk").setup({
  indent = {
    enable = true,
    chars = { "▏" },
    style = {
      { fg = "#FAB387" },
      { fg = "#A6E3A1" },
      { fg = "#F38BA8" },
      { fg = "#89DCEB" },
    },
    use_treesitter = true,
    right_align = true,
  },

  chunk = {
    enable = true,
    support_filetypes = { "*" },
    use_treesitter = true,
    chars = {
      horizontal_line = "━",
      vertical_line = "┃",
      left_top = "┏",
      left_bottom = "┗",
    },
    style = {
      { fg = "#FAB387" },
    },
  },

  line_num = {
    enable = false,
  },

  blank = {
    enable = false,
  },

  exclude = {
    filetypes = { "help", "dashboard", "NvimTree", "terminal" },
    buftypes = { "terminal", "nofile" },
  },
})


local null_ls = require("null-ls")
--must have create revive.toml in ~/.config/revive/revive.toml  and golangci.yml  in ~/.config/golangci-lint/golangci.yml 
--можливо створено звідси але неясно   implemented by: main. implements: main.

--go install golang.org/x/tools/cmd/goimports@latest
--go install mvdan.cc/gofumpt@latest
--go install github.com/mgechev/revive@latest
--file : ~/.config/revive/revive.toml 
--Открой .go файл, попробуй внести ошибку или сохранить файл — revive должен показать диагностику, goimports/gofumpt — отформатировать.
null_ls.setup({
  sources = {
    -- goimports → добавит недостающие импорты
    null_ls.builtins.formatting.goimports,

    -- gofumpt → строгий gofmt
    null_ls.builtins.formatting.gofumpt,

    -- golangci-lint (может включать revive, если настроен в .golangci.yml)
    null_ls.builtins.diagnostics.golangci_lint.with({
      command = "golangci-lint",
      args = { "run", "--out-format", "json", "--path-prefix", vim.fn.getcwd() },
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      to_temp_file = false,
    }),
  },
})



-- YAML Language Server Configuration (без дополнительных схем)
--local schemastore = require("schemastore")
--local schemas = schemastore.yaml.schemas()

-- Выводим схемы
--print(vim.inspect(schemas))
local lspconfig = require("lspconfig")

local combined_schemas = {
  -- Manually adding the Helm Chart schema
  ["https://json.schemastore.org/helm-chart.json"] = { "charts/**/Chart.yaml" },
  ["https://json.schemastore.org/helm-values.json"] = { "charts/**/values.yaml" },

  -- Manually adding the Kustomization schema
  ["https://json.schemastore.org/kustomization.json"] = { "kustomization.yaml", "kustomization.yml" },
  
  -- Manually adding the Cilium schema
  ["https://json.schemastore.org/cilium.json"] = { "cilium.yaml", "cilium.yml" },

  -- Manually adding the Kyverno schema
  ["https://json.schemastore.org/kyverno.json"] = { "kyverno.yaml", "kyverno.yml" },

  -- Manually adding the GitHub Actions schema
  ["https://json.schemastore.org/github-workflow.json"] = { ".github/workflows/*.yml", ".github/workflows/*.yaml" },

  ["https://json.schemastore.org/kubernetes.json"] = {"*.yaml"},
}

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = combined_schemas,
      validate = true,
      hover = true,
      completion = true,
    },
  },
})

local null_ls = require("null-ls")
local h = require("null-ls.helpers")

null_ls.setup({
  sources = {
    -- Helm lint
    {
      name = "helm_lint",
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "yaml" },
      generator = h.generator_factory({
        command = "helm",
        args = { "lint", "$FILENAME" },
        format = "line",
        to_stdin = false,
        on_output = function(line, params)
          return {
            message = line,
            row = 1,
            col = 1,
            source = "helm lint",
            severity = vim.diagnostic.severity.WARN,
          }
        end,
      }),
    },

    -- kubeval
    {
      name = "kubeval",
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "yaml" },
      generator = h.generator_factory({
        command = "kubeval",
        args = { "--output", "json", "$FILENAME" },
        format = "json_raw",
        to_stdin = false,
        on_output = function(params, done)
          local diagnostics = {}
          for _, msg in ipairs(params.output or {}) do
            if msg.errors then
              for _, err in ipairs(msg.errors) do
                table.insert(diagnostics, {
                  message = err,
                  row = 1,
                  col = 1,
                  severity = vim.diagnostic.severity.ERROR,
                  source = "kubeval",
                })
              end
            end
          end
          return diagnostics
        end,
      }),
    },
  },
})

