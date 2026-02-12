-- =============================================================================
-- Plugin Management (vim-plug)
-- =============================================================================
-- Keeping vim-plug via vim.cmd. 
-- Note: Consider migrating to 'lazy.nvim' or 'packer.nvim' for a pure Lua experience.
vim.cmd [[
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'habamax/vim-sendtoterm'
Plug 'ledger/vim-ledger'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'mileszs/ack.vim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sersorrel/vim-lilypond'
Plug 'github/copilot.vim'
call plug#end()
]]

-- =============================================================================
-- Basic Configuration
-- =============================================================================
vim.opt.showmatch = true          -- show matching
vim.opt.ignorecase = true         -- case insensitive
vim.opt.smartcase = true
vim.opt.mouse = 'v'               -- middle-click paste with mouse
vim.opt.hlsearch = true           -- highlight search
vim.opt.tabstop = 4               -- number of columns occupied by a tab
vim.opt.softtabstop = 4           -- see multiple spaces as tabstops
vim.opt.expandtab = true          -- converts tabs to white space
vim.opt.shiftwidth = 4            -- width for autoindents
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true             -- add line numbers
vim.opt.wildmode = {'longest', 'list'} -- get bash-like tab completions
vim.opt.cc = '80'                 -- set an 80 column border
vim.opt.mouse = 'a'               -- enable mouse click
vim.opt.clipboard = 'unnamedplus' -- using system clipboard
vim.cmd('filetype plugin on')
vim.opt.cursorline = true         -- highlight current cursorline
vim.opt.ttyfast = true            -- Speed up scrolling
vim.opt.backup = false            -- No backup files
vim.opt.hidden = true
vim.opt.shortmess:append('atI')   -- Stifle many interruptive prompts
vim.opt.wrap = false              -- Don't wrap long lines
vim.opt.path:append('**')         -- Set path so that finding files works recursively
vim.opt.splitbelow = true         -- Open new splits below
vim.opt.splitright = true         -- Open new splits right
vim.opt.lazyredraw = true         -- Don't redraw while executing macros
vim.opt.ffs = {'unix', 'dos', 'mac'} -- Use unix line endings
vim.opt.exrc = true               -- Read a local init.vim/lua when starting
vim.opt.wrapscan = false          -- Do not wrap around when searching

-- Set leader key to comma
vim.g.mapleader = ","

-- =============================================================================
-- Plugin Specific Configurations
-- =============================================================================
vim.g.slime_target = "tmux"
vim.g.slime_default_config = { socket_name = "default", target_pane = "{bottom}" }

-- =============================================================================
-- Color Configuration
-- =============================================================================
vim.opt.background = 'dark'

-- Check if running on mac to determine termguicolors setting
if vim.fn.has('mac') == 1 then
    vim.opt.termguicolors = false
else
    vim.opt.termguicolors = true
end

-- Fallback safely if gruvbox isn't installed yet
pcall(vim.cmd, 'colorscheme gruvbox')

-- =============================================================================
-- LSP Configuration
--- =============================================================================

-- 1. Define the function that runs when a server attaches to a buffer
-- (This contains all your keymaps)
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

-- 2. Configure the servers
-- We use 'vim.lsp.config' to assign settings (like on_attach) 
-- and 'vim.lsp.enable' to start the server.

-- Setup Pyright (Python)
vim.lsp.config('pyright', {
    on_attach = on_attach,
})
vim.lsp.enable('pyright')

-- If you want to add more servers later, just copy the block above:
-- vim.lsp.config('tsserver', { on_attach = on_attach })
-- vim.lsp.enable('tsserver')- =============================================================================

-- =============================================================================
-- Netrw Settings
-- =============================================================================
vim.g.netrw_banner = 0       -- Disable banner
vim.g.netrw_liststyle = 3    -- Tree style view
vim.g.netrw_preview = 1      -- Vertical split default for preview
vim.g.netrw_winsize = 20

-- =============================================================================
-- Custom Commands (Note generation)
-- =============================================================================

-- Converted NewNote function to Lua
vim.api.nvim_create_user_command('NewNote', function()
    local handle = io.popen('shuf -i 0-16777215 -n1')
    local random_nr = handle:read("*a"):gsub("%s+", "")
    handle:close()
    
    local hex_nr = string.format("%x", tonumber(random_nr))
    local filename = "n_" .. hex_nr .. ".md"
    
    vim.cmd('edit ' .. filename)
    vim.cmd('norm A#')
    -- Insert date on next line
    vim.fn.append(vim.fn.line('.'), os.date('%Y-%m-%d %H:%M'))
end, {})

-- Converted LinkedNote function to Lua
vim.api.nvim_create_user_command('LinkedNote', function()
    local current_filename = vim.fn.expand("%")
    
    local handle = io.popen('shuf -i 0-16777215 -n1')
    local random_nr = handle:read("*a"):gsub("%s+", "")
    handle:close()
    
    local hex_nr = string.format("%x", tonumber(random_nr))
    local new_filename = 'n_' .. hex_nr .. '.md'
    
    -- Append link to current file
    vim.fn.setline('.', vim.fn.getline('.') .. '(' .. new_filename .. ')')
    
    -- Edit new file
    vim.cmd('edit ' .. new_filename)
    vim.cmd('norm A#')
    vim.fn.append(vim.fn.line('.'), os.date('%Y-%m-%d %H:%M'))
    
    -- Append parent link at the end of the new file
    vim.fn.append(vim.fn.line('$'), '[Parent note](' .. current_filename .. ')')
end, {})

-- =============================================================================
-- Clipboard Configuration (WSL / win32yank)
-- =============================================================================
if vim.fn.executable('win32yank.exe') == 1 then
    vim.g.clipboard = {
        name = 'win32yank-wsl',
        copy = {
            ['+'] = 'win32yank.exe -i --crlf',
            ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 0,
    }
end

-- =============================================================================
-- Complex Mappings & Legacy Functions (Bclose)
-- =============================================================================

-- Wrapping Bclose in vim.cmd as it is complex legacy Vimscript
vim.cmd [[
" Delete buffer while keeping window layout
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
]]

-- =============================================================================
-- Key Mappings
-- =============================================================================

-- Helper for mappings
local map = vim.keymap.set
local opts = { silent = true }

-- Bclose mapping
map('n', '<leader>q', ':Bclose<CR>', opts)

-- Avoid escape
map('i', 'jk', '<Esc>')

-- Clear highlighting on double <esc> press
map('n', '<esc><esc>', ':noh<return><esc>', opts)

-- Treat longlines as different lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Use double space to save the file
map('n', '<space><space>', ':w<CR>')

-- Open a netrw Explore window on the left
map('n', '<leader>e', ':Lexplore<CR>')

-- Copy whole file
map('n', '<leader>c', 'ggVG"+y')

-- Shortcut to open fzf
map('n', '<C-f>', ':Files<CR>', opts)
map('n', '<C-b>', ':Buffers<CR>', opts)

-- Shortcut to get the current filename into the unnamed register
map('n', '<leader>f', ':let @+ = expand("%")<CR>')

-- Sort the file
map('n', '<leader>s', ':%sort<CR>')

-- Better keys for start and end of line
map('n', 'H', '^')
map('n', 'L', '$')

-- Backspace to switch to alternative buffer
map('n', '<bs>', '<C-^>`"zz')

-- Use Esc to get back to normal mode in terminal
map('t', '<Esc>', '<C-\\><C-n>')

-- Open a small horizontal terminal and enter Terminal mode
map('n', '<leader>t', ':15split term://zsh<CR>i')

-- Use PageUp and PageDown to navigate buffers
map('n', '<PageUp>', ':bprevious<CR>')
map('n', '<PageDown>', ':bnext<CR>')

-- Use the silversearcher instead of ack for ack.vim if available
if vim.fn.executable('ag') == 1 then
    vim.g.ackprg = 'ag --vimgrep'
    map('n', 'gr', ':Ack <cword><CR>') -- Fixed missing <CR> from original expectation
else
    map('n', 'gr', ':vimgrep <cword> **<CR>')
end

map('n', '<leader>a', ':Ack!')

-- =============================================================================
-- Autocommands & Misc
-- =============================================================================

-- Highlight ExtraWhitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'lightred', ctermbg = 'lightred' })

local highlight_ws_group = vim.api.nvim_create_augroup('HighlightWhitespace', { clear = true })
vim.api.nvim_create_autocmd('BufModifiedSet', {
    group = highlight_ws_group,
    pattern = '*',
    command = [[syn match ExtraWhitespace /\s\+$\| \+\ze\t/]],
})

-- Fix syntax highlighting
map('n', '<F12>', '<Esc>:syntax sync fromstart<CR>', { noremap = true })

-- Folding with Regex search
map('n', '<leader>zs', ':setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>')

-- Markdown fenced languages
vim.g.markdown_fenced_languages = {'html', 'python', 'ruby', 'vim', 'c'}

-- Open vim-fugitive buffer
map('n', '<leader>g', ':G<CR>')

-- Highlight .hcl files as .tf files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.hcl',
    command = 'set filetype=tf',
})
