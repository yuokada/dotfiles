/* ヘッダー ここから */
%{
package main

import (
	"text/scanner"
	"os"
	// "strconv"
	"strings"
	"fmt"
	"log"
	"github.com/pkg/errors"
)

type Expression interface{}

type Token struct {
    token   int
    literal string
}

type WordExpr struct {
    literal string
}
%}

%union{
    token Token
    expr  Expression
}

%type<expr>  sent
%type<expr> subject
%type<expr> verb
%type<expr> object
%token<token> I YOU LOVE ME
%token<token> WORD

%%

sent
	: subject verb object
  {
      // $$ = fmt.Sprintf("%#v %#v\n",$1, $2)
			$$ = fmt.Sprintf("%#v %#v %#v\n",$1, $2, $3)
			// $$ = []Token{$1, $2, $3}
			// book.go.y:46[/Users/callistoiv/works/IdeaProjects/dotfiles/yacc/book.go:514]: cannot use yyDollar[1].expr (type Expression) as type Token in array or slice literal: need type assertion
      yylex.(*Lexer).result = $$
  }

subject
	: I
	{
    $$ = $1
  }
  | YOU
	{
    $$ = $1
  }
	| WORD
	{
    $$ = $1
  }

verb
	: LOVE
	{
    $$ = $1
  }

object
	  : YOU
		{
	    $$ = $1
	  }
		| ME
		{
	    $$ = $1
	  }
		| WORD
		{
	    $$ = $1
	  }


%%
/* 規則部 ここまで */
/*
ヘッダとユーザ定義部には好き放題goのコードを書くことができる。どちらに何を書いても同じである。
普通に考えたらyyParseをラップする関数を書くべきで、この例ではmain()である。
*/
/* ユーザー定義部 ここから */

type Lexer struct {
	scanner.Scanner
	result Expression
}

func (l *Lexer) Lex(lval *yySymType) int {
	fmt.Printf("DEBUG0 : start \n")
	token := int(l.Scan())
	fmt.Printf("DEBUG1 : %d:'%s' \n", token, l.TokenText())
	// if token == scanner.Int {
	// 	 token = NUMBER
	// }
	switch l.TokenText() {
	case "I":
		token = I
	case "YOU":
		token = YOU
	case "LOVE":
		token = LOVE
	case "ME":
		token = ME
	// case "\n":
	// 		token = NL
	default:
		// -1のときさっさと返せばいい?
		fmt.Printf(">>DEBUG: %#v\n", token)
		// token = WORD
	}
	// TODO: たぶん、ここが間違ってる。
	lval.token = Token{token: token, literal: l.TokenText()}
	return token
}

func (l *Lexer) Error(e string) {
	log.Printf("%+v\n", errors.New(e))
	panic(e)
}

func main() {
	l := new(Lexer)
	l.Init(strings.NewReader(os.Args[1]))
	// MEMO: ここからスタート
	yyParse(l)
	fmt.Printf("%#v\n", l.result)
}
