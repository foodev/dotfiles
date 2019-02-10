" Load plugins via pathogen.vim
execute pathogen#infect()

" Settings for gvim
if has('gui_running')
    " Hide menu and toolbar in gvim
    set guioptions-=m guioptions-=T

    " Set font family and size
    set guifont=Fantasque\ Sans\ Mono\ 19
endif

" Show line numbers
set number

" Enable syntax highlighting
syntax enable
set background=dark
colorscheme solarized

" Highlight current line
set cursorline

" Don't wrap lines
set nowrap

" Show vertical line at column 80
set colorcolumn=80

" Insert 4 whitespace characters when the tab key is pressed
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Copy the indentation from the previous line, when starting a new line
set autoindent

" Find search term while typing
set incsearch

" Status bar
function GitBranch()
    return ""
    return system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr --delete '\n'")
endfunction

set laststatus=2
set statusline=\ Line\ %l,\ Column\ %c%=%.20{GitBranch()}\ \ \ \ \ %{toupper(&fileencoding)}\ \ \ \ \ %{toupper(&fileformat)}\ \ \ \ \ %{&shiftwidth}\ \ \ \ \ %Y\ \ \ \ \ 

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
