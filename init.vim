" VIM Configuration File
" Author: Sebastian Olsson
" Description: Personal vimconfig
" ----------------------------------
" ----- Contact: -----
" Github:   github.com/Spunkt
" Twitter:  twitter.com/solsson91
" Mail:     me@sebastianolsson.com
" Website:  sebastianolsson.com
" ----------------------------------
" General setup
" ----------------------------------
syntax on

set noshowmatch
set nohlsearch
set hidden
set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set number
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undoir
set undofile
set incsearch
set scrolloff=8
set ruler

" Allows directory/project specific vimrc
set exrc
set secure

set hlsearch
noremap <C-l> :nohlsearch<CR><C-l>
noremap! <C-l> <ESC>:nohlsearch<CR><C-l>
set cmdheight=1

set updatetime=50

set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set laststatus=2
" ----------------------------------
" Plugins
" ----------------------------------
set nocompatible
filetype off

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mbbill/undotree'

Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'

Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'cdelledonne/vim-cmake'
Plug 'morhetz/gruvbox'

Plug 'cespare/vim-toml'
call plug#end()

"set termguicolors " Not working with floatterm for some reason
colorscheme gruvbox
set background=dark

if executable('rg')
	let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:lightline = {
	\ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste'],
    \       [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
	\ }

set noshowmode

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

" ----------------------------------
" Keybindings
" ----------------------------------

" Moving around the tabs
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
" Edit Window
map <leader>ew :e %%
" Edit Split
map <leader>es :sp %%
" Edit Vertical Split
map <leader>ev :vsp %%
" Edit tab
map <leader>et :tabe %%

nmap <silent> <leader>/ :nohlsearch<CR>

"nmap <silent> <leader>
" Yank to end of line from current position
nnoremap Y y$


nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <leader>ps :Rg<SPACE>

nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>= <C-w>=<CR>

nnoremap <C-p> :GFiles<CR>
let g:fzf_layout = { 'down': '40%' }

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set signcolumn=auto

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart

" Git
nmap <leader>gf :diffget //3<CR>
nmap <leader>gj :diffget //2<CR>
nmap <leader>gs :G<CR>

" Remove the use of some keys
nnoremap B ^
nnoremap E $
nnoremap $          <nop>
nnoremap ^          <nop>
nnoremap <Left>     <nop>
nnoremap <Right>    <nop>
nnoremap <Up>       <nop>
nnoremap <Down>     <nop>
inoremap <Left>     <nop>
inoremap <Right>    <nop>
inoremap <Up>       <nop>
inoremap <Down>     <nop>
