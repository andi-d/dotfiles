" Type :so % to refresh .vimrc after making changes
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction

if WINDOWS()
    set runtimepath=%HOME%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

" as early as possible, has sideeffects
set nocompatible

" Setting up vim-plug as the package manager
if empty(glob('~/.vim/autoload/plug.vim'))
  execute "silent !curl -fLo " . expand("~/.vim/autoload/plug.vim") . 
    \" --create-dirs --insecure https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' " file drawer
Plug 'scrooloose/syntastic' " eslint support
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim' "file finder
"Plug 'Raimondi/delimitMate' " automatically inserts closing pairs (quoutes, braces, etc...)
Plug 'jiangmiao/auto-pairs' " automatically inserts closing pairs (quoutes, braces, etc...)
"Plug 'alvan/vim-closetag' " closes html tags automatically
Plug 'tpope/vim-ragtag' " closes html tags automatically
"Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter' " left gutter shows modified/added/deleted indicators
Plug 'terryma/vim-expand-region' " push v multiple times to expand block selection
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth' " automatically adjusts shiftwidth and expandtab
Plug 'tpope/vim-surround'
Plug 'sickill/vim-pasta' "pasting with the right indentation
Plug 'sheerun/vim-polyglot' "collection of language packs
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'ap/vim-css-color'
Plug 'gregsexton/MatchTag' "highlights matching html tags
Plug 'mattn/emmet-vim'
"Plug 'ryanoasis/vim-devicons'
Plug 'sjl/badwolf' " colorscheme
call plug#end()

" General settings
set history=700

filetype plugin on
filetype indent on

let mapleader="\<Space>"
let g:mapleader="\<Space>"

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
    " https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/
    if (has('win32'))
        "set guifont=DroidSansMonoForPowerline_NF:h10:cANSI
        "set guifont=Ubuntu_Mono_derivative_Powerlin:h10:cANSI:qNONANTIALIASED
        "set guifont=Source\ Code\ Pro\ Medium:h10:cANSI
        "set guifont=Inconsolata-g_for_Powerline:h10:cANSI
        set guifont=DejaVuSansMonoForPowerline_NF:h10

        "https://github.com/gzentkovich/dotfiles-powerline-font
        "set guifont=Andale_Mono_for_Powerline:h10:cANSI
    else
        " higher dpi on mac
        "set guifont=Source\ Code\ Pro\ Medium:h12
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h12
    endif
    let g:airline_powerline_fonts=1
    set lines=999 columns=999
else
    let &t_Co=256
    "set term=xterm
    if has('win32')
      let &t_AB="\e[48;5;%dm"
      let &t_AF="\e[38;5;%dm"
    endif
endif

"set background=dark
colorscheme badwolf

set tabstop=4 " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4 " number of spaces in tab when editing
set expandtab " insert spaces for tabs
set relativenumber
set number " show linenumbers
set textwidth=1000
set visualbell " Use visual bell instead of beeping
set showcmd " show command in bottom bar
set showmode " show current mode
set hidden " background buffers without writing them to disk
set autoread " auto read when file is changed from outside
set scrolloff=5 "set 7 lines gap to the edge when moving verticaly
set gdefault " :s// substitutes in whole line
set synmaxcol=1000 " disable syntax highlighting on long lines
set autoindent
set updatetime=250
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
set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
set termencoding=utf-8
"set fileencoding=utf-8
set laststatus=2 " enable airline status bar
set list listchars=tab:»·,trail:·,nbsp:· " show trailing whitespace

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

""""""""""""""""""""""
" Plugin Configuration
""""""""""""""""""""""

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
  let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
  let s:ctrlp_fallback = 'ack %s --nocolor -f'
" On Windows use "dir" as fallback command.
elseif WINDOWS()
  let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
else
  let s:ctrlp_fallback = 'find %s -type f'
endif
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': s:ctrlp_fallback
\ }

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_debug=3


let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" HTML Editing
"set matchpairs+=<:>
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.blade.php,*.php"

let delimitMate_balance_matchpairs = 1
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

"let g:user_emmet_expandabbr_key = '<Tab>'
"let g:user_emmet_leader_key='<C-Z>'

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" fast saving
nmap <leader>w :w!<CR>
" turn of search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" tagbar
nnoremap <silent><Leader>t :TagbarToggle<CR>

" close buffer without closing split
nnoremap <silent> <leader>d :bp<bar>bd #<CR>

"cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack<Space>

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

nnoremap <silent> <C-t> :NERDTreeToggle<CR>
nnoremap <silent> <leader>n :NERDTreeFind<CR>

nnoremap <silent> <C-Tab> :bn<CR>
nnoremap <silent> <C-S-Tab> :bp<CR>

" Use tab to jump between blocks, because it's easier
"nnoremap <tab> %
"vnoremap <tab> %

" copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-z> 3<C-y>

" horizontal split size increase
nnoremap <C-w>+ 5<C-w>+
nnoremap <C-w>- 5<C-w>-


""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
"F2 before pasting to preserve indentation
set pastetoggle=<F2>
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

"""""""""""""""""""""""""""
" neocomplete configuration
"""""""""""""""""""""""""""

""Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"imap <expr> <CR> pumvisible() ? "\<C-r>=<SID>".my_cr_function()."\<CR>" : "<Plug>delimitMateCR"
"
"function! s:my_cr_function()
"  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? "\<C-y>" : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"" inoremap <expr><BS> neocomplete#smart_close_popup()."\<BS>"
"inoremap <expr><BS>  pumvisible() ? neocomplete#smart_close_popup()."\<BS>" : delimitMate#BS()
"" Close popup by <Space>.
""inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
"
"" AutoComplPop like behavior.
""let g:neocomplete#enable_auto_select = 1
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplete#enable_auto_select = 1
""let g:neocomplete#disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
"endif
""let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
""let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
""let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"" For perlomni.vim setting.
"" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 15
let g:neocomplete#force_overwrite_completefunc = 1


" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings {
	" These two lines conflict with the default digraph mapping of <C-K>
	if !exists('g:spf13_no_neosnippet_expand')
		imap <C-k> <Plug>(neosnippet_expand_or_jump)
		smap <C-k> <Plug>(neosnippet_expand_or_jump)
	endif
	if exists('g:spf13_noninvasive_completion')
		inoremap <CR> <CR>
		" <ESC> takes you out of insert mode
		inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
		" <CR> accepts first, then sends the <CR>
		inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
		" <Down> and <Up> cycle like <Tab> and <S-Tab>
		inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
		inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
		" Jump up and down the list
		inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
		inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
	else
		" <C-k> Complete Snippet
		" <C-k> Jump to next snippet point
		imap <silent><expr><C-k> neosnippet#expandable() ?
					\ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
					\ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
		smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

		inoremap <expr><C-g> neocomplete#undo_completion()
		inoremap <expr><C-l> neocomplete#complete_common_string()
		"inoremap <expr><CR> neocomplete#complete_common_string()

		" <CR>: close popup
		" <s-CR>: close popup and save indent.
		inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

		function! CleverCr()
			if pumvisible()
				if neosnippet#expandable()
					let exp = "\<Plug>(neosnippet_expand)"
					return exp . neocomplete#smart_close_popup()
				else
					return neocomplete#smart_close_popup()
				endif
			else
				return "\<CR>"
			endif
		endfunction

		" <CR> close popup and save indent or expand snippet
		imap <expr> <CR> CleverCr()
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><C-y> neocomplete#smart_close_popup()
	endif
	" <TAB>: completion.
	inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

	" Courtesy of Matteo Cavalleri

	function! CleverTab()
		if pumvisible()
			return "\<C-n>"
		endif
		let substr = strpart(getline('.'), 0, col('.') - 1)
		let substr = matchstr(substr, '[^ \t]*$')
		if strlen(substr) == 0
			" nothing to match on empty string
			return "\<Tab>"
		else
			" existing text matching
			if neosnippet#expandable_or_jumpable()
				return "\<Plug>(neosnippet_expand_or_jump)"
			else
				return neocomplete#start_manual_complete()
			endif
		endif
	endfunction

	imap <expr> <Tab> CleverTab()
" }

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
