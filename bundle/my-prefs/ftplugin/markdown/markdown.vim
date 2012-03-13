set makeprg=mdown\ %\ \\\|bcat
nmap <leader>ll :silent make<CR>
function SaveHTML(...)
    if a:0 == 1
        execute '!mdown ' . @% . ' > ' . a:1
    else
        let filename=expand('%:r') . '.html'
        if filereadable(filename)
            " TODO ask if we want to overwrite it
            " TODO also add exclamation option
            echo "file already exists!"
        else
            execute '!mdown ' . @% . ' > ' . expand('%:r') . '.html'
        endif
    endif
endfun
command -nargs=? SaveHTML call SaveHTML(<f-args>)
