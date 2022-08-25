" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin(stdpath('data') . '/plugged')
  " Ruby stuff
  Plug 'vim-ruby/vim-ruby' | Plug 'tpope/vim-rails' |  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'lucapette/vim-ruby-doc'

  " Handlebars
  Plug 'joukevandermaas/vim-ember-hbs'
  Plug 'dsawardekar/ember.vim'

  " Javascript
  Plug 'pangloss/vim-javascript'
  Plug 'mustache/vim-mustache-handlebars'
  " All languages
  Plug 'tpope/vim-endwise'
  Plug 'dense-analysis/ale'
  Plug 'ntpeters/vim-better-whitespace'

  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " Editor Config
  Plug 'sgur/vim-editorconfig'

  " Help to navigate
  Plug 'liuchengxu/vim-which-key'
  Plug 'sudormrfbin/cheatsheet.nvim'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'

  " Theme
  Plug 'morhetz/gruvbox'
  Plug 'kyazdani42/nvim-web-devicons'

  " FZF Lua
  Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

  " Status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Use Treesitter to build source and enable some utilities.
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-refactor' " this provides "go to def" etc

  " General utilities and libs
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " Telescope and utilities
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-github.nvim'
  Plug 'LinArcX/telescope-command-palette.nvim'
  Plug 'fannheyward/telescope-coc.nvim'

  " LSP
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'RishabhRD/nvim-lsputils'
  Plug 'RishabhRD/popfix'
  Plug 'neovim/nvim-lspconfig'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/trouble.nvim'

  " Completion
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'Shougo/deoplete-lsp'
  "Plug 'deoplete-plugins/deoplete-tag'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}


  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

  " NERDtree
  Plug 'ryanoasis/vim-devicons'

  " Search
  Plug 'jremmen/vim-ripgrep'

  " Neoterm
  Plug 'kassio/neoterm'

  " Smooth scrolling
  Plug 'psliwka/vim-smoothie'

  " Use the tabline to show buffer names
  Plug 'ap/vim-buftabline'

  " Startup screen

  Plug 'startup-nvim/startup.nvim'

  "Tmux navigation
  Plug 'christoomey/vim-tmux-navigator'

  "Twilight
  Plug 'folke/twilight.nvim'

  "Ruby Debugging
  Plug 'thoughtbot/vim-rspec'

  Plug 'p00f/nvim-ts-rainbow'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'lewis6991/nvim-treesitter-context'
call plug#end()

let g:ruby_doc_command='open'

" vim fzf setting
set rtp+=/opt/homebrew/opt/fzf

" Mode Settings
set guicursor=n-v-c:block-blinkon0,i-ci-ve:block-blinkwait100-blinkoff50-blinkon50,r-cr:hor20,o:hor50

" Deoplete options
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#lsp#use_icons_for_candidates = 1
"call deoplete#custom#option('max_list', 10)
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
set number
set updatetime=100

" Theme
set t_Co=256 "256 colours
set background=dark
set termguicolors
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
colorscheme gruvbox

" Default value is clap
let g:dashboard_default_executive ='telescope'
" set airline theme
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts=1

" Search
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=longest,list,full
set clipboard+=unnamedplus


" Layout and tabs
set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=2
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
nnoremap <leader>fc <cmd>Telescope live_grep<cr>
" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Allow mouse
set mouse=a

" Set default splits
set splitright
set splitbelow

" Better Whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_only_modified_lines=1

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
nnoremap <leader>fg <cmd>Telesco pe live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>? <cmd>Cheatsheet<cr>

nnoremap <leader>Cp <cmd>Telescope loclist<cr>
nnoremap <leader>Cs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>Ct <cmd>Telescope current_buffer_tags<cr>
nnoremap <leader>Clt <cmd>Telescope tag_stack<cr>
nnoremap <leader>Cf <cmd>Telescope file_browser<cr>
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>

nnoremap <c-T> <cmd>lua require('fzf-lua').tags_live_grep()<CR>
" Spelling
set spelllang=en_gb
set spell
nnoremap <silent> <F4> :set spell!<cr>
inoremap <silent> <F4> <C-O>:set spell!<cr>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
set signcolumn=number

" Commands

" chomp whitespace from a line
command! Chomp %s/\s\+$// | normal! ``
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

" Find git root
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

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
require('telescope').setup({
  extensions = {
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
        { "relative number", ':set relativenumber!' },
        { "search highlighting (F12)", ':set hlsearch!' },
      }
    }
  }
})
require('telescope').load_extension('command_palette')
require('telescope').load_extension('coc')

require "startup".setup()


require('twilight').setup {
  dimming = {
    alpha = 0.25, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { "Normal", "#ffffff" },
    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 10, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
  exclude = {}, -- exclude these filetypes
}
require("trouble").setup()
require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
require'treesitter-context'.setup()

EOF

