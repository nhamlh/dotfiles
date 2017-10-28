
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

" easily surround text
Plug 'tpope/vim-surround'

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
"Plug 'w0rp/ale'

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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" deoplete specific language support
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" languages support
Plug 'fatih/vim-go', { 'tag': 'v1.11' }

Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

"Plug 'python-mode/python-mode'

Plug 'junegunn/vim-easy-align'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'flazz/vim-colorschemes'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'easymotion/vim-easymotion'

Plug 'terryma/vim-multiple-cursors'

"Plug 'junegunn/vim-github-dashboard'

" Add plugins to &runtimepath
call plug#end()

