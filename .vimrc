set nocompatible " Use Vim defaults (better!)

runtime! ftplugin/man.vim         " Allows for reading of man pages
" Vundle Packages ----------- {{{
set rtp+=~/.vim/bundle/Vundle.vim " Modifies the run time path to include Vundle
"set rtp+=~/.fzf                   " Includes fuzzy find

" Load Vundle Packages
call vundle#begin()
"    Plugin 'wakatime/vim-wakatime'
    Plugin 'gmarik/Vundle.vim'
    Plugin 'scrooloose/nerdtree'                 " File exploration
    Plugin 'guns/vim-clojure-static'             " Clojure formatting
    Plugin 'junegunn/rainbow_parentheses.vim'    " Multicolored clojure parentheses
    Plugin 'andymass/vim-matchup'                " Matching between terms e.g. if else
    Plugin 'junegunn/fzf'                        " Enables fuzzy finding
    Plugin 'junegunn/fzf.vim'                    " Adds fuzzy finding bindings for vim
    Plugin 'w0rp/ale'                            " Adds async syntax linting
call vundle#end()
" }}}

" Basic Settings ------------ {{{

filetype plugin indent on " Enables file type detection, 
                          " plugins for specific files to be loaded,
                          " and enables indentation based on language

syntax on                 " Turns syntax highlighting on.
set number                " Show line numbers
set noruler               " No ruler
set nowrap                " No line wrapping

set autoindent            " Turn on autoindenting (e.g. after a while statement)
set tabstop=4             " Width (in spaces) that a <tab> is displayed
set shiftwidth=4          " Width (in spaces) used in each step of the autoindent (as well as << and >> )
set expandtab             " Uses spaces instead of tabs.

set incsearch             " incsearch. Incremental searching. Highlights matches as you type
set nojoinspaces          " no join spaces. When joining two lines, it does not inclue a space
set showmatch             " show match. Briefly jump to matching bracket when inserting one
set ignorecase

" Set completion menu background to gray
highlight Pmenu ctermbg=gray guibg=gray

" Matchup Background colors
hi MatchParen ctermbg=blue ctermfg=black guibg=red

"" Status line -------- {{{
set laststatus=2
set statusline=%f   " Path to file
set statusline+=%=  " Switch to right side
set statusline+=%l  " Current line
set statusline+=/   " Separator
set statusline+=%L  " Total lines
"" }}}


set tags=tags;/~
set hidden " Allows for switching buffers without saving

"" Buffers ----- {{{
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>
" }}}


" }}}

" General Mappings ---------- {{{

let mapleader = ","
let maplocalleader = "\\"
set pastetoggle=<F2>

"" Mode Mapping ------- {{{
inoremap jk <esc>
vnoremap jk <esc>
inoremap <esc> <nop>
" Fix paste bug triggered by the above inoremaps
set t_BE=
""" Strong Movement
noremap H 0
noremap L $
noremap K <c-u>
noremap J <c-d>
""" Grabs a word
noremap <space> viw
""" Shifts line up/down
noremap - ddp
noremap _ ddkP
""" Converts word to uppercase
nnoremap <c-u> viwUe
inoremap <c-u> <esc>viwUea
""" Easy edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
""" Surround word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
""" Surround selection with < >
vnoremap <leader>< <esc>`<i<<esc>`>a><esc>
""" Switch between screen splits
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
""" Enter Adds newline
nnoremap <cr> o<esc>
""" Toggle Highlighting
nnoremap <leader>h :set hlsearch!<cr>
""" Fuzzy Files
nmap ; :Buffers<cr>
nmap <leader>f :Files<CR>
nmap <leader>r :Tags<CR>
""" ALE
nnoremap <leader>, :ALEToggle<CR>

"" Terminal ----- {{{
""" Open console
nnoremap <leader>c :bel call term_start("/bin/zsh", {"term_rows": (&lines * 1/4)})<cr>
""" Collapses/Resizes terminals
nnoremap <leader>x :exe "resize" . (&lines)<cr>
nnoremap <leader>z :exe "resize" . (&lines * 3/4)<cr>
""" Opens Rails Console
nnoremap <leader>rc :bel call term_start("rails c", {"term_rows": (&lines * 1/4)})<cr>
nnoremap <leader>rt :bel call term_start("rails t", {"term_rows": (&lines * 1/4)})<cr>
nnoremap <leader>rr :bel call term_start("rails s", {"term_rows": (&lines * 1/4)})<cr>


"" }}}

" }}}

"" Operator Mapping ---- {{{

" Get next/last paranthesis
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F(va(<cr>
" Get next/last quotations
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap an" :<c-u>normal! f"va"<cr>
onoremap al" :<c-u>normal! F"va"<cr>

" Get next parenthesis
onoremap p i(

"" }}}

"" Abbreviations ----- {{{

iabbrev teh the
iabbrev widht width
iabbrev tehn then
iabbrev boyd body
iabbrev hmtl html

iabbrev @@ avram.twitch@gmail.com
iabbrev atcom avramtwitchell.com
iabbrev ssig <cr>Avram Twitchell<cr>avram.twitch@gmail.com
" }}}

" }}}

" Autocmds ------------ {{{

"" Vimscript file settings -------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevelstart=1
augroup END
"" }}}

"" Writing file Settings -------------- {{{
augroup writing
    autocmd!
    "autocmd FileType markdown,mkd,md,txt set spell spelllang=en_us
augroup END
"" }}}

"" Python file settings --------- {{{
augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>x :exec '!python3' shellescape(@%, 1)<cr>
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    autocmd FileType python onoremap b /return<cr>
    autocmd FileType python :iabbrev <buffer> iff if:<left> 
    autocmd FileType python :iabbrev <buffer> forr for:<left>
    autocmd FileType python :iabbrev <buffer> rr return
    autocmd Filetype python :onoremap ifn :<c-u>execute "normal! ?def .*\r:nohlsearch\rwve"<cr>
augroup END
"" }}}

"" C file settings -------------- {{{
augroup filetype_c
    autocmd!
    autocmd BufNewFile,BufRead *.c :iabbrev <buffer> ffor for (int i = 0; i <; i++)<left><left><left><left><left><left><left>
    autocmd BufNewFile,BufRead *.c nnoremap <buffer> <localleader>f ofor (int i = 0; i < ; i++)<cr>{<cr>}<esc>kk9wi
    autocmd BufNewFile,BufRead *.c nnoremap <buffer> <localleader>w owhile ()<cr>{<cr>}<esc>kkela
augroup END

"" }}}

"" Javascript file settings --------- {{{
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2
augroup END
"" }}}

"" Ruby file settings -------- {{{
augroup filetype_ruby
    autocmd!
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
augroup END
"" }}}

"" Lisp file settings -------- {{{
augroup filetype_lisp
    autocmd!
    autocmd FileType lisp,clojure,schem RainbowParentheses
augroup END
"" }}}

"" HTML file settings ----------- {{{
augroup filetype_html
    autocmd!
    autocmd BufNewFile,BufRead *.html.erb set filetype=html
    autocmd FileType html setlocal ts=2
    autocmd FileType html setlocal sw=2
    autocmd FileType html setlocal ai
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
"" }}}

autocmd BufRead,BufNewFile *.scss setlocal filetype=css

"" CSS file settings ------------- {{{
augroup filetype_css
    autocmd!
    autocmd FileType css nnoremap <buffer> <localleader>c 0i/*<esc>A*/<esc>
    autocmd FileType css nnoremap <buffer> <localleader>xc ?\/\*<cr>xx/\*\/<cr>xx
augroup END
"" }}}

" }}}
