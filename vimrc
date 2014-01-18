" JGNog's vimrc
"
" Author: JGNog - Gonçalo Nogueira


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Configuração de pathogen
" (instalação de plugins)
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=250		" keep 250 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

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

" Easier window switching
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" clear highlighting on double <esc> press
nnoremap <esc><esc> :noh<return><esc>

" Clipboard is the "* register
set clipboard=unnamed

" Look for tags file in current directory and in
" current buffer directory
set tags=./tags,tags

" Make delimitMate expand <CR> as example below
"
"
"                      <CR><CR><Up>  |  You get
"                    ============================
"                           (|)      |    (
"                                    |    |
"                                    |    )
let g:delimitMate_expand_cr=1

" Set personal details for snipMate
let g:snips_author="Gonçalo Nogueira"
let g:snips_email="jgoncalonogueira@gmail.com"
let g:snips_github="github.com/jgnog"

" Allow switching buffers without saving a file
set hidden

" Treat longlines as different lines
nnoremap j gj
nnoremap k gk

" Use space to toggle folding
nnoremap <space> za
" Use double space to save the file
nnoremap <space><space> :w<CR>

