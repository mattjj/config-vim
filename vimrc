" vi? This is VIMMMMMMMMMMMMMM
set nocompatible

""" Vundle stuff
" to set up vundle: 
" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" git repos
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'ervandew/supertab'
Bundle 'wincent/Command-T'
Bundle 'mileszs/ack.vim'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/pep8'
Bundle 'alfredodeza/pytest.vim'
Bundle 'sontek/rope-vim'
Bundle 'tpope/vim-repeat'
Bundle 'scrooloose/syntastic'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'tpope/vim-unimpaired'
Bundle 'edsono/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kchmck/vim-coffee-script'
Bundle 'majutsushi/tagbar'
Bundle 'ivanov/vim-ipython'
Bundle 'docunext/closetag.vim'

" vim-scripts repos
Bundle 'TaskList.vim'
Bundle 'The-NERD-tree'
Bundle 'UltiSnips'
Bundle 'LaTeX-Box'

" my stuff
"Static 'python_general'
" Static 'latex_general'
" Static 'templates'
" Static 'mlint'
" Static 'syntastic-supplement'

" To disable a plugin, add it's bundle name to the following list
"let g:pathogen_disabled = ['easygrep', 'tagbar'] " easygrep makes startup slow and I don't use it much
"
"if v:version < '703' || !has('python')
"    call add(g:pathogen_disabled, 'gundo')
"    call add(g:pathogen_disabled, 'python_vim_ipython')
"endif
"if !has('ruby')
"    call add(g:pathogen_disabled, 'command-t')
"endif
"
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

""" Now the general stuff!

filetype plugin indent on

" Move this somewhere
let g:syntastic_enable_signs=1
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
nmap <silent> <Leader>o :CommandT<CR>


" all movement keys will move the the next line when at last character
set whichwrap=b,s,h,l,~,[,],<,>

" I'm a programmer.
if &t_Co > 2 || has("gui_running")
    syntax on
    set number
endif

" turn on hlsearch, but make it go away when I hit return
set hls
nmap <CR> :nohlsearch<CR>/<BS>

" show command as I'm typing it
set showcmd

" search stuff
set ignorecase
set smartcase
set incsearch

" quick mapping to put \(\) in pattern string
cmap ;\ \(\)<Left><Left>

" I have no idea, but I think these are fine
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full
set shortmess+=r
set bs=2
set showmode
set shiftround
set wrap

" Setup backup location and enable
" the double slash means editing /etc/X11/x.org and ~/x.org won't clobber
set backupdir=~/.vim/backup//
set backup
set directory=~/.vim/swap//
if v:version >= '703'
    set undodir=~/.vim/undo//
    set undofile
endif

" Set up Printer options
set printoptions=left:15mm,right:15mm,top:15mm,bottom:15mm,paper:A4,header:2,syntax:n
set printfont=courier_new:h7

" Set Printer up
set printexpr=PrintFile(v:fname_in)

if !exists("*PrintFile")
    function PrintFile(fname)
        call system("lpr -r " . a:fname)
        return v:shell_error
    endfunc
endif

" so that .tex files are latex filetype
let g:tex_flavor='latex'

" show matching parens, brackets
set showmatch

set autochdir

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  "
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

  autocmd FileType html let b:closetag_html_style=1
  autocmd FileType html source ~/.vim/bundle/closetag/plugin/closetag.vim

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  
  autocmd bufwritepost .vimrc source $MYVIMRC
  
  au BufRead *.html,*.erb source ~/.vim/scripts/closetag.vim

  augroup END

  " the <CR> nohlsearch mapping needs to be fixed so that <CR> will execute
  " the current line in cmdwin
  augroup ECW_au
    au!
    au CmdwinEnter * nunmap <CR>
    au CmdwinLeave * nmap <CR> :nohlsearch<CR>/<BS>
  augroup END
else
  set autoindent
endif
  
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis

" \r := save the current file, chmod it +x, and run it
noremap \r :w<CR>:!chmod u+x %<CR>:!./%<CR>

" run make
map <buffer> \m :w<CR>:!make<CR>

" wrap when moving left or right
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Bind C-j to escape
inoremap <C-j> <ESC>
cnoremap <C-j> <ESC>
nnoremap <C-j> <ESC>
vnoremap <C-j> <ESC>

"" Just a few emacs bindings...
"vnoremap <C-A> <Home>
"vnoremap <C-E> <End>
"inoremap <C-A> <Home>
"inoremap <C-E> <End> " this messes with ending completion
"cnoremap <C-A> <Home>
"cnoremap <C-E> <End>
"" back one character
"cnoremap <C-B>         <Left>
"" delete character under cursor
"cnoremap <C-D>         <Del>
"" forward one character
"cnoremap <C-F>         <Right>

" Bindings for tabbed editing
"noremap <C-n> :tabnew<CR>
noremap <C-l> :tabnext<CR>
noremap <C-h> :tabNext<CR>

" Make tabs work how I like them: made of 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set formatoptions=lc
set lbr

set ruler

" correct my common typos
abbreviate teh the

" fonts and colors
colorscheme slate
silent! set gfn=Inconsolata:h14
silent! colorscheme customslate

" fold stuff
set fdo=hor,insert,search,undo,tag
set fdl=99

" sets w!! to sudo write
cmap w!! w !sudo tee % > /dev/null

set autoread

" open definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" open definition in new veritcal split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"set tags=tags;/
set tags=./.tags,./tags,tags

set wildmode=full
set wildmenu

set formatprg="par -w"
set grepprg="ack"

" set completion to show a preview window
set cot=menu,preview,menuone

" use blowfish encryption with :X
if v:version >= '703'
    set cm=blowfish
endif

" chordless saving, with a fix so that EasyMotion doesn't use the same mapping
let g:EasyMotion_mapping_w = '_w'
nnoremap <leader>w :w<cr>h 

" easier jumping between errors and opening error list window
" map <leader>cc :botright cope<cr> " there seem to be errors with the
" quickfix window
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Bubble single lines with control-arrows
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" map tag commands to be nicer
map <C-Right> <C-]>
map <C-Left> <C-T>

" toggle nu and relnu with control-K
function! g:ToggleNuMode()
    if (&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc
nnoremap <C-K> :call g:ToggleNuMode()<cr>

" mmm transparency
if has("gui_macvim")
    set transparency=3
    set guioptions-=T
endif

" don't unload buffers when they are abandoned; keep them open!
set hid

