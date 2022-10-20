" au TextChanged *.tex w
" Put this in after/syntax/tex.vim
" https://github.com/lervag/vimtex/issues/2499
" call vimtex#syntax#core#new_region_math('nsflalign')
" call vimtex#syntax#core#new_region_math('nsflalign*')
" call vimtex#syntax#core#new_region_math('nsalign')
" call vimtex#syntax#core#new_region_math('nsalign*')
inoremap <buffer> <C-CR> \\<CR>
inoremap <buffer> <C-S-P> \sec
inoremap <buffer> <C-S-U> ^=UltiSnips#ExpandSnippet()
inoremap <buffer> <C-S-D> _=UltiSnips#ExpandSnippet()
inoremap <buffer> <C-S-Q> sq=UltiSnips#ExpandSnippet()
inoremap <buffer> <C-S-V> \overrightarrow{}<left>

" let g:ulti_expand_or_jump_res = 0 "default value, just set once
" function! Ulti_ExpandOrJump_and_getRes()
"   call UltiSnips#ExpandSnippetOrJump()
"   return g:ulti_expand_or_jump_res
" endfunction

" inoremap <NL> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":445<CR>

function! tex#vis_snip_trig(snip_trigger)
	exec "call UltiSnips#SaveLastVisualSelection()<cr>gvs" . snip_trigger . "<C-R>=UltiSnips#ExpandSnippet()<cr>"
endfunction

" Alternatively: select text then press <F7> to be prompted for a tex command
" Currently there is an issue when selecting text from insert mode with shift-arrow
vnoremap <buffer> <C-S-E> :call UltiSnips#SaveLastVisualSelection()gvs#=UltiSnips#ExpandSnippet()
" See https://vi.stackexchange.com/questions/38597/mapping-snippet-trigger-in-visual-mode
inoremap <buffer> <C-S-E> #=UltiSnips#ExpandSnippet()

inoremap <buffer> <S-CR> mk
vnoremap <silent> <buffer> <C-/> :g/^/call ToggleComment('%')<CR>gv
nnoremap <silent> <buffer> <C-/> :call ToggleComment('%')<CR>
inoremap <silent> <buffer> <C-/> <ESC>:call ToggleComment('%')<CR>gi
