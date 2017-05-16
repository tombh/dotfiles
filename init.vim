" Plugins
call plug#begin('~/.config/nvim/plugged')

" Make vim keybindings behave more like a 'normal' editor
Plug 'tombh/novim-mode'

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
"Plug 'roxma/nvim-completion-manager'

" Use tab for lots of things, mainly autocompleting
Plug 'ervandew/supertab'

" Ultisnips snippet engine.
Plug 'SirVer/ultisnips'
" Snippets are separate from the actual ultisnips engine
Plug 'honza/vim-snippets'

" Tree view of files
Plug 'scrooloose/nerdtree'
" Show git status next to files
Plug 'Xuyuanp/nerdtree-git-plugin'
" Set project root to whatever can be found up the FS tree
Plug 'airblade/vim-rooter'

" Mainly so that autoread triggers. So I know when changes to a
" file are made outside the editor.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Use the same keys to navigate tmux and vim panes
Plug 'christoomey/vim-tmux-navigator'

Plug '~/Workspace/nvim-plugin-installer'

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
autocmd BufWritePost * silent Neomake
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

" Default to opening files in a new tab when pressing ENTER
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

" Prompt when the file changes on disk
au CursorHold * checktime

" CTRL+l gives the vim command prompt
inoremap <C-L> <C-O>:

" Pane navigation with magic vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
inoremap <silent> <C-Left> <C-O>:TmuxNavigateLeft<CR>
nnoremap <silent> <C-Left> :TmuxNavigateLeft<CR>
inoremap <silent> <C-Down> <C-O>:TmuxNavigateDown<CR>
nnoremap <silent> <C-Down> :TmuxNavigateDown<CR>
inoremap <silent> <C-Up> <C-O>:TmuxNavigateUp<CR>
nnoremap <silent> <C-Up> :TmuxNavigateUp<CR>
inoremap <silent> <C-Right> <C-O>:TmuxNavigateRight<CR>
nnoremap <silent> <C-Right> :TmuxNavigateRight<CR>

" Ensure CtrlP doesn't get overridden by autocomplete in insertmode
inoremap <C-P> <C-O>:CtrlP<CR>
" Shortcut for choosing between open files in buffer
inoremap <C-B> <C-O>:CtrlPBuffer<CR>

" Always show tabs even if there is only one file open
set showtabline=2

" Shortcut for CtrlPFunky symbol lookup
inoremap <C-J> <C-O>:CtrlPFunky<CR>

" CTRL+_ (and CTRL+/ on my machine at least) toggles comments
inoremap <C-_> <C-O>:call NERDComment('n', 'toggle')<CR>
vnoremap <C-_> :call NERDComment('n', 'toggle')<CR><Esc>i

" CTRL+E to toggle the NERDTree
inoremap <silent> <C-E> <C-O>:NERDTreeToggle<CR>
nnoremap <silent> <C-E> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Close NERDTree if it's the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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

" automatic reload .vimrc
augroup source_vimrc
  autocmd!
  autocmd! bufwritepost .vimrc source %
  autocmd! bufwritepost init.vim source %
augroup END
set autoread " Set to auto read when a file is changed from the outside
