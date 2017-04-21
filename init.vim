" Plugins
call plug#begin('~/.config/nvim/plugged')

" Quick fuzzy matched file opening
Plug 'ctrlpvim/ctrlp.vim'
" CtrlP-based symbol searching without ctags
Plug 'tacahiroy/ctrlp-funky'

" Prettier, more verbose, vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Dark vim colour theme
Plug 'mhartington/oceanic-next'

" Show added/deleted/modifed symbols next to lines
Plug 'airblade/vim-gitgutter'
" Lots of git shortcuts
Plug 'tpope/vim-fugitive'

" Lazy loading support for squillions of languages
Plug 'sheerun/vim-polyglot'

" Asynchronous linter
Plug 'neomake/neomake'

" Just some nice functions to comment code quickly
Plug 'scrooloose/nerdcommenter'

" Highlight bad whitespace in code
Plug 'ntpeters/vim-better-whitespace'

" Move the cursor to the last known place when openining a file
Plug 'dietsche/vim-lastplace'

" Autoformat code
Plug 'sbdchd/neoformat'

" :Rg command to search the whole project for string or pattern
Plug 'jremmen/vim-ripgrep'

" Asynchronous autocompletion, like deoplete, but not
Plug 'roxma/nvim-completion-manager'

" Use tab for lots of things, mainly autocompleting
Plug 'ervandew/supertab'

" Ultisnips snippet engine.
Plug 'SirVer/ultisnips'
" Snippets are separate from the actual ultisnips engine
Plug 'honza/vim-snippets'

" Tree view of files
Plug 'scrooloose/nerdtree'

" Mainly so that autoread triggers. So I know when changes to a
" file are made outside the editor.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Add plugins to &runtimepath
call plug#end()

" Theme
set termguicolors
colorscheme OceanicNext
let g:airline_theme = 'oceanicnext'
" Don't show mode in command bar
set noshowmode

" Force powerline fonts
let g:airline_powerline_fonts = 1

" Neomake config
set switchbuf+=usetab,newtab
autocmd BufWritePost,BufWinEnter * silent Neomake
let g:neomake_open_list=2
let g:neomake_list_height=5
let g:neomake_verbose=3

" Neomake language-specific config
" C++
let g:neomake_cpp_gcc_args = ['-Iinclude', '-fsyntax-only', '-Wall', '-Wextra']
let g:neomake_cpp_enabled_makers = ['gcc']
" JS
if executable('semistandard') == 1
  let g:neomake_javascript_enabled_makers = ['semistandard']
endif
if findfile('.eslintrc', '.;') ==# '.eslintrc'
  let g:neomake_javascript_enabled_makers = ['eslint']
endif
if findfile('.jshintrc', '.;') ==# '.jshintrc'
  let g:neomake_javascript_enabled_makers = ['jshint']
endif

" Don't show the autocompletion popup as you type
let g:cm_auto_popup = 0

" CtrlP setup

" Make use of ripgrep for file searching
" Searches for hidden files except `.git`
if executable("rg")
  let g:ctrlp_user_command = 'rg %s --files --hidden --glob "!.git" --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|vendor\|node_modules\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat\|\.bin\|\.o$'
  \ }

" Default to opening filess in a new tab when pressing ENTER
" To place the file in the currernt buffer use CTRL+B
let g:ctrlp_prompt_mappings = {
      \'AcceptSelection("e")': ['<c-b>'],
      \'AcceptSelection("t")': ['<cr>']
      \}
" Open new files in a tab
let g:ctrlp_open_new_file = 't'

" CTRL+J fucntion finding
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1

" Highlight JSX in normal files
let g:jsx_ext_required = 0

" Make sure insert mode is the default mode when opening/switching to files
au BufWinEnter * set insertmode

" Prompt when the file changes on disk
au CursorHold * checktime

" Copy and paste stuff
inoremap <S-Left> <Esc><Right>v<Left>
inoremap <S-Right> <Esc><Right>v<Right>
inoremap <S-Up> <Esc><Right>v<Up>
inoremap <S-Down> <Esc><Right>v<Down>
inoremap <C-V> <Esc>pi<Right>
vnoremap <C-C> y<Esc>i
vnoremap <C-X> d<Esc>i

" The `gv` returns you to the exact same selection, so you can repeat the
" command
vnoremap <Tab> ><Esc>gv
vnoremap <S-Tab> <<Esc>gv

" CTRL+q to exit pane/app
inoremap <C-Q> <C-O>:q<CR>

" CTRL+l gives the vim command prompt
inoremap <C-L> <C-O>:

" Pane navigation
inoremap <C-W> <C-O><C-W>

" Find
inoremap <C-F> <C-O>:noh<CR><C-O>/
inoremap <F3> <C-O>n

" Ensure CtrlP doesn't get overridden by autocomplete in insertmode
inoremap <C-P> <C-O>:CtrlP<CR>
" Shortcut for choosing between open files in buffer
inoremap <C-B> <C-O>:CtrlPBuffer<CR>

" Always show tabs even if there is only one file open
set showtabline=2

" Shortcut for CtrlPFunky symbol lookup
inoremap <C-J> <C-O>:CtrlPFunky<CR>

" Undo/redo
inoremap <C-U> <C-O>u
inoremap <C-R> <C-O><C-R>

" CTRL+s saves
inoremap <C-S> <C-O>:update<CR>

" CTRL+k deletes the current line
inoremap <C-K> <C-O>dd

" CTRL+d duplicates current line
inoremap <C-D> <C-O>yy<C-O>p

" Alt+/- moves the current line up and down
inoremap <M--> <C-O>:m -2<CR>
inoremap <M-=> <C-O>:m +1<CR>

" Home goes back to the first non-whitespace character of the line
inoremap <Home> <C-O>^

" CTRL+_ (and CTRL+/ on my machine at least) toggles comments
inoremap <C-_> <C-O>:call NERDComment('n', 'toggle')<CR>
vnoremap <C-_> :call NERDComment('n', 'toggle')<CR><Esc>i

" Tab actions
inoremap <M-Tab> <C-O>:tabnext<CR>
inoremap <M-Backspace> <C-O>:tabprevious<CR>

" Tab settings ruby style
set tabstop=2 shiftwidth=2 expandtab

" Show whitespace
set list
set listchars=tab:»~,trail:·,nbsp:*
" Make the listchars only just slightly lighter than the background of OceanNext
highlight SpecialKey guifg=#464646

" highlight the current line that the cursor's on
set cursorline

" Allow text to wrap in text files
au BufNewFile,BufRead *.txt,*.md,*.markdown setlocal linebreak spell
" Make arrow keys move through wrapped lines
au BufNewFile,BufRead *.txt,*.md,*.markdown inoremap <buffer> <Up> <C-O>gk
au BufNewFile,BufRead *.txt,*.md,*.markdown inoremap <buffer> <Down> <C-O>gj

" Existing useful commands
" * Indenting: <C-O> >> and <C-O> <<

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
"
