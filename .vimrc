" sudo  apt-get install vim   ctags vim-doc vim-scripts
syntax on
set title
set showmatch
set wildmenu
set laststatus=2

set autoindent
set cindent
set smartindent
set expandtab

set background=dark
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
set shiftround
set showcmd         " display incomplete commands
set softtabstop=4
set tabstop=4       " numbers of spaces of tab character
set textwidth=80
set list
set cursorline
hi CursorLine term=reverse cterm=reverse

set iskeyword+=:
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
"set errorformat=%m\ in\ %f\ on\ line\ %l
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

""" ref.vim
"nmap ,ra :<C-u>Ref alc<Space>
"let g:ref_alc_start_linenumber = 39 " 表示する行数
let g:ref_alc_encoding = 'Shift-JIS' " 文字化けするならここで文字コードを指定してみる

" 保存時に行末の空白を除去する
"autocmd BufWritePre * :%s/\s\+$//ge
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufWritePre * if &filetype !=? 'markdown' | %s/ *$//ge | endif

" 保存時にtabをスペースに変換する
"autocmd BufWritePre * :%s/\t/ /ge

augroup rbsyntaxcheck
    autocmd!
    autocmd Bufwrite *.rb w ! ruby -c
augroup END

" """ Vundle の設定  """
" "set nocompatible
" "let g:vundle_default_git_proto='git'
" "filetype off
" "
" "set rtp+=~/.vim/bundle/vundle
" "call vundle#rc()
"
" set nocompatible
" filetype plugin indent off
"
" if has('vim_starting')
"   set runtimepath+=~/.vim/bundle/neobundle.vim/
"   call neobundle#rc(expand('~/.vim/bundle/'))
" endif
"
"
" NeoBundle 'mattn/gist-vim'
" NeoBundle 'tsaleh/vim-align'
" NeoBundle 'gmarik/vundle'
" NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'surround.vim'
" NeoBundle 'snipMate'
" NeoBundle 'Conque-Shell'
" NeoBundle 'SuperTab'
" "Bundle 'twitvim'
" NeoBundle 'AutoComplPop'
" NeoBundle 'python_fold'
" "NeoBundle 'unite.vim'
" "NeoBundle 'quickrun'
" NeoBundle 'thinca/vim-quickrun'
" "2012/02/16
" NeoBundle 'thinca/vim-ref'
" NeoBundle 'Shougo/unite.vim'
" "2012/05/04
" NeoBundle 'taglist-plus'
" NeoBundle 'taglist.vim'
" "2012/09/20
" "NeoBundle 'errormarker.vim'
" "NeoBundle 'phpErrorMarker'
" NeoBundle 'ZenCoding.vim'
" NeoBundle 'Zen-Color-Scheme'
" NeoBundle 'repeat.vim'
" NeoBundle 'L9'
" NeoBundle 'project.tar.gz'
" "NeoBundle 'davidhalter/jedi-vim'
" "2012/02/02
" NeoBundle 'Solarized'
" NeoBundle 'rest.vim'
" NeoBundle 'Rykka/riv.vim'
" "2013/08/15
" NeoBundle 'Shougo/neosnippet'
"
" "2013/12/30
" NeoBundle 'renamer.vim'
"
" "NeoBundle 'MarcWeber/vim-addon-manager'
" NeoBundle 'h1mesuke/unite-outline'
"
" "NeoBundleInstall 'Blackrush/vim-gocode'
"
"
" NeoBundle 'pangloss/vim-javascript'
" NeoBundle 'moll/vim-node'
" NeoBundle 'kchmck/vim-coffee-script'
"
" "clojure
" NeoBundle 'guns/vim-clojure-static'
" NeoBundle 'kien/rainbow_parentheses.vim'
" NeoBundle 'tpope/vim-fireplace'
" NeoBundle 'tpope/vim-classpath'
"
"

" "clojure
" NeoBundle 'guns/vim-clojure-static'
" NeoBundle 'kien/rainbow_parentheses.vim'
" NeoBundle 'tpope/vim-fireplace'
" NeoBundle 'tpope/vim-classpath'



" last nsert
"NeoBundle 'pep8'
filetype plugin indent on
""" Vundle の設定 終わり """
""" NeoVundle の設定 開始 """
"set nocompatible               " Be iMproved
"
"if has('vim_starting')
"set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif
"
"call neobundle#rc(expand('~/.vim/bundle/'))
"
"" Let NeoBundle manage NeoBundle
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"" Recommended to install
"" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
"NeoBundle 'Shougo/vimproc'
"
"" My Bundles here:
""
"" Note: You don't set neobundle setting in .gvimrc!
"" Original repos on github
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"" vim-scripts repos
"NeoBundle 'L9'
""NeoBundle 'FuzzyFinder'
"NeoBundle 'rails.vim'
"" Non github repos
"NeoBundle 'git://git.wincent.com/command-t.git'
"" gist repos
"NeoBundle 'gist:Shougo/656148', {
"    \ 'name': 'everything.vim',
"    \ 'script_type': 'plugin'}
"" Non git repos
"NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

" ...

"filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
"NeoBundleCheck

"""" NeoVundle の設定 終わり """
"

let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1

set guifont=Ricty:h14

" colorscheme solarized
colorscheme molokai
"colorscheme rdark
set t_Co=256
set background=light

"let g:jedi#auto_initialization = 1
"let g:jedi#rename_command= "<leader>R"
"let g:jedi#popup_on_dot=1

" golang
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
  " Go に付属の plugin と gocode を有効にする
  " set rtp^=${GOROOT}/misc/vim
  " set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
  set rtp+=${GOROOT}/misc/vim
  set rtp+=${GOPATH}/src/github.com/nsf/gocode/vim
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
  set completeopt=menu,preview
endif

" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

"スニペットのディレクトリ
if !exists("g:neosnippet#snippets_directory")
    let g:neosnippet#snippets_directory=""
endif
let g:neosnippet#snippets_directory=$HOME.'/.vim/snippets'

"<TAB>でスニペット補完
"if g:neocomplcache_enable_at_startup
"  imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"endif
"
"" スニペットで単語が選択されている場合でも <Tab> で次のプレースホルダへ移動する
"vmap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"
"augroup filetypedetect
"  " Cのタブ幅は4で
"  au BufNewFile,BufRead *.c    setlocal tabstop=4 shiftwidth=4
"  au BufNewFile,BufRead *.cpp  setlocal tabstop=4 shiftwidth=4
"  au BufNewFile,BufRead *.h    setlocal tabstop=4 shiftwidth=4
"augroup END

autocmd BufNewFile,BufRead *.twig set ft=html
