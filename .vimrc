syntax on
  
set noerrorbells "This removes vim's default error bell, turning it off so that it doesn't annoy us 
set textwidth=100 "Ensures that each line is not longer than 100 columns 
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent 
set linebreak 
set number
set showmatch 
set showbreak=+++
set smartcase
set noswapfile 
set undodir=~/.vim/undodir
set undofile
set incsearch 
set spell 
set showmatch 
set confirm 
set ruler 
set autochdir 
set autowriteall 
set undolevels=1000
set backspace=indent,eol,start 

" The next two settings ensure that line breaks and wrap work how writers, not
" coders, prefer it

set wrap
nnoremap <F5> :set linebreak<CR>
nnoremap <C-F5> :set nolinebreak<CR>

