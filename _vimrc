au GUIEnter * simalt ~x 

"set nocompatible " esquece compatibilidade com vi antigo
filetype on
filetype plugin on
filetype indent on
syntax on " colore
set hidden " discart hidden buffer, next buffer funciona melhor
set lazyredraw " ??
set showmode " ??
set wildmenu

set ts=3 sts=3 sw=3 noexpandtab " tabsize
set smarttab " tabs para novas linhas
set smartindent
set autoindent

set virtualedit=all
set cpoptions+=$ " $ indicando o fim do que esta sendo midficando...
set nu " numero da linha
set hlsearch " destaca o que se buscou
set incsearch " vai buscando mesmo antes do enter

set foldmethod=manual

set backspace=eol,start,indent

set ignorecase
set smartcase " case-sensitive if search contains an uppercase character
set wildignore=*~

" let NERDTreeShowHidden

set guifont=Lucida\ Console
colorscheme navajo-night     
set list
set listchars=tab:-\ ,eol:¬
"set listchars=trail:·,precedes:«,extends:»,eol:?,tab:?\   
highlight NonText guifg=#5d758c
highlight SpecialKey guifg=#5d758c
" infelizmente fui obrigado a colocar estas linhas no navajo-night também

function! <SID>StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	%s/$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

nnoremap <silent> <F1> :call <SID>StripTrailingWhitespaces()<CR>
imap <silent> <c-space> <esc>
nmap <Space> :
nmap <silent> <Tab> :bn<cr>
nmap <silent> <S-Tab> :bp<cr>
nmap <silent> <C-l> <C-w>l
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-h> <C-w>h
nmap ç ^

" moving
imap <c-h> <c-o>h
imap <c-j> <c-o>j
imap <c-k> <c-o>k
imap <c-l> <c-o>l

" novas linhas
" imap <s-space> <c-o>$<cr>
imap <c-cr> <c-o>$<cr>
imap <s-cr> <c-o>O
" apagando
" imap <c-u> <bs>
" imap <a-u> <del>

" Surrounding
imap '' ''<c-o>h
imap {} {}<c-o>h
imap "" ""<c-o>h
imap ""; ;<c-o>h""
imap ''; ;<c-o>h''

" clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>
nmap <silent> ,n :NERDTreeToggle<cr>

" scape xml chars in jsp
nmap ,$ :%s/${\([^}]*\)}/<c:out value="${\1}"/>/gc<cr>

command ReloadAllSnippets :call ReloadAllSnippets()<cr>

""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar

function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile'
        " Buffer is marked as not a file
        return 0
    endif
    if empty(glob(expand('%:p')))
        " File does not exist on disk
        return 0
    endif
    if len($TEMP) && expand('%:p:h') == $TEMP
        " We're in a temp dir
        return 0
    endif
    if len($TMP) && expand('%:p:h') == $TMP
        " Also in temp dir
        return 0
    endif
    return 1
endfunction
augroup vimrcAutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePost,BufLeave,WinLeave ?* if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent loadview | endif
augroup end


let s:sparkup = "C:\Python27\python "
