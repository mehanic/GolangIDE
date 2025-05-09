local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Save with Alt+w
map('n', '<A-w>', ':w<CR>', opts)

-- Show hover doc with K
map('n', 'K', ":call CocActionAsync('doHover')<CR>", { noremap = true, silent = true })

-- Test leader key
map('n', '<Leader>b', ':echo "Leader key works!"<CR>', opts)

-- Go to definition using Coc
vim.cmd([[nmap <silent> gd <Plug>(coc-definition)]])

-- Маппинг для Telescope
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })


require('nvim-navic').setup({
    highlight = true,
    separator = ' > ',
    depth = 5,
  })


  require('lualine').setup {
    sections = {
      lualine_c = {'filename', require('nvim-navic').get_location},
    },
  }


--

local cmp = require("cmp")
--подтверждала автодополнение только если меню открыто
--а иначе — просто делала новый абзац
cmp.setup({
  mapping = {
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      else
        fallback() -- обычный Enter
      end
    end, { "i", "s" }),
  },
})
