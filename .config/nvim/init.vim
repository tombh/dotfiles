if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

" A true colour dark colourscheme
Plug 'joshdick/onedark.vim'

" Follow the rules set in a project's `.editorconfig`
Plug 'editorconfig/editorconfig-vim'

" Show buffers in tabs along the top
Plug 'ap/vim-buftabline'
" Prettier, more verbose, vim status line
Plug 'itchyny/lightline.vim'

" Lots of git shortcuts
Plug 'tpope/vim-fugitive'

" Open files in Github
Plug 'tpope/vim-rhubarb'

" Lazy loading syntax support for squillions of languages
Plug 'sheerun/vim-polyglot'

" Just some nice functions to comment code quickly
Plug 'scrooloose/nerdcommenter'

" Highlight bad whitespace in code
Plug 'ntpeters/vim-better-whitespace'

" Move the cursor to the last known place when openining a file
Plug 'dietsche/vim-lastplace'

" Autoformat code
Plug 'chiel92/vim-autoformat'

" Autocompletion and Language Server manager
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'amiralies/coc-elixir', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}

Plug 'mattn/emmet-vim'

" Autoclose brackets if/end, etc
Plug 'cohama/lexima.vim'

" Comprehensive snippet collection
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

" Golang
Plug 'fatih/vim-go', { 'do': ':silent GoUpdateBinaries' }

" Minimap sugar
Plug 'wfxr/minimap.vim'

" Add plugins to &runtimepath
call plug#end()

" Theme
set termguicolors

if (has("autocmd") && !has("gui_running"))
  let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
  autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
end
colorscheme onedark

" Stops SQL files triggering autocomplete errors
let g:omni_sql_no_default_maps = 1
let g:loaded_sql_completion = 0

" Show the '+' next to modified buffers
let g:buftabline_indicators=1
" Use the PmenuSel colour to highlight the active buffer tab
hi default link BufTabLineCurrent PmenuSel

" Don't show mode in command bar
set noshowmode

set noswapfile
set backupcopy=yes

" START OF COC
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:user_emmet_mode='a'
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,eruby,less EmmetInstall

" Remap keys for gotos
inoremap <silent> <M-i> <C-O>:execute "normal \<Plug>(coc-implementation)"<CR>
inoremap <silent> <M-r> <C-O>:execute "normal \<Plug>(coc-references)"<CR>
inoremap <silent> <M-h> <C-O>:execute "normal \<Plug>(coc-rename)"<CR>
inoremap <silent> <M-e> <C-O>:call CocActionAsync('diagnosticInfo')<CR>
" Use Alt-k to show documentation in preview window
inoremap <silent> <M-d> <C-O>:call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"autocmd CursorHoldI * call CocActionAsync('diagnosticInfo')
"autocmd CursorHoldI * call s:Autocmd('CursorHold', +expand('<abuf>'))

hi CocErrorHighlight guibg=#3f0e0e
hi CocWarningHighlight guibg=#3a3f0e
hi CocInfoHighlight guibg=#15165b
hi CocHintHighlight guibg=#0e3f0f

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [[ 'lineinfo' ], [ 'percent' ]]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" END OF COC
""""""""""""""""""""""""

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Surround highlighted string with character
snoremap ( <S-LEFT><ESC>`>a)<ESC>`<i(
snoremap [ <S-LEFT><ESC>`>a]<(ESC)>`<i[
snoremap { <S-LEFT><ESC>`>a}<ESC>`<i{
snoremap " <S-LEFT><ESC>`>a"<ESC>`<i"
snoremap ' <S-LEFT><ESC>`>a'<ESC>`<i'
snoremap ` <S-LEFT><ESC>`>a`<ESC>`<i`
snoremap < <S-LEFT><ESC>`>a><ESC>`<i<

" Autoformat certain file types
"let g:formatters_javascript = ['prettier']
let g:formatdef_mix_format = '"/home/tombh/.asdf/shims/mix format -"'
"autocmd BufWritePre *.sql Autoformat
autocmd BufWritePre *.go Autoformat
"autocmd BufWritePre *.js Autoformat
"autocmd BufWritePre *.ts Autoformat
autocmd BufWritePre *.json Autoformat
autocmd BufWritePre *.exs,*.ex Autoformat
autocmd BufWritePre *.css Autoformat
autocmd BufWritePre *.scss Autoformat
autocmd BufWritePre *.rb Autoformat
autocmd BufWritePre *.py Autoformat
autocmd BufWritePre *.rs Autoformat

" Prompt when the file changes on disk
" Not sure this even works in nvim
autocmd CursorHoldI,CursorHold * checktime
" Useful when git has commited and you focus back to a pane
autocmd User CursorHoldI * CocGitStatusChange

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

" Quickly fuzzy find files
inoremap <C-P> <C-O>:CocList files<CR>
nnoremap <C-P> :CocList files<CR>
" Shortcut for choosing between open files in buffer
inoremap <C-B> <C-O>:CocList buffers<CR>
" Fuzzy find Vim commands, like atom/sublime CTRL+SHIFT+P
inoremap <A-p> <C-O>:CocList vimcommands<CR>
nnoremap <A-p> :CocList vimcommands<CR>
" Instantly reopen previous list in same state
inoremap <A-l> <C-O>:CocListResume<CR>
nnoremap <A-l> :CocListResume<CR>
" Open the traditional vim quickfix list pane
inoremap <A-q> <C-O>:CocList quickfix<CR>

" Shortcuts for finding things
let g:novim_mode_use_finding = 0
inoremap <C-f> <C-O>:CocList words<CR>
nnoremap <C-f> :CocList words<CR>
inoremap <A-f> <C-O>:CocList grep<CR>
inoremap <silent> <A-F> <C-O>:exe 'CocList -I --normal --input='.expand('<cword>').' grep'<CR>
" Fuzzy find symbol in current buffer
inoremap <C-J> <C-O>:CocList outline<CR>

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

" Buffer navigation
inoremap <silent> <C-PageUp> <C-O>:bp<CR>
nnoremap <silent> <C-PageUp> :bp<CR>
snoremap <silent> <C-PageUp> <C-O>:<C-W>bp<CR>
inoremap <silent> <C-PageDown> <C-O>:bn<CR>
nnoremap <silent> <C-PageDown> <C-O>:bn<CR>
snoremap <silent> <C-PageDown> <C-O>:<C-W>bn<CR>

" Load git history using tpope's fugitive
inoremap <silent> <A-L> <C-O>:0Glog<CR>
" List all changed files
inoremap <silent> <A-g> <C-O>:CocList gstatus<CR>

" Quicklist shortcuts
nnoremap <A-=> :copen<CR>
nnoremap <A-[> :cprev<CR>
nnoremap <A-]> :cnext<CR>
" Coclist
inoremap <A-{> <C-O>:CocPrev<CR>
nnoremap <A-{> :CocPrev<CR>
inoremap <A-}> <C-O>:CocNext<CR>
nnoremap <A-}> :CocNext<CR>

if exists('$WAYLAND_DISPLAY')
  " clipboard on wayland with newline fix
  let g:clipboard = {
      \   'name': 'WL-Clipboard with ^M Trim',
      \   'copy': {
      \      '+': 'wl-copy --foreground --type text/plain',
      \      '*': 'wl-copy --foreground --type text/plain --primary',
      \    },
      \   'paste': {
      \      '+': {-> systemlist('wl-paste --no-newline | sed -e "s/\r$//"', '', 1)},
      \      '*': {-> systemlist('wl-paste --no-newline --primary | sed -e "s/\r$//"', '', 1)},
      \   },
      \   'cache_enabled': 1,
      \ }
endif

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

" automatic reload .vimrc
augroup source_vimrc
  autocmd!
  autocmd! bufwritepost init.vim source %
augroup END
set autoread " Set to auto read when a file is changed from the outside
