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


## 19. Working with numbers

Rubyの算術演算は難しくない。

```ruby
puts 1 + 2
# 3
# => nil
```

### `Integer`と`Float`の割り算

`Integer / Integer`とすると整数の範囲で割り算をする。

```ruby
10 / 2
# => 5

10 / 4
# => 2

10.0 / 4
# => 2.5

10 / 4.0
# => 2.5

10 / 4.to_f
# => 2.5

(10 / 4).to_f
# => 2.0
```


### 文字列と掛け算

`String * Intger`とすると文字列を回数分つなげ合わせた文字列になる。

```ruby
# "5" * "5"
# => TypeError

"5" * 2
# => "55"

# 2 * "5"
# => TypeError

puts "-" * 20
# "--------------------"
# => nil
```


### `times`メソッド

`times`メソッドで回数分繰り返せる。

```ruby
20.times{print "-"}
# --------------------=> 20
```


### `rand`メソッド
`rand`メソッドは(0以上1未満の浮動小数点数)乱数を生成する。
`rand(n)`で0以上`n`未満(`n`を含まない)の整数乱数を取得できる。

```ruby
20.times{ puts rand(10) }
# 4
# 2
# ...
# 7
# => 20
```


### `to_i` / `to_f`メソッド

文字列など整数以外に`to_i`メソッドを適用すると`0`が返る。
同様に小数以外に`to_f`メソッドを適用すると`0.0`が返る。

```ruby
"hello".to_i
# => 0

"hello".to_f
# => 0.0
```


### Simple calculator

```ruby
puts "Simple calculator"
25.times{ print "-" }
puts
puts "Enter the first number"
num_1 = gets.chomp
puts "Enter the second number"
num_2 = gets.chomp
puts "The first number multiplied by the second number is #{num_1.to_i * num_2.to_i}"
```


## 22. Brief look at comparsion operators

### `==` / `!=`

`==`は等価性をテストする演算子。
つまり，左辺と右辺が等しいかを判定する。

`!=`は等しくないことを判定する演算子。

```ruby
10 == 9
# => false

10 == 10
# => true

10 == "10".to_i
# => true

10 == "10".to_f
# => true

10 != 9
# => true

"hello" != "bye"
# => true

"hello" != "hello"
# => false

"hello" == "hello"
# => true

"" == " "
# => false
```


### `<` / `>` / `<=` / `>=`

`<` / `>` / `<=` / `>=`は大小比較演算子である。

```ruby
100 > 99
# => true

100 >= 100
# => true

100 >= 99
# => true

100 >= 101
# => false

100 <= 101
# => true
```

### `eql?`メソッド

`eql?`メソッドでは型も含めて等価性を判定する。

```ruby
10 == "10".to_f
# => true

10 == 10.0
# => true

10 === 10.0
# => true

10.eql?(10.0)
# => false
```


## 23. Methods

同じ処理を繰り返し書かないようにするためにメソッドを用いる。
Rubyではメソッド内で最後に評価された値が戻り値となる。
明示的に`return`することもできる。
メソッドは利用する前に定義する必要がある。

```ruby
def multiply(first_num, second_num)
  first_num.to_f * second_num.to_f
end

puts "Please enter your first number"
first_number = gets.chomp
puts "Please enter your second number"
second_number = gets.chomp
puts "The first number multiplied by the second number is: #{multiply(first_number, second_number)}"
```


## 24. Branching `if` / `elsif` / `else` / `end`

Rubyでは`if` / `elsif` / `else` / `end`により条件分岐を表す。

```ruby
# if / else
if true
  # execute some code
else
  # execute some other code
end
```

### `if` / `else` / `end`

```ruby
if true
  puts "Hello"
end
# Hello

if true
  puts "Hello"
else
  puts "Bye"
end
# Hello

if true
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"
# Hello
# La la la

condition = false
if condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"
# Bye
# La la la

condition = true
if condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"
# Hello
# La la la
```

### 複数の条件

`&&`は論理積で両辺が共に`true`なら`true`，それ以外は`false`になる。

`||`は論理和で両辺のうち少なくとも一方が`true`なら`true`，それ以外は`false`になる。

```ruby
condition = true
another_condition = true
if condition && another_condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"
# Hello
# La la la

condition = true
another_condition = false
if condition && another_condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"
# Bye
# La la la

condition = true
another_condition = false
if condition || another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"
# this evaluated to true
# La la la

condition = false
another_condition = false
if condition || another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"
# this evaluated to false
# La la la
```

### 否定

`!`は否定で`true`ならば`false`に，`false`ならば`true`になる。

```ruby
condition = false
another_condition = false
if !condition && !another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"
# this evaluated to true
# La la la

condition = false
another_condition = false
if !condition || !another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"
# this evaluated to true
# La la la

condition = false
another_condition = false
if !condition || another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"
# this evaluated to true
# La la la
```

### 複雑な条件

複雑な条件は`(`，`)`でくくって表現する。

```ruby
condition = false
another_condition = false
if (!condition || another_condition) && 
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"
# this evaluated to true
# La la la
```

### `elsif`

```ruby
name = "Mashrur"

if name == "Mashrur"
  puts "Welcome to the program, Mashrur"
elsif name == "Jack"
  puts "Welcome to the program, Jack"
else
  puts "Welcome to the program, User"
end
# Welcome to the program, Mashrur

name = "Jack"

if name == "Mashrur"
  puts "Welcome to the program, Mashrur"
elsif name == "Jack"
  puts "Welcome to the program, Jack"
else
  puts "Welcome to the program, User"
end
# Welcome to the program, Jack

name = "Evgeny"

if name == "Mashrur"
  puts "Welcome to the program, Mashrur"
elsif name == "Jack"
  puts "Welcome to the program, Jack"
elsif name == "Evgeny"
  puts "Go back to helping students Evgeny"
else
  puts "Welcome to the program, User"
end
# Go back to helping students Evgeny
```


## 26. Arrays and Iterators

Rubyで配列は`[`，`]`で囲むことで定義する。
配列の要素は何でも良い(数値，文字列，別の配列，ハッシュ，オブジェクトなど)。
インデックスは0で始まる。

```ruby
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
puts a
# 1
# 2
# ...
# 9

print a
# [1, 2, 3, 4, 5, 6, 7, 8, 9]

p a
# [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### `last`メソッド

`last`メソッドで配列の最後の要素を得ることができる。

``` ruby
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
p a.last
# 9
```

### `Range` / `..`

`a..b`とすると`a`以上`b`以下の範囲を表す`Range`オブジェクトのインスタンスを得る。

```ruby
x = 1..100
# => 1..100

x.class
# => Range

x.to_a
# => [1, 2, 3, ... 99, 100]
```

### `shuffle`メソッド / `shuffle!`メソッド

`shuffle`メソッドで配列をランダムに並び替えた配列を得ることができる。
`shuffle!`メソッドは元の配列をランダムに並び替える。

```ruby
x = 1..100
# => 1..100

x.to_a.shuffle
# => [70, 4, 95, ... 99, 80]

x.to_a.shuffle!
# => [2, 74, 20, ... 18, 39]
```

### `reverse`メソッド / `reverse!`メソッド

`reverse`メソッドで配列を逆に並べ替えた配列を得ることができる。
`reverse!`メソッドで元の配列を逆に並べ替える。

Rubyでは`!`が付いたメソッドは破壊的である。

```ruby
x = (1..10).to_a
# => [1, 2, 3, ... 9, 10]

x.reverse
# => [10, 9, 8, ... 2, 1]

x
# => [1, 2, 3, ... 9, 10]

x.reverse!
# => [10, 9, 8, ... 2, 1]

x
# => [10, 9, 8, ... 2, 1]
```

### 文字列の`Range`

```ruby
x = "a".."z"
# => "a".."z"

x.to_a
# => ["a", "b", "c", ... "y", "z"]

x.to_a.shuffle
# => ["z", "m", "b", ... "o", "l"]

x.to_a.length
# => 26
```

### `<<`演算子 / `first`メソッド / `last`メソッド

`<<`演算子で配列の末尾に値を加えることができる。
`first`メソッドは配列の最初の要素を，`last`メソッド配列の最後の要素を得ることができる。

```ruby
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
# => [1, 2, 3, 4, 5, 6, 7, 8, 9]

a << 10
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.last
# => 10

a.first
# => 1
```

### `unshift`メソッド / `append`メソッド

`unshift`メソッドは配列の最初に，`append`メソッドは配列の最後に要素を追加する。

```ruby
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.unshift("Mashrur")
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.append("Mashrur")
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Mashrur"]
```

### `uniq`メソッド / `uniq!`メソッド

`uniq`メソッドで配列の重複要素を削除できる。
`uniq!`メソッドは元の配列を破壊的に変更する。

```ruby
a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Mashrur"]
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Mashrur"]

a.uniq
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

p a
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Mashrur"]

a.uniq!
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

p a
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### `empty?`メソッド

`empty?`メソッドで配列が空かを判定できる

```ruby
a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.empty?
# => false

b = []
# => []

b.empty?
# => true
```

### `include?`メソッド

`include?`メソッドで配列に与えられた値が含まれているかを判定できる。

```ruby
a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.include?("Mashrur")
# => true

a.include?("Hossain")
# => false
```

### `push`メソッド / `pop`メソッド

`push`メソッドは配列の末尾に値を加える。
`pop`メソッドは配列の末尾の要素を削除する。

```ruby
a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.push("new item")
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "new item"]

b = a.pop
# => "new item"
```

### `join`メソッド / `split`メソッド

`join`メソッドはすべての要素を文字列にして結合する。
デリミタを指定することもできる。

`split`メソッドは与えられた文字列を分割する。
分割する文字を指定しないと自身のみを要素にもつ配列を返す。

```ruby
a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# => ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

a.join
# => "Mashrur12345678910"

a.join("-")
# => "Mashrur-1-2-3-4-5-6-7-8-9-10"

a.join(", ")
# => "Mashrur, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10"

b = a.join("-")
# => "Mashrur-1-2-3-4-5-6-7-8-9-10"

b.split
# => ["Mashrur-1-2-3-4-5-6-7-8-9-10"]

b.split("-")
# => ["Mashrur", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
```

### `%w()`記法 / システム変数`_`

`%w()`記法で`(`，`)`で囲まれた空白区切りの文字列を文字列の配列リテラルとして定義できる。

irbではシステム変数`_`で直前に評価した値を得ることができる。

```ruby
%w(my name is mashrur and this is great Ruby is amazing)
# => ["my", "name", "is", "mashrur", "and", "this", "is", "great", "Ruby", "is", "amazing"]
```

### イテレータ

配列の各要素に対して処理をする方法は`for`を使う方法と`each`メソッドを利用する方法がある。

```ruby
z = %w(my name is mashrur and this is great Ruby is amazing)
# => ["my", "name", "is", "mashrur", "and", "this", "is", "great", "Ruby", "is", "amazing"]

z[0]
# => "my"

for i in z
  print i + " "
end
# my name is mashrur and this is great Ruby is amazing
# => ["my", "name", "is", "mashrur", "and", "this", "is", "great", "Ruby", "is", "amazing"]

z.each do |food|
  print food + " "
end
# my name is mashrur and this is great Ruby is amazing
# => ["my", "name", "is", "mashrur", "and", "this", "is", "great", "Ruby", "is", "amazing"]

z.each {|food| print food + " "}
# my name is mashrur and this is great Ruby is amazing
# => ["my", "name", "is", "mashrur", "and", "this", "is", "great", "Ruby", "is", "amazing"]

z.each {|food| print food.capitalize + " "}
# My Name Is Mashrur And This Is Great Ruby Is Amazing
# => ["my", "name", "is", "mashrur", "and", "this", "is", "great", "Ruby", "is", "amazing"]
```

### `select`メソッド

`select`メソッドは条件にあう要素のみを抜き出す

```ruby
z = (1..100).to_a.shuffle
# => [42, 79, 52, ... 21, 36]

z.select {|number| number.odd?}
# => [79, 85, 9, ... 65, 21]
```

## 28. Hashes

ハッシュはディクショナリ(辞書)とも呼ばれるデータ構造で，開発の場面でもよく見られる。

Rubyのハッシュは`{`，`}`で囲み，その中にキーと値のペアを入れる。
キーと値は`=>`で区切り，キーと値のペアは`,`で区切る。

ハッシュとキーから値を取り出すためには，キーを`[`，`]`で囲んでハッシュ名の後ろに置く。

```ruby
sample_hash = {'a' => 1, 'b' => 2, 'c' => 3}
# => {"a"=>1, "b"=>2, "c"=>3}

sample_hash['b']
# => 2

my_details = {'name' => 'mashrur', 'favcolor' => 'red'}
# => {"name"=>"mashrur", "favcolor"=>"red"

my_details['favcolor']
# => "red"
```

### シンボル

Rubyのシンボルはアイデンティティ(識別子)となるもの。
文字列(`String`)とは異なり，変更されることはない。

記述方法が2通りある(`{key: value}`と`{:key => value}`)。

```ruby
another_hash = {a: 1, b: 2, c: 3}
# => {:a=>1, :b=>2, :c=>3}

another_hash[:a]
# => 1
```

### `keys`メソッド / `values`メソッド

`keys`メソッドでハッシュのキーのみの配列を得ることができる。

`keyvaluess`メソッドでハッシュの値のみの配列を得ることができる。

```ruby
sample_hash = {'a' => 1, 'b' => 2, 'c' => 3}
# => {"a"=>1, "b"=>2, "c"=>3}

sample_hash.keys
# => ["a", "b", "c"]

sample_hash.values
# => [1, 2, 3]
```

### ハッシュとイテレータ

ハッシュに対して`each`メソッドを適用する場合は`|key, value|`としてキーと値の組を得ることができる。

```ruby
sample_hash = {'a' => 1, 'b' => 2, 'c' => 3}
# => {"a"=>1, "b"=>2, "c"=>3}

sample_hash.each do |key, value|
  puts "The class for key is #{key.class} and the vlaue is #{value.class}"
end
# The class for key is String and the vlaue is Integer
# The class for key is String and the vlaue is Integer
# The class for key is String and the vlaue is Integer
# => {"a"=>1, "b"=>2, "c"=>3}

my_details = {'name' => 'mashrur', 'favcolor' => 'red'}
# => {"name"=>"mashrur", "favcolor"=>"red"}

my_details.each do |key, value|
  puts "The class for key is #{key.class} and the vlaue is #{value.class}"
end
# The class for key is String and the vlaue is String
# The class for key is String and the vlaue is String
# => {"name"=>"mashrur", "favcolor"=>"red"}

my_details = {:name => 'mashrur', :favcolor => 'red'}
# => {:name=>"mashrur", :favcolor=>"red"}

my_details.each do |key, value|
  puts "The class for key is #{key.class} and the vlaue is #{value.class}"
end
# The class for key is Symbol and the vlaue is String
# The class for key is Symbol and the vlaue is String
# => {:name=>"mashrur", :favcolor=>"red"}
```

### 要素の追加・変更

```ruby
myhash = {a: 1, b: 2, c: 3, d: 4}
# => {:a=>1, :b=>2, :c=>3, :d=>4}

myhash[:e] = "Mashrur"
# => "Mashrur"

myhash
# => {:a=>1, :b=>2, :c=>3, :d=>4, :e=>"Mashrur"}

myhash[:c] = "Ruby"
# => "Ruby"

myhash
# => {:a=>1, :b=>2, :c=>"Ruby", :d=>4, :e=>"Mashrur"}

myhash.each {|some_key, some_value| puts "The class for key is #{some_key} and the vlaue is #{some_value}"}
# The class for key is a and the vlaue is 1
# The class for key is b and the vlaue is 2
# The class for key is c and the vlaue is Ruby
# The class for key is d and the vlaue is 4
# The class for key is e and the vlaue is Mashrur
# => {:a=>1, :b=>2, :c=>"Ruby", :d=>4, :e=>"Mashrur"}

myhash.select {|k, v| v.is_a?(String)}
# => {:c=>"Ruby", :e=>"Mashrur"}

myhash.each {|k, v| myhash.delete(k) if v.is_a?(String)}
# => {:a=>1, :b=>2, :d=>4}
```

## 33. Ruby Style Guide

RubyとRailsにおけるスタイルについて。
- スネークケース
  - メソッド名や変数名に使われる。
- キャメルケース
  - クラス名に使われる。
  - クラス名は最初の文字が大文字でなければならない。

インデントは2つのスペースでいれる。

参考: [Rubocopのスタイルガイド](https://github.com/fortissimo1997/ruby-style-guide/blob/japanese/README.ja.md)

```ruby
this_is_snake_case

also_snake_case

def my_name_is
  # and my code is here
end

CamelCase

camelCase

class SomeClass
end
```

## 40. Introduction to Object Oriented Programming

オブジェクト指向プログラミングとはオブジェクトとその相互作用を利用してアプリケーションを設計し実装するようなプログラミングパラダイムである。

プログラミングでオブジェクトを考えることは，物を考えることと同じ。
- 物 ←→ オブジェクト (クラスという設計図から作られる)
  - 物の特徴 ←→ オブジェクトの属性 (クラスで指定される)

1. 生徒というクラスには姓や名，メールアドレスなどの属性がある。
1. コースというクラスにはコースIDや名前などの属性がある。

Rubyでクラスを作るためには`class`キーワードを用いて大文字から始まるクラス名を続ける。

クラスから作られた実態はインスタンスと呼ばれる。
インスタンスの属性はインスタンス変数と呼ばれ`@`から始める。

```ruby
# student.rb
class Student
  @first_name
  @last_name
  @email
  @username
  @password
end

mashrur = Student.new

puts mashrur
# => #<Student:0x00007f128862bdc0>
```

インスタンスを`puts`メソッドで表示する際は，クラスの`to_s`メソッドが自動的に呼ばれる。

```ruby
# student.rb
class Student
  @first_name
  @last_name
  @email
  @username
  @password

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new

puts mashrur
# First name: 
```

## 42. Attributes, getters and stters

インスタンス変数を定義するだけではインスタンス変数にアクセスできない。

```ruby
class Student
  @first_name
  @last_name
  @email
  @username
  @password

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new

puts mashrur
# First name:

mashrur.first_name = "Mashrur"
# => NoMethodError
```

`変数名=`のメソッドを定義することで，インスタンス変数へ代入できる (setter)。

```ruby
class Student
  @first_name
  @last_name
  @email
  @username
  @password

  def first_name=(name)
    @first_name = name
  end

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new

mashrur.first_name = "Mashrur"

puts mashrur
# First name: Mashrur
```

さらに`変数名`のメソッドを定義することで，値を参照できる (getter)。

```ruby
class Student
  @first_name
  @last_name
  @email
  @username
  @password

  def first_name=(name)
    @first_name = name
  end

  def first_name
    @first_name
  end

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new

mashrur.first_name = "Mashrur"

puts mashrur.first_name
# Mashrur
```

getterやsetterは記述すると冗長なので，簡単に記述できる属性がある。

- `attr_accessor`はgetter / setterを両方実装する。
- `attr_reader`はgetterのみ実装する。

```ruby
class Student
  attr_accessor :first_name, :last_name, :email
  attr_reader :username

  @first_name
  @last_name
  @email
  @username
  @password

  def set_username
    @username = "mashrur1"
  end

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new

mashrur.first_name = "Mashrur"

mashrur.last_name = "Hossain"

mashrur.email = "mashrur@example.com"

# mashrur.username = "mashrur1"
mashrur.set_username

puts mashrur.first_name
# Mashrur

puts mashrur.last_name
# Hossain

puts mashrur.email
# mashrur@example.com

puts mashrur.username
# mashrur1
```

`initialize`メソッドは`new`を呼び出したときに実行される (コンストラクタ)。

```ruby
class Student
  attr_accessor :first_name, :last_name, :email
  attr_reader :username

  @first_name
  @last_name
  @email
  @username
  @password

  def initialize(firstname, lastname, email, username, password)
    @first_name = firstname
    @last_name = lastname
    @email = email
    @username = username
    @password = password
  end

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new("Mashrur", "Hossain", "mashrur@example.com", "mashrur1", "password1")

puts mashrur.first_name
# Mashrur

puts mashrur.last_name
# Hossain

puts mashrur.email
# mashrur@example.com

puts mashrur.username
# mashrur1
```
