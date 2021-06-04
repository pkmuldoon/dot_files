" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" No trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

call plug#begin(stdpath('data') . '/plugged')
  Plug 'junegunn/vim-easy-align'
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'liuchengxu/vim-which-key'
  Plug 'tpope/vim-endwise'
  Plug 'preservim/nerdtree'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'dense-analysis/ale'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mg979/vim-visual-multi'
call plug#end()

let g:deoplete#enable_at_startup = 1

highlight ws ctermbg=red guibg=red
match ws /\s\+$/
autocmd BufWinEnter * match ws /\s\+$/

set nocompatible
syntax on
colorscheme dracula
filetype on
filetype indent on
filetype plugin on
set hidden
set cursorline
set backspace=indent,eol,start
set modeline
set splitright
cmap w!! %!sudo tee > /dev/null %

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=longest,list,full

set ruler
set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=2
set autoread


set t_Co=256 "256 colours
set background=dark
set termguicolors

"Open file at same line as when closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Buffer shortcuts
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Ale configury
let g:ale_linters = {
      \   'ruby': ['standardrb', 'rubocop'],
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'ruby': ['standardrb'],
      \}
let g:ale_fix_on_save = 1

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Some fzf bindings.
noremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>b :BTags<CR>

let g:airline_powerline_fonts=1

