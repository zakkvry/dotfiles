if !exists('g:os')
    if has('win32') || has('win16')
        let g:os = 'Windows'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

set timeoutlen=1000
set ttimeoutlen=0
set background=dark
set t_Co=256
set encoding=UTF-8
set nowrap
set linebreak
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set autoread
set directory^=$HOME/.vim/tmp//
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set updatetime=100
set hlsearch
set shortmess-=S
hi MatchParen cterm=none ctermbg=white ctermfg=blue

" https://vi.stackexchange.com/questions/56/how-can-i-prevent-vim-from-leaving-too-many-files-like-swap-backup-undo
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

imap <C-Return> <CR><CR><C-o>k<Tab>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>b :Buffers<CR>
" close all buffers but the current once
nnoremap <Leader>B :w <bar> %bd <bar> e# <bar> Buffers<CR> 
nnoremap <Leader><space> :noh<CR>
nnoremap <Leader>s :mksession! ./.vim/session.vim<CR>
nnoremap * *N
noremap <A-Left>  :tabmove -1<CR>
noremap <A-Right> :tabmove +3<CR>

if g:os == "Darwin"

  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>

  " filename       (foo.txt)
  nnoremap <leader>ct :let @*=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
endif

call plug#begin('~/.vim/plugged')
Plug 'google/vim-searchindex'
" Plug 'ryanoasis/vim-devicons'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" Plug 'low-ghost/nerdtree-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
" Plug 'pangloss/vim-javascript'
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'tpope/vim-surround'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'Valloric/YouCompleteMe'
" Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'ludovicchabant/vim-gutentags'
Plug 'maximbaz/lightline-ale'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/xolox/vim-notes.git'
Plug 'https://github.com/xolox/vim-misc.git'
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-startify'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimMate

" let delimitMate_expand_cr = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"
" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'white', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'LightMagenta', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('js', 'LightRed', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('ts', 'Blue', 'none', '#013acc', '#151515')
call NERDTreeHighlightFile('tsx', 'LightBlue', 'none', '#65DBFB', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151518')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('log', 'Red', 'none', 'Red', '#151515')

" autocmd vimenter * NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Automatically close NERDTree if it's the only remaining window after closing
" tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

function MyNerdToggle()
    if &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <C-B> :call MyNerdToggle()<CR>

" let g:nerdtree_tabs_focus_on_files = 1
" let g:NERDTreeTabsToggle = 1
" let g:nerdtree_tabs_autofind = 1

let g:NERDTreeWinSize=75

" https://vi.stackexchange.com/questions/22398/disable-lightline-on-nerdtree
" augroup filetype_nerdtree
"     au!
"     au FileType nerdtree call s:disable_lightline_on_nerdtree()
"     au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
" augroup END

" fu s:disable_lightline_on_nerdtree() abort
"     let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
"     call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
" endfu

" nerdtree-git-plugin
" let g:NERDTreeIndicatorMapCustoD = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale Linting
"

highlight ALEError ctermbg=none cterm=underline
highlight ALEEWarning ctermbg=none cterm=underline

let g:ale_statusline_format = ['x %d', '! %d', 'ok']
" let g:ale_sign_error = 'x'
" let g:ale_sign_warning = '!'

set signcolumn=yes              " always show the signcolumn on LH side
let g:ale_set_highlights = 0    " don't highlight first char of errors

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint']
\}

let g:ale_fixers = {
\ 'css': ['prettier'],
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'json': ['prettier']
\}

let g:ale_fix_on_save = 1

" TODO find better mappings
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
"

nnoremap <Leader>p :ALEFix<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement

" Always move linewise in normal mode
nnoremap k gk
nnoremap j gj

" Preserve indentation when moving lines
" See http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<Return>==
nnoremap <C-k> :m .-2<Return>==
vnoremap <C-j> :m '>+1<Return>gv=gv
vnoremap <C-k> :m '<-2<Return>gv=gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbers

set number              " show line numbersa

highlight LineNr ctermfg=grey

" Toggle line numbers with <Leader>n
noremap <Leader>n :set number!<Return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax

let g:jsx_ext_required = 1          " allow JSX in .js files
let g:javascript_plugin_flow = 1    " allow Flow in .js files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split panes

:set splitbelow          " open split panes on bottom (instead of top)
:set splitright          " open split panes on right (instead of left)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JavaScript folding
" extreme performance degradation?
" :set foldmethod=syntax "syntax highlighting items specify folds
" " :set foldcolumn=1 "defines 1 col at window left, to indicate folding
" :set foldlevelstart=99 "start file with all folds opened
" let javaScript_fold=1 "activate folding by JS syntax


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline

:set noshowmode

" color theme  alternatives: wombat, seoul256, nord, tomorrow, seoul256
let g:lightline = {
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'readonly', 'relpathname' ] ],
\     'right': [ [ 'lineinfo' ],
\                [ 'filetype' ],
\                [ 'gutentags'],
\                [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
\                [ 'gitbranch',  'gitgutter' ] ] 
\   },
\   'component_function': {
\     'gutentags': 'GutenTagsIsRunning',
\     'relpathname': 'RelPathname',
\     'gitbranch': 'GitBranchWithIcon',
\     'bufferinfo': 'lightline#buffer#bufferinfo',
\     'gitgutter': 'GitStatus'
\   },
\    'linter_checking': 'lightline#ale#checking',
\    'linter_infos': 'lightline#ale#infos',
\    'linter_warnings': 'lightline#ale#warnings',
\    'linter_errors': 'lightline#ale#errors',
\    'linter_ok': 'lightline#ale#ok',
\    'colorscheme': 'Tomorrow_Night',
\    'component_expand': {
\      'linter_checking': 'lightline#ale#checking',
\      'linter_infos': 'lightline#ale#infos',
\      'linter_warnings': 'lightline#ale#warnings',
\      'linter_errors': 'lightline#ale#errors',
\      'linter_ok': 'lightline#ale#ok'
\     },
\   'component_type': {
\     'linter_checking': 'right',
\     'linter_infos': 'right',
\     'linter_warnings': 'warning',
\     'linter_errors': 'error',
\     'linter_ok': 'right'
\   },
\   'component': {
\     'separator': '',
\   },
\   'mode_map': {
\     'n' : 'N',
\     'i' : 'I',
\     'R' : 'R',
\     'v' : 'V',
\     'V' : 'VL',
\     "\<C-v>": 'VB',
\     'c' : 'C',
\     's' : 'S',
\     'S' : 'SL',
\     "\<C-s>": 'SB',
\     't': 'T',
\   },
\ }



function! RelPathname()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified  
endfunction

function! GitBranchWithIcon()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

" function! GutenTagsIsRunning() 
"   return gutentags#statusline()
" endfunction


function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

if !has('gui_running')
  set t_Co=256
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gitgutter

let g:gitgutter_override_sign_column_highlight = 0

highlight SignColumn ctermbg=0
" highlight SignColumn guibg=green:w!
"
highlight GitGutterAdd    guifg=#009900 ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy Finder
"

nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>g :G<CR>
nnoremap <Leader>f :Rg<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags'
let g:gutentags_ctags_extra_args = ['-R', '--exclude=node_modules', '--exclude=package-lock.json']

let g:gutentags_ctags_tagfile = '.tags'

" --column: Show column number
 " --line-number: Show line number
 " --no-heading: Do not show file headings in results
 " --fixed-strings: Search term as a literal string
 " --ignore-case: Case insensitive search
 " --no-ignore: Do not respect .gitignore, etc...
 " --hidden: Search hidden files and folders
 " --follow: Follow symlinks
 " --glob: Additional conditions for search (in this case ignore everything
 " in the .git/ folder)
 " --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow--glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
