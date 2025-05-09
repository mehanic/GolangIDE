-- Bash completion
vim.g.loaded_bash_completion = 1
vim.g.sh_autocmd = 1

-- Python host
vim.g.python3_host_prog = "/home/mehanic/myenv/bin/python3"

-- Настройки для NERDTree
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "NERDTree",
  })
  
  vim.g.NERDTreeHighlightFoldersFullName = 1
  vim.g.NERDTreeHighlightFolders = 1
  -- vim.g.NERDTreeShowHidden = 1  -- можно раскомментировать, если нужно показывать скрытые файлы
  vim.g.NERDTreeIgnore = { '\\.csm$' }
  vim.g.NERDTreeShowIcons = 1
  
  -- Автозакрытие NERDTree при выходе из Neovim
  vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*",
    command = "if exists('g:NERDTree') && g:NERDTree.IsOpen() | NERDTreeClose | endif",
  })
  