if has('win32') || has('win64')
    set runtimepath=%HOME%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

" Plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" General settings
set nocompatible
set history=700

filetype plugin on
filetype indent on

let mapleader=","
let g:mapleader=","

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions+=e
  set t_Co=256
  set guitablabel=%M\ %t
  set guifont=Inconsolata:h10
  colorscheme badwolf
  set background=dark
  set lines=80 columns=160
else
  set term=xterm
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  colorscheme badwolf
  set background=dark
endif

set tabstop=4 " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4 " number of spaces in tab when editing
set expandtab " insert spaces for tabs
set number " show linenumbers
set relativenumber
set visualbell " Use visual bell instead of beeping
set showcmd " show command in bottom bar
set showmode " show current mode
set hidden " background buffers without writing them to disk
set autoread " auto read when file is changed from outside
set scrolloff=7 "set 7 lines gap to the edge when moving verticaly
set gdefault " :s// substitutes in whole line
set autoindent

"set cursorline " highlight current line

filetype indent on " load filetype-specific indent files

set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when necessary
set showmatch " highlight matching brackets, braces...
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " caseinsensitive search
set smartcase " when searching try to be smart about cases
set backspace=indent,eol,start " enable backspace in insert mode
set encoding=utf8
set laststatus=2 " enable airline status bar

" Backups and Swapfiles
" set swapfile " enbale swapfile
set noswapfile " disable swapfiles
" set directory=~/.vim/tmp/swap/ " swap files 

" set backup " enable backup
set nobackup " disable backup
" set backupdir=~/.vim/tmp/backup/ " backup files
"
" Set utf8 as standard encoding and en_US as the standard language

" Keybindings
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nmap <leader>w :w!<CR> " fast saving
nnoremap <leader><space> :nohlsearch<CR> " turn of search highlighting

" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap / /\v
vnoremap / /\v

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

