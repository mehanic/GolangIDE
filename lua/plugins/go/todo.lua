require("todo-comments").setup({
    signs = true,
    keywords = {
      TODO = { icon = " ", color = "info" },
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      HACK = { icon = " ", color = "warning" },
      PERF = { icon = " ", color = "default", alt = { "OPTIMIZE" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
      keyword = "wide",
      after = "fg",
      comments_only = true,
    },
    search = {
      command = "rg",
      args = {
        "--color=never", "--no-heading", "--with-filename",
        "--line-number", "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  })
  
  -- Подключаем расширение в Telescope
  require("telescope").load_extension("todo-comments")
  
  -- Горячая клавиша
  vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "🔍 Поиск TODO через Telescope" })
  
  