" Vim configuration file
" By Alexandre Daigneault
" Updated: 20220922
" This is now tracked by git!!!
" (And by the undofile)
" Don't forget to update and commit with git!

" BASIC CONFIGURATION

" set pythonthreedll=C:\Users\Alex\.conda\envs\Python_vim\python36.dll
" set pythonthreehome=C:\ProgramData\Anaconda3
" set pythonthreedll=C:\ProgramData\Anaconda3\python3.dll
" set pythonthreehome="C:\Program Files\Python310"
" let pythonthreedll="C:\Program Files\Python310\python310.dll"
" set pythonthreehome="C:\Program Files\Python36\"
" set pythonthreedll="C:\Program Files\Python36\python36.dll"
" set pythonthreehome=c:\Users\Alex\Anaconda3\
" set pythonthreedll=c:\Users\Alex\Anaconda3\python39.dll

" :echo system('where python36.dll')

syntax on					" syntax highlighting

set gdefault				" flag g is default on (for :substitute)
set incsearch				" Show partial search results as you type
" set hlsearch				" Highlight all search results
set ignorecase				" Ignores the case for regex search
set smartcase				" Overrides ignorecase if upper case character
set number					" Show line number
set autoindent				" Autoindent
set nowrapscan				" Avoids scanning again from the top after reaching the end
" set showmatch				" Shows matching brackets during input
" let mapleader = "ù"		" Leader key is now "ù" (not working with utf-8)
" ENCODING: Might need to be commented out
set encoding=utf-8
" set encoding=ansi
" set spell spelllang=en_ca		" Spelling correct (in English)
" set spelllang+=fr
set spell spelllang=fr		" Spelling correct (in French)
set tabstop=4				" Set tab width to 4 spaces
set shiftwidth=4			" For proper (auto)indent width
set noexpandtab				" Tabs inserted as tabs
" For no adding missing end of line at end of file:
set nofixendofline
set undofile				" Activate saving of undofiles
set undodir=~\vimfiles\undo		" Specify the directory for undofiles
set viewdir=~\vimfiles\view		" Specify the directory for view files


inoremap jk <ESC>
map Y y$
" Bracket completion
inoremap " ""<left>
" inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
" Correct the spelling using CTRL-l in insert-mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
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
" Save using Ctrl-S in any mode
noremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <C-O>:w<CR>
" Undo using Ctrl-Z
inoremap <C-Z> <C-O>u
noremap <C-Z> u
nnoremap <Leader><space> :nohlsearch<CR>
noremap <Leader>l :set list!<CR>
imap oe<tab> œ

" https://www.reddit.com/r/vim/comments/i02w3v/code_commenting_without_plugins/
function! ToggleComment(comment_char)
	if getline(".") =~ "^" . a:comment_char
		execute ".s/^" . a:comment_char . " \\?//g"
	else
		execute ".s/^/" . a:comment_char . " /g"
	endif
endfunction
" Example use:
autocmd FileType vim nnoremap <buffer> gc :call ToggleComment('"')<CR>

" colorscheme elflord
colorscheme molokai			" Change the colorscheme

" Could be moved to gvimrc:
set guifont=Consolas:h10	" Set font to Consolas size 10
set guioptions-=T			" Removes toolbar
set guioptions-=t			" Removes tearoff menu entries
" set guioptions-=rL			" Removes scrollbars
set guioptions+=d			" Dark theme for GUI
highlight Normal guibg=#000000		" Sets black background

" Affects appearance
set splitright
set splitbelow
set linebreak
set display=lastline,uhex
set belloff+=backspace,cursor,esc
set visualbell
set completeopt=menuone,longest,noinsert	" Allows more convenient completion menu
set wildmenu				" Show completion menu
" set scrolloff=1			" keep at least 1 lines above/below
" set sidescrolloff=5		" keep at least 5 lines left/right

" Make VIM more convenient like a normal text editor
set whichwrap+=<,>,h,l,[,]	" Allows cursor wrapping
set backspace=3 "indent,eol,start,nostop	" Allow backspace wrapping in editing
set keymodel=startsel,stopsel	" Shift-arrow will start visual/select mode
au InsertEnter * set selectmode=mouse,key	" Mouse and shift-arrow will start select mode instead of visual when started from Insert mode
au InsertLeave * set selectmode=			" Resets mouse and shift-arrow to start visual mode when note from Insert mode

" https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping

" from sys import stdin
" for line in stdin:
" 	"".join([line[i-1] for i in range(len(line),0,-1)]) 

" --------------------------------------------------------------------------------

" Plugins: Run :PlugInstall to install them

call plug#begin()

Plug 'lervag/vimtex'		" For VimTeX
	let g:tex_flavor='latex'
	let g:vimtex_view_general_viewer = 'SumatraPDF'
	let g:vimtex_view_general_options
	    \ = '-reuse-instance -forward-search @tex @line @pdf'
	
	" https://github.com/lervag/vimtex/issues/1410#issuecomment-506143020
	" let g:vimtex_quickfix_mode=0
	" set conceallevel=2
	" let g:tex_conceal='abdmgs'
	" vimtex#imaps#add_map  map = {
	"     \ 'lhs' : lhs,
	"     \ 'rhs' : rhs,
	"     \ 'expr' : bool,
	"     \ 'leader' : leader_key,
	"     \ 'wrapper' : function_name,
	"     \ 'context' : value,
	"     \ }

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" --------------------------------------------------------------------------------
