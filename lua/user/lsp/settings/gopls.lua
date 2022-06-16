local status_ok, _ = pcall(require, "packer")
if not status_ok then
  return
end

return {
  settings = {
    gopls = {
      buildFlags = { "-tags=integration" },
      analyses = {
        unusedparams = true,
      },
      usePlaceholders = false,
      staticcheck = true,
      env = { GOFLAGS = "-tags=integration" },
      gofumpt = true,
      ["local"] = "<repo>",
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
    buildFlags = { "-tags=integration" },
  },
  init_options = {
    buildFlags = { "-tags=integration" },
  },
}
