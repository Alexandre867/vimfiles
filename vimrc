" Vim configuration file
" By Alexandre Daigneault
" Updated: 20220901

" BASIC CONFIGURATION

syntax on			" syntax highlighting

set incsearch			" Show partial search results as you type
set hlsearch			" Highlight all search results
set number			" Show line number
let mapleader = "ù"		" Leader key is now "ù"

inoremap jk <ESC>
" For the movements in wrapped text
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <Up>   gk
noremap <Down> gj
noremap g<Up>   k
noremap g<Down> j
inoremap <Up>   <C-O>gk
inoremap <Down> <C-O>gj
" For copy, cut and paste in visual mode using system clipboard
vnoremap <C-C> "+ygv
vnoremap <C-X> "+d
vnoremap <C-V> "+p
nnoremap <Leader><space> :nohlsearch<CR>
noremap <Leader>l :set list!<CR>

" colorscheme elflord
colorscheme molokai		" Change the colorscheme

set gdefault			" flag g is default on (for :substitute)
set guifont=Consolas:h10	" Set font to Consolas size 10
set splitright
set splitbelow
set linebreak
set display=lastline,uhex
set guioptions-=T		" Removes toolbar
set whichwrap+=<,>,h,l,[,]	" Allows cursor wrapping
" set scrolloff=1		" keep at least 1 lines above/below
" set sidescrolloff=5		" keep at least 5 lines left/right
set backspace=3 "indent,eol,start,nostop	" Allow backspace wrapping in editing
set belloff+=backspace,cursor,esc
set keymodel=startsel,stopsel
set visualbell

" https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
