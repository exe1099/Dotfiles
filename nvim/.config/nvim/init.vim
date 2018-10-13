"__     _____ __  __ ____   ____ 
"\ \   / /_ _|  \/  |  _ \ / ___|
" \ \ / / | || |\/| | |_) | |    
"  \ V /  | || |  | |  _ <| |___ 
"   \_/  |___|_|  |_|_| \_\\____|
"                                

" => General --------------------------------------------------------{{{

" turn backup off, since most stuff is in SVN, git et.c anyway...
" set nobackup
" set nowb
set noswapfile

set mouse=a                    " use mouse to switch between panels + scroll
set incsearch                  " show search matches as you type
set nocompatible
set colorcolumn=85
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set autoindent
set laststatus=2
set splitright
set splitbelow
map yx :wq<cr>
map yy :w<cr>
" map xx :q<cr>

" strip all trailing whitespaces in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" highlight line if in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
" how many lines of history VIM has to remember
set history=500

" enable filetype plugins
filetype plugin on
filetype indent on

" auto read when a file is changed from the outside
set autoread

let mapleader = "," " map leader key

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w suda://%

" }}}
" => VIM User Interface ---------------------------------------------{{{
"
" keep space between coursor and top/bottom
set so=8

" turn on the wild menu
set wildmenu

" always show current position
set ruler

" height of the command bar
set cmdheight=1

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" don't redraw while executing macros (good performance config)
set lazyredraw

" for regular expressions turn magic on
set magic

" show matching brackets when text indicator is over them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" ignore compiled files
" set wildignore=*.o,*~,*.pyc
" if has("win16") || has("win32")
"     set wildignore+=.git\*,.hg\*,.svn\*
" else
"     set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" endif

" }}}
" => Folding --------------------------------------------------------{{{

" add a bit extra margin to the left
set foldcolumn=1

" toggle current fold
nnoremap <leader>f za

" create fold
vnoremap <leader> zf

" custom fold text
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" autosave folds
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" }}}
" => Plugins --------------------------------------------------------{{{

" Plug 
call plug#begin('~/.vim/plugged')
" Add plugins here
Plug 'https://github.com/mbbill/undotree/'
Plug 'sheerun/vim-polyglot'  " synatx highlighting for different languages
Plug 'vim-airline/vim-airline'  " fancy status bar
Plug 'vim-airline/vim-airline-themes'  " themes for fancy status bar
" Plug 'wincent/command-t'  " fuzzy-finder
Plug 'scrooloose/nerdcommenter'  " comment/uncomment plugin
Plug 'exe1099/minimalist_2'  " color-scheme
Plug 'https://github.com/lambdalisue/suda.vim' " write file with sudo
Plug 'python-mode/python-mode', { 'branch': 'develop' } " Python Stuff for editor
Plug 'vim-scripts/restore_view.vim' " remembers cursor position and view
call plug#end()


" Options for plugins

set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

nnoremap <F5> :UndotreeToggle<cr>

let g:pymode = 1 " turn on the whole plugin
let g:pymode_python = 'python3' " Python3 syntax checking
let g:pymode_trim_whitespaces = 1 " trim unused whitespaces on save
let g:pymode_options = 1 " set default python option (line length, ...)
let g:pymode_indent = 1 " pep8 compatible python ident
let g:pymode_doc = 1 " turn on documentation
let g:pymode_doc_bind = 'K' " bind key to documentation
let g:pymode_run = 1 " turn on run code
let g:pymode_run_bind = '<leader>r' " bind key to run code
" autocmd BufEnter __run__,__doc__ :wincmd L " open doc-, run-windows on right
" let g:pymode_rope = 1
" let g:pymode_rope_completion = 1
" let g:pymode_rope_complete_on_dot = 1
" let g:pymode_rope_completion_bind = '<C-Space>'


" NERDComToggleComment
nnoremap <c-b> :call NERDComment(0,"toggle")<CR>
vnoremap <c-b> :call NERDComment(0,"toggle")<CR>
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" airline
let g:airline_powerline_fonts = 1 " needed for status line
" set noshowmode " hide -- INSERT --
let g:airline_theme='minimalist_2'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" show buffers if only single tab open
let g:airline#extensions#tabline#show_buffers = 0
" formatting of path + file
let g:airline#extensions#tabline#formatter = 'jsformatter'
" hide open splits per tab
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0

" }}}
" => Tabs, Windows, Buffers -----------------------------------------{{{

" a buffer becomes hidden when it is abandoned
set hid

" return to last edit position when opening files (You want this!){{{
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif"}}}

" }}}
" => Movement with Tabs, Windows, Buffers----------------------------{{{

" set wildcharm=<C-z>
" nnoremap <leader>b :buffer <C-z><S-Tab>
" nnoremap <leader>B :vsp b <C-z><S-Tab>
" nnoremap <leader>b :ls<CR>:b<Space>
" nnoremap <leader>B :ls<CR>:vert sb<space>
" nnoremap <PageUp>   :bprevious<CR>
" nnoremap <PageDown> :bnext<CR>
" nnoremap <leader>+ :vertical resize +5<cr>
" nnoremap <leader>- :vertical resize -5<cr>
" nnoremap <leader>o :only<cr>
" smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" close all the buffers
" map <leader>ba :bufdo bd<cr>

" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" let 'tl' toggle between this and the last accessed tab
" let g:lasttab = 1
" nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
" au TabLeave * let g:lasttab = tabpagenr()

" opens a new tab with the current buffer's path
" super useful when editing files in the same directory
" map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers
" try
" set switchbuf=useopen,usetab,newtab
" set stal=2
" catch
" endtry

" }}}
" => Colors and Fonts------------------------------------------------{{{
"
colorscheme minimalist_2

" enable syntax highlighting
syntax enable

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" use Unix as the standard file type
set ffs=unix,dos,mac

set termguicolors

" }}}
" => Text, Wrap, Indent ---------------------------------------------{{{

" use spaces instead of tabs
set expandtab

" be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak on 500 characters
set lbr
set tw=500

set ai " auto indent
set si " smart indent

set wrap linebreak nolist " wrap lines

" :Wrap to make softwrap
command! -nargs=* Wrap set wrap linebreak nolist
set breakindent
set breakindentopt=shift:2"}}}
" => Searching ------------------------------------------------------{{{

" pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <space> /
nnoremap <c-space> ?

" disable highlight when pressed
nnoremap <CR> :nohlsearch<cr>

" ignore case when searching
" if it contains upper letter, be case sensitive
set ignorecase
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch

" }}}
" => Working with Text ----------------------------------------------{{{

" move a line of text using ALT+[jk]
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi

" delete in black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" use system clipboard
" + clipboard
" * primary selection ("mouse highlight")
vnoremap <c-C> "*y :let @+=@*<CR>
nnoremap <c-V> "+p
inoremap <c-V> <Esc>"+pa

" }}}
" => Working with Code ----------------------------------------------{{{

" compile markdown file
function! CompilteMarkdown()
    execute "w"
    execute "! pandoc -o %:p.pdf %:p"
endfunction
:nmap mc :call CompilteMarkdown()<CR><CR>

" save and run current file and show output in vertical split
function! Setup_ExecNDisplay()
  " write file
  execute "w"
  " execute permission
  execute "silent !chmod +x %:p"
  " save filename in variable, not sure what :t is for
  let n=expand('%:t')
  " 2>&1 stderr to stdout (2>1 would be to file names 1)
  " tee: write stdin to file
  execute "silent !%:p 2>&1 | tee ~/.vim/tmp/out_".n
  " create new vsplit
  execute "vsplit ~/.vim/tmp/out_".n
  execute "redraw!"
  set autoread
endfunction

function! ExecNDisplay()
  execute "w"
  let n=expand('%:t')
  execute "silent !%:p 2>&1 | tee ~/.vim/tmp/out_".n
endfunction

:nmap <F8> :call Setup_ExecNDisplay()<CR>
:nmap <F9> :call ExecNDisplay()<CR>

" }}}
" => Spell Checking -------------------------------------------------{{{

" toggle spell checking
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"}}}
" => Movement -------------------------------------------------------{{{

" remap to first non-blank character
map 0 ^

" jump 10 lines up or down/characters left/right
nmap <c-j> 10j
nmap <c-k> 10k
nmap <c-h> 10h
nmap <c-l> 10l

" insert empty line below/above and stay in normal mode
nmap # o<esc>
nmap ' O<esc>

" deactive arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" move along screen lines, not file lines
nnoremap j gj
nnoremap k gk

" useful mappings for managing tabs
map <c-t> :tabnew<cr>
"map <c-w> :tabclose<cr>

" }}}
" => Unused Stuff ---------------------------------------------------{{{

" Delete trailing white space on save, useful for some filetypes ;)
" fun! CleanExtraSpaces()
" let save_cursor = getpos(".")
" let old_query = getreg('/')
" silent! %s/\s\+$//e
" call setpos('.', save_cursor)
" call setreg('/', old_query)
" endfun
" if has("autocmd")
" autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,.vimrc :call CleanExtraSpaces()
" endif

" Returns true if paste mode is enabled
" function! HasPaste()
"     if &paste
"         return 'PASTE MODE  '
"     endif
"     return ''
" endfunction
"
" " Don't close window, when deleting a buffer
" command! Bclose call <SID>BufcloseCloseIt()
" function! <SID>BufcloseCloseIt()
"     let l:currentBufNum = bufnr("%")
"     let l:alternateBufNum = bufnr("#")
"
"     if buflisted(l:alternateBufNum)
"         buffer #
"     else
"         bnext
"     endif
"
"     if bufnr("%") == l:currentBufNum
"         new
"     endif
"
"     if buflisted(l:currentBufNum)
"         execute("bdelete! ".l:currentBufNum)
"     endif
" endfunction
"
" function! CmdLine(str)
"     call feedkeys(":" . a:str)
" endfunction
"
" function! VisualSelection(direction, extra_filter) range
"     let l:saved_reg = @"
"     execute "normal! vgvy"
"
"     let l:pattern = escape(@", "\\/.*'$^~[]")
"     let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"     if a:direction == 'gv'
"         call CmdLine("Ack '" . l:pattern . "' " )
"     elseif a:direction == 'replace'
"         call CmdLine("%s" . '/'. l:pattern . '/')
"     endif
"
"     let @/ = l:pattern
"     let @" = l:saved_reg
" endfunction

" }}}
" => Stuff to remember ----------------------------------------------{{{



" }}}
