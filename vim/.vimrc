" enable syntax highlighting
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

" F9 key executes python in new buffer
nnoremap <buffer> <F9> :exec '!clear; python' shellescape(@%, 1)<cr>

" Adds cursor line to current window
hi CursorLine   cterm=NONE ctermbg=8 ctermfg=NONE
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Adds mouse support
set mouse=a

" Maximum line width and warning
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python syntax highlighting, format-checking
Plug 'python-mode/python-mode'

" Prevents the annoying red line
let g:pymode_options_colorcolumn = 0

" Prevents Jedi problems
let g:pymode_rope_complete_on_dot = 0

" Disable automatic folding
set nofoldenable

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Simple, colorful statusline
Plug 'itchyny/lightline.vim'

" Enables status bar always and disables the command bar from showing the mode
set laststatus=2
set noshowmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easy commenting... 'gc' comments out highlighted lines, 'gcc' comments out
" selected line in just about any language

Plug 'tomtom/tcomment_vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Python autocomplete and docstrings

Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'

" Enables supertab to tab complete after dot
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0

" Prevents Jedi docstring
autocmd FileType python setlocal completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ARM syntax highlighting
Plug 'ARM9/arm-syntax-vim'

" Use @ vim:ft=armv5 to set the format
" Enable modelines to declare ARM format
set modeline
set modelines=5
""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#end()
