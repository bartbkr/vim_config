set nocompatible
" Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

set t_vb=
set visualbell

colo moria
Colo black
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
autocmd FileType python set complete+=k~/.vim/syntax/python.vim
filetype plugin indent on

"Save undo and backup files to centralized dir
set undodir=$HOME/.vim/undo
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

"Turn on autoread and autoindent
set autoread
set autoindent

"yank command included with '.'
set cpo+=y

"Change leader key
let mapleader = ","

"search options
set incsearch
set showmatch
set hlsearch

"Correct file types
au BufRead,BufNewFile *.log set filetype=log
au BufRead,BufNewFile *.lst set filetype=lst
au BufRead,BufNewFile *.SPS set filetype=sps
au BufRead,BufNewFile *.do set filetype=stata
au BufRead,BufNewFile *.R set filetype=r

"tab shortcuts
ca tn tabnew

au filetype log syntax enable

"set leader
let mapleader = ","

"search options
set incsearch
set showmatch
set hlsearch

"undo file option
set undofile

"get *nix-like tab completion in command
set wildmenu
set wildmode=list:longest

"spell check for tex
au FileType tex set spell foldmethod=manual
au FileType mail set spell

"vim-latex options
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:tex_comment_nospell= 1
let g:tex_flavor = "latex" 


"correct word wrapping
set wrap
set linebreak
set nolist
set tw=0
set wrapmargin=0
set formatoptions+=1

"turn on autocomplete
au filetype python set tw=79
au filetype c set tw=79
au filetype tex set tw=79
au filetype sas set tw=79
au filetype R set tw=79
au filetype mail set tw=79
set ofu=syntaxcomplete#Complete

"turn on line numbering
set relativenumber
au filetype log set nonumber

"get correct tab stops
au filetype tex set tabstop=2 softtabstop=2 shiftwidth=2 relativenumber
au filetype sas set tabstop=3 softtabstop=3 shiftwidth=3 relativenumber
au filetype html set tabstop=2 softtabstop=2 shiftwidth=2 relativenumber
au filetype cpp set tabstop=4 softtabstop=4 shiftwidth=4 relativenumber
au filetype python set tabstop=4 softtabstop=4 shiftwidth=4 relativenumber
au filetype txt set tabstop=4 softtabstop=4 shiftwidth=4 relativenumber
au filetype r set tabstop=4 softtabstop=4 shiftwidth=4 relativenumber
au filetype mail set tabstop=2 softtabstop=2 shiftwidth=2 relativenumber tw=79

"set gui options
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guifont=DejaVu\ Sans\ Mono\ 09

"Turn off maximum characters for syntax highlighting for tex file
au filetype tex set synmaxcol=0 
" netrw preferences
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_fastbrowse = 1
let g:netrw_liststyle = 0
let g:netrw_keepdir = 1
let g:netrw_special_syntax = 1
let g:netrw_menu=1
let g:netrw_browsex_viewer= "gnome-open"

" Change directory to the current buffer when opening files.
set autochdir

"python code completion
let g:pydiction_location = "/home/bart/.vim/pydiction/complete-dict"
set laststatus=2
set statusline+=,%{GitBranchInfoString()}
set statusline=%t\ %m\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ %{GitBranchInfoString()}%=\ %c,%l\ %P
let g:git_branch_status_head_current=1
let g:git_branch_status_text=""

"Create SAS search term quick keys
nmap <Leader>e <Esc>gg/\<ERROR\><CR>
nmap <Leader>w <Esc>gg/\<WARNING\><CR>
nmap <Leader>u <Esc>gg/\<uninitialized\><CR>

"Shortcut for setting all three tabbing commands
nmap <Leader>st4 <Esc>:set tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <Leader>st3 <Esc>:set tabstop=3 shiftwidth=3 softtabstop=3<CR>
nmap <Leader>st2 <Esc>:set tabstop=2 shiftwidth=2 softtabstop=2<CR>

"set shell.vim preferences
:let g:shell_mappings_enabled = 0
:inoremap <Leader>fs <C-o>:Fullscreen<CR>
:nnoremap <Leader>fs :Fullscreen<CR>
:inoremap <Leader>op <C-o>:Open<CR>
:nnoremap <Leader>op :Open<CR>

"python pylint code checker
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0

if has("gui_running")
    colo moria
    Colo black
else 
    colo calmar256-dark
endif

"Add shortcut for NERDTree
"nnoremap <F2> :NERDTree <CR>
"
"get correct backspace behavior
set bs=indent,eol,start     " Backspace over everything in insert mode

noremap <MiddleMouse> <LeftMouse>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

"mutt google contacts
imap <C-F> <ESC>:r!google-contacts-lookup.sh <cword><CR><ESC>

"show cmds
set showcmd

"vimdiff Git options
" Disable one diff window during a three-way diff allowing you to cut out the
" noise of a three-way diff and focus on just the changes between two versions
" at a time. Inspired by Steve Losh's Splice
function! DiffToggle(window)
  " Save the cursor position and turn on diff for all windows
  let l:save_cursor = getpos('.')
  windo :diffthis
  " Turn off diff for the specified window (but keep scrollbind) and move
  " the cursor to the left-most diff window
  exe a:window . "wincmd w"
  diffoff
  set scrollbind
  set cursorbind
  exe a:window . "wincmd " . (a:window == 1 ? "l" : "h")
  " Update the diff and restore the cursor position
  diffupdate
  call setpos('.', l:save_cursor)
endfunction
" Toggle diff view on the left, center, or right windows
nmap <silent> <leader>dl :call DiffToggle(1)<cr>
nmap <silent> <leader>dc :call DiffToggle(2)<cr>
nmap <silent> <leader>dr :call DiffToggle(3)<cr>

"Python good looking comment
function BigCommentPython(comment, ...)

    let width      =  a:0 >= 1  ?  a:1  :  strlen(a:comment) + 4

    let char = "#"

    return repeat(char,width). "\<CR>"
    \       . char . " " . a:comment . " " . char. "\<CR>"
    \       . repeat(char,width) . "\<CR>"
endfunction

imap <silent> <Leader>pc <C-R>=BigCommentPython(input("Enter comment: "))<CR>
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
"create shortcut for yanking full path
nnoremap <Leader>yp :let @"=expand("%:p")<CR>
"create shortcut for yanking name 
nnoremap <Leader>yn :let @"=expand("%")<CR>

"python browse to next function
nmap <Leader>fn <Esc>/ *def <CR> zt
nmap <Leader>fN <Esc>? *def <CR> zt

"shortcut for vimgrep results view
map <leader>cc :botright cope<cr>

"Compile latex
nmap <leader>cl <Esc>:!pdflatex %<cr>

"Open pomo file
nmap <leader>po <Esc>:tabnew /home/bart/Pomo/pomo.txt<cr>

"open bibliography file dissertation
nmap <leader>ob <Esc>:tabnew /home/bart/Code/Bib_file/master1.bib<cr>

"Remap star so it doesn't jump
function! SuperStar()
    let w='\<' . expand('<cword>') . '\>'
    call histadd('/', w)
    let @/=w
endfunction
nnoremap * :call SuperStar()<CR>:set hls<CR>

"django html highlighting
nmap <leader>sd <Esc>:setfiletype htmldjango<cr>

"""""""""""""""""""""""
"Python mode settings
""""""""""""""""""""""
let g:pymode_run = 1
let g:pymode_run_key='<leader>rp'
" Load pylint code plugin
let g:pymode_lint = 1
" Switch pylint, pyflakes, pep8, mccabe code-checkers
" Can have multiply values "pep8,pyflakes,mcccabe"
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
"
" Skip errors and warnings
" E.g. "E501,W002", "E2,W" (Skip all Warnings and Errors startswith E2) and etc
let g:pymode_lint_ignore = ""

" Select errors and warnings
" E.g. "E4,W"
let g:pymode_lint_select = ""

" Run linter on the fly
let g:pymode_lint_onfly = 0

" Pylint configuration file
" If file not found use 'pylintrc' from python-mode plugin directory
let g:pymode_lint_config = "$HOME/.pylintrc"

" Check code every save
let g:pymode_lint_write = 0

" Auto open cwindow if errors are found
let g:pymode_lint_cwindow = 0

" Show error message if cursor placed at the error line
let g:pymode_lint_message = 1

" Auto jump on first error
let g:pymode_lint_jump = 0

" Hold cursor in current window
" when quickfix is open
let g:pymode_lint_hold = 0

" Place error signs
let g:pymode_lint_signs = 1

" Maximum allowed mccabe complexity
let g:pymode_lint_mccabe_complexity = 8

" Minimal height of pylint error window
let g:pymode_lint_minheight = 3

" Maximal height of pylint error window
let g:pymode_lint_maxheight = 6

" Enable python folding
let g:pymode_folding = 1

" Enable python objects and motion
let g:pymode_motion = 1

" Enable pymode's custom syntax highlighting
let g:pymode_syntax = 1

" Enable all python highlightings
let g:pymode_syntax_all = 1

" Highlight "print" as function
let g:pymode_syntax_print_as_function = 0

" Highlight indentation errors
let g:pymode_syntax_indent_errors = g:pymode_syntax_all

" Highlight trailing spaces
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Highlight string formatting
let g:pymode_syntax_string_formatting = g:pymode_syntax_all

" Highlight str.format syntax
let g:pymode_syntax_string_format = g:pymode_syntax_all

" Highlight string.Template syntax
let g:pymode_syntax_string_templates = g:pymode_syntax_all

" Highlight doc-tests
let g:pymode_syntax_doctests = g:pymode_syntax_all

" Highlight builtin objects (__doc__, self, etc)
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all

" Highlight builtin functions
let g:pymode_syntax_builtin_funcs = g:pymode_syntax_all

" Highlight exceptions
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all

" For fast machines
let g:pymode_syntax_slow_sync = 0
