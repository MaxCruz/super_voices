" File type plugins
filetype plugin on

" Enable indentation
filetype indent on

" Unix as standar file type
set ffs=unix,mac,dos

" Read when a file is changed from the outside
set autoread

" Save using sudo for handling permissions
command W w !sudo tee % > /dev/null

" Format JSON
 command! FormatJSON %!python -m json.tool

" Turn on wild menu (command line complenion)
set wildmenu

" Show current position
set ruler

" Size of the command bar
set cmdheight=2

" Margin to the left
set foldcolumn=1

" Normal backspace behavior
set backspace=eol,start,indent

" Smartcase when search
set smartcase

" Highlight search results
set hlsearch

" Incremental searching
set incsearch

" Simplify regulars expressions
set magic

" Show pair bracket when text indicator is over
set showmatch

" Enable syntax highlighting
syntax on

" Beautiful color scheme 
colorscheme desert

" Fix text color when search
autocmd ColorScheme * highlight Search ctermfg=Black

" Force dark background
set background=dark

" UTF-8 encoding
set encoding=utf8

" Don't create swap fies
set noswapfile

" Don't make backups
set nobackup

" Use spaces instead of tab
set expandtab

" Smart tabs
set smarttab

" When indent use 4 spaces
set shiftwidth=4

" Existing tab with 4 spaces
set tabstop=4

" Don't wrap long lines
set nowrap

" Paste toggle (fix indentation when paste)
set pastetoggle=<F12>

" Show status line
set laststatus=2

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Jump to the last position when reopening a file
if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

