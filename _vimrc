set nocompatible
filetype plugin indent on
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
syntax on
colo moria
Colo black
"colo darker-robin
"au FileType python Colo black

"debug loaded plugins
"let g:loaded_shell = 1
"let loaded_libList = 1
"let g:loaded_surround = 1
"let g:loaded_outlook = 1
"let g:Imap_FreezeImap = 1
"let loaded_gzip = 1

set directory^=$HOME/TEMP
set undodir^=$HOME/TEMP
set backupdir^=$HOME/TEMP

"tabnew shortcut
ca tn tabnew

"Turn on autoread and autoindent
set autoread
set autoindent

"preferences for gvim fullscreen
let g:shell_fullscreen_items = "mT"
let g:shell_verify_urls=1

"yank command included with '.'
set cpo+=y

"Change leader key
let mapleader = ","

"search options
set incsearch
set showmatch
set hlsearch

"filetypes
au BufRead,BufNewFile *.log set filetype=log
au BufRead,BufNewFile *.lst set filetype=lst
au BufRead,BufNewFile *.SPS set filetype=sps
au BufRead,BufNewFile *.do set filetype=stata
au BufRead,BufNewFile *.R set filetype=r

"setup command to run sas_logcheck
au filetype log e ++ff=mac | %s/^\r//e | %s/\r/\r/ge
au filetype lst e ++ff=mac | %s/^\r//e | %s/\r//ge
au filetype log syntax enable
nnoremap <F9> :! sas_logcheck "%"<CR>
"nnoremap <F9> :ConqueTermTab cmd /c sas_logcheck "%"<CR>
"
"Run latex
au filetype tex nnoremap <F6> :! pdflatex "%"<CR>

"undo file option
set undofile

"*nix-like completion
set wildmenu
set wildmode=list:longest

"turn on spell checking for latex and txt
au FileType tex set spell
au BufRead,BufNewFIle *.txt set filetype=txt
au FileType txt set spell 
"au BufRead,BufNewFIle *.txt set spell

"Get correct filetype for vim
let g:tex_flavor='latex'

" Syntax folding for vim
"let g:xml_syntax_folding=1
"au FileType xml setlocal foldmethod=syntax

" Try mapping something else to Esc
" map! ;; <Esc> " map ;; to Esc
"inoremap <TAB> <Esc>
"vnoremap <TAB> <Esc>
"noremap <TAB> <Esc>

"outlook-vim preferences
let g:outlook_use_tabs = 1
let g:outlook_save_cscript_output = 1

set wrap
set linebreak
set nolist
set tw=0
set wrapmargin=0
set formatoptions+=1
set relativenumber

"autocmd for gmail text
if match(expand("%:p:h"), ".*gmail.*") + 1
    set filetype=mail
    set spell
elseif match(expand("%:p"), ".*TextEditorAnywhere.*") + 1
    set filetype=mail
    set spell
elseif match(expand("%:p"), ".*outlook") + 1
    set filetype=mail
    set spell
else
  au BufRead, BufNewFile *.txt set filetype=txt
endif
    

"Enable code completion for python
"let g:pydiction_location = 'C:/Program Files/Vim/vimfiles/ftplugin/pydiction/complete-dict'
set ofu=syntaxcomplete#Complete

"Turn on line numbering
"nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
"au filetype log set orelativenumber

"Get proper tabbing for SAS and Python files
au filetype tex set tabstop=2 softtabstop=2 shiftwidth=2 tw=79
au filetype sas set tabstop=3 softtabstop=3 shiftwidth=3 tw=79
au filetype stata set tabstop=4 softtabstop=4 shiftwidth=4  tw=79
au filetype html set tabstop=2 softtabstop=2 shiftwidth=2 tw=79 
au filetype cpp set tabstop=4 softtabstop=4 shiftwidth=4 tw=79
au filetype python set tabstop=4 softtabstop=4 shiftwidth=4 tw=79
au filetype txt set tabstop=4 softtabstop=4 shiftwidth=4 spell tw=79
au filetype r set tabstop=4 softtabstop=4 shiftwidth=4  tw=79
au filetype mail set tabstop=2 softtabstop=2 shiftwidth=2 tw=72 spell
au filetype c set tabstop=4 softtabstop=4 shiftwidth=4 tw=79 

"Turn off maximum characters for syntax highlighting for tex file
au filetype tex set synmaxcol=0

"Use spaces instead of tabs for display that isn't editor specific
set expandtab

if has("win32")
  "source $VIMRUNTIME/mswin.vim
  set shell=c:\WINDOWS\system32\cmd.exe
  set shellslash
  "set guifont=Courier_New:h10:cANSI
  set gfn=Inconsolata:h11
  set guioptions-=T
  set guioptions-=m

  "open maximized
  "nmap <F12> <Esc>:simalt~x<CR>

  "Make all searches case-insensitive in windows
  "set ic

  "   MyDiff function in official vimrc example
  set diffexpr=MyDiff()
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction
endif


function! Loadloglst()
    " Assumes you are editing a SAS program.   The log and lst file names will
    " be based on the SAS program basename (the file in the current buffer) and
    " are assumed to end in .log and .lst, as produced by SAS by default.

    " Load the SAS log file in a tab, if it is not already loaded & it exists
    :call Bdeleteonly()
    :if filereadable(expand("%:p:r") . ".log")
       :execute "rightbelow vsplit " . expand("%:p:r") . ".log"
    :else
       :echo "*** SAS log file does not exist."
    :endif

    :if filereadable(expand("%:p:r") . ".lst")
        :execute "tabedit " . expand("%:p:r") . ".lst"
    :else
        :echo "*** SAS lst file does not exist."
    :endif

endfunction
function! Loadllsimp()
    " Assumes you are editing a SAS program.   The log and lst file names will
    " be based on the SAS program basename (the file in the current buffer) and
    " are assumed to end in .log and .lst, as produced by SAS by default.

    " Load the SAS log file in a tab, if it is not already loaded & it exists
    :let log=bufexists(expand("%:p:r") . ".log")
    :if filereadable(expand("%:p:r") . ".log")
        :execute "rightbelow vsplit " . expand("%:p:r") . ".log"
    :else
        :echo "*** SAS log file does not exist."
    :endif

    :let lst=bufexists(expand("%:p:r") . ".lst")
    :if filereadable(expand("%:p:r") . ".lst")
        :execute "tabedit " . expand("%:p:r") . ".lst"
    :else
        :echo "*** SAS lst file does not exist."
    :endif

endfunction

"Easily switch between windows
"nmap <silent> <A-Up> :wincmd k<CR>
"nmap <silent> <A-Down> :wincmd j<CR>
"nmap <silent> <A-Left> :wincmd h<CR>
"nmap <silent> <A-Right> :wincmd l<CR>

function IntroSAS()
    let com = "*"

    let time = toupper(strftime("%B %d, %Y"))

    return repeat(com,79)  . "\<CR>"
    \   . "PROJECT:      " . "\<CR>"
    \   . "\<CR>"
    \   . "PROGRAM:      " . shellescape(expand("%")) . "\<CR>"
    \   . "\<CR>"
    \   . "DATE:         " . time ."\<CR>"
    \   . "\<CR>"
    \   . "PURPOSE:      " . "\<CR>"
    \   . "\<CR>"
    \   . "INPUTFILES:   " . "\<CR>"
    \   . "\<CR>"
    \   . "OUTPUT:       " . "\<CR>"
    \   . "\<CR>"
    \   . "MODIFICATION: " . "\<CR>"
    \   . "\<CR>"
    \   . "CREATED BY:   " . "BARTON BAKER". "\<CR>"
    \   . "\<CR>"
    \   . repeat(com,78)    . ";". "\<CR>"

endfunction

"This function is for automatically producing comments as per Keith's
"suggestion

function BigCommentSAS(comment, ...)
    let introducer =  "*"

    let box_char   =  "*"

    let width      =  a:0 >= 1  ?  a:1  :  strlen(a:comment) + 4

    let ender = ";"

    " Build the comment box and put the comment inside it...
    return introducer . repeat(box_char,width+1) . "\<CR>"
    \    . introducer . "  " . a:comment . "  " . introducer . "\<CR>"
    \    . introducer . repeat(box_char,width+1) . ender . "\<CR>"
endfunction

function RegCommentSAS(comment, ...)
    let introducer =  "*"

    let box_char   =  "*"

    let ender = ";"

    " Build the comment box and put the comment inside it...
    return repeat(box_char, 3) . "  " . a:comment . "  " . repeat(box_char,9) . ender . "\<CR>"
endfunction

au filetype sas imap <silent>  **;  <C-R>=BigCommentSAS(input("Enter comment: "))<CR>
au filetype sas imap <silent>  ***  <C-R>=RegCommentSAS(input("Enter comment: "))<CR>
au filetype sas imap <silent>  **h  <C-R>=IntroSAS()<CR><Esc>kkkkkkkkkkkkkkkkkA

"Python good looking comment
function BigCommentPython(comment, ...)

    let width      =  a:0 >= 1  ?  a:1  :  strlen(a:comment) + 4

    let char = "#"

    return repeat(char,width). "\<CR>"
    \       . char . " " . a:comment . " " . char. "\<CR>"
    \       . repeat(char,width) . "\<CR>"
endfunction

imap <silent> <Leader>pc <C-R>=BigCommentPython(input("Enter comment: "))<CR>

noremap <MiddleMouse> <LeftMouse>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" Run SAS on the current file/buffer. Assumes you have a SAS program in
" the current buffer. File will be saved before running SAS, if it has
" been modified. SAS will run on the saved file on disk. Two tabs will
" be opened, one for the log and one for the list, assumed to be in the
" same location and with the same basename as the SAS program file.
function! SAS()
        " Make sure this is a SAS program file (ends with .sas) so that
        " we don't run SAS on a log file or similar.
        :let checkSASpgm=match(expand("%"),"\.sas")

        " If we did not match .sas in the file name, end this function with
        " a warning msg
        if checkSASpgm==-1
                :echo "*** Current file is not a SAS program.  SAS run has been canceled."
                :return
        endif

        " Ask user if we want to run SAS so we don't accidentally run it.
        :let l:answer = input("Run SAS? Y/N ")
        :if (l:answer == "Y" || l:answer == "y")

                " If file has been modified, save it before running
                if exists(&modified)
                        :echo "*** Saving modified file before SAS run..."
                        :w
                endif

                " Run SAS on path/file name (modify to your location of sas)
                :echo "*** Running SAS..."

                "let returntxt = system("/usr/local/bin/sas -nodms  . shellescape(expand("%:p")))
                " The following may work for your Windows system. Comment the line above and uncomment
                " the two lines below and make them one long line.
                "let returntxt = system("sas " . shellescape(expand("%:p")))
                let returntxt = xolox#shell#execute("sas " . shellescape(expand("%:p")), 0)

                " Shows the return messages from the SAS commandline (may be useful
                " if no log produced)

                :echo "*** SAS commandline: " . returntxt

                :call Loadloglst()

                :else
                :echo "SAS Run cancelled."

        " endif for the Run SAS? check
        :endif
endfunction

function! SIMPSAS()
        " Make sure this is a SAS program file (ends with .sas) so that
        " we don't run SAS on a log file or similar.
        :let checkSASpgm=match(expand("%"),"\.sas")

        " If we did not match .sas in the file name, end this function with
        " a warning msg
        if checkSASpgm==-1
                :echo "*** Current file is not a SAS program.  SAS run has been canceled."
                :return
        endif

        " Ask user if we want to run SAS so we don't accidentally run it.
        :let l:answer = input("Run SAS? Y/N ")
        :if (l:answer == "Y" || l:answer == "y")

                " If file has been modified, save it before running
                if exists(&modified)
                        :echo "*** Saving modified file before SAS run..."
                        :w
                endif

                " Run SAS on path/file name (modify to your location of sas)
                :echo "*** Running SAS..."

                "let returntxt = system("/usr/local/bin/sas -nodms  . shellescape(expand("%:p")))
                " The following may work for your Windows system. Comment the line above and uncomment
                " the two lines below and make them one long line.
                "let returntxt = system("sas " . shellescape(expand("%:p")))
                let returntxt = xolox#shell#execute("sas -sysin " . shellescape(expand("%:p")), 0)

                " Shows the return messages from the SAS commandline (may be useful
                " if no log produced)

                :echo "*** SAS commandline: " . returntxt

                :sleep 2

                :cal Loadllsimp()

                :else
                :echo "SAS Run cancelled."

        " endif for the Run SAS? check
        :endif
endfunction

function! RSAS()
        " Make sure this is a SAS program file (ends with .sas) so that
        " we don't run SAS on a log file or similar.
        :let checkSASpgm=match(expand("%"),"\.sas")

        " If we did not match .sas in the file name, end this function with
        " a warning msg
        if checkSASpgm==-1
                :echo "*** Current file is not a SAS program.  SAS run has been canceled."
                :return
        endif

       :echo "*** Running SAS..."
       "let returntxt = system("/usr/local/bin/sas -nodms  . shellescape(expand("%:p")))
       " The following may work for your Windows system. Comment the line above and uncomment
       " the two lines below and make them one long line.
       "let returntxt = system("sas " . shellescape(expand("%:p")))
       let returntxt = xolox#shell#execute("sas -sysin " . shellescape(expand("%:p")), 0)

       :echo "*** SAS commandline: " . returntxt

endfunction

nmap <F3> <Esc>:call SIMPSAS()<CR>
nmap <F4> <Esc>:call SAS()<CR>
noremap <Leader>rs <Esc>:call RSAS()<CR>

" Working on function to grap section of code

function! SASsection()
    "Make sure this is a SAS program file
    :let checkSASpgm=match(expand("%"),"\.sas")
    " If we did not match .sas in the file name, end this function with
    " a warning msg
    if checkSASpgm==-1
        :echo "*** Current file is not a SAS program.  SAS run has been canceled."
        :return
    endif

    "Yank previously yanked visual block
    :normal qbq
    :normal gv
    :normal "by
    :normal qaq
    ":g/^\(libname\|options\)\_.\{-};/yank a
    :g/^\(libname\|options\)\_.\{-};$/normal! v/;$"Ay
    :let @a.=@b
    :call writefile(split(@a,"\n"), ".tempsas.sas")

    " Ask user if we want to run SAS so we don't accidentally run it.
    :let l:answer = input("Run SAS on yanked visual block? Y/N ")

    :if (l:answer == "Y" || l:answer == "y")
        ":let returntxt = system("sas .tempsas.sas")
        :let returntxt = xolox#shell#execute("sas .tempsas.sas", 0)

        " Shows the return messages from the SAS commandline (may be useful
        " if no log produced)

        :echo "*** SAS commandline: " . returntxt

        " Load the SAS log file in a tab, if it is not already loaded & it exists
        :let log=bufexists(".tempsas.log")
        :if filereadable(".tempsas.log")
            :execute "rightbelow vsplit .tempsas.log"
        :else
            :echo "*** SAS log file does not exist."
        :endif

        :let lst=bufexists(".tempsas.lst")
        :if filereadable(".tempsas.lst")
            :execute "tabedit .tempsas.lst"
        :else
            :echo "*** SAS lst file does not exist."
        :endif
    :endif

endfunction

au filetype sas nmap <F6> <Esc>:call SASsection()<CR>

"Print options with shortcut
set printoptions=number:y,left:5pc
nmap <F7> <Esc>:colo murphy<CR> :hardcopy<CR>

"Get nerdtree like browsing for
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
"map <silent> <F2> :call ToggleVExplorer()<CR>

" netrw preferences
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 0
let g:netrw_fastbrowse = 1
let g:netrw_liststyle = 0
let g:netrw_keepdir = 1
let g:netrw_bannercnt = 7
let g:netrw_localcopycmd="cp -rp"
let g:netrw_localmovecmd="mv"
let g:netrw_localrmdir = "rm -r"
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

"create shortcut for yanking full path
nnoremap <Leader>yp :let @"=expand("%:p")<CR>
"create shortcut for yanking name 
nnoremap <Leader>yn :let @"=expand("%")<CR>

" Change directory to the current buffer when opening files.
set autochdir

" get decent status line with git
set laststatus=2
set statusline+=,%{GitBranchInfoString()}
set statusline=%t\ %m\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ %{GitBranchInfoString()}%=\ %c,%l\ %P
let g:git_branch_status_head_current=1
let g:git_branch_status_text=""

"Create SAS search term quick keys
nmap <Leader>e <Esc>gg/\<ERROR\><CR>
nmap <Leader>w <Esc>gg/\<WARNING\><CR>
nmap <Leader>u <Esc>gg/\<uninitialized\><CR>
nmap <Leader>n <Esc>gg/\<NOTE\><CR>

"Shortcut for setting all three tabbing commands
nmap <Leader>st4 <Esc>:set tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <Leader>st3 <Esc>:set tabstop=3 shiftwidth=3 softtabstop=3<CR>
nmap <Leader>st2 <Esc>:set tabstop=2 shiftwidth=2 softtabstop=2<CR>

"Turn of whitespace highight for cmd.exe
"au filetype conque_term HideBadWhitespace

"Create shortcut command to delete all buffers except for current
function! Buflist()
    redir => bufnames
    silent ls
    redir END
    let list = []
    for i in split(bufnames, "\n")
        let buf = split(i, '"' )
        call add(list, buf[-2])
|   endfor
    return list
endfunction

function! Bdeleteonly()
    let list = filter(Buflist(), 'v:val != bufname("%")')
    for buffer in list
        exec "bdelete ".buffer
    endfor
endfunction

command! BdelOnly :silent call Bdeleteonly()
nmap <Leader>bd <Esc>:BdelOnly<CR>

"Define proper SAS comment type tcomment
call tcomment#DefineType('sas', '*%s')

"set shell.vim preferences
:let g:shell_mappings_enabled = 0
:inoremap <Leader>fs <C-o>:Fullscreen<CR>
:nnoremap <Leader>fs :Fullscreen<CR>
:inoremap <Leader>op <C-o>:Open<CR>
:nnoremap <Leader>op :Open<CR>
:vnoremap <Leader>cs :s/\//\\/g

"get correct backspace behavior
set bs=indent,eol,start     " Backspace over everything in insert mode

"define shortcut for finding conflicts
nmap <Leader>gc <Esc>/<<<<<<<<CR>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"Emacs style cursor movement on command line and find
cnoremap <C-a> <Home>

"Python function finding
nmap <Leader>fn <Esc>/ *def.*(<CR>zt:noh<CR>
nmap <Leader>fN <Esc>? *def.*(<CR>zt:noh<CR>

