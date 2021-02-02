" VIM Configuration File
" Author: Sebastian Olsson
" Description: Personal vimconfig, used for C++, python, javascript, html and css development
" ----------------------------------
" Contact:
" Github: github.com/Spunkt
" Twitter: twitter.com/solsson91
" Mail: me@sebastianolsson.com

" ----------------------------------
" C++ Specific
" ----------------------------------
" Switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

nnoremap <F7> :make!<cr>

nmap <leader>cg :CMakeGenerate<cr>
nmap <leader>cb :CMakeBuild<cr>
nmap <leader>cq :CMakeClose<cr>

let g:cmake_default_config = 'build'
let g:cmake_jump_on_error = 0

" Close the Build if succeeded
augroup vim-cmake-group
  autocmd! User CMakeBuildSucceeded CMakeClose
augroup END


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Remove all trailing whitespaces
nnoremap <silent> <leader>cws :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
