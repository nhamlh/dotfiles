
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
" }}}

" History saving
set history=2000

" UI settings {{{
" --------------------
colorscheme solarized
set background=light

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
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar

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
nnoremap <space> za
" }}}
