set shell=/bin/bash
let mapleader = ";"

" ###############
" ### PLUGINS ###
" ###############

call plug#begin('~/.local/shared/nvim/plugged')

Plug 'file://'.expand('~/.local/shared/nvim/plugged/fluix')

Plug 'dunstontc/vim-vscode-theme'
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'saltdotac/citylights.vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'victorze/foo'
Plug 'schickele/vim-nachtleben'

Plug 'itchyny/lightline.vim'

Plug 'airblade/vim-rooter'
Plug 'cloudhead/neovim-fuzzy'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/fish-syntax'

call plug#end()

colorscheme gruvbox
set background=dark
set termguicolors

" lightline config
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.active = {}
let g:lightline.active.left = [['mode'], ['readonly', 'filename', 'coc_error', 'coc_warning']]
let g:lightline.active.right = [['lineinfo'], ['filetype']]
let g:lightline.component_function = {
            \ 'filename': 'LightLineFilename',
            \ }
let g:lightline.component_expand = {
            \ 'coc_error': 'LightLineCocErrors',
            \ 'coc_warning': 'LightLineCocWarnings',
            \ }
let g:lightline.component_type = {
            \ 'coc_error': 'error',
            \ 'coc_warning': 'warning',
            \ }

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.error = [['#FFFFFF', '#FF0000', 255, 255]]
let s:palette.normal.warning = [['#FFFFFF', '#FF8000', 255, 255]]

autocmd User CocDiagnosticChange call lightline#update()

function! s:lightline_coc_diagnostic(kind) abort
    let l:diagnostics = CocAction('diagnosticList')
    if a:kind == "error"
        let l:errors = filter(l:diagnostics, {idx, val -> val.level == 1})
        let l:count = len(l:errors)
        let l:sign = "E"
    else
        let l:warnings = filter(l:diagnostics, {idx, val -> val.level == 2})
        let l:count = len(l:warnings)
        let l:sign = "W"
    endif
    if l:count == 0
        return ''
    else
        return printf('%s %d', l:sign, l:count)
    endif
endfunction

function! LightLineFilename() abort
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? '*' : ''
    return filename . modified
endfunction

function! LightLineCocErrors() abort
    return s:lightline_coc_diagnostic('error')
endfunction

function! LightLineCocWarnings() abort
    return s:lightline_coc_diagnostic('warning')
endfunction

" coc.nvim config
set updatetime=300

inoremap <silent><expr> <Down> (pumvisible() ? "\<Right>\<Down>" : "\<Down>")
inoremap <silent><expr> <Up> (pumvisible() ? "\<Right>\<Up>" : "\<Up>")

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>

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

nmap <silent> fd <Plug>(coc-definition)
nmap <silent> ft <Plug>(coc-type-definition)
nmap <silent> fi <Plug>(coc-implementation)
nmap <silent> fr <Plug>(coc-references)
nmap <silent> E <Plug>(coc-diagnostic-next)
nmap <silent> W <Plug>(cod-diagnostic-prev)

" ###############
" ### UTILITY ###
" ###############

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" ##############
" ### EDITOR ###
" ##############

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

" ###################
" ### KEYBINDINGS ###
" ###################

nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
"tnoremap <Esc> <C-\><C-n>
nnoremap <leader><leader> <c-^>

" fuzzy file search
map <C-p> :FuzzyOpen<CR>
map <C-o> :FuzzyGrep<CR>
map <C-l> :! 

" move/copy lines up/down
imap <C-A-Up> <Esc>:t .+0<CR>==gi
imap <C-A-Down> <Esc>:t .-1<CR>==gi
imap <A-Down> <Esc>:m .+1<CR>==gi
imap <A-Up> <Esc>:m .-2<CR>==gi

nnoremap <silent> <leader>ec :e ~/.config/nvim/init.vim<CR>
nnoremap <C-_> :call Toggle_comments()<CR>

function! Toggle_comments()
    let l:cursor_pos = getpos('.')

    if getline('.') =~ "\s*// "
        :exe "normal ^i\<Del>\<Del>\<Del>\<Esc>"
    else
        :exe "normal ^i// \<Esc>"
    endif

    :call setpos('.', l:cursor_pos)
endfunc
