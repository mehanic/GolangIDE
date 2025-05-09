-- Включение синтаксической подсветки для Markdown
vim.cmd("syntax enable")

-- Убедитесь, что файл Markdown правильно определяется
vim.cmd("filetype plugin indent on")

{
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "vimwiki" },
    build = "cd app && npm install",  -- Установи Node.js зависимости
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_theme = 'light'
      vim.g.mkdp_combine_preview = 0
      vim.g.mkdp_combine_preview_auto_refresh = 1
      vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_images_path = vim.fn.expand('~/.markdown_images')
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        sequence_diagrams = {},
        flowchart_diagrams = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
  
      -- Горячие клавиши
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown: Preview" })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Markdown: Stop Preview" })
      vim.keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown: Toggle Preview" })
    end,
  }

  
  vim.g.vimwiki_list = {
    {
      path = '~/vimwiki/',
      syntax = 'markdown',
      ext = '.md',
    },
  }
  