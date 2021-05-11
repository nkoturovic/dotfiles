" Basic options
set number
set relativenumber
set cursorline
set scrolloff=3 " start scrolling 3 lines before edge

set t_Co=256
syntax enable
set background=dark
colorscheme xoria256-custom
" highlight Comment cterm=italic gui=italic

" ignore annoying swapfile messages
set shortmess+=A

" Ignore case while searching with '/'
set ignorecase
set smartcase

" Make mouse work with vim
set mouse=n

" Moving trought long line up and down
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" -------------------- LEADER MAPPINGS --------------
let mapleader = " " " Maps leader to space key
let maplocalleader = '\' " Maps local leader to '\' key
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>
nnoremap <Leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>o :only<CR>
noremap <Leader>bq :bd<CR>
noremap <Leader>p :set paste<CR>"+p:set nopaste<CR>
noremap <Leader>y "+y
nnoremap <Leader>o :only<CR>

"Shifting tabs
map <Leader>b :bnext<CR>
map <Leader>k :tabnext<CR>
map <Leader>j :tabprevious<CR>
map <Leader>h :tabfirst<CR>
map <Leader>l :tablast<CR>
map <Leader>n :tabnew<CR>
set tabstop=3 shiftwidth=4 expandtab
