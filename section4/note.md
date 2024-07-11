# Section4: CRUD Operations in Ruby on Rails

## 76. Introduction To Section4: Tables, migrations and naming conventions

- Railsにおける命名規則
  - `Articles`リソース
    - モデル名: `article` (単数形)
      - モデルファイル名: `article.rb`
      - モデルクラス名: `Article` (キャメルケース)
    - テーブル名: `articles` (複数形)
      - `id`は自動で生成され，ユニークになるようRails側で管理される
      - `string`は255文字まで
      - `text`は長い文字列

- マイグレーションの作成
  `rails generate migration create_articles`
  - ファイル名の先頭にタイムスタンプがつく
- マイグレーションの実行
  `rails db:migrate`
  まだ実行されていないマイグレーションを実行する
  - 実行済みのスキーマファイルに変更を加えて実行しても反映されない
    - ロールバック(`rails db:rollback`)する
    - ロールバックは望ましくはないので，変更の度にマイグレーションファイルを作成するべき

## 78. Models and rails console

- モデルの作成
  - `app/models/Article.rb`
    ```ruby
    class Article < ApplicationRecord
    end
    ```
- Railsコンソールでのモデルの操作
  `rails console`または`rails c`
  ```ruby
  Article.all
  # (1.8ms)  SELECT sqlite_version(*)
  # Article Load (0.6ms)  SELECT "articles".* FROM "articles"
  # => []

  Article.create(title: 'first article', description: 'description of first article')
  # TRANSACTION (0.1ms)  begin transaction
  # Article Create (0.8ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "first rticle"], ["description", "description of first article"], ["created_at", "2024-07-11 13:50:59.929388"], ["updated_at", "2024-07-11 13:50:59.929388"]]
  # TRANSACTION (9.5ms)  commit transaction
  # => #<Article:0x00007f569299a210                                                   
  #  id: 1,                                                                        
  #  title: "first article",                                           
  #  description: "description of first article",                      
  #  created_at: Thu, 11 Jul 2024 22:50:59.929388084 JST +09:00,       
  #  updated_at: Thu, 11 Jul 2024 22:50:59.929388084 JST +09:00>

  Article.all
  # (0.7ms)  SELECT sqlite_version(*)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f56923d26c0
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>]

  article = Article.new
  # => #<Article:0x00007f5691914df0

  article.title = 'second article'
  # => "second article"

  article.description = 'description of second article'
  # => "description of second article"

  article
  # => #<Article:0x00007f5691914df0
  #  id: nil,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: nil,
  #  updated_at: nil>

  article.save
  # TRANSACTION (0.1ms)  begin transaction
  # Article Create (0.3ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "second article"], ["description", "description of second article"], ["created_at", "2024-07-11 13:57:01.090116"], ["updated_at", "2024-07-11 13:57:01.090116"]]
  # TRANSACTION (18.0ms)  commit transaction
  # => true

  Article.all
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f56985c1ca0
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f56985c1bd8
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>]

  article
  # => #<Article:0x00007f5691914df0
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116557 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116557 JST +09:00>

  article = Article.new(title: 'third article', description: 'description of third article')
  # => #<Article:0x00007f5691a16ca8

  article
  # => #<Article:0x00007f5691a16ca8
  #  id: nil,
  #  title: "third article",
  #  description: "description of third article",
  #  created_at: nil,
  #  updated_at: nil>

  article.save
  # TRANSACTION (0.1ms)  begin transaction
  # Article Create (0.4ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "third article"], ["description", "description of third article"], ["created_at", "2024-07-11 14:00:49.783965"], ["updated_at", "2024-07-11 14:00:49.783965"]]
  # TRANSACTION (14.1ms)  commit transaction
  # => true

  Article.all
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f5693010810
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f5693010748
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>,
  #  #<Article:0x00007f5693010680
  #   id: 3,
  #   title: "third article",
  #   description: "description of third article",
  #   created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>]

  exit
  ```

## 80. CRUD operations from rails console

- RailsコンソールでのCRUD処理
  ```ruby
  Article.all
  # (0.4ms)  SELECT sqlite_version(*)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f56928dd958
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f569289f8d8
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>,
  #  #<Article:0x00007f569289f810
  #   id: 3,
  #   title: "third article",
  #   description: "description of third article",
  #   created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>]

  Article.find(2)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f5692393998
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  Article.first
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 1]]
  # => #<Article:0x00007f56924012e0
  #  id: 1,
  #  title: "first article",
  #  description: "description of first article",
  #  created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>

  Article.last
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
  # => #<Article:0x00007f5692906290
  #  id: 3,
  #  title: "third article",
  #  description: "description of third article",
  #  created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>

  article = Article.find(2)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f56923e6b70

  articles = Article.all
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f5698f372f8

  article
  # => #<Article:0x00007f56923e6b70
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  articles
  # => [#<Article:0x00007f5698f372f8
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f5698f36df8
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>,
  #  #<Article:0x00007f5698f36cb8
  #   id: 3,
  #   title: "third article",
  #   description: "description of third article",
  #   created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>]

  article.title
  # => "second article"

  article.description
  # => "description of second article"

  article.description = 'edited - description of second article'
  # => "edited - description of second article"

  article
  # => #<Article:0x00007f56923e6b70
  #  id: 2,
  #  title: "second article",
  #  description: "edited - description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  Article.find(2)
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f56923545b8
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  article.save
  # TRANSACTION (0.1ms)  begin transaction
  # Article Update (0.4ms)  UPDATE "articles" SET "description" = ?, "updated_at" = ? WHERE "articles"."id" = ?  [["description", "edited - description of second article"], ["updated_at", "2024-07-11 14:14:48.035293"], ["id", 2]]
  # TRANSACTION (18.0ms)  commit transaction
  # => true

  Article.find(2)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f56923dec40
  #  id: 2,
  #  title: "second article",
  #  description: "edited - description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 23:14:48.035293000 JST +09:00>

  article = Article.last
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
  # => #<Article:0x00007f5698491880

  article.destroy
  # TRANSACTION (0.1ms)  begin transaction
  # Article Destroy (0.3ms)  DELETE FROM "articles" WHERE "articles"."id" = ?  [["id", 3]]
  # TRANSACTION (10.7ms)  commit transaction
  # => #<Article:0x00007f5698491880
  #  id: 3,
  #  title: "third article",
  #  description: "description of third article",
  #  created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>

  Article.all
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f5692957f78
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f5692957eb0
  #   id: 2,
  #   title: "second article",
  #   description: "edited - description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:14:48.035293000 JST +09:00>]
  ```