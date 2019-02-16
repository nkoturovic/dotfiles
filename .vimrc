" Basic options
set number
set relativenumber
set cursorline
set scrolloff=3 " start scrolling 3 lines before edge

" GUI SETTINGS
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Inconsolata\ 11

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

" Move undo, swap, etc to ~/.vim/tmp folder
if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/local/.vim/tmp/swap
  set directory+=~/.vim/tmp/swap    " keep swap files out of the way
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/local/.vim/tmp/undo
    set undodir+=~/.vim/tmp/undo      " keep undo files out of the way
    set undodir+=.
    set undofile                      " actually use undo files
  endif
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                      " don't create root-owned files
  else
      set viminfo+=n~/.vim/tmp/viminfo " override ~/.viminfo default
  endif
endif

if has('mksession')
  if isdirectory('~/local/.vim/tmp')
    set viewdir=~/local/.vim/tmp/view
  else
    set viewdir=~/.vim/tmp/view " override ~/.vim/view default
  endif

  set viewoptions=cursor,folds  " save/restore just these (with `:{mk,load}view`)
endif

if has('virtualedit')
  set virtualedit=block  " allow cursor to move where there is no text in visual block mode
endif

"Save foldings
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Finding files
" Search trought all directories
set path+=**
" Display all matching files on TAB complete
set wildmenu

" Zap trailing whitespace.
function! Zap() abort
  let l:pos=getcurpos()
  let l:search=@/
  keepjumps %substitute/\s\+$//e
  let @/=l:search
  nohlsearch
  call setpos('.', l:pos)
endfunction

" -------------------- LEADER MAPPINGS --------------
let mapleader = " " " Maps leader to space key
let maplocalleader = '\' " Maps local leader to '\' key
nnoremap <Leader>zz :call Zap()<CR>
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
autocmd BufNewFile,BufRead *.ypp set syntax=yacc
