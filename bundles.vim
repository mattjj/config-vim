" vi? This is VIMMMMMMMMMMMMMM
set nocompatible

""" Vundle plugin management
" to set up vundle the first time: 
" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" git repos
Bundle 'alfredodeza/pytest.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'docunext/closetag.vim'
Bundle 'edsono/vim-matchit'
Bundle 'ervandew/screen'
Bundle 'ervandew/supertab'
Bundle 'fmoralesc/vim-pad'
Bundle 'fs111/pydoc.vim'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-arpeggio'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'majutsushi/tagbar'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mileszs/ack.vim'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
Bundle 'sontek/rope-vim'
Bundle 'spiiph/vim-space'
" NOTE: Tim Pope is my hero
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-afterimage'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/pep8'
Bundle 'wgibbs/vim-irblack'
" Bundle 'ivanov/vim-ipython'

" vim-scripts repos
Bundle 'bufkill.vim'
Bundle 'bufkill.vim'
Bundle 'current-func-info.vim'
Bundle 'LaTeX-Box'
Bundle 'LustyJuggler'
Bundle 'pyrex.vim'
Bundle 'The-NERD-tree'
Bundle 'UltiSnips'

" my bundles
" keeping vim-prefs as a separate bundle is needed until vundle works out its
" Bundle! command
Bundle 'ssh://173.255.229.4/srv/git/matts-vim-prefs.git'

" conditional bundles
if !has("gui_running")
    Bundle 'ShowMarks7'
endif
if 0 && v:version >= '703' && has('python')
    Bundle 'sjl/gundo.vim'
endif

filetype plugin indent on
