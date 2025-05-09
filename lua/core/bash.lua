vim.keymap.set("n", "<leader>x", function()
    -- Выполнить Bash-команду
    local result = vim.fn.system("echo Hello from Bash && touch /tmp/bash_was_here")
  
    -- Затем выполнить Lua
    print("Lua: Bash завершился, результат:\n" .. result)
  end, { desc = "Run Bash then Lua" })

  
    vim.keymap.set("n", "<leader>r", function()
        os.execute("echo Bash first && sleep 1")
        print("Lua после Bash")
      end)

      
      vim.keymap.set("n", "<leader>r", function()
        os.execute("echo Bash first && sleep 1")
        print("Lua после Bash")
      end)
      