" Plugins
call plug#begin('~/.vim/plugged')

  " Quick fuzzy matched file opening
  Plug 'ctrlpvim/ctrlp.vim'

  " Prettier, more verbose, vim status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Dark vim colour theme
  Plug 'mhartington/oceanic-next'

  " Show added/deleted/modifed symbols next to lines
  Plug 'airblade/vim-gitgutter'
  " Lots of git shortcuts
  Plug 'tpope/vim-fugitive'

  " Comprehensive lint highlighter
  Plug 'scrooloose/syntastic'
  " Just some nice functions to comment code quickly

  Plug 'scrooloose/nerdcommenter'

  " Highlight bad whitespace in code
  Plug 'ntpeters/vim-better-whitespace'

  " Move the cursor to the last known place when openining a file
  Plug 'dietsche/vim-lastplace'

" Add plugins to &runtimepath
call plug#end()

" Theme
set background=dark
let g:airline_theme='oceanicnext'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme OceanicNext

" Force powerline fonts
let g:airline_powerline_fonts=1

" Recommended defaults
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 2

" CTRL+N in spell mode will autocomplete the word
set complete+=kspell

" Make sure insert mode is the default mode when opening/switching to files
au BufWinEnter * set insertmode

" CTRL+q to exit pane/app
inoremap <C-Q> <C-O>:q<CR>

" CTRL+l gives the vim command prompt
inoremap <C-L> <C-O>:

" Pane navigation
inoremap <C-W> <C-O><C-W>

" Find
inoremap <C-F> <C-O>/
inoremap <Esc> <C-O>:noh<CR>

" Ensure CtrlP doesn't get overridden by autocomplete in insertmode
inoremap <C-P> <C-O>:CtrlP<CR>

" Better spelling suggestions shortcut
inoremap <C-G> <C-X>s

" Undo/redo
inoremap <C-U> <C-O>u
inoremap <C-R> <C-O><C-R>

" CTRL+s saves
inoremap <C-S> <C-O>:update<CR>

" CTRL+k deletes the current line
inoremap <C-K> <C-O>dd

" CTRL+d duplicates current line
inoremap <C-D> <C-O>yy<C-O>p

" Make arrow keys move through wrapped lines
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Alt+up/down moves the current line
inoremap <Esc><Down> <C-O>:m +1<CR>
inoremap <Esc><Up> <C-O>:m -2<CR>

" Home goes back to the first non-whitespace character of the line
inoremap <Home> <C-O>^

" CTRL+_ (and CTRL+/ on my machine at least) toggles comments
inoremap <C-_> <C-O>:call NERDComment('n', 'toggle')<CR>

" Tab settings ruby style
set tabstop=2 shiftwidth=2 expandtab

" Show whitespace
:set list 
:set listchars=tab:>>,trail:·,nbsp:*

" Allow text to wrap in text files
au BufNewFile,BufRead *.txt,*.md,*.markdown setlocal linebreak spell

" Existing useful commands
" * Indenting: <C-O> >> and <C-O> <<
" * Copy/paste: <C-O>v then arrow keys to select, then y/d to copy/cut and <C-O>p to paste

" automatic reload .vimrc
augroup source_vimrc
  autocmd!
  autocmd! bufwritepost .vimrc source %
  autocmd! bufwritepost init.vim source %
augroup END
set autoread " Set to auto read when a file is changed from the outside

" TODO:
" * Scroll 1 wrapped soft line at a time rather an entire block of wrapped
"   lines
