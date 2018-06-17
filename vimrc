colorscheme molokai

syntax on

set nocompatible
set backspace=indent,eol,start
set textwidth=0
set number
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set undolevels=1000
set showmode
set hidden
set list
set listchars=tab:»\ ,trail:·,eol:$
set formatoptions=cnoqr
set smartcase
set ignorecase
set laststatus=2
set encoding=utf8
"set autoindent
set incsearch
set hlsearch
set complete=.,w,b,u,U,t,i,d
set showmatch
set t_Co=256

filetype plugin indent on
set fileencoding=utf8

set hidden

cabbr E NERDTree
cabbr ls BufExplorer

if has("vertsplit")
	set cmdwinheight=10
endif

if has("statusline")
	set statusline=%<%f\ %h%m%r%=\%03.3b\ -\ 0x\%02.2B\ -\ %-12.(%l,%c%V%)\ %p%%\ of\ %L\ -\ %Y\ %{&fenc}\ %{&fo}
endif

if has("gui_running")
	colorscheme desert
	set guioptions=ic
	set shell=/usr/bin/uxterm
	set shellcmdflag=-e
endif

if has("cmdline_info")
	set showcmd
	set ruler
endif

if has("cmdline_hist")
	set history=50
endif

if has("linebreak")
	set linebreak
	set sbr=+>\ 
	set showtabline=2
endif

if has("folding")
	set foldmethod=indent
	set foldnestmax=32
	set foldlevel=32
endif

if has("autocmd")
	augroup filetypedetect
	autocmd BufNewFile,BufRead *.js setlocal makeprg=jslint\ %
	augroup END
endif

if has("localmap")
	nmap <unique> <silent> <Leader>a :w %<CR> :!aspell -c %<CR> :e! %<CR>
	nmap <unique> <silent> <Leader>s :syn sync fromstart<CR>
	nmap <unique> <silent> <S-A-h> :execute TabMoveRW()<CR>
	nmap <unique> <silent> <S-A-l> :execute TabMoveFW()<CR>
	nmap <unique> <silent> <C-A-h> :tabprev<CR>
	nmap <unique> <silent> <C-A-l> :tabnext<CR>
	nmap <unique> <silent> <A-t> :tabnew<CR>
	nmap <unique> <silent> <A-w> :bd<CR>
	nmap <unique> <silent> <A-S-w> :close<CR>
	nmap <unique> <silent> <F5> :prev<CR>
	nmap <unique> <silent> <F6> :next<CR>
	nmap <unique> <silent> <Leader>f :FilesystemExplorer<CR>
	nmap <unique> <silent> <Leader>r :FilesystemExplorerFromHere<CR>
	nmap <unique> <silent> <Leader>b :buffers<CR>:buffer<Space>
	nmap <unique> <silent> <unique> <Leader>be :BufExplorer<CR>

	nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
	nmap _= :call Preserve("normal gg=G")<CR>

	nmap j gj
	nmap k gk

	"nmap <silent> <F5> :w<CR>:make<CR>:cw<CR>:copen<CR>
endif

function! Preserve(command)
	"Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")

	"Do the business:
	execute a:command

  "Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

filetype plugin on

command! -bar -nargs=* -complete=file SVN enew! | set ft=diff | read ! svn diff -r HEAD <args>
