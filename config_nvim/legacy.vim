syntax on
set wildmenu
set showcmd

"set hlsearch
set ignorecase
set smartcase

set backspace=indent,eol,start
set autoindent
set shiftwidth=4
set tabstop=4

set ruler
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2

set nu rnu

set clipboard=unnamedplus
set wrap linebreak
set bri
set showbreak=›
set whichwrap+=<,>,h,l,[,]
set novisualbell

let g:lightline = {
		\ 'colorscheme': 'deus',
		\ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'gitbranch', 'readonly', 'path', 'modified' ] ]
		\ },
		\ 'component_function': {
		\   'gitbranch': 'FugitiveHead'
		\ },
		\ 'component': {
		\   'path': '%F'
		\ },
		\ 
		\ }

set termguicolors
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_italic=1

let mapleader=","
imap jk <Esc>

let g:python_recommended_style=0

" run shortcut, c++
autocmd FileType cpp nnoremap <buffer> <leader>m <Cmd>:w<CR>:bel sp<CR>:te cd /tmp && echo "%:p" && g++ -std=gnu++20 -DLOCAL -Wall -Wextra -O2 -Wshadow -Wfloat-equal -Wduplicated-cond -o x.out "%:p" && ./x.out<CR>i
autocmd FileType cpp nnoremap <buffer> <leader>k <Cmd>:w<CR>:vert sp<CR><C-w><Right>:te cd /tmp && echo "%:p" && g++ -std=gnu++20 -DLOCAL -Wall -Wextra -O2 -Wshadow -Wfloat-equal -Wduplicated-cond -o x.out "%:p" && ./x.out<CR>i

" run shortcut, shell script
autocmd FileType sh nnoremap <buffer> <leader>m <Cmd>:w<CR>:bel sp<CR>:te cd /tmp && echo "%:p" && cp "%:p" x.sh && chmod +x x.sh && ./x.sh <CR>i
autocmd FileType sh nnoremap <buffer> <leader>k <Cmd>:w<CR>:vert sp<CR><C-w><Right>:te cd /tmp && echo "%:p" && cp "%:p" x.sh && chmod +x x.sh && ./x.sh <CR>i

" run shortcut, python
autocmd FileType python nnoremap <buffer> <leader>m <Cmd>:w<CR>:bel sp<CR>:te python3 "%:p" <CR>i
autocmd FileType python nnoremap <buffer> <leader>k <Cmd>:w<CR>:vert sp<CR><C-w><Right>:te python3 "%:p" <CR>i

" other shortcuts
nnoremap <silent> <leader>fe <Cmd>:%y<CR>
nnoremap <silent> <leader>s <Cmd>:w<CR>
nnoremap <silent> <leader>c <Cmd>:q<CR>

set hidden&

imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" nmap <C-h> <Left>
" nmap <C-j> <Down>
" nmap <C-k> <Up>
" nmap <C-l> <Right>

nnoremap d "_d
vnoremap d "_d
noremap x "_x
nnoremap X "_X
nnoremap y "3y
vnoremap y "3y
nnoremap p "3p
nnoremap gp "3gp

" tab visualization
set list
set listchars=tab:▒░░
nnoremap <leader>inv <Cmd>:set invlist<CR>

function! Kt()
	let regs=split('0123456789', '\zs')
	for r in regs
		call setreg(r, [])
	endfor
endfunction
