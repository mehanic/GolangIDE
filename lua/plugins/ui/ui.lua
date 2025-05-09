-- Устанавливаем lualine в pluginvim.vim

-- РУНЫ ДЛЯ COMPONENT_SEPARATORS
local component_runes = {
  "ᚠ", "ᚢ", "ᚦ", "ᚱ", "ᚲ", "ᚷ", "ᛃ", "ᛈ", "ᛋ"
}

-- РУНЫ ДЛЯ SECTION_SEPARATORS
local section_runes = {
  "ᛁ", "ᛇ", "ᛉ", "ᛏ", "ᛒ", "ᛖ", "ᛗ", "ᛚ", "ᛟ"
}

-- СЛУЧАЙНЫЙ ВЫБОР РУН
math.randomseed(os.time())
local sep_component = component_runes[math.random(#component_runes)]
local sep_section = section_runes[math.random(#section_runes)]

-- ФУНКЦИЯ ОБНОВЛЕНИЯ РУН
local function animate_runes()
  sep_component = component_runes[math.random(#component_runes)]
  sep_section = section_runes[math.random(#section_runes)]

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'nord',
      component_separators = { left = sep_component, right = sep_component },
      section_separators = { left = sep_section, right = sep_section },
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {
        { 'filename', path = 1 },
        { 'filetype', icon_only = true },
        { 'encoding', icon = '' },
        { 'fileformat', icon = '' },
      },
      lualine_x = {
        'diagnostics',
        'lsp_progress',
        'location',
      },
      lualine_y = {
        { 'progress', separator = '' },
        { 'lineinfo', separator = '' },
      },
      lualine_z = {
        'os.date("%H:%M:%S")',
      },
    },
    inactive_sections = {
      lualine_a = {'filename'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {'progress'},
      lualine_z = {'os.date("%H:%M:%S")'},
    },
    extensions = {'fugitive', 'nvim-tree', 'quickfix'},
  }
end

-- ЗАПУСК LUALINE ПЕРВЫЙ РАЗ
animate_runes()

-- ЗАПУСК ТАЙМЕРА (раз в 1 час)
local timer = vim.loop.new_timer()
timer:start(0, 3600000, vim.schedule_wrap(animate_runes))

vim.g.db_ui_use_nerd_fonts = 1

vim.api.nvim_create_user_command("DBUI", "DBUI", {})
vim.api.nvim_create_user_command("DBUIToggle", "DBUIToggle", {})
vim.api.nvim_create_user_command("DBUIAddConnection", "DBUIAddConnection", {})
vim.api.nvim_create_user_command("DBUIFindBuffer", "DBUIFindBuffer", {})
