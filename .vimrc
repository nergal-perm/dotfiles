set background=dark
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'plasticboy/vim-markdown'
Plug 'dracula/vim'
call plug#end()

let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1
set conceallevel=0

" Goyo & Limelight setup
" let g:limelight_conceal_ctermfg = 240
" let g:goyo_linenr=1

" Auto run Goyo when opening markdown files
augroup markdown
	autocmd!
	autocmd FileType markdown,mkd call SetUpMk()
augroup END

function! SetUpMk()
	colorscheme dracula
"	if !exists('#goyo')
"		Goyo 85
"	endif
	set number relativenumber
	highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	match OverLength /\%81v.\+/
endfunction

function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
	Limelight
endfunction

function! s:goyo_leave()
	  " Quit Vim if this is the only remaining buffer
	  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	  endif
	  Limelight!
endfunction
		  
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Generic vim options
set nocompatible
syntax enable
filetype plugin on
set number relativenumber

set keymap=russian-jcukenwin

" Fuzzy file finder
set path+=**
set wildmenu
set wildignorecase

" Open and source .vimrc file
nnoremap <leader>ev :sp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Open personal_wiki file by ID under cursor in a new tab
set wildcharm=<c-z>
nnoremap <leader>tf :tabe<space>*<c-R><c-W><c-z><cr>
