local present, luasnip = pcall(require, "luasnip")
if not present then
  return
end

require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/user/snippets/file-types/" }
require("luasnip.loaders.from_vscode").load { paths = "~/.config/nvim/lua/user/snippets/file-types/json/" }
require("luasnip/loaders/from_vscode").lazy_load()

local ok, types = pcall(require, "luasnip.util.types")
if not ok then
  return
end

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
  },
}

vim.keymap.set({ "i", "s" }, "<a-p>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<a-k>", function()
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<a-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<a-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<a-h>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)
