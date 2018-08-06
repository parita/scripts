"Use Pathogen
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

"Typo checks
iabbrev teh the
iabbrev adn and
iabbrev funciton function
iabbrev functoin function
iabbrev fucntion function

set nocompatible
set laststatus=2
syntax enable
set modelines=0
set encoding=utf-8
filetype indent on
filetype plugin indent on
filetype plugin on
set term=screen-256color

"toggle pastemode with <F2>
set pastetoggle=<F2>

"This tells Vim not to bother redrawing during these scenarios, leading to faster macros.
set lazyredraw

"show the last command entered
set showcmd

"fuck you ex mode
nnoremap Q <nop>

"Bind :Q and :W to :q and :w respectively
command! Q q
command! W w

"switch off the bell
set visualbell t_vb=
set novisualbell

"better mapping for esc
imap jk <ESC>

"better use of space in normal mode
nnoremap <space> viw

"better use of H and L
nnoremap H ^
nnoremap L $

"mapping leader
let mapleader = ','

" easier navigation between split windows
set splitbelow
set splitright
nnoremap `<Down> <c-w>j
nnoremap `<Up> <c-w>k
nnoremap `<Left> <c-w>h
nnoremap `<right> <c-w>l

"folding settings
set foldmethod=indent
set foldlevelstart=10
set foldnestmax=10
set foldenable
set foldlevel=1

"editing
set ruler                       " show the co-ordinates of the cursor
set cursorline                  " highlight the line with the cursor
set scrolloff=3                 " provide some context for editing
set number

"" Whitespace
set nowrap                      " dont wrap lines
set expandtab                   " spaces as tabs
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " except when you tell vim
set gdefault                    " g flag is set on default

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

"" Look
set background=dark
"set guifont=Sauce\ Code\ Powerline\ Regular:h23
if has('gui_running')
  set guioptions-=T
  set guioptions-=R
  set guioptions-=r
  set guioptions-=L
  set guioptions-=l
  set guioptions-=m
  colorscheme base16-default
else
  set t_Co=256
  colorscheme jellybeans
endif

"read .ru files as rb
au BufNewFile,BufRead *.ru set filetype=ruby

"customizing the insert menu
"http://goo.gl/UqCSV
set completeopt=longest,menuone

" editing vimrc in a jiffy
" source $MYVIMRC reloads the saved $MYVIMRC
nnoremap <Leader><Leader>s :source $MYVIMRC
" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nnoremap <Leader><Leader>v :e $MYVIMRC

"NERD Tree
let NERDTreeShowBookmarks  = 1
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
map <leader>n :NERDTreeToggle <cr>

" highlight nbsp and trailing whitespace
" thanks to https://github.com/henrik/dotfiles
autocmd BufNewFile,BufRead * highlight nbsp ctermbg=Red
autocmd BufNewFile,BufRead * match nbsp "[\xc2\xa0]"
autocmd BufNewFile,BufRead * highlight trailing_spaces ctermbg=Red
autocmd BufNewFile,BufRead * match trailing_spaces /\s\+$/
" Remove trailing whitespace for all python files when saving
autocmd BufWritePre *.py %s/\s\+$//e

"Bufexplorer
map <leader><leader>b :BufExplorer

"Vim Fireplace - Clojure
map <leader><leader>e :Eval

"leader mappings
nnoremap <tab> %
vnoremap <tab> %
map <Leader>w <C-w>w

" Scratch {{{
command! ScratchToggle call ScratchToggle()

function! ScratchToggle() " {{{
  if exists("w:is_scratch_window")
    unlet w:is_scratch_window
    exec "q"
  else
    exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
    let w:is_scratch_window = 1
  endif
endfunction " }}}

nnoremap <silent> <leader><tab> :ScratchToggle<cr>

"buffer mappings
nnoremap <F5> :buffers<CR>:buffer<Space>

"pressing Tab on the command line will show a menu to complete buffer and file names
set wildchar=<Tab> wildmenu wildmode=full

"press F10 to open the buffer menu.
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

""settings for ctrlp
"let g:ctrlp_cmd = 'CtrlPBuffer'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/venv/*,
let g:clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|_build'

" Show syntax highlighting groups for word under cursor
nmap <C-S-T> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"" zencoding bindings
let g:user_zen_expandabbr_key = '<leader>o'
let g:use_zen_complete_tag = 1

"" python syntax-highlight all
let python_highlight_all=1

"file-specific indentation settings
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.py set filetype=python
autocmd BufRead,BufNewFile *.html setlocal tabstop=2 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent
autocmd BufRead,BufNewFile *.go setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.jsjs set filetype=scala

" Show syntax highlighting groups for word under cursor
nmap <C-S-R> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" SOME SETTINGS FROM HERE - http://dougblack.io/words/a-good-vimrc.html
" language specific commands
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.markdown setlocal wrap
    autocmd BufEnter *.markdown setlocal linebreak
    autocmd BufEnter *.md setlocal wrap 
    autocmd BufEnter *.md setlocal linebreak
    autocmd BufEnter *.md setlocal spell spelllang=en_us
    autocmd BufEnter *.c setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab cindent
augroup END

" move backup into temp folder
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" settings for rust
let g:rustc_path = "/usr/local/bin/rustc"
nnoremap <Leader><Leader>r :RustRun

" settings for Go
nnoremap <Leader><Leader>g :GoRun
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 1

" for wrapping
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

" for the silver surfer (ag)
set runtimepath^=~/.vim/bundle/ag

" LaTex settings
let g:Tex_CompileRule_pdf = 'pdflatex $*'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf = 'xpdf -fullscreen -v $*'
let g:Imap_UsePlaceHolders = 1
