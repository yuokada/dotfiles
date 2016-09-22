`go tool`には`yacc`というものがある。
これはunixの言語処理系で広く使われるyaccというパーサジェネレータのGoバージョンである。
本稿はその使い方を説明するチュートリアルである。

## 対象読者
[goyaccを使う - Qiita](http://qiita.com/draftcode/items/c9f2422fca14133c7f6a)という記事があって、これはgoのyaccを使って簡単な言語の構文解析をして使い方を説明している。
しかし、yaccについての基本的な説明が完全ではなく(例えば%%とか)、yaccを触ったことがない人には若干難しい。
従って、私のようなGoの文法は理解しているがyaccを使ったことがない人向けにごく簡単な使い方を説明する。

## 参考資料
[yacc - The Go Programming Language](http://golang.org/cmd/yacc/)が公式のドキュメントっぽいが、これもyaccの文法自体は他に任せている。
RHGの[速習yacc](http://loveruby.net/ja/rhg/book/yacc.html)がとても参考になると思う。
本稿はあくまで取っ付き易いチュートリアルにしかしないつもりなので、あとでこちらを参照されたい。

困ったときは[src/cmd/yacc](https://code.google.com/p/go/source/browse/src/cmd/yacc)を読むと理解が深まる。

# とりあえず動かしてみる
まずは足し算をパースしてみる。
文法としては以下のようになる。

```
program
	: expr

expr
	: NUMBER
	| expr '+' expr
```

ようするに+で連結された式１つを全体のプログラムとして扱う。


## parser.go.y

```go
%{
package main

import (
	"fmt"
	"text/scanner"
	"os"
	"strings"
)

type Expression interface{}
type Token struct {
	token   int
	literal string
}

type NumExpr struct {
	literal string
}
type BinOpExpr struct {
	left     Expression
	operator rune
	right    Expression
}
%}

%union{
	token Token
	expr  Expression
}

%type<expr> program
%type<expr> expr
%token<token> NUMBER

%left '+'

%%

program
	: expr
	{
		$$ = $1
		yylex.(*Lexer).result = $$
	}

expr
	: NUMBER
	{
		$$ = NumExpr{literal: $1.literal}
	}
	| expr '+' expr
	{
		$$ = BinOpExpr{left: $1, operator: '+', right: $3}
	}

%%

type Lexer struct {
	scanner.Scanner
	result Expression
}

func (l *Lexer) Lex(lval *yySymType) int {
	token := int(l.Scan())
	if token == scanner.Int {
		token = NUMBER
	}
	lval.token = Token{token: token, literal: l.TokenText()}
	return token
}

func (l *Lexer) Error(e string) {
	panic(e)
}

func main() {
	l := new(Lexer)
	l.Init(strings.NewReader(os.Args[1]))
	yyParse(l)
	fmt.Printf("%#v\n", l.result)
}
```

を、`parser.go.y`という名前で保存し、`go tool yacc -o parser.go parser.go.y; go run parser.go "1+2"`などとしてみてほしい。

```bash
$ go tool yacc -o parser.go parser.go.y; go run parser.go "1+2"
main.BinOpExpr{left:main.NumExpr{literal:"1"}, operator:43, right:main.NumExpr{literal:"2"}}
```

となっただろうか。

## go tool yacc
`go tool yacc`はyaccファイルをgoのソースに変換するコマンドである。
`-o`オプションでそのgoのファイル名を指定する。
動作確認の際は毎度これでgoのコードを生成しないといけない。
`y.output`というファイルも生成されるが、本稿では説明しない。

## yacc全体の見方
yaccは`%%`で全体を3分割する。

```
%{
ヘッダ
%}
%union ....
%token ....
%type ....
%left ....

%%
規則部
%%
ユーザ定義部
```

規則部に文法を書くとその文法のパースをする`func(yyLexer) int`型の関数`yyParse`を作ってくれる。(`parser.go`参照)
規則部全体がyyParse関数のテンプレートだと思って良い。

ヘッダとユーザ定義部には好き放題goのコードを書くことができる。どちらに何を書いても同じである。
普通に考えたらyyParseをラップする関数を書くべきで、この例では`main()`である。

残りの`%union`,`%token`,`%type`,`%left`について説明する。

### %union

文法の構成要素は`yyParse`内で全て`yySymType`型の変数にいれる。この`yySymType`の宣言が`%union`である。
トークン、式、文など全てを区別しつつ全て`yySymType`にいれるために、yySymTypeはstructとして定義される。
規則部の`$$ =`(後述)は`yyVAL.expr =`と変換され(`yyVAL`は`yySymType`型)、トークンや式の代入先に`yySymType`のメンバが使われていることがわかる。

メモリ節約のためにCではunionが使われているから`%union`なのだと思うが、Goにはunionがないため実体はstructである。

### %token, %type
`%token`と`%type`で規則部に出てくる文法の構成要素を宣言しなければならない。
`%type`は非終端記号(プログラム、式、文)、`%token`は終端記号(数字や変数のリテラル)のために使う。

```
%type<unionのメンバ名> 規則部で使う名前
%token<unionのメンバ名> 規則部で使う名前
```

のように宣言する。

### %left, %right, %nonassoc
演算子の結合の方向を決定する。
たとえば、`%left '+'`と書いておくと、`+`が左結合になるため`1+2+3`は`(1+2)+3`と解釈されるが、
`%right '+'`とすると`1+(2+3)`となり、`%nonassoc '+'`だとエラーになる(3つ以上つなげた時にエラーにしたい場合に使われる)。

`%token`, `%type`, `%left`等は後ろに書くほど結合の優先順位が高くなる。
この例では、最も親要素であるprogramを一番最初に、その子となるexprをその次に、exprの構成要素となる演算子をその次に宣言している。
四則演算を書く場合は、

```
%left '+' '-'
%left '*' '/'
```

のようにすると、隣り合う物同士は優先順位が同じで、後に書かれた`*`と`/`の優先順位が`+`と`-`より高くなる。

## yyParseの引数

先ほど、`yyParse`は`func(yyLexer) int`型であると述べた。
[公式のドキュメント](http://golang.org/cmd/yacc/)にも書いてある、

```go
type yyLexer interface {
	Lex(lval *yySymType) int
	Error(e string)
}
```

というインターフェースを満たした型を渡さないといけない。lexerとは[字句解析器](http://ja.wikipedia.org/wiki/%E5%AD%97%E5%8F%A5%E8%A7%A3%E6%9E%90%E5%99%A8)のことである。
`Lex`はトークンを一つ読み、`lval`にトークンリテラルを解釈した結果を入れ、トークンの種類を返すことを期待されている。
`Error`はsyntax errorが起きた時のコールバックである。

この例では、goの標準ライブラリ`text/scanner`の`Scanner`というgoの字句解析器をラップした`Lexer`型を使っている。

## トークンの種類
本稿では字句解析のやり方については説明しない。([goyaccを使う - Qiita](http://qiita.com/draftcode/items/c9f2422fca14133c7f6a)の方を参照)
が、構文解析への接続部分は説明する。

一つ前で「トークンの種類」と言ったが、これは「演算子の文字コード」か「終端記号の識別定数」である。
`%token<token> NUMBER`という宣言をすると、`const NUMBER = 57346`に変換される。
`Lex`は、`'+'`のような文字コードか、`NUMBER`のような`%token`で宣言した定数を返せば良い。
(`text/scanner`は数字リテラルを読み込むと`scanner.Int`を返すが、`Lex`でこれをNUMBERに変えている)

## 規則部の書き方
長くなったが、yaccの説明はこれが最後である。
規則部は、[BN記法](http://ja.wikipedia.org/wiki/%E3%83%90%E3%83%83%E3%82%AB%E3%82%B9%E3%83%BB%E3%83%8A%E3%82%A6%E3%82%A2%E8%A8%98%E6%B3%95)に似た規則で書かなければならない。
Goのコードを書く部分以外は普通のyaccと同じなので、詳細は[速習yacc](http://loveruby.net/ja/rhg/book/yacc.html)を見て欲しい。

まず、

```
program
	: expr

expr
	: NUMBER
	| expr '+' expr
```

のように書く。
そして、各文法規則が解釈された際のコールバックを定義する。

```
program
	: expr
	{
		コールバック
	}

expr
	: NUMBER
	{
		コールバック
	}

	| expr '+' expr
	{
		コールバック
	}
```

このコールバックでは、`$$`というメタ変数にその文法を解釈した結果を入れることを期待されている。
前述した通り、`$$`は`%union`のメンバのいずれかを指している。
expr(`%type<expr> expr`)のコールバックであれば`yySymType.expr`、NUMBER(`%token<token> NUMBER`)のコールバックであれば`yySymType.token`となる。

このスコープでは`$$`の他に、`$1`, `$2` ... のようなメタ変数と、yyParseの引数(このyylex引数を使う)やローカル変数が参照できる。
`$1`、`$2`には文法の右辺に相当する`yySymType`のメンバの型の値が入っている。
すなわち、`expr '+' expr`のコールバックでは最初のexprが`$1`、'+'が`$2`、最後のexprが`$3`に入っている。

これらを好きな型(この例では、`NumExpr`、`BinOpExpr`)でラップして`$$`にいれることで、独自の構文解析を行う。
yaccではASTのroot要素を一番上に書くことになっており、一番上の文法規則のコールバック(すなわち、プログラム全体の解釈が終了した時のコールバック)で、yylex.resultに全体の結果を入れている。

# 文法の拡張
四則演算ができるように拡張する。

```diff
-%left '+'
+%left '+', '-'
+%left '*', '/'

 %%

 program
 	: expr
 	{
 		$$ = $1
 		yylex.(*Lexer).result = $$
 	}

 expr
 	: NUMBER
 	{
 		$$ = NumExpr{literal: $1.literal}
 	}
 	| expr '+' expr
 	{
 		$$ = BinOpExpr{left: $1, operator: '+', right: $3}
 	}
+	| expr '-' expr
+	{
+		$$ = BinOpExpr{left: $1, operator: '-', right: $3}
+	}
+	| expr '*' expr
+	{
+		$$ = BinOpExpr{left: $1, operator: '*', right: $3}
+	}
+	| expr '/' expr
+	{
+		$$ = BinOpExpr{left: $1, operator: '/', right: $3}
+	}
```

`1+2*3`を入力にすると、

```bash
$ go tool yacc -o parser.go parser.go.y; go run parser.go "1+2*3"
main.BinOpExpr{left:main.NumExpr{literal:"1"}, operator:45, right:main.BinOpExpr{left:main.NumExpr{literal:"2"}, operator:42, right:main.NumExpr{literal:"3"}}}
```

となり、`*`の結合の優先度が正しく解釈されていることがわかる。
ほぼパースのためのプログラムを書くことなく、最小限の労力で文法を拡張できた。非常に便利。


# 意味解析
単なる四則演算だが、`l.result`はまがりなりにもASTである。
構文解析をしただけでは面白く無いので、最後にこれの意味解析をして終わりにする。

```diff
+func Eval(e Expression) int {
+	switch e.(type) {
+	case BinOpExpr:
+		left := Eval(e.(BinOpExpr).left)
+		right := Eval(e.(BinOpExpr).right)
+
+		switch e.(BinOpExpr).operator {
+		case '+':
+			return left + right
+		case '-':
+			return left - right
+		case '*':
+			return left * right
+		case '/':
+			return left / right
+		}
+	case NumExpr:
+		num, _ := strconv.Atoi(e.(NumExpr).literal)
+		return num
+	}
+	return 0
+}

 func main() {
 	l := new(Lexer)
 	l.Init(strings.NewReader(os.Args[1]))
 	yyParse(l)
-	fmt.Printf("%#v\n", l.result)
+	fmt.Printf("%d\n", Eval(l.result))
 }
```

```bash
$ go tool yacc -o parser.go parser.go.y; go run parser.go "14/2-2*3"
1
```

最終的なコードは[こちら](https://gist.github.com/k0kubun/955d0220b0740329d577)。
お疲れ様でした。
