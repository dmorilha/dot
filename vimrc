﻿if v:progname =~? "evim"
  finish
endif

colorscheme desert
syntax on

set nocompatible
set backspace=indent,eol,start
set textwidth=0
set number
set softtabstop=2
set shiftwidth=2
set tabstop=8
set expandtab
set undolevels=1000
set showmode
set pastetoggle=<F11>
"set list
set listchars=tab:»\ ,trail:·,eol:$
set formatoptions=cnoqr
set smartcase
set ignorecase
set laststatus=2
set encoding=utf8
set autoindent
set incsearch
set hlsearch
set complete=.,w,b,u,U,t,i,d
set showmatch
set backupdir=$HOME/tmp/.vim/bck
set dir=$HOME/tmp/.vim/swp
"filetype plugin indent on
"set fileencoding=utf8

if has("vertsplit")
  set cmdwinheight=10
endif

if has("statusline")
  set statusline=%<%f\ %h%m%r%=\ %-10.(%l,%c%V%)\ %P\ %{&fenc}\ %{&fo}
endif

if has("gui_running")
  "let moria_style='black'
  colorscheme zenburn
  set guioptions=ic
  set guifont=unifont\ 12
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
endif

if has("autocmd")
  augroup filetypedetect
    autocmd BufRead,BufNewFile *.yicf setfiletype yicf
    autocmd filetype tex syn match texRefZone '\\citeonline\%([tp]\*\=\)\=' nextgroup=texRefOption,texCite
    autocmd filetype tex syn match texRefZone '\\citeauthor\%([tp]\*\=\)\=' nextgroup=texRefOption,texCite
  
    autocmd filetype tex set spell
    autocmd filetype mail set spell tw=72 fo=noqrt
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
  nmap <unique> <silent> <Leader>t :NERDTreeToggle<CR>
  nmap <unique> <silent> <Leader>b :BufExplorer<CR>
  nmap <unique> <silent> <unique> <Leader>be :BufExplorer<CR>
endif

if has("windows") && v:version >= 700
  function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
      " select the highlighting
      if i + 1 == tabpagenr()
        let s .= '%#TabLineSel#'
      else
        let s .= '%#TabLine#'
      endif
  
      " set the tab page number (for mouse clicks)
      let s .= '%' . (i + 1) . 'T'
  
      " the label is made by MyTabLabel()
      let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor
  
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
  
    " right-align the label to close the current tab page
    "if tabpagenr('$') > 1 let s .= '%=%#TabLine#%999Xclose' endif
  
    return s
  endfunction
  
  function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let s = substitute((bufname(buflist[winnr - 1])), '.*/', '', '')
    if (empty(s))
      let s = '[No Name]'
    endif
    let s = s . ' ['. bufnr(buflist[winnr-1]) .']'
    return(s)
  endfunction

  set tabline=%!MyTabLine()

  function TabMoveFW()
    if (tabpagenr() == tabpagenr('$'))
      :execute "tabmove 0"
    else
      :execute "tabmove ". tabpagenr()
    endif
  endfunction
  
  function TabMoveRW()
    if (tabpagenr() < 2)
      :execute "tabmove"
    else
      :execute "tabmove ". (tabpagenr()-2)
    endif
  endfunction
endif

if has("printer")
  set printoptions=paper:A4,syntax:y,number:n,wrap:y
  set printfont=unifont\ 13
endif
