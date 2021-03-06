local M = {}
local Styles = {}

local status_ok, staline = pcall(require, "staline")
if not status_ok then
  return
end

M.setup = function()
  Styles.simple_line = {
    sections = {
      left = {
        "  ",
        "mode",
        " ",
        "branch",
        function()
          if vim.o.columns > 100 then
            -- return '     '
            -- return '    '
            return "    "
          end
          return ""
        end,
      },
      mid = { "lsp", "%<" },
      right = {
        "%l/%L  :%c  ",
        "file_name",
        "  ",
        function()
          local current_line = vim.fn.line "."
          local total_lines = vim.fn.line "$"
          local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
          local line_ratio = current_line / total_lines
          local index = math.ceil(line_ratio * #chars)
          return chars[index]
        end,
        " ",
      },
    },
    mode_colors = { n = "#94c461" },

    defaults = {
      true_colors = true,
      line_column = " [%l/%L] :%c  ",
      branch_symbol = " ",
      bg = "#11121d",
    },
  }

  Styles.pebble_line = {
    sections = {
      left = {
        " ",
        "right_sep_double",
        "-mode",
        "left_sep_double",
        " ",
        "right_sep",
        "-file_name",
        "left_sep",
        " ",
        function()
          local head = vim.g.gitsigns_head or ""
          return (head ~= nil or head ~= "") and unpack { "   " .. head } or ""
        end,
      },
      mid = { "lsp" },
      right = {
        "right_sep",
        "-cool_symbol",
        "left_sep",
        "%< ",
        "right_sep",
        "- ",
        "-lsp_name",
        "- ",
        "left_sep",
        " ",
        "right_sep_double",
        "-line_column",
        "left_sep_double",
        " ",
      },
    },

    defaults = {
      cool_symbol = "  ",
      left_separator = "",
      right_separator = "",
      true_colors = true,
      line_column = "[%l:%c] 並%p%% ",
      mod_symbol = "nice",
    },
    mode_colors = {
      n = "#94c461",
      i = "#94c461",
      ic = "#94c461",
      v = "#94c461",
    },
  }

  staline.setup(Styles.simple_line)
end

return M
