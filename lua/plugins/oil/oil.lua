require("oil").setup({
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    default_file_explorer = true,
  
    -- Columns to display in the oil view
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
  
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
  
    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
  
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
  
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
  
    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    prompt_save_on_select_new_entry = true,
  
    -- Oil will automatically delete hidden buffers after this delay
    cleanup_delay_ms = 2000,
  
    lsp_file_methods = {
      -- Enable or disable LSP file operations
      enabled = true,
      -- Time to wait for LSP file operations to complete before skipping
      timeout_ms = 1000,
      -- Set to true to autosave buffers that are updated with LSP willRenameFiles
      -- Set to "unmodified" to only save unmodified buffers
      autosave_changes = false,
    },
  
    -- Constrain the cursor to the editable parts of the oil buffer
    -- Set to `false` to disable, or "name" to keep it on the file names
    constrain_cursor = "editable",
  
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = false,
  
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
  
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,
  
    -- View options
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name)
        return vim.startswith(name, ".")
      end,
      -- Sort file names with numbers in a more intuitive order for humans.
      -- Can be "fast", true, or false. "fast" will turn it off for large directories.
      natural_order = true,
      -- Sort file and directory names case insensitive
      case_insensitive = false,
      sort = {
        -- sort order can be "asc" or "desc"
        { "type", "asc" },
        { "name", "asc" },
      },
      -- Customize the highlight group for the file name
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
        return nil
      end,
    },
  
    -- Extra arguments to pass to SCP when moving/copying files over SSH
    extra_scp_args = {},
  
    -- EXPERIMENTAL support for performing file operations with git
    git = {
      -- Return true to automatically git add/mv/rm files
      add = function(path)
        return false
      end,
      mv = function(src_path, dest_path)
        return false
      end,
      rm = function(path)
        return false
      end,
    },
  
    -- Configuration for the floating window in oil.open_float
    float = {
      -- Padding around the floating window
      padding = 2,
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.8,
      max_height = 0.2,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
      get_win_title = nil,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
    },
  
    -- Configuration for the file preview window
    preview_win = {
      -- Whether the preview window is automatically updated when the cursor is moved
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      preview_method = "fast_scratch",
      -- A function that returns true to disable preview on a file e.g. to avoid lag
      disable_preview = function(filename)
        return false
      end,
      -- Window-local options to use for preview window buffers
      win_options = {},
    },
  
    -- Configuration for the floating action confirmation window
    confirmation = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a single value or a list of mixed integer/float types.
      -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
      max_width = 0.9,
      -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
      min_width = { 40, 0.4 },
      -- optionally define an integer/float for the exact width of the preview window
      width = nil,
      -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_height and max_height can be a single value or a list of mixed integer/float types.
      -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
      max_height = 0.9,
      -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
      min_height = { 5, 0.1 },
      -- optionally define an integer/float for the exact height of the preview window
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  
    -- Configuration for the floating progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
  
    -- Configuration for the floating SSH window
    ssh = {
      border = "rounded",
    },
  
    -- Configuration for the floating keymaps help window
    keymaps_help = {
      border = "rounded",
    },
  })
  
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  
  vim.api.nvim_create_user_command("OilCopyDir", function()
    local function pick_dir(prompt_title, callback)
      pickers.new({}, {
        prompt_title = prompt_title,
        finder = finders.new_oneshot_job({
          "find", ".", "-type", "d", "-not", "-path", "*/.git/*"
        }, {
          cwd = vim.loop.cwd(),
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            if not selection then
              vim.notify("❌ Ничего не выбрано", vim.log.levels.WARN)
              return
            end
            actions.close(prompt_bufnr)
            callback(selection[1])
          end)
          return true
        end,
      }):find()
    end
  
    pick_dir("📁 Откуда копировать директорию", function(from_path)
      pick_dir("📂 Куда скопировать директорию", function(to_path)
        from_path = vim.fn.expand(from_path)
        to_path = vim.fn.expand(to_path)
  
        if from_path == "" or to_path == "" then
          vim.notify("❌ Путь не указан", vim.log.levels.ERROR)
          return
        end
  
        if from_path == to_path then
          vim.notify("❌ Нельзя копировать директорию в саму себя", vim.log.levels.ERROR)
          return
        end
  
        local cmd = string.format('cp -r "%s" "%s"', from_path, to_path)
        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_exit = function(_, code, _)
            if code == 0 then
              vim.notify("✅ Копирование завершено!", vim.log.levels.INFO)
            else
              vim.notify("❌ Ошибка при копировании", vim.log.levels.ERROR)
            end
          end,
        })
      end)
    end)
  end, {})
  
  
  
  --//////
  
  vim.api.nvim_create_user_command("SshRsyncUpload", function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local previewers = require("telescope.previewers")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
  
    local function pick_host(callback)
      local ssh_config = os.getenv("HOME") .. "/.ssh/config"
  
      pickers.new({}, {
        prompt_title = "🔌 SSH Хост",
        finder = finders.new_oneshot_job({ "awk", "/^Host / {print $2}", ssh_config }),
        previewer = previewers.new_buffer_previewer({
          title = "📄 Конфигурация SSH",
          define_preview = function(self, entry)
            local host = entry.value
            if not host or host == "" then return end
  
            local ssh_lines = vim.fn.systemlist("ssh -G " .. host)
            local lines = {}
            local user, hostname
  
            if not ssh_lines or #ssh_lines == 0 or ssh_lines[1]:match("unknown") then
              lines = vim.fn.systemlist(string.format(
                "awk 'BEGIN{p=0} /^Host %s$/ {p=1; print; next} /^Host /{p=0} p {print}' %s",
                host, ssh_config
              ))
              table.insert(lines, 1, "[⚠️ Не удалось получить ssh -G, показан raw конфиг]")
            else
              for _, line in ipairs(ssh_lines) do
                if line:match("^user ") then
                  user = line:match("^user%s+(.*)")
                elseif line:match("^hostname ") then
                  hostname = line:match("^hostname%s+(.*)")
                end
              end
              lines = vim.tbl_extend("force", { string.format("[✅ ssh -G: %s@%s]", user or "?", hostname or "?") }, ssh_lines)
            end
  
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
          end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(bufnr, _)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            if not selection then
              vim.notify("❌ Хост не выбран", vim.log.levels.WARN)
              return
            end
  
            actions.close(bufnr)
  
            local host = selection[1]
            local ssh_output = vim.fn.systemlist("ssh -G " .. host)
            local user, hostname
  
            for _, line in ipairs(ssh_output) do
              if line:match("^user ") then
                user = line:match("^user%s+(.*)")
              elseif line:match("^hostname ") then
                hostname = line:match("^hostname%s+(.*)")
              end
            end
  
            local full_target = host
            if user and hostname then
              full_target = string.format("%s@%s", user, hostname)
            end
  
            callback({
              host = host,
              target = full_target,
              ssh_output = ssh_output,
            })
          end)
          return true
        end,
      }):find()
    end
  
    local function pick_local_dir(callback)
      pickers.new({}, {
        prompt_title = "📁 Локальная директория",
        finder = finders.new_oneshot_job({ "find", ".", "-type", "d", "-not", "-path", "*/.git/*" }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(bufnr, _)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            if not selection then
              vim.notify("❌ Директория не выбрана", vim.log.levels.WARN)
              return
            end
            actions.close(bufnr)
            callback(vim.fn.fnamemodify(selection[1], ":p"))
          end)
          return true
        end,
      }):find()
    end
  
    -- Выбор протокола для передачи (rsync, scp, ssh)
    local function pick_transfer_protocol(callback)
      -- Протестируем с выводом ошибок для диагностики
      vim.ui.select({ "rsync", "scp", "ssh" }, { prompt = "Выберите протокол передачи: " }, function(protocol)
        if not protocol then
          vim.notify("❌ Протокол не выбран", vim.log.levels.WARN)
          return
        end
        vim.notify("Выбран протокол: " .. protocol, vim.log.levels.INFO)  -- Для отладки
        callback(protocol)
      end)
    end
  
    pick_host(function(info)
      pick_local_dir(function(local_path)
        pick_transfer_protocol(function(protocol)
          vim.ui.input({ prompt = "📂 Удалённый путь на " .. info.target .. ": " }, function(remote_path)
            if not remote_path or remote_path == "" then
              vim.notify("❌ Удалённый путь не указан", vim.log.levels.ERROR)
              return
            end
  
            -- Ищем кастомный порт из ssh -G
            local port
            for _, line in ipairs(info.ssh_output) do
              if line:match("^port ") then
                port = tonumber(line:match("^port%s+(%d+)"))
              end
            end
  
            local ssh_option = (port and port ~= 22) and string.format("-e 'ssh -p %d'", port) or ""
            
            local cmd
            if protocol == "rsync" then
              cmd = string.format("rsync -avz --progress %s '%s' '%s:%s'", ssh_option, local_path, info.target, remote_path)
            elseif protocol == "scp" then
              cmd = string.format("scp -r %s '%s' '%s:%s'", ssh_option, local_path, info.target, remote_path)
            elseif protocol == "ssh" then
              cmd = string.format("ssh %s '%s' 'mkdir -p %s'", ssh_option, info.target, remote_path)
            end
  
            vim.notify("🚀 Отправка через " .. protocol .. ": " .. cmd, vim.log.levels.INFO)
  
            vim.fn.jobstart(cmd, {
              stdout_buffered = true,
              stderr_buffered = true,
              on_stdout = function(_, data)
                if data and #data > 0 then
                  vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = protocol })
                end
              end,
              on_stderr = function(_, data)
                if data and #data > 0 then
                  vim.notify(table.concat(data, "\n"), vim.log.levels.WARN, { title = protocol .. " error" })
                end
              end,
              on_exit = function(_, code)
                if code == 0 then
                  vim.notify("✅ Отправлено!", vim.log.levels.INFO)
                else
                  vim.notify("❌ Ошибка при отправке", vim.log.levels.ERROR)
                end
              end,
            })
          end)
        end)
      end)
    end)
  end, {})
  
  
  