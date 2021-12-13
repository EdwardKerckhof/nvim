-- Autocommands
vim.cmd [[
  " disable syntax highlighting in big files
  function! DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
    endif

    set foldmethod=manual
    syntax clear
    syntax off
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
    set lazyredraw
  endfunction

  augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END
]]

-- Autoformat Buffers on Save
vim.cmd [[autocmd BufWritePre *.ts,*.lua,*.css,*.html,*.tsx,*.js,*.jsx,*.json,*.rs,*.html,*.graphql,*.c,*.md :Format]]
vim.cmd [[autocmd BufWritePre *.ts,*.css,*.html,*.tsx,*.js :EslintFixAll]]
