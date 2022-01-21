" Plugin management
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'habamax/vim-sendtoterm'
Plug 'ledger/vim-ledger'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'neovim/nvim-lspconfig'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
call plug#end()


" Some basic configuration
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set smartcase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent
set smartindent
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set nobackup            " No backup files
set hidden
set shortmess=atI           " Stifle many interruptive prompts
set nowrap                  " Don't wrap long lines
set path+=**                " Set path so that finding files works recursively
set splitbelow              " Open new splits below the current window
set splitright              " Open new splits right to the current window
set lazyredraw              " Don't redraw while executing macros
set ffs=unix,dos,mac        " Use unix line endings
set exrc                    " Read a local init.vim when starting nvim
let mapleader = ","         " Change leader key

" Plugin specific configurations
let g:slime_target = "tmux"     " Use tmux as a target for vim-slime
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom}"}


" Color configuration
set background=dark
set termguicolors
colorscheme gruvbox


" LSP configuration

lua require'lspconfig'.pyright.setup{}

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF


" netrw settings
let g:netrw_banner=0 " Disable banner
let g:netrw_liststyle=3 " Tree style view
let g:netrw_preview=1 " Make vertical splitting the default for previewing files
let g:netrw_winsize=20


" Custom commands

function NewNote ()
    execute 'edit '.printf('%x', str2nr(strftime('%Y%m%d%H%M'))).".md"
    execute 'norm A#'
    put=strftime('%Y-%m-%d %H:%M')
endfunction
command NewNote call NewNote()

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif


" Complex mappings

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
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
  " Numbers of windows that view target buffer which we will delete.
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
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
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

nnoremap <leader>q :Bclose<CR>

" Simple Mappings


" Avoid escape
imap jk <Esc>

" clear highlighting on double <esc> press
nnoremap <esc><esc> :noh<return><esc>

" Treat longlines as different lines
nnoremap j gj
nnoremap k gk

" Use double space to save the file
nnoremap <space><space> :w<CR>

" Open a netrw Explore window on the left
nnoremap <leader>e :Lexplore<CR>

" Copy whole file
nnoremap <leader>c ggVG"+y

" Shortcut to open fzf
nnoremap <leader>o :FZF<CR>

" Shortcut to get the current filename into the unnamed register
" You can then paste it using p in normal mode
nmap <leader>f :let @+ = expand("%")<CR>

" Sort the file
nmap <leader>s :%sort<CR>

" Better keys for start and end of line
nnoremap H ^
nnoremap L $

" Backspace to switch to alternative buffer
nnoremap <bs> <C-^>`"zz

" Use Esc to get back to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

" Window navigation across all modes
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open a small horizontal terminal and enter Terminal mode
nnoremap <leader>t :15split term://bash<CR>i

" Use PageUp and PageDown to navigate buffers
nnoremap <PageUp> :bprevious<CR>
nnoremap <PageDown> :bnext<CR>

" Mappings to vimgrep word under cursor
nnoremap gr :vimgrep <cword> **<CR>
