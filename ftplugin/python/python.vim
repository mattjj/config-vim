set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let python_highlight_all = 1
set softtabstop=4

" with smartindent, need this to fix comment indenting, but filetype
" indent on is much better
if &smartindent
    inoremap <buffer> # X#
endif

" Wrap at 80 chars for comments.
set formatoptions=cq textwidth=80 foldignore= wildignore+=*.py[co]

"au BufWritePost <buffer> silent! !ctags -R -f %:p:h/.tags & 
"if filereadable(expand("$HOME/.vim/tags/pythonlib.ctags"))
"    set tags+=$HOME/.vim/tags/pythonlib.ctags
"endif

" experimental: may suck, may do nothing
let b:Tlist_Process_File_Always = 0

" `gf` jumps to the filename under the cursor.  Point at an import statement
" and jump to it!
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

"let g:pylint_onwrite = 0 
"compiler pylint
"
"" makes pyflakes not use quickfix, decent fix for using both pylint and
"" pyflakes for now: pylint gets quickfix window to itself and only gets run
"" when called, while pyflakes does highlighting.
"let g:pyflakes_use_quickfix = 0 
"
"nmap <buffer> <Leader>l :Pylint<CR> :copen <CR>
"set grepprg=grep\ -n

nmap <buffer> <Leader>d :grep TODO %<CR> :copen <CR>

" i want this to disable the syntastic python checking, since i use
" pyflakes.vim for that separately (it has nicer highlighting and stuff)
let loaded_python_syntax_checker = 1

