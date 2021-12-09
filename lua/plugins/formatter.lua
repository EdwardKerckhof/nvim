-- Formatter (https://github.com/lukas-reineke/format.nvim)
local M = {}

M.setup = function ()
  local status_ok, format = pcall(require, "format")
  if not status_ok then
    return
  end

  format.setup {
    ["*"] = {
      { cmd = { "sed -i 's/[ \t]*$//'" } }
    },
    html = {
      { cmd = { "prettier -w" } }
    },
    css = {
      { cmd = { "prettier -w" } }
    },
    json = {
      { cmd = { "prettier -w" } }
    },
    yaml = {
      { cmd = { "prettier -w" } }
    },
    vue = {
      { cmd = { "prettier -w" } }
    },
    javascript = {
      { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } }
    },
    javascriptreact = {
      { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } }
    },
    typescript = {
      { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } }
    },
    typescriptreact = {
      { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } }
    },
    lua = {
      {
        cmd = {
          function(file)
            return string.format('lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb --indent-width=2 %s', file)
          end
        }
      }
    },
    python = {
      {
        cmd = {
          function(file)
            return string.format('black --quiet %s', file)
          end
        }
      }
    },
  }

  vim.cmd('autocmd BufWritePost * FormatWrite')
end

return M
