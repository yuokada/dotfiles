setlocal omnifunc=gocomplete#Complete
set noexpandtab
set nolist
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview
