nnoremap <buffer> <C-/> :call ToggleComment('::')<CR>
vnoremap <buffer> <C-/> :g/^/call ToggleComment('::')<CR>gv
