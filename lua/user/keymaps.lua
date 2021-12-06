local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-q>", ":BufferClose!<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Remove highlight from search
keymap("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)

-- Control keys
keymap("n", "<C-s>", ":w<CR>", opts) -- Alternative way of saving a file
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts) -- Toggle file tree
keymap("n", "<C-q>", ":bd<CR>", opts) -- Close buffer
keymap("n", "<C-o>", ":RnvimrToggle<CR>", opts) -- Toggle ranger
keymap("n", "<C-p>", ":Telescope find_files prompt_prefix=🔍<CR>", opts) -- CTRL-P with telescope
keymap("n", "<C-f>", ":lua require('spectre').open_file_search()<CR>", opts) -- Spectre file search
keymap("n", "<C-g>", ":w<CR>", opts) -- Open git fugitive
keymap("n", "<C-a>", ":dial-increment<CR>", opts) -- Increment numbers
keymap("n", "<C-x>", ":dial-decrement<CR>", opts) -- Decrement numbers

-- F2 to rename
keymap("n", "<F2>", ":lua require('renamer').rename({empty = true})<CR>")

-- Insert --
-- Press jk or kj fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- F2 to rename
keymap("i", "<F2>", ":lua require('renamer').rename({empty = true})<CR>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Control keys
keymap("v", "<C-a>", ":dial-increment<CR>", opts) -- Increment numbers
keymap("v", "<C-x>", ":dial-decrement<CR>", opts) -- Decrement numbers

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Command --
-- Menu navigation
keymap("c", "<C-j>",  'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } )
keymap("c", "<C-k>",  'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } )
