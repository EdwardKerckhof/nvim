-- Autocommands
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo,spectre_panel nnoremap <silent> <buffer> q :close<CR>
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

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

  augroup _bigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END

  augroup _autoFormat
    autocmd!
    autocmd BufWritePre *.lua,*.go,*.css,*.html,*.tsx,*.js,*.ts,*.vue,*.svelte,*.cjs,*.prisma lua vim.lsp.buf.formatting() 
    autocmd BufWritePre *.ts,*.css,*.html,*.tsx,*.js,*.vue :EslintFixAll
    autocmd BufWritePost * :w
  augroup END

  augroup _buildNote
    autocmd!
    autocmd BufWritePost *note-*.md silent !/home/edward/.local/bin/build-note %:p
  augroup END
]]
