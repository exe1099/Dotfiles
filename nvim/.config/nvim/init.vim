"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
" nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w suda://%
" command W w !sudo tee % > /dev/null " this doesnt work in neovim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 8 lines to the cursor - when moving vertically using j/k
set so=8 " keep space between coursor and top/bottom

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
":set t_Co=256 " 256 colors

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <cr> is pressed
nnoremap <CR> :nohlsearch<cr>

" Smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
" map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
set switchbuf=useopen,usetab,newtab
set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk]
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" different binding for terminal
" if !has("gui_running")
   " nnoremap <Esc>j mz:m+<cr>`z
   " nnoremap <Esc>k mz:m-2<cr>`z
" endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
let save_cursor = getpos(".")
let old_query = getreg('/')
silent! %s/\s\+$//e
call setpos('.', save_cursor)
call setreg('/', old_query)
endfun
if has("autocmd")
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,.vimrc :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Stuff (excalibur1099)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug
call plug#begin('~/.vim/plugged')
" Add plugins here
Plug 'https://github.com/mbbill/undotree/'
Plug 'sheerun/vim-polyglot'  " synatx highlighting for different languages
Plug 'vim-airline/vim-airline'  " fancy status bar
Plug 'vim-airline/vim-airline-themes'  " themes for fancy status bar
Plug 'wincent/command-t'  " fuzzy-finder
Plug 'scrooloose/nerdcommenter'  " comment/uncomment plugin
Plug 'exe1099/minimalist_2'  " color-scheme
Plug 'https://github.com/lambdalisue/suda.vim' " write with sudo
call plug#end()

" Options for plugins
nnoremap <F5> :UndotreeToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDComment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDComToggleComment
nnoremap <c-b> :call NERDComment(0,"toggle")<CR>
vnoremap <c-b> :call NERDComment(0,"toggle")<CR>
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Useful mappings for managing tabs
map <c-t> :tabnew<cr>
"map <c-w> :tabclose<cr>
" abc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rebindings for working with the code
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set clipboard=unnamedplus " always use global clipboard
" delete in black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" use system clipboard
" + clipboard
" * primary selection ("mouse highlight")
vnoremap <c-C> "*y :let @+=@*<CR>
nnoremap <c-V> "+p
inoremap <c-V> <Esc>"+pa

" save and run current file, :! (execute) % (current filename) :p (use absolute path)
" map <F9> <Esc>:w<CR>:!%:p<CR>

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1 " needed for status line
" set noshowmode " hide -- INSERT --
let g:airline_theme='minimalist_2'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this doesnt work with neovim, use ginit.vim for config
" if has("gui_running")
    " set guioptions-=T
    " set guioptions-=e
    " set t_Co=256
    " set guitablabel=%M\ %t
    " set guifont=Hack\ 10
    " let g:airline_powerline_fonts = 1 " needed for status line
    " set linespace=2
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Style
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
" these options destroy inverted cursor block
" set gui cursor block (same as in terminal)
" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:block-Cursor
set termguicolors
colorscheme minimalist_2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CommandT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>t :CommandT<cr>
nnoremap <leader>f :CommandT /home/excalibur1099<cr>
" ignore directories/files
set wildignore+=miniconda3


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers, windows and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildcharm=<C-z>
" nnoremap <leader>b :buffer <C-z><S-Tab>
" nnoremap <leader>B :vsp b <C-z><S-Tab>
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader>B :ls<CR>:vert sb<space>
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Stuff to remember
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" D/C - d$/c$
" CommandT: <c-v> - open in vertical split
    "           <c-s> - open in split
" alt-j/k - move line up/down
" ctrl-t - new tab

