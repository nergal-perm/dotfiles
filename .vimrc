set background=dark
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'plasticboy/vim-markdown'
Plug 'dracula/vim'
call plug#end()

let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1
set conceallevel=0

augroup markdown
	autocmd!
	autocmd FileType markdown,mkd call SetUpMk()
augroup END

function! SetUpMk()
	colorscheme dracula
	if !exists('#goyo')
		Goyo
	endif
endfunction

function! s:goyo_enter()
	  let b:quitting = 0
	    let b:quitting_bang = 0
	      autocmd QuitPre <buffer> let b:quitting = 1
	        cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
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
	endfunction
		  
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
