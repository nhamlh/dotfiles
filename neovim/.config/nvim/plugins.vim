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

Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
  set noshowmode
  let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste'  ],
        \             [ 'gitbranch', 'readonly', 'relativepath', 'modified', 'method' ] ]
        \
        \ },
        \ 'component_function': {
        \   'filename': 'LightLineFilename',
        \   'gitbranch': 'fugitive#head',
        \   'method': 'NearestMethodOrFunction'
        \
        \ },
        \
        \ }

Plug 'blueyed/vim-diminactive'
  let g:diminactive_enable_focus = 1
  let g:diminactive_use_syntax = 0

"Plug 'roman/golden-ratio'
"  let g:golden_ratio_exclude_nonmodifiable = 1

"-----------------------------------------------------------
" programming languages support
"-----------------------------------------------------------
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/rainbow-end'
Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1

Plug 'w0rp/ale'
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
  let g:ale_open_list = 0
  let g:ale_keep_list_window_open = 0
  let g:ale_python_flake8_options = '--ignore=E501'

  let g:ale_completion_enabled = 1
  let g:ale_fix_on_save = 1

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Plug 'sebosp/vim-snippets-terraform'

Plug 'jiangmiao/auto-pairs'
  let g:AutoPairsFlyMode = 0
  let g:AutoPairsShortcutToggle = ''

Plug 'tpope/vim-dispatch'

Plug 'janko-m/vim-test'
  let test#strategy = "vimux"
  nnoremap <c-t>f :TestFile<CR>
  nnoremap <c-t>l :TestLast<CR>
  nnoremap <c-t>n :TestNearest<CR>
  nnoremap <c-t>v :TestNearest<CR>

Plug 'scrooloose/nerdcommenter'
  "let g:NERDCreateDefaultMappings = 0
  let g:NERDToggleCheckAllLines = 1
  let g:NERDDefaultAlign = 'left'

Plug 'Yggdroot/indentLine'
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']

Plug 'craigemery/vim-autotag'

"Plug 'majutsushi/tagbar'
"  nmap <silent> <F8> :TagbarToggle<CR>
"  let g:tagbar_ctags_bin = '/usr/bin/ctags'
"  let g:tagbar_sort = 0
"  let g:tagbar_width = 30

Plug 'liuchengxu/vista.vim'
  nmap <silent> <F8> :Vista!!<CR>

Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"  let g:go_fmt_command = "goimports"
"  let g:go_auto_type_info = 1
"  let g:go_auto_sameids = 1
"  "let g:go_def_mode = 'godef'
"  "let g:go_def_mapping_enabled = 1

"  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"  nnoremap <leader>gb :GoBuild<CR>
"  nnoremap <leader>gr :GoRun<CR>

Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.cfg/vim-config/plugins/gocode/nvim/symlink.sh' }
Plug 'hashivim/vim-terraform'
  let g:terraform_fmt_on_save = 0
  let g:terraform_fold_sections=1
  let g:terraform_remap_spacebar=1

Plug 'andrewstuart/vim-kubernetes'
Plug 'sheerun/vim-polyglot'

Plug 'pedrohdz/vim-yaml-folds'

if has("autocmd")
  au BufReadPost *.rkt,*.rktl set filetype=scheme
endif

"-----------------------------------------------------------
" git
"-----------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
  let g:signify_sign_change = '~'

Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
"Plug 'chrisbra/vim-diff-enhanced'

function! s:open_review_file(line)
  let keys = split(a:line, '\t')
  bufdo bd
  execute 'e '.keys[2]
  execute 'vert Gdiff '.g:reviewbase
endfunction

command! GitChangesFZF call fzf#run({
\   'source':  'git status | sort -k3',
\   'sink':    function('<sid>open_review_file'),
\   'window': 'call FzfFloatingWindow()',
\   'options': '--extended --nth=3..',
\   'down':    '30%'
\})

Plug 'rhysd/git-messenger.vim'
  nnoremap gm :GitMessenger<CR>

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
  nnoremap <C-n> :NERDTreeToggle<CR>
  inoremap <C-n> <Esc>:NERDTreeToggle<CR>
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
  let NERDTreeQuitOnOpen = 0
  nnoremap <silent> <Leader>v :NERDTreeFind<CR>

  " NERDTress File highlighting
  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
   exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
   exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

Plug 'Xuyuanp/nerdtree-git-plugin'

"Plug 'Shougo/defx.nvim'
"Plug 'kristijanhusak/defx-git'
"Plug 'kristijanhusak/defx-icons'
"nnoremap <C-n> :Defx -split=vertical -winwidth=30 -direction=topleft -root-marker='' -columns='git:indent:icons:filename:type:size:time'<CR>
"autocmd FileType defx call s:defx_my_settings()
"  function! s:defx_my_settings() abort
"    nnoremap <silent><buffer><expr> v
"    \ defx#do_action('open', 'pedit')
"    nnoremap <silent><buffer><expr> <space>
"    \ defx#do_action('open_or_close_tree')
"    nnoremap <silent><buffer><expr> N
"    \ defx#do_action('new_directory')
"    nnoremap <silent><buffer><expr> n
"    \ defx#do_action('new_file')
"    nnoremap <silent><buffer><expr> c
"    \ defx#do_action('copy')
"    nnoremap <silent><buffer><expr> m
"    \ defx#do_action('move')
"    nnoremap <silent><buffer><expr> p
"    \ defx#do_action('paste')
"    nnoremap <silent><buffer><expr> d
"    \ defx#do_action('remove')
"    nnoremap <silent><buffer><expr> y
"    \ defx#do_action('yank_path')
"    nnoremap <silent><buffer><expr> .
"    \ defx#do_action('toggle_ignored_files')
"    nnoremap <silent><buffer><expr> q
"    \ defx#do_action('quit')
"  endfunction

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
  "command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  nnoremap \                     :Ag<CR>
  nnoremap <Leader><space>       :Files<CR>
  nnoremap <Leader>ss            :BLines<CR>
  nnoremap <Leader>sp            :Lines<CR>
  nnoremap <Leader>st            :BTags<CR>
  nnoremap <Leader>sT            :Tags<CR>
  nnoremap <Leader>bb            :Buffers<CR>

  nnoremap <M-x>                 :Commands<CR>
  nnoremap gw                    :Windows<CR>

  nnoremap K           :Ag <C-R><C-W><CR>
  "nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  "" bind \ (backward slash) to grep shortcut

"Open FZF in floating window
"let g:fzf_layout = { 'window': 'call FzfFloatingWindow()' }
function! FzfFloatingWindow()
  let height = float2nr((&lines - 2) * 0.6) " lightline + status
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

"Plug 'liuchengxu/vim-clap'

Plug 'easymotion/vim-easymotion'
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1

  " quick character navigating
  nmap gss <Plug>(easymotion-overwin-f2)

  " quick line navigating
  map gsj <Plug>(easymotion-j)
  map gsk <Plug>(easymotion-k)

"Plug 'mg979/vim-visual-multi'
"Plug 'terryma/vim-multiple-cursors'
"  let g:multi_cursor_use_default_mapping=0
"  let g:multi_cursor_next_key='<C-j>'
"  let g:multi_cursor_prev_key='<C-k>'
"  let g:multi_cursor_skip_key='<C-x>'
"  let g:multi_cursor_quit_key='<Esc>'

Plug 'AndrewRadev/splitjoin.vim'
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

Plug 'dhruvasagar/vim-zoom'
  nmap <c-o>z <Plug>(zoom-toggle)

Plug '~/.config/nvim/plugins/diffchanges'

Plug 'iamcco/markdown-preview.nvim'

Plug 'kshenoy/vim-signature'

Plug 'tpope/vim-obsession'

Plug 'mg979/do.vim'

Plug 'freitass/todo.txt-vim'
Plug 'junegunn/goyo.vim'

" Add plugins to &runtimepath
call plug#end()

