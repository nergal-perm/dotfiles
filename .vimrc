set background=dark
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'nergal-perm/vim-markdown'
Plug 'dracula/vim'
Plug 'erichdongubler/vim-sublime-monokai'
Plug 'trapd00r/vimpoint'
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
	let g:vim_markdown_auto_insert_bullets=0
	let g:vim_markdown_new_list_item_indent=2
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

function! JumpToAnchor()
	let l:save_clipboard = &clipboard
	set clipboard= " Avoid clobbering the selection and clipboard registers.
	let l:save_reg = getreg('"')
	let l:save_regmode = getregtype('"')
	normal! yi[
	let l:text = @@ " Your text object contents are here.
	call setreg('"', l:save_reg, l:save_regmode)
	let &clipboard = l:save_clipboard
	let l:split = split(l:text, ":")
	let l:file = system("find . -name ".l:split[0]."*.md")
	if len(l:split) == 2
		let l:anchor = l:split[1]
		let l:result = "+/@" . l:anchor . " " . l:file
	else 
		let l:result = l:file
	endif
	return l:result
endfunction
nnoremap <leader>tfa :execute 'tabe '.JumpToAnchor()<cr>

" Function to know any syntax element group

function! SynStack()
    if !exists("*synstack")
	    return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Multiline abbreviation to enter markdown frontmatter
iabbrev frmat ---
\<CR>id: 
\<CR>title:
\<CR>tags:
\<CR>private: false
\<CR>---

setglobal termencoding=utf-8 fileencodings=
scriptencoding utf-8
set encoding=utf-8

autocmd BufNewFile,BufRead  *   try
autocmd BufNewFile,BufRead  *       set encoding=utf-8
autocmd BufNewFile,BufRead  *   endtry
