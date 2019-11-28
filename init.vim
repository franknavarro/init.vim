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
Plug 'ryanoasis/vim-devicons'           " Icons for vim
" Patched Fira font for vim-devicons can be found at:
" https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Color Dev Icons

" Navigation & Searching
Plug 'scrooloose/nerdtree'  " File Tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder for terminal
Plug 'junegunn/fzf.vim' " Fuzzy finder for vim


" Git integration
Plug 'itchyny/vim-gitbranch'  " Display current git branch
Plug 'tsony-tsonev/nerdtree-git-plugin' " Show git changes in NERDTree
Plug 'airblade/vim-gitgutter' " Show git changes in line number column

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}


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
set hidden                   " Allow current buffer to be hidden
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace while typing
set laststatus=2             " window will always have a status line
set noshowmode               " Don't show '-- INSERT --' in the command line
set nobackup
set nowritebackup

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
map <C-p> :Files<CR>
map <C-f> :Rg<CR>
" }}} Search


" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
" Start NERDTree if no file is specified on start up
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Add git symbols and file highlighting in NERDTree
let g:NERDTreeGitStatusWithFlags = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
    \ "Modified"  : ["#ffd700", "220", "NONE", "NONE"],  
    \ "Staged"    : ["#87d700", "112", "NONE", "NONE"],  
    \ "Untracked" : ["#ff5f00", "202", "NONE", "NONE"],  
    \ "Dirty"     : ["#00afff", "39", "NONE", "NONE"],  
    \ "Clean"     : ["#d0d0d0", "252", "NONE", "NONE"],
    \ "Ignored"   : ["#585858", "240", "NONE", "NONE"]   
    \ }
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}} NERDTree


" COC Plugins {{{
let g:coc_global_extensions = [
  \ 'coc-marketplace',
  \ 'co-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-pairs',
  \ ]
" }}} COC Plugins

" Prettier {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}} Prettier


" COC {{{
set cmdheight=2   " Better display for messages
set updatetime=300    
set signcolumn=yes    " always show signcolumns

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


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


" }}} COC
