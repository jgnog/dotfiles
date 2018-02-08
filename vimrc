" JGNog's vimrc
"
" Author: JGNog - Gonçalo Nogueira


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'benmills/vimux'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=1000	" keep 250 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Line numbers on all files
set number

" Better colors for a dark background
set background=dark

" Tabs are 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

" No backup files
set nobackup

" clear highlighting on double <esc> press
nnoremap <esc><esc> :noh<return><esc>

" Clipboard is the "* register
set clipboard=unnamedplus

" Look for tags file in current directory and in
" current buffer directory
set tags+=./tags,tags

" Allow switching buffers without saving a file
set hidden

" Treat longlines as different lines
nnoremap j gj
nnoremap k gk

" Use double space to save the file
nnoremap <space><space> :w<CR>

" Add /usr/share/vim to runtimepath because of lilypond files in there
set runtimepath+=/usr/share/vim/
set runtimepath+=/usr/share/lilypond/2.18.2/vim/

" Enable case-smart searching
set ignorecase
set smartcase

" Change leader key
let mapleader = ","

" File/command completion more useful
set wildmenu
set wildmode=list:longest

" Swap files all in one place
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Stifle many interruptive prompts
set shortmess=atI

" Search recursively for files
set path+=**

" Use the solarized colorscheme
colorscheme solarized

" Configurations for Vimux
" Work with a REPL on another tmux pane

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys("Enter")
endfunction


" Save current selection in the v buffer and send that buffer to tmux
vnoremap <LocalLeader>ss "vy :call VimuxSlime()<CR>
" Save current line in the v buffer and send that buffer to tmux
nnoremap <LocalLeader>ll "vyy :call VimuxSlime()<CR>

" Binding to reload vim configuration file
nnoremap <Leader>r :source $MYVIMRC<CR>

""""""""""""""""
" Git bindings "
""""""""""""""""

" See the git status
nnoremap <Leader>gs :!git status<CR>
" Commit everything that is staged
nnoremap <Leader>gc :!git commit -a<CR>
