" vim:foldmethod=marker:foldlevel=0

" Author: Nham Le <lehoainham@gmail.com>
" Date:   Oct 28 2017

" Requirements: need to install vim-plug first to load plugins
" Inspired by https://github.com/rafi/vim-config


"-----------------------------------------------------------
" General settings
"-----------------------------------------------------------
" {{{
" Thanks to dougblack https://dougblack.io/words/a-good-vimrc.html for some of
" below configurations

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
set history=2000             " History saving
set updatetime=100
"set termguicolors
" }}}

"-----------------------------------------------------------
" Install and configure plugins
"-----------------------------------------------------------
source ~/.config/nvim/plugins.vim

"-----------------------------------------------------------
" Appearance
"-----------------------------------------------------------
" {{{
"colorscheme solarized
colorscheme NeoSolarized
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

" Set tab
set tabstop=2
set shiftwidth=2
set expandtab
" }}}

"-----------------------------------------------------------
" Mapping
"-----------------------------------------------------------
" {{{

" Get efficient: shortcut mappings
nnoremap ; :
inoremap jk <Esc>

" move vertically by visual line
" j/k won't skip over the "fake" part of the visual line in favor of the next "real" line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" Quickly replace selected text
map ,g :s/<C-R><C-W>/
" Quickly replace the word at the cursor
map ,G :s/<C-R>"/

" Quickly working on buffers
nnoremap <leader>bd :bdelete<CR>
nnoremap <c-l> :bnext<CR>
nnoremap <c-h> :bprevious<CR>
" strange <c-h> behavior in nvim
if has('nvim')
  nnoremap <BS> :bprevious<CR>
else
  nnoremap <c-h> :bprevious<CR>
endif

" Quickly copy to/paste from system clipboard
vnoremap Y "+y
vnoremap P "+p

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Quickly jump to errors indicated in quickfix window
nnoremap ef :cnf<CR>
nnoremap en :cnext<CR>
nnoremap el :clast<CR>
nnoremap ep :cprevious<CR>

" Toggle folding with the spacebar
nnoremap <space> za

nnoremap <c-o>h :split<CR>
nnoremap <c-o>v :vsplit<CR>

" }}}

"-----------------------------------------------------------
" Misc
"-----------------------------------------------------------
" {{{

" python with virtualenv support {{{
py << PYCODE
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
PYCODE
" }}}

" automatically close quickfix if it's the only open buffer
" credit: https://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Ignore quickfix when listing or navigating between buffers
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

" Remove trailing whitespace when saving buffer
autocmd BufWritePre * %s/\s\+$//e

" Toggle quickfix window {{{
fun! s:QuickfixToggle()
  let nr = winnr("$")
  cwindow
  let nr2 = winnr("$")
  if nr == nr2
    cclose
  endif
endfunction

nnoremap <silent> <M-q> :call <SID>QuickfixToggle()<CR>
" }}}

" Quickfix always occupy full width at the bottom
au FileType qf wincmd J

" auto resize panes when vim windows is resized (like tmux zoom in)
autocmd VimResized * wincmd =

" }}}
