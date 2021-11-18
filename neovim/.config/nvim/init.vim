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


" Color configuration
set background=dark
set termguicolors
colorscheme gruvbox


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

" Change leader key
let mapleader = ","

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
nmap <leader>f :let @" = expand("%")<CR>

" Sort the file
nmap <leader>s :%sort<CR>

" Bring search results to midscreennnoremap n nzz
nnoremap n nzz
nnoremap N Nzz

" Better keys for start and end of line
nnoremap H ^
nnoremap L $

" Backspace to switch to alternative buffer
nnoremap <bs> <C-^>`"zz
