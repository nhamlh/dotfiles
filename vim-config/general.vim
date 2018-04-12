" vim:foldmethod=marker:foldlevel=0

" Thanks to dougblack https://dougblack.io/words/a-good-vimrc.html for some of
" below configurations

" General settings {{{
" --------------------
syntax on
filetype plugin indent on
set nocompatible
let mapleader=','            " remapping leader key to ,
let maplocalleader='-'       " remapping leader key to ,
set mouse=nv                 " Disable mouse in command-line mode
set modeline                 " automatically setting options from modelines
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set virtualedit=block        " Position cursor anywhere in visual block
set synmaxcol=1000           " Don't syntax highlight long lines
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap text
set lazyredraw               " Redraw only when we need to.
set incsearch                " Search as characters are entered
set updatetime=100
" }}}

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" History saving
set history=2000

" UI settings {{{
" --------------------
colorscheme solarized
set background=dark

" Highlight current line
set cursorline
highlight CursorLine cterm=underline ctermbg=None ctermfg=None

" Show hidden characters
set list
set listchars=tab:▸·,eol:¬,trail:·

" Disable list chars on golang files
autocmd FileType go set nolist

" Display line number
set relativenumber
set number

" Enable folding
set foldlevelstart=10        " open most folds by default
set foldnestmax=10           " 10 nested fold max
set foldmethod=indent        " fold based on indent level
" Toggle folding with the spacebar
nnoremap <space> za

" Set tab
set tabstop=2
set shiftwidth=2
set expandtab
" }}}

" Mappings {{{
" --------------------

" Get efficient: shortcut mappings
nnoremap ; :
inoremap jk <Esc>

" move vertically by visual line
" j/k won't skip over the "fake" part of the visual line in favor of the next "real" line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" }}}

" remove trailing whitespace when saving buffer
autocmd BufWritePre * %s/\s\+$//e
