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

type NumExpr struct {
    literal string
}
type BinOpExpr struct {
    left     Expression
    operator rune
    right    Expression
}
%}

/* Union部 */
%union{
    token Token
    expr  Expression
}

%type<expr> program
%type<expr> expr
%token<token> NUMBER

%left '+', '-'
%left '*', '/'

/* 規則部 ここから */
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
    | expr '-' expr
    {
        $$ = BinOpExpr{left: $1, operator: '-', right: $3}
    }
    | expr '*' expr
    {
        $$ = BinOpExpr{left: $1, operator: '*', right: $3}
    }
    | expr '/' expr
    {
        $$ = BinOpExpr{left: $1, operator: '/', right: $3}
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
		// if token == scanner.Ident {
		// if token == scanner.Ident {
		// 			fmt.Printf("DEBUG: %d:'%s' \n", token, l.TokenText())
		// }
    lval.token = Token{token: token, literal: l.TokenText()}
    return token
}

func (l *Lexer) Error(e string) {
    panic(e)
}

func Eval(e Expression) int {
	switch e.(type) {
	case BinOpExpr:
		left := Eval(e.(BinOpExpr).left)
		right := Eval(e.(BinOpExpr).right)
		switch e.(BinOpExpr).operator {
		case '+':
			return left + right
		case '-':
			return left - right
		case '*':
			return left * right
		case '/':
			return left / right
		}
	case NumExpr:
		num, _ := strconv.Atoi(e.(NumExpr).literal)
		return num
	}
	return 0
}

func main() {
    l := new(Lexer)
    l.Init(strings.NewReader(os.Args[1]))
    // MEMO: ここからスタート
    yyParse(l)
    fmt.Printf("%#v, %d \n", l.result, Eval(l.result))
}

/* ユーザー定義部 ここまで */

// main.BinOpExpr{
//   left:main.BinOpExpr{
//     left:main.NumExpr{literal:"1"},
//     operator:43,
//     right:main.NumExpr{literal:"2"}
//   },
//   operator:43,
//   right:main.NumExpr{literal:"3"}
// }
