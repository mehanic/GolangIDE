local lsp_signature = require("lsp_signature")

local cfg = {
  bind = true,
  hint_enable = true,
  hint_prefix = "󰊕 ",
  hint_scheme = "LspSignatureHintPrefix",
  floating_window = true,
  floating_window_above_cur_line = false,

  floating_window_off_x = function()
    local win_width = vim.api.nvim_win_get_width(0)
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local max_width = 60
    local offset = win_width - col - max_width - 4
    return offset > 0 and offset or 0
  end,

  floating_window_off_y = function()
    local screen_line = vim.fn.winline()
    local win_height = vim.fn.winheight(0)
    if screen_line < 5 then
      return 1
    elseif win_height - screen_line < 5 then
      return -1
    else
      return 0
    end
  end,

  handler_opts = {
    border = "rounded",
    handler = function(sig_handler, err, result, ctx, config)
      -- Проверим, есть ли сигнатура
      if result and result.signatures and result.signatures[1] then
        local label = result.signatures[1].label or ""
        local ignore_list = { "Println", "Printf", "Print", "Errorf" }
        for _, name in ipairs(ignore_list) do
          if label:find(name) then
            return -- игнорируем
          end
        end
      end
      -- вызываем стандартный обработчик
      return sig_handler(err, result, ctx, config)
    end,
  },

  doc_lines = 2,
  max_width = 40,
  wrap = true,
}

vim.cmd([[
  highlight LspSignatureHintPrefix guifg=#ff8800 gui=bold
]])

lsp_signature.setup(cfg)


