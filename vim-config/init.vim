" vim:foldmethod=marker:foldlevel=0

call plug#begin('~/.cfg/vim-config/plugins')

" more text objects
Plug 'wellle/targets.vim'

" run shell command inside vim
Plug 'benmills/vimux'

" Plugin for editing salt file
Plug 'saltstack/salt-vim'

" seamlessly split navigation between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" personal wiki
Plug 'vimwiki/vimwiki'

" insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" Display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'

Plug 'majutsushi/tagbar'

" Perform all your vim insert mode completions with tab
Plug 'ervandew/supertab'

" syntax checking
Plug 'w0rp/ale', {'tag': 'v1.7.0'}

" enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

" gitk for vim
Plug 'gregsexton/gitv'

" git wrapper
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" quoting/paranthesizing made simble
Plug 'tpope/vim-surround'

" a code-completetion engine for vim
Plug 'Shougo/deoplete.nvim', { 'tag': '4.0-serial', 'do': ':UpdateRemotePlugins' }

" deoplete specific language support
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" languages support
Plug 'fatih/vim-go', { 'tag': 'v1.16' }

Plug 'nsf/gocode', { 'tag': 'v.20170907', 'rtp': 'nvim', 'do': '~/.cfg/vim-config/plugins/gocode/nvim/symlink.sh' }

"Plug 'python-mode/python-mode'

Plug 'junegunn/vim-easy-align'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'flazz/vim-colorschemes'

Plug 'vim-airline/vim-airline', { 'tag': 'v0.9' }
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'easymotion/vim-easymotion'

Plug 'terryma/vim-multiple-cursors'

"Plug 'junegunn/vim-github-dashboard'

" Easier to undo
Plug 'sjl/gundo.vim'

" Simplify the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim', { 'tag': 'v0.8.0' }

" snippets for kubernetes
Plug 'andrewstuart/vim-kubernetes'

" basic vim/terraform integration
Plug 'hashivim/vim-terraform', { 'commit': '7679927' }

" Dim inactive windows
Plug 'blueyed/vim-diminactive'

" Add plugins to &runtimepath
call plug#end()

