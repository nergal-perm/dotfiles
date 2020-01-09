set background=dark
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'plasticboy/vim-markdown'
Plug 'dracula/vim'
Plug 'erichdongubler/vim-sublime-monokai'
call plug#end()

let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1
set conceallevel=0

" Auto setup when opening markdown files
augroup markdown
	autocmd!
	autocmd FileType markdown,mkd call SetUpMk()
augroup END

function! SetUpMk()
	colorscheme dracula
	set number relativenumber
	" Make obvious where 80 symbols border is
	set textwidth=80
	set colorcolumn=+1
endfunction

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
nnoremap <leader>tff :tabe<space>**/<c-R><c-W><c-z><cr>
nnoremap <leader>cr <c-c>bi<cr><c-c><s-a>

function! JumpToAnchor()
	let l:save_clipboard = &clipboard
	set clipboard= " Avoid clobbering the selection and clipboard registers.
	let l:save_reg = getreg('"')
	let l:save_regmode = getregtype('"')
	normal! yi[
	let l:text = @@ " Your text object contents are here.
	call setreg('"', l:save_reg, l:save_regmode)
	let &clipboard = l:save_clipboard
	let l:anchor = split(l:text, "-")[1]
	let l:file = system("find . -name ".split(l:text, "-")[0]."*.md")
	let l:result = "+/@" . l:anchor . " " . l:file
	return l:result
endfunction
nnoremap <leader>tfa :execute 'tabe '.JumpToAnchor()<cr>
