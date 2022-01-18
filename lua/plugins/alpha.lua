local present, alpha = pcall(require, "alpha")
if not present then
  return
end

local M = {}

M.setup = function()
  local kind = require "user.lsp.lsp-kind"

  local header = {
    type = "text",
    val = require("plugins.banners").dashboard(),
    opts = { position = "center", hl = "Comment" },
  }

  local handle = io.popen 'fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | grep pack | wc -l | tr -d "\n" '
  local plugins = handle:read "*a"
  handle:close()

  local thingy = io.popen 'echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'
  local date = thingy:read "*a"
  thingy:close()
  plugins = plugins:gsub("^%s*(.-)%s*$", "%1")

  local plugin_count = {
    type = "text",
    val = "└─ " .. kind.cmp_kind.Module .. " " .. plugins .. " plugins in total ─┘",
    opts = { position = "center", hl = "String" },
  }

  local heading = {
    type = "text",
    val = "┌─ " .. kind.icons.calendar .. " Today is " .. date .. " ─┐",
    opts = { position = "center", hl = "String" },
  }

  local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 24,
      align_shortcut = "right",
      hl_shortcut = "Number",
      hl = "Function",
    }
    if keybind then
      opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
      type = "button",
      val = txt,
      on_press = function()
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
    }
  end

  local buttons = {
    type = "group",
    val = {
      button("f", " " .. kind.cmp_kind.Folder .. " Explore", ":Telescope find_files<CR>"),
      button("e", " " .. kind.cmp_kind.File .. " New file", ":ene <BAR> startinsert <CR>"),
      button("p", " " .. kind.cmp_kind.Module .. " Projects", ":Telescope projects<CR>"),
      button("r", " " .. kind.icons.clock .. " Recents", ":Telescope oldfiles<CR>"),
      button("c", " " .. kind.icons.settings .. " Config", ":e ~/.config/nvim/init.lua<CR>"),
      button("q", " " .. kind.icons.exit .. " Quit", ":qa<CR>"),
    },
    opts = { spacing = 1 },
  }

  local section = {
    header = header,
    buttons = buttons,
    plugin_count = plugin_count,
    heading = heading,
  }

  local opts = {
    layout = {
      { type = "padding", val = 1 },
      section.header,
      { type = "padding", val = 2 },
      section.heading,
      section.plugin_count,
      { type = "padding", val = 1 },
      -- section.top_bar,
      section.buttons, -- section.bot_bar,
      -- { type = "padding", val = 1 },
      section.footer,
    },
    opts = { margin = 5 },
  }

  -- Add color to header
  if vim.api.nvim_buf_get_name(0) == "" then
    vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

    vim.schedule(function()
      vim.fn.matchadd("Error", "[░▒]")
      vim.fn.matchadd("Function", "[▓█▄▀▐▌]")
    end)
  end

  alpha.setup(opts)
end

return M
