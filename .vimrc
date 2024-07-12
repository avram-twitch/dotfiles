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
    Plugin 'tpope/vim-fugitive'                        " Git Plugin
    Plugin 'Yggdroot/indentLine'                       " Shows indent lines
    " Plugin 'iCyMind/NeoSolarized'                      " Solarized theme
    Plugin 'joshdick/onedark.vim'                      " onedark theme
    Plugin 'vim-airline/vim-airline'                   " Status/tabline
    Plugin 'neoclide/coc.nvim', {'branch': 'release'}  " Autocompletion
    Plugin 'tpope/vim-rails'                           " Rails Plugin
    Plugin 'tpope/vim-commentary'                      " Quick commenting
    " Plugin 'tpope/vim-surround'                        " Surrounds with quotes, tags, brackets, etc
    Plugin 'ryanoasis/vim-devicons'                    " Icons for file manager
    Plugin 'vimwiki/vimwiki'                           " Vimwiki
    Plugin 'michal-h21/vim-zettel'                     " Some vimwiki helpers
    Plugin 'neovim/nvim-lspconfig'                     " Setup lsp in neovim
    Plugin 'nvim-lua/plenary.nvim'                     " Dependency for telescope
    Plugin 'nvim-telescope/telescope.nvim'             " Telescope fuzzy finding
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
" set relativenumber        " Makes numbers relative

set incsearch             " incsearch. Incremental searching. Highlights matches as you type
set nojoinspaces          " no join spaces. When joining two lines, it does not include a space
set showmatch             " show match. Briefly jump to matching bracket when inserting one
set ignorecase
set termguicolors
colorscheme onedark 
set background=dark
set clipboard+=unnamed

set tags=tags;/~
set hidden " Allows for switching buffers without saving

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
" Set completion menu background to gray
highlight Pmenu ctermbg=gray guibg=gray

" Matchup Background colors
hi MatchParen ctermbg=blue ctermfg=black guibg=red
" Matchup Settings
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200
let g:matchup_matchparen_deferred_hide_delay = 50

" Vimwiki settings
let g:vimwiki_list = [{'path':'~/vimwiki/wiki', 'path_html':'~/vimwiki/export/html', 'auto_export': 1}]
let g:vimwiki_list = [{'path':'~/vimwiki/wiki', 'syntax': 'markdown', 'links_space_char': '_', 'ext': '.md'}]

" Dev icons
let g:webdevicons_enable_nerdtree = 1

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

""" Easy edit/source vimrc
" $MYVIMRC = init.vim in neovim
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>env :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ea :vsplit ~/.config/alacritty/alacritty.toml<cr>

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
nnoremap ; :lua require('telescope.builtin').buffers({sort_mru=true})<cr>
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>t :Telescope help_tags<CR>

""" Notes Stuff
function! OpenProjectNotes()
    " Get the current working directory
    let l:cwd = getcwd()

    " Extract the top-level folder name
    let l:project_name = fnamemodify(l:cwd, ':t')

    " Construct the file path for notes
    let l:notes_file = '~/notes/' . l:project_name . '.md'

    " Open the notes file
    execute 'edit ' . l:notes_file
endfunction

" Define a custom command that calls the function
command! ProjectNotes call OpenProjectNotes()

nnoremap <leader>en :edit ~/notes/notes.md<CR>
nnoremap <leader>e. :ProjectNotes<CR>

" Yanks current file's path (relative to pwd) with current cursor's
" Line number appended
nnoremap <leader>yf :let @+=expand('%:~:.') . ':' . line('.')<CR>


""" Nvim LSP
nmap <leader>dh :lua vim.diagnostic.open_float()<CR>

""" Turns off fuzzy file preview windows
let g:fzf_preview_window = []

""" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

"" Operator Mapping ----

" " Get next/last paranthesis
" onoremap in( :<c-u>normal! f(vi(<cr>
" onoremap il( :<c-u>normal! F(vi(<cr>
" onoremap an( :<c-u>normal! f(va(<cr>
" onoremap al( :<c-u>normal! F(va(<cr>
" " Get next/last quotations
" onoremap in" :<c-u>normal! f"vi"<cr>
" onoremap il" :<c-u>normal! F"vi"<cr>
" onoremap an" :<c-u>normal! f"va"<cr>
" onoremap al" :<c-u>normal! F"va"<cr>

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
    autocmd FileType typescript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType typescript setlocal tabstop=2
    autocmd FileType typescript setlocal shiftwidth=2
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

"" Commands

command Exec set splitbelow | new | set filetype=sh | read !sh #
