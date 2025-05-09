-- ~/.config/nvim/lua/snacks-config.lua (или в init.lua напрямую)
require("snacks").setup({
    picker = {
      enabled = true,
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          layout = {
            preset = "default",
            preview = false,
          },
          actions = {
            copy_file_path = {
              action = function(_, item)
                if not item then return end
                local vals = {
                  ["BASENAME"] = vim.fn.fnamemodify(item.file, ":t:r"),
                  ["EXTENSION"] = vim.fn.fnamemodify(item.file, ":t:e"),
                  ["FILENAME"] = vim.fn.fnamemodify(item.file, ":t"),
                  ["PATH"] = item.file,
                  ["PATH (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
                  ["PATH (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
                  ["URI"] = vim.uri_from_fname(item.file),
                }
                local options = vim.tbl_filter(function(val)
                  return vals[val] ~= ""
                end, vim.tbl_keys(vals))
                if vim.tbl_isempty(options) then
                  vim.notify("No values to copy", vim.log.levels.WARN)
                  return
                end
                table.sort(options)
                vim.ui.select(options, {
                  prompt = "Choose to copy to clipboard:",
                  format_item = function(list_item)
                    return ("%s: %s"):format(list_item, vals[list_item])
                  end,
                }, function(choice)
                  local result = vals[choice]
                  if result then
                    vim.fn.setreg("+", result)
                    require("snacks").notify.info("Yanked `" .. result .. "`")
                  end
                end)
              end,
            },
            search_in_directory = {
              action = function(_, item)
                if not item then return end
                local dir = vim.fn.fnamemodify(item.file, ":p:h")
                require("snacks").picker.grep({
                  cwd = dir,
                  cmd = "rg",
                  args = {
                    "-g", "!.git", "-g", "!node_modules", "-g", "!dist",
                    "-g", "!build", "-g", "!coverage", "-g", "!.DS_Store",
                    "-g", "!.docusaurus", "-g", "!.dart_tool",
                  },
                  show_empty = true,
                  hidden = true,
                  ignored = true,
                  follow = false,
                  supports_live = true,
                })
              end,
            },
            diff = {
              action = function(picker)
                picker:close()
                local sel = picker:selected()
                if #sel > 1 then
                  vim.cmd("tabnew " .. sel[1].file)
                  vim.cmd("vert diffs " .. sel[2].file)
                  require("snacks").notify.info("Diffing " .. sel[1].file .. " against " .. sel[2].file)
                else
                  require("snacks").notify.info("Select two entries for the diff")
                end
              end,
            },
          },
          win = {
            list = {
              keys = {
                ["y"] = "copy_file_path",
                ["s"] = "search_in_directory",
                ["D"] = "diff",
              },
            },
          },
        },
      },
    },
  })
  
  -- Открыть файловый "explorer" snacks
  vim.api.nvim_create_user_command("SnacksExplorer", function()
    require("snacks").picker.explorer()
  end, {})
  
  -- Поиск по проекту (grep)
  vim.api.nvim_create_user_command("SnacksGrep", function()
    require("snacks").picker.grep()
  end, {})
  
  -- Поиск файлов (аналог telescope find_files)
  vim.api.nvim_create_user_command("SnacksFiles", function()
    require("snacks").picker.files()
  end, {})
  
  
  -- Snacks Explorer
  vim.keymap.set("n", "<leader>se", function()
    require("snacks").picker.explorer()
  end, { desc = "Snacks: Explorer" })
  
  -- Snacks Grep (поиск по тексту)
  vim.keymap.set("n", "<leader>sg", function()
    require("snacks").picker.grep()
  end, { desc = "Snacks: Grep" })
  
  -- Snacks Files (поиск по имени файла)
  vim.keymap.set("n", "<leader>sf", function()
    require("snacks").picker.files()
  end, { desc = "Snacks: Files" })
  