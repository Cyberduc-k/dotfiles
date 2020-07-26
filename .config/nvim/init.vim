set shell=/bin/bash
let mapleader = ";"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'file://'.expand('~/.local/share/nvim/plugged/fluix')
Plug 'file://'.expand('~/.local/share/nvim/plugged/ori.nvim')
" Plug 'file://'.expand('~/.local/share/nvim/plugged/plum.nvim')
Plug 'file://'.expand('~/.local/share/nvim/plugged/plum2.nvim')

Plug 'morhetz/gruvbox'
Plug 'arzg/vim-colors-xcode'
Plug 'franbach/miramare'
Plug 'Rigellute/shades-of-purple.vim'
" Plug 'sainnhe/forest-night'
Plug 'Cyberduc-k/forest-night' " fork for forest-night with highlighting for Plum
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'file://'.expand('~/.local/share/nvim/plugged/jsfiddle')

Plug 'airblade/vim-rooter'
" Plug 'cloudhead/neovim-fuzzy'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'preservim/nerdcommenter'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/fish-syntax'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'tikhomirov/vim-glsl'

call plug#end()

let g:forest_night_disable_italic_comment = 1

set background=dark
set termguicolors
colorscheme forest-night

filetype plugin indent on

set autoindent
set mouse=a
set timeoutlen=300
set encoding=utf-8
set scrolloff=1
set noshowmode
set hidden
set nowrap
set nojoinspaces
set lazyredraw
set signcolumn=yes
set colorcolumn=160
set splitright
set splitbelow
set undodir=~/.vimdid
set undofile
set wildmenu
set wildmode=list:longest
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set path+=**

syntax on

set formatoptions=tc
set formatoptions+=r
set formatoptions+=q
set formatoptions+=n
set formatoptions+=b

set incsearch
set ignorecase
set smartcase
set gdefault

set guioptions-=T
set foldmethod=marker
set ruler
set number
set showcmd

" Tree sitter
let s:enable_treesitter = 0

if s:enable_treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    refactor = {
        highlight_definitions = {
            enable = true
        }
    }
}
EOF
endif

" Ale
let g:ale_fixers = { 'rust': ['rustfmt'] }
let g:ale_fix_on_save = 1
let g:ale_linters = { 'rust': ['analyzer'] }
let g:ale_set_highlights = 1
let g:ale_sign_column_always = 1
hi ALEError guifg=red ctermfg=red gui=undercurl cterm=undercurl
hi ALEWarning cterm=undercurl
nmap <silent>K :ALEHover<CR>
nmap <silent>E :ALENextWrap<CR>
nmap <silent>W :ALEPreviousWrap<CR>
nmap <silent>fd :ALEGoToDefinition<CR>

call deoplete#custom#option('sources', { '_': ['ale'] })
let g:deoplete#enable_at_startup = 1
set completeopt-=preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
inoremap <expr> <Down> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"

" NERD Commenter
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'plum': { 'left': '--' } }
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle
vmap <C-C> <Plug>NERDCommenterMinimal
vmap <C-U> <Plug>NERDCommenterUncomment

" Lightline
let g:shades_of_purple_lightline=1
let g:lightline = {}
let g:lightline.colorscheme = 'forest_night'
let g:lightline.active = {}
let g:lightline.active.left = [['mode'], ['readonly', 'filename', 'linter_errors', 'linter_warnings']]
let g:lightline.active.right = [['lineinfo'], ['filetype']]
let g:lightline.component_function = {
	\ 'filename': 'LightlineFilename',
	\ }
let g:lightline.component_expand = {
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ }
let g:lightline.component_type = {
    \ 'linter_errors': 'error',
    \ 'linter_warnings': 'warning',
    \ }
let g:lightline#ale#indicator_errors = "E "
let g:lightline#ale#indicator_warnings = "W "
" let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
" let s:palette.normal.error = [['#FFFFFF', '#FF0000', 255, 255]]
" let s:palette.normal.warning = [['#FFFFFF', '#FF8000', 255, 255]]

function! LightlineFilename() abort
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? '*' : ''
    return filename . modified
endfunction

" FZF
let g:fzf_preview_window = ''
let g:fzf_layout = { 'down': '15%' }

map <C-p> :Files<CR>
map <C-g> :Rg<CR>

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <C-s> :call SynStack()<CR>
nmap <leader><leader> <C-^>
nmap <leader>ec :e ~/.config/nvim/init.vim<CR>

nmap <A-Up> dd<Up>P
nmap <A-Down> ddp

" hi Normal guibg=NONE
