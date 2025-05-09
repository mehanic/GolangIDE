-- Инициализация плагина kube-utils-nvim
require("kube-utils-nvim.init").setup {
    -- Настройка для kubectl
    kubectl = {
      command = 'kubectl',  -- Убедись, что kubectl установлен
      context_display = true,  -- Показывать контексты Kubernetes
    },
  
    -- Управление контекстами и namespaces
    context_and_namespace = {
      enable = true,  -- Включить возможность переключаться между контекстами и namespaces
    },
  
    -- Просмотр CRD (Custom Resource Definitions)
    crd_viewer = {
      enable = true,  -- Включить просмотр CRD
    },
  
    -- Интеграция с Helm
    helm = {
      enable = true,  -- Включить поддержку Helm
      command = 'helm',  -- Команда Helm
    },
  
    -- Просмотр логов Kubernetes
    log_viewer = {
      enable = true,  -- Включить просмотр логов
      format = 'json',  -- Форматирование логов в JSON
    },
  
    -- Интеграция с Telescope для выбора контекста и namespaces
    telescope_integration = {
      enable = true,  -- Включить интеграцию с Telescope
    },
  
    -- Интеграция с LSP для работы с YAML и Helm
    lsp_integration = {
      enable = true,  -- Включить LSP для YAML и Helm
    },
  
    -- Интеграция с K9s
    k9s_integration = {
      enable = true,  -- Включить запуск K9s из Neovim
    },
  }
  
  require('telescope').setup{
    defaults = {
      extensions = {
        telescope_k8s = {  -- Используем правильное имя расширения
          context_display = true,  -- Показывать контексты в Telescope
          namespace_display = true,  -- Показывать namespaces
          helm_releases_display = true,  -- Показывать релизы Helm
        },
      },
    },
  }
  

  -- Команды для работы с Kubernetes через терминал

-- Команда для запуска K9s
vim.api.nvim_exec([[
  command! K9s :terminal k9s
]], false)

-- Команда для работы с kubectl
vim.api.nvim_exec([[
  command! KubeCtl :terminal kubectl
]], false)

-- Команда для работы с helm
vim.api.nvim_exec([[
  command! Helm :terminal helm
]], false)

-- Команда для просмотра всех CRD
vim.api.nvim_exec([[
  command! K8sCRD :terminal kubectl get crds
]], false)

-- Команда для просмотра подробной информации о конкретном CRD
vim.api.nvim_exec([[
  command! K8sCRDDetails :terminal kubectl describe crd <name_of_crd>
]], false)

-- Команда для просмотра всех Kubernetes Operators
vim.api.nvim_exec([[
  command! K8sOperators :terminal kubectl get operators
]], false)

-- Команда для применения YAML файла из текущего буфера
vim.api.nvim_exec([[
  command! KubectlApplyFromBuffer execute '!kubectl apply -f ' . expand('%:p')
]], false)
