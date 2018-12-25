" vim:foldmethod=marker:foldlevel=0

call plug#begin('~/.config/nvim/plugins')

"-----------------------------------------------------------
" UI
"-----------------------------------------------------------
Plug 'flazz/vim-colorschemes'
Plug 'iCyMind/NeoSolarized'

Plug 'ryanoasis/vim-devicons'
  let g:webdevicons_enable = 1
  let g:webdevicons_enable_airline_statusline = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline', { 'tag': 'v0.9' }
Plug 'vim-airline/vim-airline-themes'

Plug 'blueyed/vim-diminactive'
  let g:diminactive_enable_focus = 1
  let g:diminactive_use_syntax = 0

"-----------------------------------------------------------
" programming languages support
"-----------------------------------------------------------
Plug 'tpope/vim-endwise'

Plug 'w0rp/ale', {'tag': 'v2.2.0'}
  let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
  let g:ale_fixers = {
  \   'python': ['yapf'],
  \   'ruby': ['rubocop'],
  \}
  let g:airline#extensions#ale#enabled = 1
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 1
  let g:ale_set_quickfix = 1
  let g:ale_set_loclist = 0
  let g:ale_open_list = 1
  let g:ale_keep_list_window_open = 0
  let g:ale_python_flake8_options = '--ignore=E501'

  let g:ale_completion_enabled = 1
  let g:ale_fix_on_save = 1

Plug 'Shougo/deoplete.nvim', { 'tag': '4.0', 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  " Use smartcase
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_completion_start_length = 1
  let g:deoplete#sources#go#gocode_binary = "$GOBIN/gocode"

Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"

  let g:airline_theme='powerlineish'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1

Plug 'jiangmiao/auto-pairs'
  let g:AutoPairsFlyMode = 1
  let g:AutoPairsShortcutToggle = ''

Plug 'tpope/vim-dispatch'

Plug 'janko-m/vim-test'
  let test#strategy = "dispatch"

Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'

Plug 'majutsushi/tagbar'
  nmap <silent> <F8> :TagbarToggle<CR>
  let g:tagbar_ctags_bin = '/usr/bin/ctags'

Plug 'junegunn/vim-easy-align'

Plug 'fatih/vim-go', { 'tag': 'v1.16' }
  let g:go_fmt_command = "goimports"
  let g:terraform_fmt_on_save = 1
  let g:go_auto_type_info = 1
  let g:go_auto_sameids = 1
  "let g:go_def_mode = 'godef'
  "let g:go_def_mapping_enabled = 1

  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  nnoremap <leader>gb :GoBuild<CR>
  nnoremap <leader>gr :GoRun<CR>

Plug 'nsf/gocode', { 'tag': 'v.20170907', 'rtp': 'nvim', 'do': '~/.cfg/vim-config/plugins/gocode/nvim/symlink.sh' }
Plug 'hashivim/vim-terraform', { 'commit': '7679927' }
Plug 'andrewstuart/vim-kubernetes'
Plug 'sheerun/vim-polyglot'

"-----------------------------------------------------------
" git
"-----------------------------------------------------------
Plug 'gregsexton/gitv'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
Plug 'junegunn/gv.vim'
"Plug 'chrisbra/vim-diff-enhanced'

"-----------------------------------------------------------
" misc
"-----------------------------------------------------------
Plug 'benmills/vimux'
  map <Leader>rp :VimuxPromptCommand<CR>
  map <Leader>rm :VimuxPromptCommand("make ")<CR>
  map <Leader>rl :VimuxRunLastCommand<CR>
  map <Leader>ri :VimuxInspectRunner<CR>
  map <Leader>rq :VimuxCloseRunner<CR>

Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'

" split navigation (more info: https://github.com/christoomey/vim-tmux-navigator)
Plug 'christoomey/vim-tmux-navigator'
  let g:tmux_navigator_no_mappings = 1

  nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <m-l> :TmuxNavigateRight<cr>

  inoremap <silent> <m-h> <esc>:TmuxNavigateLeft<cr>
  inoremap <silent> <m-j> <esc>:TmuxNavigateDown<cr>
  inoremap <silent> <m-k> <esc>:TmuxNavigateUp<cr>
  inoremap <silent> <m-l> <esc>:TmuxNavigateRight<cr>

Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  map <C-n> :NERDTreeToggle<CR>
  " close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  let g:NERDTreeChDirMode=2
  let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
  let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
  let g:NERDTreeShowBookmarks=1
  let g:nerdtree_tabs_focus_on_files=1
  let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
  let g:NERDTreeWinSize = 25
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

  let NERDTreeMapOpenSplit = 'h'
  let NERDTreeMapOpenVSplit = 'v'
  let NERDTreeMinimalUI = 1
  let NERDTreeQuitOnOpen = 1
  nnoremap <silent> <Leader>v :NERDTreeFind<CR>

  " NERDTress File highlighting
  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
   exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
   exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules -f .git/tags'
  "command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  nnoremap \ :Ag<CR>
  nnoremap <c-p> :Files<CR>
  nnoremap <Leader>l :BLines<CR>
  nnoremap <Leader>L :Lines<CR>
  nnoremap <Leader>t :BTags<CR>
  nnoremap <Leader>T :Tags<CR>
  nnoremap <Leader>b :Buffers<CR>

  nnoremap K :Ag "\b<C-R><C-W>\b"<CR>
  "nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  "" bind \ (backward slash) to grep shortcut

Plug 'easymotion/vim-easymotion'
  let g:EasyMotion_do_mapping = 0
  " one keystroke
  nmap s <Plug>(easymotion-overwin-f)
  " two keystroke:
  "nmap s <Plug>(easymotion-overwin-f2)

  let g:EasyMotion_smartcase = 1

  " quick line navigating
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)

Plug 'terryma/vim-multiple-cursors'
  let g:multi_cursor_use_default_mapping=0
  let g:multi_cursor_next_key='<C-j>'
  let g:multi_cursor_prev_key='<C-k>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

Plug 'AndrewRadev/splitjoin.vim', { 'tag': 'v0.8.0' }
Plug 'KabbAmine/zeavim.vim'
Plug 'brooth/far.vim'
"Plug 'roxma/vim-tmux-clipboard'
Plug 'mbbill/undotree'
Plug 'sjl/gundo.vim'
  nnoremap <F5> :GundoToggle<CR>

  let g:gundo_help = 0
  let g:gundo_right = 1
  let g:gundo_preview_bottom = 1
  let g:gundo_close_on_revert = 1

Plug 'tmux-plugins/vim-tmux-focus-events'

" Add plugins to &runtimepath
call plug#end()

