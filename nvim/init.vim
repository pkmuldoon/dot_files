" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin(stdpath('data') . '/plugged')
  " Ruby stuff
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-endwise'
  Plug 'dense-analysis/ale'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-bundler'

  " Editor Config
  Plug 'sgur/vim-editorconfig'

  " Help to navigate
  Plug 'liuchengxu/vim-which-key'
  Plug 'sudormrfbin/cheatsheet.nvim'

  " Git
  Plug 'tpope/vim-fugitive'

  " Theme
  Plug 'morhetz/gruvbox'
  Plug 'kyazdani42/nvim-web-devicons'

  " Status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Use Treesitter to build source and enable some utilities.
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lewis6991/spellsitter.nvim'
  Plug 'nvim-treesitter/nvim-treesitter-refactor' " this provides "go to def" etc

  " General utilities and libs
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " Telescope and utilities
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }

  " LSP
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'RishabhRD/nvim-lsputils'
  Plug 'RishabhRD/popfix'
  Plug 'neovim/nvim-lspconfig'

  " Completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/deoplete-lsp'
  Plug 'deoplete-plugins/deoplete-tag'

  " NERDtree
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " Search
  Plug 'jremmen/vim-ripgrep'

  Plug 'psliwka/vim-smoothie'
  Plug 'ap/vim-buftabline'
  Plug 'mhinz/vim-startify'
call plug#end()

"Mode Settings
set guicursor=n-v-c:block-blinkon0,i-ci-ve:block-blinkwait100-blinkoff50-blinkon50,r-cr:hor20,o:hor50

let g:deoplete#enable_at_startup = 1
let g:deoplete#lsp#use_icons_for_candidates = 1
" Set some defaults.
set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on

let g:indent_guides_enable_on_vim_startup = 1

set hidden
set cursorline
set backspace=indent,eol,start
set modeline
set splitright
set number

" Theme
set t_Co=256 "256 colours
set background=dark
set termguicolors
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
colorscheme gruvbox

" set airline theme
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts=1

" Search
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

" Open file at same line as when closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" Define leader
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Setup whichkey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
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

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ale configury
let g:ale_linters = {
      \   'ruby': ['rubocop', 'rails_best_practivces', 'ruby'],
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \}
let g:ale_fixers = {
      \    'ruby': ['remove_trailing_lines', 'rubocop', 'trim_whitespace'],
      \}
let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_auto_correct_all = 1
let g:ale_lint_delay = 1000

" Telescope shortcuts
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>? <cmd>Cheatsheet<cr>

nnoremap <leader>Cp <cmd>Telescope loclist<cr>
nnoremap <leader>Cs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>Ct <cmd>Telescope current_buffer_tags<cr>
nnoremap <leader>Clt <cmd>Telescope tag_stack<cr>
nnoremap <leader>Cf <cmd>Telescope file_browser<cr>
"
" Configure the completion chains

set spelllang=en_gb
set spell
nnoremap <silent> <F4> :set spell!<cr>
inoremap <silent> <F4> <C-O>:set spell!<cr>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Commands
command! Chomp %s/\s\+$// | normal! ``
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

function! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l]; puts "l #{l}" }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local key bindings when the language server attaches
local servers = { "solargraph", "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

require'nvim-web-devicons'.setup {
 -- your personal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overridden by `get_icons` option
 default = true;
}

require('spellsitter').setup {
  hl = 'SpellBad',
  captures = {'comment'},  -- set to {} to spellcheck everything
}
require'nvim-treesitter.configs'.setup{
  ensure_installed = {"ruby", "javascript", "python", "json", "css", "typescript"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
}


require('telescope').setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('fzy_native')
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
set signcolumn=number

