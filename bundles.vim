" vi? This is VIMMMMMMMMMMMMMM
set nocompatible

""" Vundle stuff
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
" NOTE: Tim Pope is my hero
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-vividchalk'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-afterimage'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'kana/vim-arpeggio'
Bundle 'mileszs/ack.vim'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/pep8'
Bundle 'alfredodeza/pytest.vim'
Bundle 'sontek/rope-vim'
Bundle 'scrooloose/syntastic'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'edsono/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kchmck/vim-coffee-script'
Bundle 'majutsushi/tagbar'
Bundle 'docunext/closetag.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'spiiph/vim-space'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wgibbs/vim-irblack'
Bundle 'ervandew/screen'
Bundle 'godlygeek/tabular'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'fmoralesc/vim-pad'
" Bundle 'ivanov/vim-ipython'
"
" NOTE: for command-T, must cd bundle/Command-T/ && rake make (make sure correct rake version)
" removed in favor of ctrlp
" Bundle 'wincent/Command-T'

" vim-scripts repos
Bundle 'The-NERD-tree'
Bundle 'UltiSnips'
Bundle 'LaTeX-Box'
Bundle 'ShowMarks7'
Bundle 'bufkill.vim'
Bundle 'LustyJuggler'
Bundle 'current-func-info.vim'
Bundle 'bufkill.vim'
Bundle 'pyrex.vim'

filetype plugin indent on
