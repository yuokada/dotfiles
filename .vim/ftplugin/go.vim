setlocal omnifunc=gocomplete#Complete
set noexpandtab
set nolist
" :Fmt などで gofmt の代わりに goimports を使う
let g:gofmt_command = 'goimports'
" 保存時に :Fmt する
au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
au FileType go compiler go

" " -------------------
" " Go に付属の plugin と gocode を有効にする
" " set rtp^=${GOROOT}/misc/vim
" " set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
" set rtp+=${GOROOT}/misc/vim
" set rtp+=${GOPATH}/src/github.com/nsf/gocode/vim
" exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
" set completeopt=menu,preview
