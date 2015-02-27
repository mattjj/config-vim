if filereadable(expand("~/.vimrc_specific"))
    source ~/.vimrc_specific
endif

" pathogen

let g:pathogen_disabled = []

call add(g:pathogen_disabled, 'vim-go')
call add(g:pathogen_disabled, 'atp-vim-code')
call add(g:pathogen_disabled, 'pep8')
" call add(g:pathogen_disabled, 'LaTeX-Box')
" call add(g:pathogen_disabled, 'YouCompleteMe')

if v:version < '703' || !has('python')
    call add(g:pathogen_disabled, 'gundo')
    call add(g:pathogen_disabled, 'Ultisnips')
endif

execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on

" vi? This is VIMMMMMMMMMMMMMM
set nocompatible

""" Now the general stuff!

" all movement keys will move the the next line when at last character
set whichwrap=b,s,h,l,~,[,],<,>

" I'm a programmer.
if &t_Co > 2 || has("gui_running")
    syntax on
    set number
endif

set timeoutlen=500

" turn on hlsearch, but make it go away when I want
set hls
nmap <space><space> :noh<CR>/<BS>

" show command as I'm typing it
set showcmd

" search stuff
set ignorecase
set smartcase
set incsearch

" I have no idea, but I think these are fine
"set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full
set shortmess+=r
set bs=2
set showmode
set shiftround
set wrap

" Set up backup location and enable
" the double slash means editing /etc/X11/x.org and ~/x.org won't clobber
set backupdir=~/.vim/backup//
set backup
set directory=~/.vim/swap//
if v:version >= '703'
    set undodir=~/.vim/undo//
    set undofile
    set undoreload=50000
endif

" show matching parens, brackets
set showmatch

" change pwd to mru file/buffer
set autochdir
command! Cdpwd execute "cd %:p:h"

" use hidden buffers? i keep changing my mind
set hid

" use mouse
if has('mouse')
  set mouse=a
endif

" ignore some stuff
set wildignore+=*/.hg/*,*/.svn/*,*/.git/*,*.pyc,*.so

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    augroup executePermissions
        au!
        " adds execute permissions if file starts with appropriate shebang
        autocmd BufWritePost * call NoExtNewFile()
        function! NoExtNewFile()
            if getline(1) =~ "^#!.*/bin/"
                if &filetype == ""
                    filetype detect
                endif
                silent !chmod a+x <afile>
            endif
        endfunction
    augroup END

    augroup vimStuff
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

        autocmd bufwritepost .vimrc source $MYVIMRC
    augroup END

    augroup templates
        au!
        au BufNewFile * if !(expand("%:p") =~? 'ipython_edit') | silent! 0r ~/.vim/templates/%:e | endif
        au BufNewFile * if @% =~? 'pset' | silent! 0r ~/.vim/templates/pset | endif
    augroup END
else
    set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | set fdl=99 | wincmd p | diffthis | set fdl=99

" \r := save the current file, chmod it +x, and run it
noremap \r :w<CR>:!chmod u+x %<CR>:!./%<CR>

" run make
map <buffer> \m :w<CR>:!make<CR>

" yank to end of line
nmap Y y$

" wrap when moving left or right
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" and add virtual columns during visual block
set ve+=block

" Bindings for tabbed editing
noremap <C-l> :bnext<CR>
noremap <C-h> :bprev<CR>

" Make tabs work how I like them: made of 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set formatoptions=lc
set lbr

set ruler

" correct my common typos
if (&encoding == "utf-8")
    set list
    set listchars=extends:»,tab:▸\ ,trail:›
    " eol:¬,
else
    set nolist
endif

" fonts and colors
syntax enable

" set background=dark
" colorscheme solarized

" set background=light
" colorscheme github

colorscheme Tomorrow-Night-Bright

" colorscheme gotham256

hi clear SpellBad
hi SpellBad cterm=underline

" fold stuff
set fdo=hor,insert,search,undo,tag
set fillchars="fold:"

" sets w!! to sudo write
cmap w!! w !sudo tee % > /dev/null

" auto-read changed buffers from disk
set autoread

" open definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" open definition in new veritcal split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set tags=.tags,tags;/
set tags+=~/Dropbox/work/pyhsmm/tags,~/Dropbox/work/pybasicbayes/tags,~/Dropbox/work/pymattutil/tags,~/Dropbox/work/pyhsmm-library-models

set wildmode=longest,list,full
set wildmenu

set formatprg="par -w"
set grepprg="ag"

" set completion to show a preview window
set cot=menu,preview,menuone
" TODO these break in command-line window
"autocmd CursorMovedI * if pumvisible() == 0 | pclose | endif
"autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" use blowfish encryption with :X
" if v:version >= '703'
"     set cm=blowfish
" endif

" chordless saving
nnoremap <leader>w :w<CR>

" easier jumping between errors and opening error list window
" map <leader>cc :botright cope<cr> " there seem to be errors with the
" quickfix window
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>

" Bubble single lines with control-arrows
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
" vmode indent/dedent preserves selections
vnoremap > >gv
vnoremap < <gv

" map tag commands to be nicer
nmap <C-Right> <C-]>
nmap <C-Left> <C-T>

" toggle nu and relnu with control-K
function! g:ToggleNuMode()
    if (&rnu == 1)
        set nornu
        set nu
    else
        set nonu
        set rnu
    endif
endfunc
nnoremap <C-K> :call g:ToggleNuMode()<cr>
vnoremap <C-K> :call g:ToggleNuMode()<cr>

if has("gui_macvim")
    silent! set gfn=Inconsolata-g:h12
    " transparency
    " set transparency=3
    " don't show toolbar buttons
    set guioptions-=T
    " always show tab bar (so windows don't resize with just one tab open)
    set showtabline=2
elseif has("gui")
    silent! set gfm=Droid\ Sans\ Mono\ 12
    set guioptions-=Tma
endif

" in bash vi mode, a "v" in command mode starts a vim session that gets
" executed on leave. this makes sure syntax highlighting works there.
if expand('%:t') =~?'bash-fc-\d\+'
    setfiletype sh
endif

" new, experimental, and in need of organization
set ttyfast
set backspace=indent,eol,start
set history=1000
set splitright
" this makes help appear on the bottom, which is annoying, but it also makes
" omnicomplete previews appear on the bottom, which i like
set splitbelow

nmap <silent> * :let @/='\<'.expand('<cword>').'\>' \| :set hlsearch<CR>

set shell=/bin/bash

let g:tex_flavor='latex'

" nnoremap Z :w<CR>
nnoremap X :w<CR>

set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.

set laststatus=2

syntax sync minlines=256

set noautochdir

set lazyredraw

set cursorline
set cursorcolumn

" sentences should be separated by a period and ONE space when using gq
set nojoinspaces
