set nocompatible " Use Vim defaults (better!) 
runtime! ftplugin/man.vim         " Allows for reading of man pages
" Vundle Packages -----------
set rtp+=~/.vim/bundle/Vundle.vim  " Modifies the run time path to include Vundle
"set rtp+=~/.fzf                   " Includes fuzzy find

" Load Vundle Packages
call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'scrooloose/nerdtree'                       " File exploration
    Plugin 'andymass/vim-matchup'                      " Matching between terms e.g. if else
    Plugin 'junegunn/fzf'                              " Enables fuzzy finding
    Plugin 'junegunn/fzf.vim'                          " Adds fuzzy finding bindings for vim
    " Plugin 'dense-analysis/ale'                        " Adds async syntax linting
    Plugin 'tpope/vim-fugitive'                        " Git Plugin
    Plugin 'Yggdroot/indentLine'                       " Shows indent lines
    " Plugin 'junegunn/goyo.vim'                         " Distraction-free writing
    Plugin 'iCyMind/NeoSolarized'                      " Solarized theme
    Plugin 'joshdick/onedark.vim'                      " onedark theme
    Plugin 'vim-airline/vim-airline'                   " Status/tabline
    Plugin 'neoclide/coc.nvim', {'branch': 'release'}  " Autocompletion
    " Plugin 'neoclide/coc-solargraph'
    Plugin 'luochen1990/rainbow'                       " Rainbow Parantheses
    Plugin 'tpope/vim-rails'                           " Rails Plugin
    Plugin 'tpope/vim-commentary'                      " Quick commenting
    Plugin 'tpope/vim-surround'                        " Surrounds with quotes, tags, brackets, etc
    Plugin 'ryanoasis/vim-devicons'                    " Icons for file manager
    Plugin 'vimwiki/vimwiki'                           " Vimwiki
    Plugin 'michal-h21/vim-zettel'                     " Some vimwiki helpers
call vundle#end()

" Basic Settings ------------

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
set relativenumber        " Makes numbers relative

set incsearch             " incsearch. Incremental searching. Highlights matches as you type
set nojoinspaces          " no join spaces. When joining two lines, it does not include a space
set showmatch             " show match. Briefly jump to matching bracket when inserting one
set ignorecase
set termguicolors
colorscheme onedark 
set background=dark
set clipboard+=unnamedplus

" Set completion menu background to gray
highlight Pmenu ctermbg=gray guibg=gray

" Matchup Background colors
hi MatchParen ctermbg=blue ctermfg=black guibg=red
" Matchup Settings
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200
let g:matchup_matchparen_deferred_hide_delay = 50

" Vimwiki settings
" let g:vimwiki_list = [{'path':'~/vimwiki/wiki', 'path_html':'~/vimwiki/export/html', 'auto_export': 1}]
let g:vimwiki_list = [{'path':'~/vimwiki/wiki', 'syntax': 'markdown', 'links_space_char': '_', 'ext': '.md'}]

set tags=tags;/~
set hidden " Allows for switching buffers without saving

" General Mappings ----------

let mapleader = ","
let maplocalleader = "\\"
set pastetoggle=<leader>p

"" Mode Mapping -------
inoremap jk <esc>
vnoremap jk <esc>
inoremap <esc> <nop>
" Fix paste bug triggered by the above inoremaps
set t_BE=
""" Strong Movement
noremap K <c-u>
noremap J <c-d>
""" Easy edit/source vimrc
" nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
""" Switch between screen splits
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
""" Enter Adds newline
nnoremap <cr> o<esc>
""" Toggle Highlighting
nnoremap <leader>h :set hlsearch!<cr>
""" Toggle Relative number
nnoremap <leader>rn :set rnu!<cr>
""" Fuzzy Files
nmap ; :Buffers<cr>
nmap <leader>f :Files<CR>
nmap <leader>t :Tags<CR>
" """ ALE
" nnoremap <leader>aa :ALEToggle<CR>
" nnoremap <leader>ad :ALEDetail<CR>
" nnoremap <leader>af :ALEFix<CR>
" nnoremap <leader>as :ALEFixSuggest<CR>
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'
" " let g:ale_sign_info
" let g:ale_sign_style_error = '⁉️'
" let g:ale_sign_style_warning = '💩'
""" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

"" Operator Mapping ----

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

"" }}}

" Autocmds ------------

"" Python file settings ---------
augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>x :exec '!python3' shellescape(@%, 1)<cr>
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    autocmd FileType python onoremap b /return<cr>
    autocmd FileType python :onoremap ifn :<c-u>execute "normal! ?def .*\r:nohlsearch\rwve"<cr>
    autocmd FileType python set backspace=2 " Allows backspacing on new line
augroup END
"" }}}

"" C file settings --------------
augroup filetype_c
    autocmd!
    autocmd BufNewFile,BufRead *.c :iabbrev <buffer> ffor for (int i = 0; i <; i++)<left><left><left><left><left><left><left>
augroup END

"" Javascript file settings ---------
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2
augroup END
"" }}}

"" Ruby file settings --------
augroup filetype_ruby
    autocmd!
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby set backspace=2 " Allows backspacing on new line
augroup END
"" }}}

"" HTML file settings -----------
autocmd BufNewFile,BufRead *.html.erb set filetype=html
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal ts=2
    autocmd FileType html setlocal sw=2
    autocmd FileType html setlocal ai
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

autocmd BufRead,BufNewFile *.scss setlocal filetype=css

"" CSS file settings -------------
augroup filetype_css
    autocmd!
    autocmd FileType css nnoremap <buffer> <localleader>c 0i/*<esc>A*/<esc>
    autocmd FileType css nnoremap <buffer> <localleader>xc ?\/\*<cr>xx/\*\/<cr>xx
augroup END

augroup filetype_racket
    autocmd!
    autocmd BufNewFile,BufRead *.rkt set filetype=scheme
    let g:rainbow_active = 1
augroup END

augroup VimwikiGroup
    autocmd!
    autocmd BufWritePre *.wiki ZettelBackLinks
augroup end

command! Diary VimwikiDiaryIndex " Alias to go to diary index
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
    " consolidate the writebackups -- not a big
    " deal either way, since they usually get deleted
    set backupdir^=~/.vim/backup//
end

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//
