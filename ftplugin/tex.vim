" au TextChanged *.tex w
inoremap <buffer> <C-CR> \\<CR>
inoremap <buffer> <C-S-P> \sec

" function! WrapBrack()
" 	call UltiSnips#ExpandSnippet()
" 	normal i#
" 	call UltiSnips#ExpandSnippet()
" 	return ''
" endfunction

" vnoremap <buffer><expr> <C-S-E> WrapBrack()
" vnoremap <buffer> <C-S-E> 	#	
" vnoremap <buffer> <C-S-E> :call UltiSnips#ExpandSnippet()#:call UltiSnips#ExpandSnippet()
