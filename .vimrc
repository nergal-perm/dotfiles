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
Plug 'mileszs/ack.vim'
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
nnoremap <leader>tf :execute 'tabe '.JumpToAnchor()<cr>

" Multiline abbreviation to enter markdown frontmatter
iabbrev frmat ---
\<CR>id: 
\<CR>title:
\<CR>tags:
\<CR>private: false
\<CR>---
\<CR>

" Open quickfix entries in a new tab (or switch to existing one)
set switchbuf+=usetab,newtab

" ack.vim
" Use ripgrep for searching
" Options:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge SQL dumps
" --smart-case -> case-insensitive if all lowercase
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix window after pressing <enter> on a list item
let g:ack_autoclose = 1

" Any empty ack search will search the word under cursor
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>rs so we're ready to type search term
nnoremap <Leader>rs :Ack!<Space>

" Navigate Quickfix list easily
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
