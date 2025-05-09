-- colorscheme
vim.cmd("colorscheme vim")

-- custom highlight groups (example)
vim.cmd [[
  highlight Normal guibg=none guifg=white
  highlight CommandLine guibg=black guifg=white
  highlight Pmenu guibg=black guifg=white
  highlight PmenuSel guibg=blue guifg=white
]]

-- leader key
vim.g.mapleader = ";"

-- enable mouse support
vim.opt.mouse = "a"

-- manually set filetype (not always necessary)
vim.cmd("set filetype=helm")

-- Syntastic plugin settings
vim.g.syntastic_auto_loc_list = 0
vim.g.syntastic_show_signs = 0
vim.g.syntastic_quiet = 1
vim.g.syntastic_always_populate_loc_list = 0
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0
vim.g.syntastic_check_on_filetype = 0
vim.g.syntastic_enable_signs = 0
vim.g.syntastic_use_local_files = 1
vim.g.syntastic_save_on_check = 1

vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"


require('fzf-lua').setup({
    winopts = {
      border = 'rounded',
      preview = {
        layout = 'vertical', -- горизонтально: 'horizontal' или 'flex'
        scrollbar = 'float',
        delay = 100,
      },
    },
    files = {
      prompt = '   Files❯ ',
      git_icons = true,
      file_icons = true,
    },
    grep = {
      prompt = ' 🔍 Grep❯ ',
      rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!{.git,node_modules}/*'",
    },
    git = {
      commits = {
        prompt = ' Git commits❯ ',
        preview = 'git show --color=always --format=fuller --stat {1}',
      },
    },
  })
  

 
 
  vim.api.nvim_set_keymap('n', '<leader>gC', ':CoAuthor<CR>', { noremap = true, silent = true })
  