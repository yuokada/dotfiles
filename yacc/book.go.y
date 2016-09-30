/* ヘッダー ここから */
%{
package main

import (
	"text/scanner"
	"os"
	"strconv"
	"strings"
	"fmt"
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

%token<expr>  S
%token<expr>  sent
%token<token> subject
%token<token> verb
%token<token> object
%token<token> I
%token<token> YOU
%token<token> LOVE
%token<token> ME
%token<token> NL

%%

S : sent
    {
        $$ = $1
        yylex.(*Lexer).result = $$
    }

sent : subject verb object
    {
        $$ = $1
        yylex.(*Lexer).result = $$
    }

subject : I {
        WordExpr{literal: $1.literal}
      }
      | YOU {
        WordExpr{literal: $1.literal}
      }

verb : LOVE {
                WordExpr{literal: $1.literal}
      }

object : ME {
          WordExpr{literal: $1.literal}
        }
        | YOU {
          WordExpr{literal: $1.literal}
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
	token := int(l.Scan())
	fmt.Printf("DEBUG: %d:'%s' \n", token, l.TokenText())
	if token == scanner.Int {
		 token = NUMBER
	}
	switch l.TokenText() {
	case "I":
		token = I
	case "YOU":
		token = YOU
	case "LOVE":
		token = LOVE
	case "ME":
		token = ME
	case "\n":
			token = NL
	default:
		token =NUMBER
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
	// MEMO: ここからスタート
	yyParse(l)
	fmt.Printf("%#v\n", l.result)
}
