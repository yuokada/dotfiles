# 動機

仕事でとあるDSLから別のDSLに変換する必要に迫られ、[pyparsing](http://pyparsing.wikispaces.com/)を使ってコンパイラを書くことにしました。まずはpyparsingを理解するために[PL/0](http://ja.wikipedia.org/wiki/PL/0)を例題にしてパーサーを実装してみます。


# PL/0ってどんな言語?

PL/0はPascalに似た文法の言語です。教育用のため極小の言語仕様です。実は僕も大学三年の時にコンパイラの実習の教材として使ったことがあります。

Wikipediaにあったサンプルを下に示します。

```pascal:ex1.pl0
VAR x, squ;

PROCEDURE square;
BEGIN
   squ := x * x
END;

BEGIN
   x := 1;
   WHILE x <= 10 DO
   BEGIN
      CALL square;
      ! squ;
      x := x + 1;
   END
END.
```

# 文法
パーサーを書くためには文法の定義が必要です。文法の表記法の一つに[BNF](http://ja.wikipedia.org/wiki/%E3%83%90%E3%83%83%E3%82%AB%E3%82%B9%E3%83%BB%E3%83%8A%E3%82%A6%E3%82%A2%E8%A8%98%E6%B3%95)があります。下のPL/0の(E)BNFはリンク先のWikipediaから頂いてきました。BNFは終端記号と生成規則から成り立っています。

WikipediaにあったPL/0のBNFにはident(識別子)が含まれていなかったので、追加しました。

予約語は小文字になっていますが、先ほどのサンプルをパースするには大文字の対応が必要になるでしょう。

```bnf:pl0_bnf.txt
ident = alpha { alpha | number | '_' } .

program = block "." .

block = [ "const" ident "=" number {"," ident "=" number} ";"]
        [ "var" ident {"," ident} ";"]
        { "procedure" ident ";" block ";" } statement .
statement = [ ident ":=" expression | "call" ident |
            "begin" statement {";" statement } "end" |
            "if" condition "then" statement |
            "while" condition "do" statement ].
condition = "odd" expression |
            expression ("="|"#"|"<"|"<="|">"|">=") expression .
expression = [ "+"|"-"] term { ("+"|"-") term}.
term = factor {("*"|"/") factor}.
factor = ident | number | "(" expression ")".
```

# パーサー

文法を完全に満たすパーサーをいきなり書こうとすると大変です。どうしたらよいでしょうか？終端記号に近いところから始め、最小構成単位毎に実装とテストを行って、あとはそれらを組み合わせて積み上げる方針が良いです。

具体的には予約語(reserved keyword)、識別子(identifier)、式(expression), 文(statement)、ブロック、宣言、プログラムという順になります。意外なことに変数の宣言などの基本は最後の方で実装することになりました。

**先に方針を立てるのはとても大切です。** ある生成規則を実装
しているとき未実装の生成規則が見つかったら、それを実装してまた元に戻ってとやっていると、入れ子や再帰的参照の奥深くにハマる可能性が高いです。

それでは次の順で実装していきましょう。

1. keyword
2. ident
3. term, factor, expression
4. condition
5. assignment (ident := expressionのこと)
6. call
7. if, then
8. while, do
9. statement, begin-end
10. const
11. var
12. procedure
13. block
14. program

## reserved keyword - 予約語
PL/0の予約語はBNFから読み取る限り、const, var, procedure, call, begin, end, if, then, while, do, oddです。pyparsingでは`Keyword()`で予約語を宣言することができます。大文字小文字を区別しない予約語はCaselessKeyword()で宣言します。

```py
CONST = CaselessKeyword('CONST')
VAR = CaselessKeyword('VAR')
 :
```

と書く代わりに、次のように書くのが推奨されているようです。もうちょっとDRYな書き方はないのでしょうか...

```py
from pyparsing import CaselessKeyword, MatchFirst
(CONST, VAR, PROCEDURE, CALL, BEGIN, END, IF, THEN, WHILE, DO, ODD) = map(CaselessKeyword,
"CONST, VAR, PROCEDURE, CALL, BEGIN, END, IF, THEN, WHILE, DO, ODD".replace(",","").split())

keyword = MatchFirst((CONST, VAR, PROCEDURE, CALL, BEGIN, END, IF, THEN, WHILE, DO, ODD))
```

結果は大文字小文字に関係なく、CONSTと認識しました。

```
>>> print keyword.parseString('CONST')
['CONST']
>>> print keyword.parseString('const')
['CONST']
```

## identifier - 識別子
識別子の定義は、先頭がアルファベット、続いてアルファベットまたは数字と_が繰り返されるというのが一般的ですので、それに従うことにします。また予約語は識別子になれないので`~keyword`を先頭に書きます。

```
from pyparsing import Word, alphas, alphanums
ident = ~keyword + Word(alphas, alphanums+"_")
```

有効な識別子、無効な識別子、予約語をそれぞれパースした結果、有効な識別子だけ成功しました。

```
>>> print repr(ident.parseString('valid_id'))
(['valid_id'], {})
>>> print repr(ident.parseString('0123bad_id'))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib/python2.7/dist-packages/pyparsing.py", line 1041, in parseString
    raise exc
pyparsing.ParseException: Expected W:(abcd...,abcd...) (at char 0), (line:1, col:1)
>>> print repr(ident.parseString('CONST'))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib/python2.7/dist-packages/pyparsing.py", line 1041, in parseString
    raise exc
pyparsing.ParseException: Found unwanted token, {"CONST" | "VAR" | "PROCEDURE" | "CALL" | "BEGIN" | "END" | "IF" | "THEN" | "WHILE" | "DO" | "ODD"} (at char 0), (line:1, col:1)
```

## expression - 式

PL/0の式は次のBNFで完結しています。

```
expression = [ "+"|"-"] term { ("+"|"-") term}.
term = factor {("*"|"/") factor}.
factor = ident | number | "(" expression ")"
```

pyparsingの実装は次のようになります。生成規則が再帰的に参照されているときは`Forward`を使ってまず箱を用意しておきます。あとから生成規則をセットするには`<<`を使います。oneOfをつかっているのは演算子の優先順位が同じという意味です。

<<とせずに、いつものノリでうっかり=を使ってしまうと一見原因不明のエラーとなりデバッグに悩まされます。また<<を使うときは右辺を()で括るようにしましょう。`x << y | z`と`x << (y | z)`は演算子の優先順位に起因して計算結果がことななるため。当然利用したいのは後者です。これもパース時に原因不明のエラーとなり、デバッグに悩まされます。pyparsingの仕様なので、そういうものだと思って気をつけるしかないです。

```py
number = Regex(r"\d+(\.\d*)?([eE][+-]?\d+)?")
term = Forward()
factor = Forward()
expression = Optional(oneOf("+ -")) + term + ZeroOrMore( oneOf("+ -") + term)
term << factor + ZeroOrMore(oneOf("* /") + factor)
factor << ident | number | "(" + expression + ")"
```

ではテストしてみましょう。正しくパースできているようです。

```
>>> expression.parseString('123')
(['123'], {})
>>> expression.parseString('123+456')
(['123', '+', '456'], {})
>>> expression.parseString('(x+y)*z')
(['(', 'x', '+', 'y', ')', '*', 'z'], {})
```

## condition - 条件式
PL/0はなぜか"odd"なる単項演算子があります。それ以外は普通の二項演算子ばかりです。pyparsingにはinfixNotationという条件式パーサーを生成するための仕組みがあるのですが、ここではBNFに忠実に実装します。

```
condition = "odd" expression |
            expression ("="|"#"|"<"|"<="|">"|">=") expression .
```

実装は次のとおり。

```py
condition = ODD + expression | expression + oneOf('= # < <= > >=') + expression
```

テスト

```
>>> condition.parseString('odd 1')
(['ODD', '1'], {})
>>> condition.parseString('3 <= 1')
(['3', '<=', '1'], {})
```

## assign - 代入文
代入のBNFは`ident ":=" expression`です。identもexpressionも実装済みなので簡単ですね。

```py
assign_statement = ident + ":=" + expression
```

## call - 手続き呼び出し文
同じことの繰り返しなので、ここからは実装のみで行きます。

```py
call_statement = CALL + ident
```

## if-then - IF文

IF文を定義します。文全体を表すstatementはまだ出てきていないのでForwardで宣言しておきます。

```py
statement = Forward()
if_statement = IF + condition + THEN + statement
```

## while-do - WHILE文

```py
while_statement = WHILE + condition + DO + statement
```

## statement - 文
やっとパーツがそろったので、最後に文生成規則を定義します。BNFは次のとおり。

```
statement = [ ident ":=" expression | "call" ident |
            "begin" statement {";" statement } "end" |
            "if" condition "then" statement |
            "while" condition "do" statement ].
```

そのままpyparsingで実装します。

```py
statement = Optional(assign_statement
                   | call_statement
                   | BEGIN + statement + ZeroOrMore(";" + statement) + END
                   | if_statement
                   | while_statement
                   )
```

## const - 定数宣言
疲れてきたので実装だけ。

```py
const = CONST + ident + "=" + number + ZeroOrMore("," + ident + "=" + number) + ";"
```

## var - 変数宣言

```py
var = VAR + ident + ZeroOrMore("," + ident) + ";"
```

## procedure -  手続き宣言

BNFのこの部分`"procedure" ident ";" block ";" `だけに注目します。外側の繰り返しなどはブロックの実装時に行います。

```py
block = Forward()
procedure = PROCEDURE + ident + ";" + block + ";"
```

## block
```py
block << Optional(const) + Optional(var) + ZeroOrMore(procedure) + statement
```

## program
これが最上位の生成規則です。お疲れ様でした。

```
program = block + "."
```

# テスト
冒頭に掲載した、サンプルプログラムをパースしてみます。

```
$ python pl0_parser.py ex1.pl0
Traceback (most recent call last):
  File "pl0_parser.py", line 64, in <module>
    print program.parseString(txt)
  File "/usr/lib/python2.7/dist-packages/pyparsing.py", line 1041, in parseString
    raise exc
pyparsing.ParseException: Expected "." (at char 59), (line:8, col:1)
```

通りませんね。なんででしょう。line:8, col:1と言っているのでBEGIN-ENDのパースが出来ず、プログラム終了の"."を期待しているようです。この辺りもう少し親切なエラーが出せないのでしょうか。確認のためstatementパーサーだけでテストしてみます。

```
>>> statement.parseString('''\
... BEGIN
...    x := 1;
...    WHILE x <= 10 DO
...    BEGIN
...       CALL square;
...       ! squ;
...       x := x + 1;
...    END
... END
... ''')
([], {})
```

結果が空で確かに失敗しています。クラッシュしない失敗はデバッグが面倒です。よく見ると`! squ;`という見慣れない文があります。これは拡張PL/0の文法で、今回の実装のBNFでは定義されていません。削除してもう一度走らせます。

```
$ python pl0_parser.py ex1.pl0
['VAR', 'x', ',', 'squ', ';', 'PROCEDURE', 'square', ';', 'BEGIN', 'squ', ':=', 'x', '*', 'x', 'END', ';', 'BEGIN', 'x', ':=', '1', ';', 'WHILE', 'x', '<=', '10', 'DO', 'BEGIN', 'CALL', 'square', ';', 'x', ':=', 'x', '+', '1', ';', 'END', 'END', '.']
```

うまく行きました！

次回は本格的に構文木(AST)を作ってコード生成をやりたいと思います。

# ソースコード

最後に今まで実装してきたパーサーのソースを掲載します。

```py:pl0_parser.py
from pyparsing import CaselessKeyword, MatchFirst, Word, alphas, alphanums, Forward, Optional, oneOf, ZeroOrMore, Regex


# 1. reserved keyword
(CONST, VAR, PROCEDURE, CALL, BEGIN, END, IF, THEN, WHILE, DO, ODD) = map(CaselessKeyword,
"CONST, VAR, PROCEDURE, CALL, BEGIN, END, IF, THEN, WHILE, DO, ODD".replace(",", "").split())
keyword = MatchFirst((CONST, VAR, PROCEDURE, CALL, BEGIN, END, IF, THEN, WHILE, DO, ODD))

# 2. identifier
ident = ~keyword + Word(alphas, alphanums + "_")

# 3. expression
number = Regex(r"\d+(\.\d*)?([eE][+-]?\d+)?")
term = Forward()
factor = Forward()
expression = Optional(oneOf("+ -")) + term + ZeroOrMore(oneOf("+ -") + term)
term << (factor + ZeroOrMore(oneOf("* /") + factor))
factor << (ident | number | "(" + expression + ")")

# 4. condition
condition = ODD + expression | expression + oneOf('= # < <= > >=') + expression

# 5. assignment
assign_statement = ident + ":=" + expression

# 6. call
call_statement = CALL + ident

# 7. if-then
statement = Forward()
if_statement = IF + condition + THEN + statement

# 8. while-do
while_statement = WHILE + condition + DO + statement

# 9. statement
statement << Optional(assign_statement
                      | call_statement
                      | BEGIN + statement + ZeroOrMore(";" + statement) + END
                      | if_statement
                      | while_statement
)

# 10. const
const = CONST + ident + "=" + number + ZeroOrMore("," + ident + "=" + number) + ";"

# 11. var
var = VAR + ident + ZeroOrMore("," + ident) + ";"

# 12. procedure
block = Forward()
procedure = PROCEDURE + ident + ";" + block + ";"

# 13. block
block << Optional(const) + Optional(var) + ZeroOrMore(procedure) + statement

# 14. program
program = block + "."

if __name__ == '__main__':
    import sys
    with open(sys.argv[1], 'r') as fp:
        txt = fp.read()
        print program.parseString(txt)
```
