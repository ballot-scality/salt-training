set nocompatible              " required
filetype off                  " required
syntax on

" Change leader
let mapleader="\<Space>"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead
" of Plugin)*

" Auto-Complete
Bundle 'Valloric/YouCompleteMe'

" Folding
Plugin 'tmhedberg/SimpylFold' "Folding

" Python autodindent
Plugin 'vim-scripts/indentpython.vim' " Indent python

" Syntax
Plugin 'scrooloose/syntastic' "Syntax checker

"
Plugin 'nvie/vim-flake8' " PEP8

" Colors
Plugin 'jnurmine/Zenburn' " Zenburn theme (console)
Plugin 'altercation/vim-colors-solarized' "Solarized theme (GUI)

Plugin 'scrooloose/nerdtree' "Hierarchy tree

Plugin 'kien/ctrlp.vim' " Search files

Plugin 'vim-airline/vim-airline' "Status bar
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-fugitive' " Show git branch in status bar

Plugin 'xolox/vim-misc' " Needed by vim-session
Plugin 'xolox/vim-session' " Make use of mksession easier

Plugin 'saltstack/salt-vim' " For saltstack files

Plugin 'fatih/vim-go' " Go Plugin

Plugin 'pearofducks/ansible-vim' " Ansible plugin

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set encoding=utf-8

" Set filetype based on name
autocmd BufRead,BufNewFile *Dockerfile* setlocal filetype=dockerfile
autocmd BufRead,BufNewFile *dockerfile* setlocal filetype=dockerfile
autocmd BufRead,BufNewFile *.spec.in setlocal filetype=spec
autocmd BufRead,BufNewFile *.functions setlocal filetype=sh

"" General section
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                    " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell           " don't beep
set noerrorbells         " don't beep

" FX button mapping
set pastetoggle=<F2> " Toggle PASTE mode

" Remove trailing whitespaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

set hidden " Allow leaving a buffer with unsaved changes

set mouse=a " Use mouse in all mode

set guioptions-=T  "remove toolbar

" Completion in menu bar
set wildmode=longest,list,full
set wildmenu

"" Remap
" <leader>sv sources .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>:runtime! plugin/settings/*<CR>:redraw<CR>:echo $MYVIMRC 'reloaded'<CR>

" Buffer navigation
nnoremap <silent> <leader><Left> <esc>:bp<CR>
nnoremap <silent> <leader><Right> <esc>:bn<CR>

" Split navigations
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Copy to system clipboard Visual selection
" vnoremap <silent> <C-c> y/<C-R>"*<CR><esc>

"" Folding
" Enable folding
set foldmethod=indent
set foldlevel=99

" See the docstring when folding
let g:SimpylFold_docstring_preview=1

" Autocompletion stuff
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Colors set
if has('gui_running')
  set background=dark
  colorscheme solarized
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
else
  "colors theme configuration (console)
  if &term == "linux" || &term == "screen.linux"
    set t_Co=8
    colorscheme zenburn
  else
    set t_Co=256
    colorscheme zenburn
  endif
endif

"" NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
map <C-n> :NERDTreeToggle<CR>
" Close vim if only NerdTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Always enable status bar
set laststatus=2

" Use powerline font symbols
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Session
let g:session_autosave = "prompt"
let g:session_autosaveperiodic = 60
let g:session_persist_colors = 0
let g:session_persist_font = 0
