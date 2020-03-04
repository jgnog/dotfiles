" JGNog's vimrc
"
" Author: JGNog - Gonçalo Nogueira

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'micha/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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
colorscheme solarized

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

" Avoid escape
imap jk <Esc>

" Don't wrap long lines
set nowrap
