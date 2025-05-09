vim.api.nvim_create_augroup("FiletypeSettings", { clear = true })

local ft_autocmds = {
  { "FileType", "ansible", "setlocal expandtab" },
  { "FileType", "css,html,htmldjango,json,svg,ruby,yaml", "setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab" },
  { "FileType", "java,php", "setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab" },
  { "FileType", "javascript", "setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab" },
  { "FileType", "typescript", "setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab colorcolumn=120 nowrap" },
  { "FileType", "make,fstab", "setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab" },
  { "FileType", "pcc", "setlocal shiftwidth=3 tabstop=3 softtabstop=3 expandtab" },
  { "FileType", "python", "setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab colorcolumn=80 nowrap" },
  { "FileType", "php", "setlocal colorcolumn=100" },
  { "FileType", "ruby", "setlocal colorcolumn=100" },
  { "FileType", "yaml", "setlocal colorcolumn=80" },
  { "FileType", "sql", "setlocal nowrap" },
  { "FileType", "tex,plaintex,context", "setlocal wrap linebreak" },
  { "FileType", "gitcommit", "setlocal spelllang=en spell" },
}

for _, autocmd in ipairs(ft_autocmds) do
  vim.api.nvim_create_autocmd(autocmd[1], {
    pattern = autocmd[2],
    command = autocmd[3],
    group = "FiletypeSettings"
  })
end

-- Выделение не-ASCII символов
vim.api.nvim_command("syntax match nonascii '[^\\x00-\\x7F]'")
vim.api.nvim_command("highlight nonascii guibg=Red ctermbg=3")

-- Настройки для типов файлов
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.ipynb",
    command = "setfiletype json",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.md",
    command = "setlocal textwidth=80 wrap colorcolumn=80 spell",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "README.md",
    command = "setlocal textwidth=80 wrap colorcolumn=80 spell",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.tsx,*.jsx",
    command = "set filetype=typescript.jsx",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = ".babelrc",
    command = "set filetype=json",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "Vagrantfile",
    command = "set filetype=ruby",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.fish",
    command = "set filetype=fish",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.td",
    command = "set filetype=tablegen",
  })
  
  -- Для файлов Ansible (.yml и .yaml)
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.yml,*.yaml",
    command = "setlocal filetype=ansible",
  })
  
  vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.yml,*.yaml",
    command = "setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2",
  })
  
-- Настройка цвета вертикальной линии ограничения ширины
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 236, guibg = "#2c2c2c" })