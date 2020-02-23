if !exists('g:os')
    if has('win32') || has('win16')
        let g:os = 'Windows'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

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
hi MatchParen cterm=none ctermbg=white ctermfg=blue

" https://vi.stackexchange.com/questions/56/how-can-i-prevent-vim-from-leaving-too-many-files-like-swap-backup-undo
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

imap <C-Return> <CR><CR><C-o>k<Tab>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader><space> :noh<CR>

call plug#begin('~/.vim/plugged')
Plug 'ryanoasis/vim-devicons'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'low-ghost/nerdtree-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'tpope/vim-surround'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'Valloric/YouCompleteMe'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'ludovicchabant/vim-gutentags'
Plug 'maximbaz/lightline-ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/xolox/vim-notes.git'
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'yuttie/comfortable-motion.vim'
call plug#end()


let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimMate

let delimitMate_expand_cr = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"
" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

" NERDTrees File highlighting only the glyph/icon
" test highlight just the glyph (icons) in nerdtree:
autocmd filetype nerdtree highlight haskell_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight go_icon ctermbg=none ctermfg=Red guifg=#ffa500

autocmd filetype nerdtree syn match haskell_icon ## containedin=NERDTreeFile

" if you are using another syn highlight for a given line (e.g.
" NERDTreeHighlightFile) need to give that name in the 'containedin' for this
" other highlight to work with it
autocmd filetype nerdtree syn match html_icon ## containedin=NERDTreeFile,html
autocmd filetype nerdtree syn match go_icon ## containedin=NERDTreeFile

autocmd vimenter * NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Automatically close NERDTree if it's the only remaining window after closing
" tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

function MyNerdToggle()
    if &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeTabsToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <C-B> :NERDTreeTabsToggle<CR>

let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeTabsToggle = 1
let g:nerdtree_tabs_autofind = 1

let g:NERDTreeWinSize=40

" https://vi.stackexchange.com/questions/22398/disable-lightline-on-nerdtree
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

" nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale Linting

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

:set foldmethod=syntax "syntax highlighting items specify folds
" :set foldcolumn=1 "defines 1 col at window left, to indicate folding
:set foldlevelstart=99 "start file with all folds opened
let javaScript_fold=1 "activate folding by JS syntax


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline

:set noshowmode

let g:lightline = {
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'readonly', 'relpathname', 'modified' ] ],
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
\    'colorscheme': 'wombat',
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
\   }
\ }

function! RelPathname()
    return expand('%f')
endfunction

function! GitBranchWithIcon()
  let branchName = fugitive#head()
  return ' ' . branchName
endfunction

function! GutenTagsIsRunning() 
  return gutentags#statusline()
endfunction


function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

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

if g:os == 'Linux'
  let g:gutentags_ctags_executable = '/snap/bin/ctags'
endif

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags'
let g:gutentags_ctags_extra_args = ['-R', '--exclude=node_modules', '--exclude=package-lock.json']

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case'.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

let g:gutentags_ctags_executable = '/snap/bin/ctags'

let g:gutentags_ctags_tagfile = '.tags'
