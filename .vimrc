" Load plugins via pathogen.vim
execute pathogen#infect()

" Settings for gvim
if has('gui_running')
    " Hide toolbar in gvim
    set guioptions-=T

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

" Status bar
function GitBranch()
    return ""
    return system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr --delete '\n'")
endfunction

set laststatus=2
set statusline=\ Line\ %l,\ Column\ %c%=%.20{GitBranch()}\ \ \ \ \ %{toupper(&fileencoding)}\ \ \ \ \ %{toupper(&fileformat)}\ \ \ \ \ %{&shiftwidth}\ \ \ \ \ %Y\ \ \ \ \ 
