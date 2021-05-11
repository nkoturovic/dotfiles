call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" ---------- My Plugins ---------
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'tpope/vim-vinegar'
Plug 'kien/ctrlp.vim'
Plug 'wincent/replay'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter' "Diff tool on side pane
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'equalsraf/neovim-gui-shim'
Plug 'vim-python/python-syntax'
Plug 'Shougo/echodoc.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'
Plug 'neovimhaskell/haskell-vim'
Plug 'rhysd/vim-clang-format'
Plug 'alaviss/nim.nvim'

call plug#end()

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
set guifont=Inconsolata\ 13.5

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

" Move undo, swap, etc to ~/.config/nvim/tmp folder
if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/.config/nvim/tmp/swap    " keep swap files out of the way
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/.config/nvim/tmp/undo
    set undodir+=~/.config/nvim/tmp/undo      " keep undo files out of the way
    set undodir+=.
    set undofile                      " actually use undo files
  endif
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                      " don't create root-owned files
  else
      set viminfo+=n~/.config/nvim/tmp/viminfo " override ~/.viminfo default
  endif
endif

if has('mksession')
  if isdirectory('~/.config/nvim/tmp')
    set viewdir=~/.config/nvim/tmp/view
  else
    set viewdir=~/.config/nvim/tmp/view " override ~/.vim/view default
  endif

  set viewoptions=cursor,folds  " save/restore just these (with `:{mk,load}view`)
endif

if has('virtualedit')
  set virtualedit=block  " allow cursor to move where there is no text in visual block mode
endif

"Save foldings
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview

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

set tabstop=4 shiftwidth=4 expandtab "Spaces instead of tabs

" additional highlighting settings
highlight Pmenu ctermfg=15 ctermbg=235 guifg=#FAFAFA guibg=#2A2A2A
highlight clear SignColumn
hi PmenuSel ctermfg=255 ctermbg=239
set nohlsearch " Do not highlight search

"----------- Plugin related stuff ---------
"---------- Powerline ------------
set noshowmode
set noruler
"set noshowcmd
set laststatus=2
let g:echodoc_enable_at_startup = 1

let g:lightline = {
      \ 'enable': { 
      \	 	'tabline': 0
      \	},
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

if $TERM == "screen-256color"
	hi Comment cterm=none
endif

"---- Plugin related configuration -----
map <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>u :UndotreeToggle<CR>

let g:SuperTabDefaultCompletionType = "<c-n>" "Supertab from top to bottom
let g:SuperTabClosePreviewOnPopupClose = 1 "Close popup after completion
"---------coc show the doc--------------
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <Leader>d :call <SID>show_documentation()<CR>

let g:ctrlp_working_path_mode = 'a'

" Mapings for latin symbols for document file types
augroup latin_mappings
    autocmd!
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;sh š
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;SH Š
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;ch č
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;CH Č
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;cj ć
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;CJ Ć
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;dj đ
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;DJ Đ
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;zh ž
    autocmd FileType tex,latex,context,plaintext,text,markdown,html inoremap ;ZH Ž
augroup END

" Save current file and run make
noremap <F3> :w<CR>:make<CR>

let g:tex_flavour='latex'

" terminal escape -> normal mode
tnoremap <Esc> <C-\><C-n>

autocmd BufNewFile,BufRead *.nim, set filetype=nim
