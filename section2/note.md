# Section2: The Ruby Programming Language

## 13. Introduction to Section 2 and Ruby

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


## 15. Working with Strings part 1

- 文字列はテキストデータをRubyで表現する方法

### 文字列

文字列は`"`または`'`で囲むことで定義できる。
`'`を使うと文字列の補間(interpolation)ができない。

```ruby
sentence = "My name is Marshrur"
sentence = 'My name is Marshrur'
p sentence

# My name is Marshrur
```


### 文字列の結合

```ruby
first_name = "Mashrur"
last_name = "Hossanin"

puts first_name + last_name
# MashrurHossanin

puts first_name + " " + last_name
# Mashrur Hossanin
```


### 文字列の補間

`"`で囲まれた文字列中で`#{変数名}`とすることで変数を埋め込める。
`'`で囲まれた文字列ではできない。

```ruby
first_name = "Mashrur"
last_name = "Hossanin"

puts "My first name is #{first_name} and my last name is #{last_name}"
# My first name is Mashrurand my last name is Hossanin

puts 'My first name is #{first_name} and my last name is #{last_name}'
# My first name is #{first_name} and my last name is #{last_name}
```


### RubyのREPL

`irb`コマンドでREPLが利用可能。

```plain
$ irb
irb(main):001:0> first_name = "Mashrur"
=> "Mashrur"
irb(main):002:0> last_name = "Hossanin"
=> "Hossanin"
irb(main):003:0> full_name = first_name + " " + last_name
=> "Mashrur Hossanin"
irb(main):004:0> full_name
=> "Mashrur Hossanin"
irb(main):005:0> 
```


### 全てはクラスである

インスタンスがもつ`class`メソッドでどのクラスから生成されたインスタンスかがわかる。
Rubyではプリミティブ型もオブジェクトである。

インスタンスのもつメソッドは`methods`メソッドで取得できる。

2つのメソッドを連続して呼び出すことをメソッドチェーンと呼ぶ。
(あまり続けすぎると読みづらい。)

```ruby
"Mashrur".class
# => String

10.class
# => Integer

10.0.class
# => Float

"Mashrur".methods
# => [:unicode_normalized?, :encode!, ... , :equal? ]

10.class
# => Integer

10.to_s.class
# => String

"Mashrur".length
# => 7

"Mashrur".reverse
# => "rurhsaM"

"Mashrur".capitalize
# => "Mashrur"

"Mashrur".empty?
# => false

"".empty?
# => true
```


### `nil`の扱い

`nil`の判定は`nil?`メソッドで行う。
`nil?`が`true`となるのは`nil`のみである。

```ruby
"".empty?
# => true

"".nil?
# => false

nil.nil?
# => true
```


### 文字列の置換

```ruby
sentence = "Welcome to the jungle"
# => "Welcome to the jungle"

sentence.sub("the jungle", "utopia")
# => "Welcome to utopia"
```


### 変数と代入

Rubyでは文字列は代入すると新たな領域で確保される。

```ruby
first_name = "Mashrur"

new_first_name = first_name
p new_first_name
# => "Mashrur"

first_name = "John"

p new_first_name
# => "Mashrur"
```


### エスケープシーケンス

`\`で直後の特殊文字をエスケープできる。

```ruby
'the new first name is #{new_first_name}'
# => "the new first name is \#{new_first_name}"

"the new first name is \#{new_first_name}"
# => "the new first name is \#{new_first_name}"

'Mashrur aske 'Hey John, how are you doing?''
# => Syntax Error

'Mashrur aske \'Hey John, how are you doing?\''
# => => "Mashrur aske 'Hey John, how are you doing?'"
```


## 16. Working with Strings part 2: Getting input from user

### `gets`メソッドと`chomp`メソッド

ユーザからの入力を標準入力から得るためには`gets`メソッドと`chomp`メソッドを使う。

```ruby
puts "What is your first name?"
first_name = gets.chomp
puts "Thank you, you said your first name is #{first_name}"

puts "Enter a number to multiply by 2"
input = gets.chomp
puts input.to_i * 2
```
