-- Load telescope configuration    telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Teles-- cope is centered around modularity, allowing for easy customization.
local telescope = require("telescope")
local actions = require("telescope.actions")
--local builtin = require("telescope.builtin")  not use variable

telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    wrap_results = true,
    winblend = 10,
    file_ignore_patterns = {
      "node_modules", "%.git/", "%.jpg", "%.jpeg", "%.png", "%.svg", "%.webp",
      "%.zip", "%.tar", "%.tar.gz",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = { wrap_results = true, theme = "ivy", previewer = false },
    live_grep = { wrap_results = true, theme = "dropdown" },
    buffers = {
      wrap_results = true,
      sort_mru = true,
      ignore_current_buffer = true,
      theme = "dropdown",
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})
-- Load the fzf extension
require('telescope').load_extension('fzf')
-- pcall(telescope.load_extension, "fzf")

vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- или ">>", "🔥" — по вкусу "❖" "✸" 
      spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
     float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })
  
  -- Цвет рамки (тонкая зелёная линия вокруг)
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#00ff00", bg = "#1e1e2e" })
  
  
  -- Цвет фона для всплывающего окна
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
  
  -- Явно указываем рамку для LSP ховеров и подсказок
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
  )
  
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
  )
  

require('bqf').setup({
  auto_enable = true,
  preview = {
    win_height = 15,
    win_vheight = 15,
    delay_syntax = 80,
    border_chars = { '│', '│', '─', '─', '┌', '┐', '┘', '└' },
  },
  func_map = {
    open = 'o',
    openc = '<CR>',
    drop = 'O',
    split = 's',
    vsplit = 'v',
    tabdrop = 't',
    toggle_preview = 'p',
    prev_file = 'K',
    next_file = 'J',
  },
  filter = {
    fzf = {
      action_for = {
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit',
        ['ctrl-t'] = 'tab drop',
      },
      extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
    }
  }
})

local path_actions = require('telescope_insert_path')

require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ["["] = path_actions.insert_reltobufpath_visual,
        ["]"] = path_actions.insert_abspath_visual,
        ["{"] = path_actions.insert_reltobufpath_insert,
        ["}"] = path_actions.insert_abspath_insert,
        ["-"] = path_actions.insert_reltobufpath_normal,
        ["="] = path_actions.insert_abspath_normal,
      }
    }
  }
}

vim.keymap.set("n", "<leader>p", function()
    require("telescope.builtin").find_files()
  end, {
    noremap = true,
    silent = true,
    desc = "Telescope: Find files",
  })
  