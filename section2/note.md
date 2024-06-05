# Section2: The Ruby Programming Language

## 13 Introduction to Section 2 and Ruby

- Ruby言語を扱う
- Rubyは純粋なオブジェクト指向言語
  - すべてがオブジェクト
- Rubyはプログラマーの幸福を重視
  - コードの字面が英語に似ている
- 公式サイト: www.ruby-lang.org
  - 他にもオンライン上に多くのドキュメント

- ローカル / Repl.it / AWS Cloud9どれでも良い


### コメント

行頭に`#`を入れると行末までコメントになる


### `puts`

`puts`はput stringの略

```ruby
puts "Hello World"

# Hello World
# => nil
```


### `nil`

Rubyは何でも返す。
`nil`は何も返すものがないことを意味する。


### `p`

`p`は与えられた文字列を返す。

```ruby
p "Hello World"

#Hello World
# => "Hello World"
```


### `print`

`print`は最後に改行を入れない.

```ruby
print "Hello World"
puts "Hello World"

# Hello WorldHello World
# => nil
```


### 変数

変数はメモリ内のアドレスに対する参照につける名前

```ruby
greeting = "Hello World"
puts greeting

# Hello World
```


### メソッド

Rubyでは`def`でメソッドを定義する。
`def`はdefineの略である。
メソッドの終了は`end`で表す。

```ruby
def say_hello
  puts "Hello World"
end

say_hello

# Hello World
```


### メソッドの引数

メソッドの外側から値を受け取る方法が引数である。
メソッド名のパーレンの中にいくつでも記述できる。

```ruby
def say_hello(thing_to_say)
  puts thing_to_say
end

say_hello "Hello World Ruby is great!"

# Hello World Ruby is great!
```
