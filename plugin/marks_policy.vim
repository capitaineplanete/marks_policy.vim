if exists('g:loaded_marks_policy') | finish | endif
let g:loaded_marks_policy = 1

let s:data_file = split(&runtimepath, ',')[0] . '/marks_locked'

function! s:Load()
    if filereadable(s:data_file)
        let g:locked_marks_files = filter(readfile(s:data_file), '!empty(v:val)')
    else
        let g:locked_marks_files = []
    endif
endfunction

function! s:Save()
    call writefile(g:locked_marks_files, s:data_file)
endfunction

function! s:IsLocked(path)
    return index(g:locked_marks_files, a:path) != -1
endfunction

function! s:ApplyPolicy()
    let l:path = expand('%:p')
    if empty(l:path) | return | endif
    silent! nunmap <buffer> m
    if s:IsLocked(l:path)
        nnoremap <buffer> m `
    else
        nnoremap <buffer> m m
    endif
endfunction

function! s:Toggle()
    let l:path = expand('%:p')
    if empty(l:path) | echo 'no file' | return | endif
    silent! nunmap <buffer> m
    if s:IsLocked(l:path)
        call remove(g:locked_marks_files, index(g:locked_marks_files, l:path))
        nnoremap <buffer> m m
        echo 'marks unlocked: ' . expand('%:t')
    else
        call add(g:locked_marks_files, l:path)
        nnoremap <buffer> m `
        echo 'marks locked: ' . expand('%:t')
    endif
    call s:Save()
endfunction

function! s:Status()
    let l:path = expand('%:p')
    if empty(l:path) | echo 'no file' | return | endif
    echo expand('%:t') . ': marks ' . (s:IsLocked(l:path) ? 'locked' : 'unlocked')
endfunction

call s:Load()

autocmd BufReadPost,BufNewFile * call s:ApplyPolicy()

nnoremap <leader>mt :call <SID>Toggle()<CR>
nnoremap <leader>ms :call <SID>Status()<CR>
