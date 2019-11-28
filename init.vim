" Source the neo vim config
command! NeoSource :source ~/.config/nvim/init.vim

" auto-install vim-plug: a plugin manager for vim 
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vim/vimrc
endif

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'drewtempelmeyer/palenight.vim'    " Palenight theme
Plug 'sheerun/vim-polyglot'             " Extended language support
Plug 'ekalinin/Dockerfile.vim'          " Dockerfile support
Plug 'nathanaelkane/vim-indent-guides'  " Indentation guides
Plug 'itchyny/lightline.vim'            " Better Status line

" Navigation & Searching
Plug 'scrooloose/nerdtree'  " File Tree

" Git integration
Plug 'itchyny/vim-gitbranch'  "Display current git branch

call plug#end()
" }}} Plugins

" Colors {{{
syntax on
set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1  " Italics enabled for palenight

" vim-indent guides colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screens
  set t_ut=
endif
" }}} Colors

" Spaces & Tabs {{{
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" vim-indent guides plugin
let g:indent_guides_enable_on_vim_startup = 1
" }}} Spaces & Tabs

" UI Config {{{
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace while typing
set laststatus=2             " window will always have a status line
set noshowmode               " Don't show '-- INSERT --' in the command line
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name'
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }
" }}} UI Config

" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight match
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise
" }}} Search


" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
" Start NERDTree if no file is specified on start up
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}


