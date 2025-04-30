-- lua/plugins/auto-session.lua
return {
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "warn",
      auto_session_suppress_dirs = { "~/", "/" },

      -- !!! ОНОВЛЕНИЙ pre_save_cmds з використанням Lua API !!!
      pre_save_cmds = {
        function()
          -- Безпечно намагаємося закрити neo-tree, якщо він завантажений і видимий
          -- Використовуємо pcall, щоб уникнути помилок, якщо neo-tree не активний
          local ok, nt_api = pcall(require, "neo-tree.api")
          if ok then
            -- Перевіряємо, чи є видимі вікна neo-tree
            local is_visible = false
            for _, tree in ipairs(nt_api.tree.get_all()) do
              if tree:is_visible() then
                is_visible = true
                break
              end
            end

            -- Якщо видимі, закриваємо їх
            if is_visible then
              print("AutoSession: Neo-tree is visible, attempting to close...")
              pcall(nt_api.tree.close_all) -- Закриваємо всі вікна neo-tree
            end
          end
        end,
      },
      -- !!! Кінець оновленого pre_save_cmds !!!
    },
    -- Не потрібно config = function(), бо ми лише змінюємо opts
  },
}
