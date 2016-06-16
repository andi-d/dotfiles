if has('win32') || has('win64')
    set runtimepath=%HOME%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

call plug#begin()
" Plugins
Plug 'scrooloose/nerdtree'
call plug#end()

" General settings
set nocompatible
set history=700

filetype plugin on
filetype indent on


" auto read when file is changed from outside
set autoread

nmap <leader>w :w!<CR> " fast saving

set so=7 "set 7 lines gap to the edge when moving verticaly

colorscheme badwolf
set background=dark

if has('gui_running')
  set guifont=Consolas:h11
endif

set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " insert spaces for tabs

set number " show linenumbers
set showcmd " show command in bottom bar
set showmode " show current mode
set hidden " background buffers without writing them to disk

set cursorline " highlight current line

filetype indent on " load filetype-specific indent files

set wildmenu " visual autocomplete for command menu

set lazyredraw " redraw only when necessary

set showmatch " highlight matching brackets, braces...

set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " caseinsensitive search
set smartcase " when searching try to be smart about cases
nnoremap <leader><space> :nohlsearch<CR> " turn of search highlighting

let mapleader=","
let g:mapleader=","

set backspace=indent,eol,start " enable backspace in insert mode

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Backups
if has("win32")
  set backupdir=~/.vim/tmp/backup/ " backups 
  set directory=~/.vim/tmp/swap/ " swap files 
else 
  set backupdir=~/.vim/tmp/backup/ " backups 
  set directory=~/.vim/tmp/swap/ " swap files 
endif

set backup " enable backup

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
