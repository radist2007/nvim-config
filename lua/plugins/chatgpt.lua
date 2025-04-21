-- lua/plugins/chatgpt.lua (Модифікована версія з vim.schedule)
local project_context = require("plugins.project_context")

-- Відкладаємо налаштування, щоб не читати файли під час старту
vim.schedule(function()
  print("CHATGPT DEBUG: Running deferred setup...") -- Залишимо print для контролю

  -- Отримуємо контекст *безпосередньо перед* викликом setup
  local system_context = ""
  local context_ok, context_result = pcall(project_context.get_project_summary)
  if context_ok then
    system_context = context_result or ""
    print("CHATGPT DEBUG: Deferred get_project_summary() OK.")
  else
    print("CHATGPT ERROR: Deferred get_project_summary() FAILED: " .. tostring(context_result))
    vim.notify("Deferred get_project_summary() failed for ChatGPT", vim.log.levels.WARN)
  end

  -- Викликаємо setup всередині відкладеної функції
  local setup_ok, setup_error = pcall(require("chatgpt").setup, {
    api_key_cmd = "cat /home/radist/.config/openai/openai_api_key",

    openai_params = { model = "gpt-4", temperature = 0.7, top_p = 1, n = 1, },
    openai_edit_params = { model = "gpt-4", temperature = 0.7, top_p = 1, n = 1, },
    system_prompt = "Ти асистент для кодування, що працює з проєктом. Пиши українською. Стиль кодування базується на нижченаведеному описі:\n\n" .. system_context
  })

  if not setup_ok then
     print("CHATGPT ERROR: Deferred require('chatgpt').setup() FAILED: " .. tostring(setup_error))
     vim.notify("Deferred require('chatgpt').setup() failed!", vim.log.levels.ERROR)
  else
     print("CHATGPT DEBUG: Deferred require('chatgpt').setup() OK.")
  end
end)

print("CHATGPT DEBUG: chatgpt.lua initial execution finished (setup scheduled).") -- Повідомлення, що файл завантажився
