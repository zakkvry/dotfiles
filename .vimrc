:set encoding=UTF-8
:set nowrap
:set linebreak
:set tabstop=2
:set shiftwidth=2
:set expandtab
:set autoindent
:set smartindent
:set autoread
:set directory^=$HOME/.vim/tmp//
:set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set updatetime=100

" https://vi.stackexchange.com/questions/56/how-can-i-prevent-vim-from-leaving-too-many-files-like-swap-backup-undo
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

imap <C-Return> <CR><CR><C-o>k<Tab>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

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
Plug 'junegunn/fzf'
Plug 'maximbaz/lightline-ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimMate

let delimitMate_expand_cr = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"
autocmd vimenter * NERDTree
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
\ 'json': ['prettier']
\}

let g:ale_fix_on_save = 1

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

:set number              " show line numbersa

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
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified' ] ],
\   'right': [ [ 'lineinfo' ],
\              [ 'filetype' ],
\              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
\              [ 'gitbranch',  'gitgutter' ] ] 
\ },
\ 'component_function': {
\   'gitbranch': 'GitBranchWithIcon',
\   'bufferinfo': 'lightline#buffer#bufferinfo',
\   'filename': 'FilenameForLightline',
\   'gitgutter': 'GitStatus'
\ },
\  'linter_checking': 'lightline#ale#checking',
\  'linter_infos': 'lightline#ale#infos',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\  'colorscheme': 'wombat',
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
\ },
\ 'component_type': {
\   'linter_checking': 'right',
\   'linter_infos': 'right',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'right'
\ },
\ 'component': {
\   'separator': '',
\ },
\ }

function! FilenameForLightline()
    return expand('%')
endfunction

function! GitBranchWithIcon()
  let branchName = fugitive#head()
  return ' ' . branchName
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
