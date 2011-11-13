""" look for a bundles file (should be there!)
if filereadable(expand("~/.vim/bundles.vim"))
    source ~/.vim/bundles.vim
endif

""" Plugin-specific stuff

" To disable a plugin, add its bundle name to the following list
let g:pathogen_disabled = ['easygrep']

if v:version < '703' || !has('python')
    call add(g:pathogen_disabled, 'gundo')
endif

if !has('ruby')
    call add(g:pathogen_disabled, 'command-t')
endif

if has("gui_running")
    call add(g:pathogen_disabled, 'ShowMarks7')
endif

" plugin options
let g:syntastic_enable_signs=1
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
" nmap <silent> <Leader>o :CommandT<CR>
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
let g:showmarks_enable=0 " use \mt to toggle
let g:showmarks_textlower="\t"
let g:showmarks_textupper="\t"
let g:showmarks_textother="\t"
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>"
let g:LatexBox_latexmk_options = '-pvc'
nmap <leader>A :Ack!
nnoremap <silent> <leader>y :TagbarToggle<CR>
let g:LustyJugglerShowKeys = 'a'
let g:ctrlp_working_path_mode = 2
" let g:pad_dir='~/.notes/'

""" Now the general stuff!

if filereadable(expand("~/.vimrc_specific"))
    source ~/.vimrc_specific
endif

" all movement keys will move the the next line when at last character
set whichwrap=b,s,h,l,~,[,],<,>

" I'm a programmer.
if &t_Co > 2 || has("gui_running")
    syntax on
    set number
endif

" turn on hlsearch, but make it go away when I want
set hls
nmap <leader><space> :set nohlsearch<CR>/<BS>

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

" change pwd to mru file/buffer
set autochdir

" use hidden buffers
set hid

" use mouse
set mouse=a

" ignore some stuff. ctrlp didn't like ignoring .git though.
set wildignore+=*/.hg/*,*/.svn/*

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    augroup ctrlp
        au!
        au BufEnter * cal ctrlp#SetWorkingPath(2)
    augroup END

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

    augroup htmlTags
        au!
        autocmd FileType html let b:closetag_html_style=1
        autocmd FileType html source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
    augroup End

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
        au BufNewFile * silent! 0r ~/.vim/templates/%:e
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

" wrap when moving left or right
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Bind some stuff to escape
call arpeggio#load()
Arpeggio inoremap jk <ESC>

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
" colorscheme slate
" silent! colorscheme customslate
let g:solarized_visibility = "normal" 
let g:solarized_contrast = "high" 
set background=dark
colorscheme solarized

set list
set listchars=extends:»,tab:▸\ ,trail:›
" eol:¬,

" fold stuff
set fdo=hor,insert,search,undo,tag
set fdl=99
set fdm=manual

" sets w!! to sudo write
cmap w!! w !sudo tee % > /dev/null

" auto-read changed buffers from disk
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
nnoremap <leader>w :w<CR>

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
" vmode indent/dedent preserves selections
vnoremap <C-Right> >gv
vnoremap <C-Left> <gv

" map tag commands to be nicer
nmap <C-Right> <C-]>
nmap <C-Left> <C-T>

" toggle nu and relnu with control-K
function! g:ToggleNuMode()
    if (&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc
nnoremap <C-K> :call g:ToggleNuMode()<cr>
vnoremap <C-K> :call g:ToggleNuMode()<cr>

if has("gui_macvim")
    silent! set gfn=Inconsolata:h14
    " transparency
    " set transparency=3
    " don't show toolbar buttons
    set guioptions-=T
    " always show tab bar (so windows don't resize with just one tab open)
    set showtabline=2
endif

" in bash vi mode, a "v" in command mode starts a vim session that gets
" executed on leave. this makes sure syntax highlighting works there.
if expand('%:t') =~?'bash-fc-\d\+'
    setfiletype sh
endif

" status line
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

