" Plugins
call plug#begin('~/.config/nvim/plugged')

" A true colour dark colourscheme
Plug 'joshdick/onedark.vim'

" Quick fuzzy matched file opening
Plug 'ctrlpvim/ctrlp.vim'
" CtrlP-based symbol searching without ctags
Plug 'tacahiroy/ctrlp-funky'
" Fuzzy match Vim commands, like Atom/Sublime Command Palette
Plug 'fisadev/vim-ctrlp-cmdpalette'

" Prettier, more verbose, vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Show added/deleted/modifed symbols next to lines
Plug 'airblade/vim-gitgutter'
" Lots of git shortcuts
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'

" Lazy loading syntax support for squillions of languages
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
" Show git status next to files
Plug 'Xuyuanp/nerdtree-git-plugin'
" Set project root to whatever can be found up the FS tree
Plug 'airblade/vim-rooter'

" Mainly so that autoread triggers. So I know when changes to a
" file are made outside the editor.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Use the same keys to navigate tmux and vim panes
Plug 'christoomey/vim-tmux-navigator'

" Make vim keybindings behave more like a 'normal' editor
Plug 'tombh/novim-mode'

" Adds various icons like for filetypes, etc
Plug 'ryanoasis/vim-devicons'

" Add plugins to &runtimepath
call plug#end()

" Provide a variable that contains the current root as defined by the nearest
" .git folder.
let s:project_root_path = system("git rev-parse --show-toplevel | tr -d '\\n'")

" Theme
let g:airline#extensions#tabline#enabled = 1
set termguicolors

if (has("autocmd") && !has("gui_running"))
  let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
  autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
end
colorscheme onedark

" Don't show mode in command bar
set noshowmode

" Force powerline fonts
let g:airline_powerline_fonts = 1

" Neomake config
set switchbuf+=usetab
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
if findfile('.eslintrc', s:project_root_path) ==# '.eslintrc'
  let g:neomake_javascript_enabled_makers = ['eslint']
endif
if findfile('.jshintrc', s:project_root_path) ==# '.jshintrc'
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

" CTRL+j function finding
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1

" Highlight JSX in normal files
let g:jsx_ext_required = 0

" Prompt when the file changes on disk
au CursorHold * checktime

" Pane navigation with magic vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
let g:novim_mode_use_pane_controls = 0
inoremap <silent> <M-Left> <C-O>:TmuxNavigateLeft<CR>
nnoremap <silent> <M-Left> :TmuxNavigateLeft<CR>
inoremap <silent> <M-Down> <C-O>:TmuxNavigateDown<CR>
nnoremap <silent> <M-Down> :TmuxNavigateDown<CR>
inoremap <silent> <M-Up> <C-O>:TmuxNavigateUp<CR>
nnoremap <silent> <M-Up> :TmuxNavigateUp<CR>
inoremap <silent> <M-Right> <C-O>:TmuxNavigateRight<CR>
nnoremap <silent> <M-Right> :TmuxNavigateRight<CR>
snoremap <silent> <M-Right> <Esc><C-O>:TmuxNavigateRight<CR>
cnoremap <silent> <M-Right> <Esc><C-O>:TmuxNavigateRight<CR>
inoremap <silent> <C-W> <C-O>:call novim_mode#ClosePane()<CR>
snoremap <silent> <C-W> <C-O>:call novim_mode#ClosePane()<CR>
nnoremap <silent> <C-W> :call novim_mode#ClosePane()<CR>
set hidden

" Ensure CtrlP doesn't get overridden by autocomplete in insertmode
inoremap <C-P> <C-O>:CtrlP<CR>
" Shortcut for choosing between open files in buffer
inoremap <C-B> <C-O>:CtrlPBuffer<CR>
" Fuzzy find Vim commands, like atom/sublime CTRL+SHIFT+P
let g:ctrlp_cmdpalette_execute = 1
inoremap <A-p> <C-O>:CtrlPCmdPalette<CR>

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
let NERDTreeShowHidden = 1
" Close NERDTree if it's the last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Buffer actions
inoremap <silent> <C-PageUp> <C-O>:bp<CR>
inoremap <silent> <C-PageDown> <C-O>:bn<CR>

" Ripgrep
inoremap <M-f> <C-O>:Rg<Space>

" Tab settings ruby style
set tabstop=2 shiftwidth=2 expandtab

" Show whitespace
set list
set listchars=tab:»~,trail:·,extends:,precedes:
" Make the listchars only just slightly lighter than the background of OceanNext
highlight NonText guifg=#464646

" Highlight the current line that the cursor's on
set cursorline

" Alacritty doesn't seem to support the width and blink yet?
" Does htis even work?
set guicursor=a:ver15-blinkwait700-blinkoff400-blinkon250

" Allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l

" Highlight column 120
set colorcolumn=120

" Don't parse those Vim directives people put in files
set modelines=0

set nowrap
set sidescroll=1

" Case insensitive search, unless an uppercase char is used
set ignorecase smartcase

" Autocomplete popup window settings
" Choose the option with the longest match in common and preselect one from
" the menu.
set completeopt=longest,menuone
" <Enter> always selects the highlighed match
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Continue tabbing through sections of snippet once it's expanded
let g:UltiSnipsJumpForwardTrigger='<tab>'

" automatic reload .vimrc
augroup source_vimrc
  autocmd!
  autocmd! bufwritepost init.vim source %
augroup END
set autoread " Set to auto read when a file is changed from the outside
