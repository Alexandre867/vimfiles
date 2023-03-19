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
let g:python_recommended_style = 0	" To disable PEP8 recommanded settings (ft-python-plugin)

" From http://github.com/jeffkreeftmeijer/vim-numbertoggle: (For relative numbers only sometimes)
" and https://vi.stackexchange.com/questions/4120/how-to-enable-disable-an-augroup-on-the-fly
" and https://vi.stackexchange.com/questions/8674/how-to-save-and-restore-the-result-of-the-command-set
function! Toggle_numbertoggle()
	if !exists('#numbertoggle#BufEnter')
		let g:old_nu = &nu
		let g:old_rnu = &rnu
		let &nu = 1
		let &rnu = 1
		augroup numbertoggle
			autocmd!
			autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
			autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
		augroup END
	else
		augroup numbertoggle
			autocmd!
		augroup END
		let &nu = g:old_nu
		let &rnu = g:old_rnu
	endif
endfunction
call Toggle_numbertoggle()

set nojoinspaces			" Join command won't add two spaces after '.', '?' and '!'
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
au BufWinEnter * silent! loadview	" Autoload the previous view if saved with :mkview
set viewdir=~\vimfiles\view		" Specify the directory for view files
set history=1000				" Command history depth

" Creates a delview command to delete a view
" https://stackoverflow.com/questions/28384159/vim-how-to-remove-clear-views-created-by-mkview-from-inside-of-vim
" # Function to permanently delete views created by 'mkview'
function! MyDeleteView()
    let path = fnamemodify(bufname('%'),':~')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
	" Replace with actual ~ path
"     if empty($HOME)
"     else
"         let path = substitute(path, '^'.$HOME, '\~', '')
"     endif
    let path = substitute(path, '\\\|/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo "Deleted: ".path
endfunction

" # Command Delview (and it's abbreviation 'delview')
command Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>


inoremap jk <ESC>
noremap Y y$
" Bracket completion: https://stackoverflow.com/questions/21316727/automatic-closing-brackets-for-vim
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
" Put selection within brackets
" snoremap ( <Esc>`>i)<Esc>`<i(<Esc>
snoremap ( <c-g>:s/\%V.*\%V./(\0)<CR>gv<c-g>
xmap <leader>( <c-g>(<c-g>
snoremap [ <c-g>:s/\%V.*\%V./[\0]<CR>gv<c-g>
xmap <leader>[ <c-g>[<c-g>
snoremap { <c-g>:s/\%V.*\%V./{\0}<CR>gv<c-g>
xmap <leader>{ <c-g>{<c-g>
" Correct the spelling using CTRL-l in insert-mode
inoremap <C-l> <c-g>u<Esc>[s1z=gi<c-g>u
" For the movements in wrapped text: https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
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
noremap <End>  g<End>
noremap <Home> g<Home>
inoremap <End>  <C-O>g<End>
inoremap <Home> <C-O>g<Home>
" For moving lines, from https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <C-down> :m .+1<CR>==
nnoremap <C-up> :m .-2<CR>==
inoremap <C-down> <Esc>:m .+1<CR>==gi
inoremap <C-up> <Esc>:m .-2<CR>==gi
vnoremap <C-down> :m '>+1<CR>gv=gv
vnoremap <C-up> :m '<-2<CR>gv=gv
" For copy, cut and paste in visual mode using system clipboard
vnoremap <C-C> "+ygv
" vnoremap <C-X> "+d			" Already mapped on Windows and clashes with count downward; next line removes it
silent! vunmap <C-X>
" vnoremap <C-V> "+p			" Clashes with visual block
" Save using Ctrl-S in any mode
noremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <C-O>:w<CR>
" Undo using Ctrl-Z
inoremap <C-Z> <esc>ugi
noremap <C-Z> u
nnoremap <Leader><space> :nohlsearch<CR>
noremap <Leader>l :set list!<CR>
set listchars+=nbsp:~,multispace:···+,tab:-->
" Change the relativenumber option
" nnoremap <Leader>n :set relativenumber!<cr>		
nnoremap <Leader>n :call Toggle_numbertoggle()<cr>
" imap oe<tab> œ " Use C-K oe instead (see :dig)

" Twiddle case (UPPER CASE to lower case to Title Case)
" https://vim.fandom.com/wiki/Switching_case_of_characters#Twiddle_case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" https://www.reddit.com/r/vim/comments/i02w3v/code_commenting_without_plugins/
" Note: For commenting a block, better to use block mode, this only toggles each line (see :h v_b_I)
function! ToggleComment(comment_char)
	if getline(".") =~ "^" . a:comment_char
		execute ".s/^" . a:comment_char . " \\?//g"
	else
		execute ".s/^/" . a:comment_char . " /g"
	endif
endfunction
" Example use (to actually put in ftplugin/<filetype>.vim):
autocmd FileType vim nnoremap <buffer> <C-/> :call ToggleComment('"')<CR>
autocmd FileType vim vnoremap <buffer> <C-/> :g/^/call ToggleComment('"')<CR>gv

" ----- COLORSCHEME -----
" colorscheme elflord
colorscheme molokai			" Change the colorscheme
" Change the colors for 16 colors terminal (`echo &t_Co`)
if &t_Co > 15 && &t_Co < 256
	if has("spell")
		hi SpellBad                ctermbg=4
	endif
end


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
set virtualedit=onemore		" Allow to move to one character past the end

" Make VIM more convenient like a normal text editor
" set whichwrap+=<,>,h,l,[,]	" Allows cursor wrapping
set whichwrap+=<,>,[,]	" Allows cursor wrapping (but not with h and l)
set backspace=3 "indent,eol,nostop	" Allow backspace wrapping in editing
set keymodel=startsel,stopsel	" Shift-arrow will start visual/select mode
au InsertEnter * set selectmode=mouse,key	" Mouse and shift-arrow will start select mode instead of visual when started from Insert mode
au InsertLeave * set selectmode=			" Resets mouse and shift-arrow to start visual mode when note from Insert mode
set selection=exclusive						" Make selection of text more normal

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

	let g:vimtex_fold_enabled=1			" Allow automatic folding of the sections

	let g:vimtex_quickfix_ignore_filters=[
				\ 'Underfull',
				\ 'Unused global option(s)',
				\ 'Generic hook.\+is deprecated.',
				\]						" To ignore messages in quickfix
	
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

" Plug 'tpope/vim-fugitive'			" For Git controls from within vim

" Plug 'moll/vim-bbye'				" For buffer closing without window closing

" Plug 'simnalamburt/vim-mundo'			"For undo tree manipulations

Plug 'preservim/vim-markdown'		" For better markdown editing in Vim
	map <Plug> <Plug>Markdown_EditUrlUnderCursor

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" --------------------------------------------------------------------------------
