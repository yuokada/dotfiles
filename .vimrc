" sudo  apt-get install vim   ctags vim-doc vim-scripts
syntax on
set title
set showmatch
set wildmenu

set autoindent
set cindent
set smartindent
set expandtab

set backspace=start,indent,eol

set hlsearch        " highlight searches
nmap <Esc><Esc> :nohlsearch<CR><Esc>
set incsearch       " do incremental searching

set magic
set showmode
set showmatch
set ls=2            " allways show status line
set nocompatible    " use vim defaults
set number
set ruler           " show the cursor position all the time
set scrolloff=3     " keep 3 lines when scrolling
set shiftwidth=4    " numbers of spaces to (auto)indent
set showcmd         " display incomplete commands
set softtabstop=4
set tabstop=4       " numbers of spaces of tab character
set textwidth=80

" http://archiva.jp/web/tool/vimrc_keymap.html
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>


set encoding=utf-8
set fencs=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

set nocp

"diff
set diffopt=filler,iwhite,icase
hi DiffAdd    ctermfg=white
hi DiffChange ctermfg=white

"PHP Coding
filetype plugin on
autocmd FileType php :set dictionary=$HOME/.vim/dict/php.dict
autocmd FileType inc :set dictionary=$HOME/.vim/dict/php.dict

"PHP Editor
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
let php_folding=1
au Syntax php set fdm=syntax
let php_sql_query=1
let php_htmllnStrings=1

"Perl Fold
let  perl_fold=1
let perl_fold_blocks=1
"Perl Hacks #5
"find_the_factorial_of
"http://www.flylib.com/books.php?ln=en&n=2&p=147&c=12&p1=1&c1=1&c2=141&view=1

"Perl Hacks #7
"http://www.flylib.com/books.php?ln=en&n=2&p=147&c=14&p1=1&c1=1&c2=141&layout=2&view=3
map ,pt  <Esc>:%! perltidy<CR>
map ,ptv <Esc>:'<,'>! perltidy<CR>

"Perl Hacks #10
"http://www.flylib.com/books.php?ln=en&n=2&p=147&c=17&p1=1&c1=1&c2=141&layout=2&view=3
map ,t  <Esc>:!prove -vl %<CR>
map ,t  <Esc>:!prove -Iwork/ -v %<CR>
map ,T  <Esc>:!prove -lv % \\| less<CR>


"backup dir
set backup
set backupdir=$HOME/.vim-backup
let &directory = &backupdir

au InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow   cterm=none
au InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGray cterm=none

"sudo  aptitude  search ^vim

""" ref.vim
"nmap ,ra :<C-u>Ref alc<Space>
"let g:ref_alc_start_linenumber = 39 " 表示する行数
let g:ref_alc_encoding = 'Shift-JIS' " 文字化けするならここで文字コードを指定してみる

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/ /ge

augroup rbsyntaxcheck
    autocmd!
    autocmd Bufwrite *.rb w ! ruby -c
augroup END

""" Vundle の設定  """
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'mattn/gist-vim'
Bundle 'tsaleh/vim-align'
Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache'
Bundle 'surround.vim'
Bundle 'snipMate'
Bundle 'Conque-Shell'
Bundle 'SuperTab'
"Bundle 'twitvim'
Bundle 'AutoComplPop'
Bundle 'python_fold'
Bundle 'unite.vim'
Bundle 'quickrun'
"2012/02/16
Bundle 'thinca/vim-ref'
Bundle 'Shougo/unite.vim'

filetype plugin indent on
""" Vundle の設定 終わり """

set guifont=Ricty:h14
