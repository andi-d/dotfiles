" Type :so % to refresh .vimrc after making changes
if has('win32') || has('win64')
    set runtimepath=%HOME%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

" as early as possible, has sideeffects
set nocompatible

" Plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-bufferline'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'
Plug 'xsbeats/vim-blade'
Plug 'jeetsukumaran/vim-buffergator'
call plug#end()

" General settings
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
    " set guifont=Inconsolata:h10
    colorscheme badwolf
    set background=dark
    set lines=999 columns=999
else
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    colorscheme badwolf
    set background=dark
endif

set guifont=Source\ Code\ Pro\ Medium:h11

set tabstop=4 " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4 " number of spaces in tab when editing
set expandtab " insert spaces for tabs
set relativenumber
set number " show linenumbers
set textwidth=100
set visualbell " Use visual bell instead of beeping
set showcmd " show command in bottom bar
set showmode " show current mode
set hidden " background buffers without writing them to disk
set autoread " auto read when file is changed from outside
set scrolloff=7 "set 7 lines gap to the edge when moving verticaly
set gdefault " :s// substitutes in whole line
set autoindent
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

"Allow usage of mouse in iTerm
set ttyfast
set mouse=a

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
set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set laststatus=2 " enable airline status bar


" HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" show trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Backups and Swapfiles
" set swapfile " enbale swapfile
set noswapfile " disable swapfiles
" set directory=~/.vim/tmp/swap/ " swap files 

" set backup " enable backup
set nobackup " disable backup
" set backupdir=~/.vim/tmp/backup/ " backup files

"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

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

" easier pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" split window vertically / horizontally
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s
" close pane
nnoremap <leader>q <C-w>q

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-z> 3<C-y>


""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

