let g:LatexBox_viewer = 'skim'
let g:LatexBox_latexmk_options = '-pvc' 

imap <silent> <buffer> ]]  <Plug>LatexCloseCurEnv
imap <silent> <buffer> <F5> <Plug>LatexChangeEnv
vmap <silent> <buffer> <F7> <Plug>LatexWrapSelection
vmap <silent> <buffer> <S-F7> <Plug>LatexEnvWrapSelection
imap <silent> <buffer> [[ \begin{

" these are fake text objects for 'latex paragraph'
" select one with vlp, indent one with gqlp
" TODO make it work with \[ and \]
vmap lp ?^$\\|\([^\\]\\|^\)%\\|^\s*\(\\begin\\|\\end\\|\\label\\|\\item\\|\\\(sub\)*section\)?1o//-1\|:<C-U>noh\|gv$
omap lp :normal Vlp

function! PushToDropbox(...)
    let dropboxpath=expand('~/Dropbox/Public/')
    let dropboxuid=177449

    :silent LatexmkClean
    if a:0 == 1
        execute 'let subdir="' . a:1 . '/"'
        execute '! mkdir -p ' . dropboxpath . subdir
    else
        let subdir=''
    endif

    execute 'let filename="' . subdir . expand('%:r') . '.tgz"'

    execute '!tar -czf ' . dropboxpath . filename . ' .'
    execute 'let @u = "\\url{dl.dropbox.com/u/' . dropboxuid . '/' . filename . '}"'
    echo 'url string copied to register u'
endfun

command! -nargs=? PushToDropbox call PushToDropbox(<f-args>)

setlocal spell
