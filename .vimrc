if !exists('g:os')
    if has('win32') || has('win16')
      let g:os = 'Windows'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set foldcolumn=1
set termguicolors
syntax enable
set hidden
set timeoutlen=1000
set ttimeoutlen=0
" set background=dark
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
nnoremap <Leader>b :call fzf#vim#buffers({'top': '25%'})<CR>
" close all buffers but the current once
nnoremap <Leader>B :w <bar> %bd <bar> e# <bar> Buffers<CR> 
nnoremap <Leader><space> :noh<CR>
nnoremap <Leader>S :mksession! ./.vim/session.vim<CR>
nnoremap * *N
noremap <A-Left>  :tabmove -1<CR>
noremap <A-Right> :tabmove +3<CR>
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

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
Plug 'ryanoasis/vim-devicons'
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
Plug 'peitalin/vim-jsx-typescript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'mhinz/vim-startify'
Plug 'metakirby5/codi.vim'
Plug 'easymotion/vim-easymotion'
Plug 'ap/vim-buftabline'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-two-firewatch'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
" Plug 'inkarkat/vim-mark'
call plug#end()

autocmd VimEnter * hi! Normal guibg=NONE
let g:buftabline_indicators = 1

""""""""""""" Color Schemes """"""""""""""""
let g:used_javascript_libs = 'react,underscore,chai'

colorscheme onedark
color onedark

" colorscheme two-firewatch
" color two-firewatch
" set background=dark

" augroup colorscheme_customize
"   autocmd!
"   autocmd ColorScheme two-firewatch highlight! link SignColumn LineNr
" augroup END

" Identify the syntax highlighting group used at the cursor
map <Leader>H :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimMate

" let delimitMate_expand_cr = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"
" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'white', 'none', '#3366FF')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow')
call NERDTreeHighlightFile('json', 'LightMagenta', 'none', 'yellow')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow')
call NERDTreeHighlightFile('js', 'LightRed', 'none', '#ffa500')
call NERDTreeHighlightFile('ts', 'Blue', 'none', '#013acc')
call NERDTreeHighlightFile('tsx', 'LightBlue', 'none', '#65DBFB')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan')
call NERDTreeHighlightFile('log', 'Red', 'none', 'Red')

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

nnoremap [a :ALEPrevious<CR>
nnoremap ]a :ALENext<CR>

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


function! ToggleWindowHorizontalVerticalSplit()
  if !exists('t:splitType')
    let t:splitType = 'vertical'
  endif

  if t:splitType == 'vertical' " is vertical switch to horizontal
    windo wincmd K
    let t:splitType = 'horizontal'

  else " is horizontal switch to vertical
    windo wincmd H
    let t:splitType = 'vertical'
  endif
endfunction

nnoremap <silent> <leader>wt :call ToggleWindowHorizontalVerticalSplit()<cr>

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


" Common colors
let s:blue   = [ '#61afef', 75 ]
let s:green  = [ '#98c379', 76 ]
let s:purple = [ '#c678dd', 176 ]
let s:red1   = [ '#e06c75', 168 ]
let s:red2   = [ '#be5046', 168 ]
let s:yellow = [ '#e5c07b', 180 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

if lightline#colorscheme#background() ==# 'light'
  " Light variant
  let s:fg    = [ '#494b53', 238 ]
  let s:bg    = [ '#fafafa', 255 ]
  let s:gray1 = [ '#494b53', 238 ]
  let s:gray2 = [ '#f0f0f0', 255 ]
  let s:gray3 = [ '#d0d0d0', 250 ]
  let s:green = [ '#98c379', 35 ]

  let s:p.inactive.left   = [ [ s:bg,  s:gray3 ], [ s:bg, s:gray3 ] ]
  let s:p.inactive.middle = [ [ s:gray3, s:gray2 ] ]
  let s:p.inactive.right  = [ [ s:bg, s:gray3 ] ]
else
  " Dark variant
  let s:fg    = [ '#abb2bf', 145 ]
  let s:bg    = [ '#282c34', 235 ]
  let s:gray1 = [ '#5c6370', 241 ]
  let s:gray2 = [ '#2c323d', 235 ]
  let s:gray3 = [ '#3e4452', 240 ]

  let s:p.inactive.left   = [ [ s:gray1,  s:bg ], [ s:gray1, s:bg ] ]
  let s:p.inactive.middle = [ [ s:gray1, s:gray2 ] ]
  let s:p.inactive.right  = [ [ s:gray1, s:bg ] ]
endif

" Common
let s:p.normal.left    = [ [ s:bg, s:green, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.normal.middle  = [ [ s:fg, s:gray2 ] ]
let s:p.normal.right   = [ [ s:bg, s:green, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.normal.error   = [ [ s:red2, s:bg ] ]
let s:p.normal.warning = [ [ s:yellow, s:bg ] ]
let s:p.insert.right   = [ [ s:bg, s:blue, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.insert.left    = [ [ s:bg, s:blue, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.replace.right  = [ [ s:bg, s:red1, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.replace.left   = [ [ s:bg, s:red1, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.visual.right   = [ [ s:bg, s:purple, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.visual.left    = [ [ s:bg, s:purple, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.tabline.left   = [ [ s:fg, s:gray3 ] ]
let s:p.tabline.tabsel = [ [ s:bg, s:purple, 'bold' ] ]
let s:p.tabline.middle = [ [ s:gray3, s:gray2 ] ]
let s:p.tabline.right  = copy(s:p.normal.right)

let g:lightline#colorscheme#one#palette = lightline#colorscheme#flatten(s:p)

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
\   'inactive': {
\     'left': [ ["relpathname"] ] 
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
\    'colorscheme': 'one',
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
\     'separator': ' ',
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
  let filename = expand('%') != '' ? expand('%') : '[No Name]'
  " let filename = len(filename) > 70 ? "..." . filename[-70:] : filename
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

" let g:gitgutter_override_sign_column_highlight = 0

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
nnoremap <Leader>p :call Fzf_dev()<CR>
nnoremap <Leader>g :G<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>F :RgStrict<CR>
nnoremap <Leader>s :FZFLines<CR>

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
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:gutentags_ctags_tagfile = '.tags'
let g:fzf_layout = { 'down': '~70%' }
" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

command! -bang -nargs=* Rg
 \ call fzf#vim#grep(
 \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
 \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* RgStrict
 \ call fzf#vim#grep(
 \   'rg --column --line-number --no-heading --color "always" --smart-case --ignore-case --follow  --glob "!{.git/*,**/__tests__/*,**/test/*,**/test/*,node_modules/*,*.lock,**/__*}" '.shellescape(<q-args>).'| tr -d "\021"', 1,
 \   fzf#vim#with_preview(), <bang>0)


" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '80%' })
endfunction

" Search in open buffers
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM

" ts autocomplete boxes cause immense lag
let g:ycm_filetype_specific_completion_to_disable = {
\ 'typescript': 1,
\ 'typescriptreact' 1
\}

