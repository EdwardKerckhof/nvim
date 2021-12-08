local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local sumneko_root_path = '/home/edward/.config/nvim/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

capabilities.textDocument.completion.completionItem.snippetSupport = true

local langServers = {
  'html',
  'cssls',
  'tsserver',
  'pylsp',
  'bashls',
  'emmet_ls',
  'sumneko_lua'
}

for _, server in ipairs(langServers) do
  if server == 'sumneko_lua' then
    lspconfig[server].setup {
      cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  elseif server == 'emmet_ls' then
    lspconfig[server].setup {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css', 'scss', 'blade', 'vue'};
      root_dir = function()
        return vim.loop.cwd()
      end;
      settings = {};
    }
  else
    lspconfig[server].setup {
      capabilities = capabilities
    }
  end
end
