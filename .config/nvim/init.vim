set nocompatible
set shell=/bin/bash
let mapleader = ";"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'file://'.expand('~/.local/share/nvim/plugged/fluix')
Plug 'file://'.expand('~/.local/share/nvim/plugged/ori.nvim')
" Plug 'file://'.expand('~/.local/share/nvim/plugged/plum.nvim')
Plug 'file://'.expand('~/.local/share/nvim/plugged/plum2.nvim')
Plug 'file://'.expand('~/.local/share/nvim/plugged/shade.nvim')

Plug 'morhetz/gruvbox'
Plug 'arzg/vim-colors-xcode'
Plug 'franbach/miramare'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'sainnhe/forest-night'
Plug 'dunstontc/vim-vscode-theme'
Plug 'lifepillar/vim-solarized8'
Plug 'delphinus/lightline-delphinus'
Plug 'HenryNewcomer/vim-theme-papaya'
Plug 'bluz71/vim-moonfly-colors'
Plug 'file://'.expand('~/.local/share/nvim/plugged/jsfiddle')

Plug 'itchyny/lightline.vim'
" Plug 'maximbaz/lightline-ale'

Plug 'airblade/vim-rooter'
" Plug 'cloudhead/neovim-fuzzy'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'dense-analysis/ale'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'preservim/nerdcommenter'
Plug 'qpkorr/vim-bufkill'

" Plug 'nvim-treesitter/nvim-treesitter'

Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/fish-syntax'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'tikhomirov/vim-glsl'
Plug 'ziglang/zig.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

let g:forest_night_disable_italic_comment = 1

set background=dark
set termguicolors
colorscheme moonfly

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

" coc
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <silent><expr> <C-.> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> fd <Plug>(coc-definition)
nmap <silent> E <Plug>(coc-diagnostic-next)
nmap <silent> W <Plug>(coc-diagnostic-prev)

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" NERD Commenter
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'shade': { 'left': '--', 'leftAlt': '---', 'rightAlt': '---' } }
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle
vmap <C-C> <Plug>NERDCommenterMinimal
vmap <C-U> <Plug>NERDCommenterUncomment

" Lightline
let g:shades_of_purple_lightline=1
let g:lightline = {}
let g:lightline.colorscheme = 'moonfly'
let g:lightline.active = {}
let g:lightline.active.left = [['mode'], ['readonly', 'filename', 'coc_status']]
let g:lightline.active.right = [['lineinfo'], ['filetype']]
let g:lightline.component_function = {
	\ 'filename': 'LightlineFilename',
    \ 'coc_status': 'coc#status'
	\ }
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
let g:fzf_layout = { 'down': '12' }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 ruler

map <C-p> :Files<CR>
map <C-g> :Rg<CR>

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <C-s> :call SynStack()<CR>

function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<CR>"
endfunction

vnoremap <silent> <expr> p <sid>Repl()

nmap <leader><leader> <C-^>
nmap <leader>ec :e ~/.config/nvim/init.vim<CR>

nmap <A-Up> dd<Up>P
nmap <A-Down> ddp

hi Normal guibg=NONE
hi Comment gui=NONE
