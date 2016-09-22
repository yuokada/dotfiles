# Overview

[goyaccで構文解析を行う - Qiita][qiita_main]

これをやっていくためのディレクトリ。

## Tutorial

### 1. edit

```
$ vim parser.go.y
```

### 2. compile

```
$ go tool yacc -o parser.go parser.go.y; go run parser.go "1+2"
main.BinOpExpr{left:main.NumExpr{literal:"1"}, operator:43, right:main.NumExpr{literal:"2"}}
```


## Link

- [goyaccで構文解析を行う - Qiita][qiita_main]
- [goyaccを使う - Qiita][qiita_sub]
  - [yaccに関する4件の投稿 - Qiita][qiita_yacc]
- [lexとyaccで計算機](http://blog.muuny-blue.info/aad64398a969ec3186800d412fa7ab31.html "lexとyaccで計算機")
- [Yacc/Lexの使い方（簡略版）][usage_yacc]
  - [Yaccの使い方 - 6.サンプルコードとコンパイル方法][usage_yacc_6]
    - [Yaccの使い方 - 6.1サンプルコード][usage_yacc_6.1]
- [yacc 足し算 - Google 検索][google_search_yacc]


### 字句解析

- [Pythonでコンパイラ: PL/0パーサー - Qiita][qiita_python_cmpiler]
- [Pythonの字句/構文解析ライブラリ - Qiita][qiita_python_parser]
- [Python2.7でETL - Part1: pyparsingで構文解析 // masato's blog][python_pyparsing]

### support

- [language-bison-improved](https://atom.io/packages/language-bison-improved "language-bison-improved")
- [Switching syntax? - features - Atom Discussion](https://discuss.atom.io/t/switching-syntax/1006/3 "Switching syntax? - features - Atom Discussion")

<!-- links  -->

[qiita_main]: http://qiita.com/k0kubun/items/1b641dfd186fe46feb65 "goyaccで構文解析を行う - Qiita"
[qiita_sub]: http://qiita.com/draftcode/items/c9f2422fca14133c7f6a "goyaccを使う - Qiita"
[qiita_yacc]: http://qiita.com/tags/yacc "yaccに関する4件の投稿 - Qiita"
[qiita_python_cmpiler]: http://qiita.com/knoguchi/items/ee949989d0a9f04bee6f "Pythonでコンパイラ: PL/0パーサー - Qiita"
[qiita_python_parser]: http://qiita.com/shinsa82/items/94d800df630e63511014 "Pythonの字句/構文解析ライブラリ - Qiita"
[usage_yacc]: http://cis.k.hosei.ac.jp/~nakata/lectureCompiler/YaccLex/index.html "Yacc/Lexの使い方（簡略版）"
[usage_yacc_6]: http://cis.k.hosei.ac.jp/~nakata/lectureCompiler/YaccLex/6.html "Yaccの使い方"
[usage_yacc_6.1]: http://cis.k.hosei.ac.jp/~nakata/lectureCompiler/YaccLex/6.1.html "Yaccの使い方"

[google_search_yacc]:  https://www.google.co.jp/search?sourceid=chrome-psyapi2&ion=1&espv=2&ie=UTF-8&q=yacc%20%E8%B6%B3%E3%81%97%E7%AE%97&oq=yacc%20%20%E8%B6%B3%E3%81%97%E7%AE%97&aqs=chrome..69i57.3884j0j7 "yacc 足し算 - Google 検索"
[python_pyparsing]: http://masato.github.io/2014/07/01/python27-etl-pyparsing-syntactic-analysis/ "Python2.7でETL - Part1: pyparsingで構文解析 // masato's blog"
