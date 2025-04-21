-- plugins/project_context.lua
local M = {}

-- Отримати контекст проєкту з файлів (README, package.json тощо)
function M.get_project_summary()
  local result = {}
  local files = {
    "README.md",
    "readme.md",
    "composer.json",
    "package.json",
    "pyproject.toml",
    "routes/web.php"
  }

  for _, file in ipairs(files) do
    local path = vim.fn.getcwd() .. "/" .. file
    if vim.fn.filereadable(path) == 1 then
      local lines = vim.fn.readfile(path)
      table.insert(result, "===== " .. file .. " =====")
      vim.list_extend(result, lines)
    end
  end

  return table.concat(result, "\n")
end

-- Зчитати залежні файли за import/use/include і додати їх у prompt
function M.get_related_code()
  local current_buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  local deps = {}

  for _, line in ipairs(lines) do
    local path = line:match("require%s*['\"](.-)['\"]") or
                 line:match("include%s*['\"](.-)['\"]") or
                 line:match("use%s+([%w%p]+)")

    if path then
      path = path:gsub("%.", "/")
      path = path:gsub("\\", "/")
      path = path:gsub("^/", "")
      local full_path = vim.fn.getcwd() .. "/" .. path .. ".php"
      if vim.fn.filereadable(full_path) == 1 then
        local dep_lines = vim.fn.readfile(full_path)
        table.insert(deps, "===== " .. full_path .. " =====")
        vim.list_extend(deps, dep_lines)
      end
    end
  end

  return table.concat(deps, "\n")
end

-- Основна команда: зібрати контекст і dependencies та показати в popup
function M.prepare_prompt()
  local context = M.get_project_summary()
  local deps = M.get_related_code()
  local full = context .. "\n\n" .. deps
  vim.fn.setreg("+", full)
  vim.notify("Контекст скопійовано в буфер. Встав у ChatGPT prompt: Ctrl+V", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ChatGPTProjectContext", function()
  local summary = M.get_project_summary()
  vim.fn.setreg("+", summary)
  vim.notify("Контекст проєкту скопійовано в буфер обміну", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("ChatGPTIncludeDependencies", function()
  local deps = M.get_related_code()
  vim.fn.setreg("+", deps)
  vim.notify("Код залежностей скопійовано в буфер обміну", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("ChatGPTPrepareProject", function()
  M.prepare_prompt()
end, {})

return M

