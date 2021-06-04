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
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mg979/vim-visual-multi'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'nvim-lua/completion-nvim'
call plug#end()

let g:deoplete#enable_at_startup = 1


"Mode Settings

set guicursor=n-v-c:block-blinkon0,i-ci-ve:block-blinkwait100-blinkoff50-blinkon50,r-cr:hor20,o:hor50
"Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

" Set some defaults.
set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on
set hidden
set cursorline
set backspace=indent,eol,start
set modeline
set splitright

" Theme
colorscheme dracula
set t_Co=256 "256 colours
set background=dark
set termguicolors

" w!! to sudo write a file
cmap w!! %!sudo tee > /dev/null %

" highlight problematic whitespace in red
highlight ws ctermbg=red guibg=red
match ws /\s\+$/
autocmd BufWinEnter * match ws /\s\+$/

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=longest,list,full

" Layout and tabs
set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=2
set autoread

"Open file at same line as when closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" Define leader
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Setup whichkey
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

" Some fzf bindings.
noremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>b :BTags<CR>

let g:airline_powerline_fonts=1

lua << EOF
require'lspconfig'.solargraph.setup{}
require'lspconfig'.solargraph.setup{on_attach=require'completion'.on_attach}
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
