" Load plugins via pathogen.vim
execute pathogen#infect()

" Settings for gvim
if has('gui_running')
    " Hide menu and toolbar in gvim
    set guioptions-=m guioptions-=T

    " Set font family and size
    set guifont=Fantasque\ Sans\ Mono\ 19

    " Tab bar
    set guitablabel=%t\ %m

    " Switch between tabs by pressing <Alt> + [1-9]
    noremap <A-1> 1gt
    noremap <A-2> 2gt
    noremap <A-3> 3gt
    noremap <A-4> 4gt
    noremap <A-5> 5gt
    noremap <A-6> 6gt
    noremap <A-7> 7gt
    noremap <A-8> 8gt
    noremap <A-9> :tablast<Enter>
endif

" Enable mouse support for terminals
set mouse=a

" List files with builtin filebrowser as tree and without banner
let g:netrw_liststyle=3
let g:netrw_banner=0

" Show line numbers
set number

" Enable syntax highlighting
syntax enable
set background=dark " Use "light" for light theme
colorscheme solarized

" Highlight current line
set cursorline

" Don't wrap lines
set nowrap

" Show vertical line at column 80
set colorcolumn=80

" Insert 4 whitespace characters when the tab key is pressed
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Copy the indentation from the previous line, when starting a new line
set autoindent

" Fold code based on indentation
set foldmethod=indent foldminlines=0

" Find search term while typing
set incsearch

" Show the current command in the bottom right corner
set showcmd

" Status bar
set laststatus=2
set statusline=\ Line\ %l,\ Column\ %c%=%{toupper(&fileencoding)}\ \ \ \ \ %{toupper(&fileformat)}\ \ \ \ \ %{&shiftwidth}\ \ \ \ \ %Y\ \ \ \ \ 

" Tab bar
set showtabline=2

" Display CtrlP dropdown at the top of the window
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

" Open new tab with <Ctrl> + n
noremap <C-n> :tabnew<Enter>

" Close tab with <Ctrl> + w
noremap <C-w> :tabclose<Enter>

" Got to function/method definition in file with <Ctrl> + r
noremap <C-r> :CtrlPBufTag<Enter>

" Custom mapping for multiple cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
