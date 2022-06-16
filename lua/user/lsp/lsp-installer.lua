local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local status_okk, nvim_lsp = pcall(require, "lspconfig")
if not status_okk then
  return
end

local M = {}

M.setup = function()
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end,
      flags = {
        debounce_did_change_notify = 250,
      },
    }

    -- if server.name == "vuels" then
    --   return
    -- end

    -- if server.name == "html" then
    --   return
    -- end

    if server.name == "jsonls" then
      local jsonls_opts = require "user.lsp.settings.jsonls"
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server.name == "gopls" then
      local gopls_opts = require "user.lsp.settings.gopls"
      opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server.name == "sumneko_lua" then
      local sumneko_opts = require "user.lsp.settings.sumneko_lua"
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    server:setup(opts)
  end)
end

return M
