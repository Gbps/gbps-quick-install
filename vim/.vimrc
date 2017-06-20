"enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1 

" soft tab stop on backspace
set softtabstop=4

" remember last location
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" :w!! writes out with sudo
cmap w!! %!sudo tee > /dev/null %

# F9 runs python script
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
