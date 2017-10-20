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
nnoremap <buffer> <F9> :exec '!clear; python3' shellescape(@%, 1)<cr>

" F10 key runs 'make run'
nnoremap <buffer> <F8> :exec '!clear; make run'<cr>

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


" Set leader character to ;
let mapleader = ";"

" Open vsplits to the right of the current window
" Open splits below the current window
set splitright
set splitbelow

" Navigate between windows with control + arrow key
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Create a split using control + shift + arrow key
nnoremap <silent> <C-S-Down> :set splitbelow<CR>:split<CR>
nnoremap <silent> <C-S-Up> :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
nnoremap <silent> <C-S-Left> :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nnoremap <silent> <C-S-Right> :set splitright<CR>:vsplit<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Python syntax highlighting, format-checking
" Plug 'python-mode/python-mode'
"
" " Prevents the annoying red line from PEP
" let g:pymode_options_colorcolumn = 0
"
" " Disable automatic folding
" set nofoldenable

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

" !!! BROKEN !!!
" Python autocomplete and docstrings

"Plug 'davidhalter/jedi-vim'
"Plug 'ervandew/supertab'

" Enables supertab to tab complete after dot
"let g:SuperTabDefaultCompletionType = "context"
"let g:jedi#popup_on_dot = 0

" Prevents Jedi docstring
"autocmd FileType python setlocal completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ARM syntax highlighting
Plug 'ARM9/arm-syntax-vim'

" Use @ vim:ft=armv5 to set the format
" Enable modelines to declare ARM format
set modeline
set modelines=5
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme plugin (lots of choices!)
Plug 'flazz/vim-colorschemes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fuzzy file finder!
" Use ';;' to switch between buffers
" Use ';t' to find files to open
" Use ';r' to find tags (ctags)

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


nmap <Leader>; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Comment'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Constant'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Comment'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Normal'] }

" Use existing buffer if available
let g:fzf_buffers_jump = 1

" Command to generate tags
" let g:fzf_tags_command = 'ctags -R'


""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()

" Defaulting to Monokai (Sublime color scheme)
colorscheme Monokai
