" vim:foldmethod=marker:foldlevel=0

" --------------------
" Configuration and mappings for installed plugins
" --------------------

map <Leader>vp :VimuxPromptCommand<CR>

" vimwiki {{{
" --------------------
"let wiki_1 = {}
"let wiki_1.path = '~/vimwiki'

let g:vimwiki_list = [{
  \ 'path': '~/gdrive/vimwiki',
  \ 'template_path': '~/gdrive/vimwiki_html/assets',
  \ 'template_default': 'default',
  \ 'template_ext': '.tpl'}]

let g:vimwiki_use_calendar = 1
" }}}

let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = ''

" require brew install ctags
nmap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" ale {{{
" --------------------
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_fixers = {
\   'python': ['yapf'],
\}
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
" }}}

" deoplete {{{
" --------------------
let g:deoplete#enable_at_startup = 1
" Use smartcase
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#sources#go#gocode_binary = "$GOBIN/gocode"
" }}}

"let g:go_def_mode = 'godef'
"let g:go_def_mapping_enabled = 1
nnoremap <leader>gb :GoBuild<CR>
nnoremap <leader>gr :GoRun<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" NERDTree {{{
" --------------------
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

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
" }}}

" easymotion {{{
" --------------------
let g:EasyMotion_do_mapping = 0
" one keystroke
nmap s <Plug>(easymotion-overwin-f)
" two keystroke:
"nmap s <Plug>(easymotion-overwin-f2)

let g:EasyMotion_smartcase = 1

" quick line navigating
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" }}}

" multiline-cursor {{{
" --------------------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" }}}

" Navigation {{{
" --------------------
let g:tmux_navigator_no_mappings = 1
" split navigation (more info: https://github.com/christoomey/vim-tmux-navigator)
nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>

inoremap <silent> <m-h> <esc>:TmuxNavigateLeft<cr>
inoremap <silent> <m-j> <esc>:TmuxNavigateDown<cr>
inoremap <silent> <m-k> <esc>:TmuxNavigateUp<cr>
inoremap <silent> <m-l> <esc>:TmuxNavigateRight<cr>

nnoremap <c-l> :bnext<CR>
nnoremap <c-h> :bprevious<CR>
" strange <c-h> behavior in nvim
if has('nvim')
  nnoremap <BS> :bprevious<CR>
else
  nnoremap <c-h> :bprevious<CR>
endif
" }}}

" fuzzy search
nnoremap <c-p> :FZF<CR>

" The Silver Searcher {{{
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" }}}

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" vim-go {{{
" --------------------

" variables
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" bindings
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" }}}

let g:terraform_fmt_on_save = 1
