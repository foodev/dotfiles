set nocompatible               " be iMproved
filetype off                   " required!

" activate vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" required!
Bundle 'gmarik/vundle'

" enable syntax highlighting
syntax on

" General
set t_Co=256
set encoding=utf-8
set number
set incsearch
set hlsearch
set cursorline
set title
set laststatus=2
set ruler
set hidden
set background=dark
filetype plugin indent on     " required!

" Bundles
"
" colorscheme
Bundle 'flazz/vim-colorschemes'
" colorscheme herald
" colorscheme molokai
colorscheme solarized
highlight CursorLine   cterm=none ctermbg=black ctermfg=none

Bundle 'kien/ctrlp.vim'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
" Bundle 'fholgado/minibufexpl.vim'
Bundle 'airblade/vim-gitgutter'

" bufferline
Bundle 'bling/vim-bufferline'
let g:bufferline_echo = 0

" statusline
Bundle 'bling/vim-airline'
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_symbols = get(g:, 'airline_symbols', {})
"let g:airline_symbols.space = "\ua0"

" NERDTree
Bundle 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

" keybinds
"
" get rid of Ex mode
nnoremap Q <nop>
" buffer next
nnoremap <silent> <F12> :bn<CR>
" buffer previous
nnoremap <silent> <S-F12> :bp<CR>
