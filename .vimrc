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
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'
call plug#end()

let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1
set conceallevel=0

let g:mapleader=" "

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
set tags+=./tags;,tags
set hlsearch

" Fuzzy file finder
set path+=**
set wildmenu
set wildignorecase

" Open and source .vimrc file
nnoremap <leader>ev :sp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Navigate through buffers
nnoremap gr :ls<CR>:b!<Space>
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>

" Multiline abbreviation to enter markdown frontmatter
iabbrev frmat ---
\<CR>id: 
\<CR>title:
\<CR>tags:
\<CR>private: false
\<CR>---
\<CR>

" Open quickfix entries in a new tab (or switch to existing one)
set switchbuf=useopen

" ack.vim
" Use ripgrep for searching
" Options:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge SQL dumps
" --smart-case -> case-insensitive if all lowercase
let g:ackprg = 'rg  --context=2 --vimgrep --type-not sql --smart-case'

" Do not close the Quickfix window after pressing <enter> on a list item
let g:ack_autoclose = 0

" Any empty ack search will search the word under cursor
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>rs so we're ready to type search term
nnoremap <Leader>sr :Ack!<Space>
nnoremap <Leader>sl :Ack!<Space>\\[\\[<c-r><c-w><CR>

" Navigate Quickfix list easily
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Insert yanked note ID
nnoremap <Leader>il i[[<c-o><s-p>]]
