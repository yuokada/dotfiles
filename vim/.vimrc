if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax enable

set encoding=utf-8
set fileformats=unix,dos,mac
set backspace=indent,eol,start
set hidden
set number
set ruler
set showcmd
set wildmenu
set laststatus=2
set scrolloff=3

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround
set autoindent
set smartindent

set incsearch
set hlsearch
set ignorecase
set smartcase
set magic

set splitbelow
set splitright
set mouse=a
set list
set listchars=tab:»·,trail:·,extends:›,precedes:‹,nbsp:␣

if has('termguicolors')
  set termguicolors
endif

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

function! s:StripTrailingWhitespace() abort
  let l:save_view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save_view)
endfunction

augroup dotfiles
  autocmd!
  autocmd FileType c,cpp,java,php,ruby,python,yaml autocmd BufWritePre <buffer> call <SID>StripTrailingWhitespace()
augroup END
