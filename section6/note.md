# Section6: Associations and Authentication Systems

## 124. Introduction to Section 6: users, associations, ERD and more

- このセクションでは関連や認証などを学ぶ
- `users`テーブルと`articles`テーブルをどのように紐づけるか
  - `user.id`と`article.user_id`で突合する (主キー・外部キー)
  - 1:多の関連
- ER図 (Entity Relationship Diagram)
- `has_many`関連

## 125. One-to-many associations demo with the rails console

- ```bash
  rails generate scaffold User username:string
  rails db:migrate
  rails console
  ```

- ```ruby
  irb(main):001:0> User
  => User(id: integer, username: string, created_at: datetime, updated_at: datetime)
  irb(main):002:0> User.create(username: "mashrur")
    TRANSACTION (0.0ms)  begin transaction
    User Create (0.2ms)  INSERT INTO "users" ("username", "created_at", "updated_at") VALUES (?, ?, ?)  [["username", "mashrur"], ["created_at", "2025-06-17 15:11:08.152916"], ["updated_at", "2025-06-17 15:11:08.152916"]]
    TRANSACTION (3.9ms)  commit transaction
  => #<User:0x000077352d542c50 id: 1, username: "mashrur", created_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00>
  irb(main):003:0> User.create(username: "john")
    TRANSACTION (0.1ms)  begin transaction
    User Create (0.3ms)  INSERT INTO "users" ("username", "created_at", "updated_at") VALUES (?, ?, ?)  [["username", "john"], ["created_at", "2025-06-17 15:11:59.305830"], ["updated_at", "2025-06-17 15:11:59.305830"]]
    TRANSACTION (9.3ms)  commit transaction
  => #<User:0x000077352d47efa8 id: 2, username: "john", created_at: Wed, 18 Jun 2025 00:11:59.305830000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:59.305830000 JST +09:00>
  irb(main):004:0> User.all
    User Load (0.1ms)  SELECT "users".* FROM "users"
  =>
  [#<User:0x000077352d5ce228 id: 1, username: "mashrur", created_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00>,
  #<User:0x000077352d5ce0e8 id: 2, username: "john", created_at: Wed, 18 Jun 2025 00:11:59.305830000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:59.305830000 JST +09:00>]
  ```

- ```bash
  rails generate migration add_user_id_to_articles
  rails console
  ```

- ```ruby
  irb(main):001:0> Article.all
    (0.3ms)  SELECT sqlite_version(*)
    Article Load (0.1ms)  SELECT "articles".* FROM "articles"
  =>
  [#<Article:0x000077352ea735c0 id: 1, title: "first article", description: "description of first article", created_at: Wed, 18 Jun 2025 00:18:42.733026000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:18:42.733026000 JST +09:00, user_id: nil>,
  #<Article:0x000077352ea4c2b8 id: 2, title: "second article", description: "this is the second article", created_at: Wed, 18 Jun 2025 00:20:28.529900000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:22:03.326157000 JST +09:00, user_id: nil>,
  #<Article:0x000077352ea53bf8 id: 3, title: "third article", description: "this is the third article", created_at: Wed, 18 Jun 2025 00:20:37.383485000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:20:37.383485000 JST +09:00, user_id: nil>]
  ```

- `app/model/user.rb`
  ```ruby
  class User < ApplicationRecord
    has_many :articles
  end
  ```
- `app/model/article.rb`
  ```ruby
  class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
    belongs_to :user
  end
  ```

- ```ruby
  irb(main):001:0> User.first
    (0.3ms)  SELECT sqlite_version(*)
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000077352e7f9ab0 id: 1, username: "mashrur", created_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00>
  irb(main):002:0> user_1 = User.first
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000077352d363920 id: 1, username: "mashrur", created_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00>
  irb(main):003:0> user_1.articles
    Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 1]]
  => []

  irb(main):004:0> Article.create(title: "some article", description: "desciption of some article", user_id: user_1.id)
    TRANSACTION (0.0ms)  begin transaction
    User Load (0.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
    Article Create (0.2ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "some article"], ["description", "desciption of some article"], ["created_at", "2025-06-17 15:28:03.983997"], ["updated_at", "2025-06-17 15:28:03.983997"], ["user_id", 1]]
    TRANSACTION (147.5ms)  commit transaction
  => #<Article:0x000077352e304988 id: 4, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, user_id: 1>
  irb(main):005:0> user_1 = User.first
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000077352eaaf188 id: 1, username: "mashrur", created_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00>
  irb(main):006:0> user_1.articles
    Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 1]]
  => [#<Article:0x000077352e2f59b0 id: 4, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, user_id: 1>]

  irb(main):007:0> Article.create(title: "some article", description: "desciption of some article", user: user_1)
    TRANSACTION (0.1ms)  begin transaction
    Article Create (0.4ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "some article"], ["description", "desciption of some article"], ["created_at", "2025-06-17 15:30:02.260052"], ["updated_at", "2025-06-17 15:30:02.260052"], ["user_id", 1]]
    TRANSACTION (5.7ms)  commit transaction
  => #<Article:0x000077352d67d930 id: 5, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:30:02.260052000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:30:02.260052000 JST +09:00, user_id: 1>
  irb(main):008:0> user_1 = User.first
  User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000077352d5fa9e0 id: 1, username: "mashrur", created_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:08.152916000 JST +09:00>
  irb(main):009:0> user_1.articles
    Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 1]]
  =>
  [#<Article:0x000077352d543d08 id: 4, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, user_id: 1>,
  #<Article:0x000077352d543ba0 id: 5, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:30:02.260052000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:30:02.260052000 JST +09:00, user_id: 1>]

  irb(main):010:0> user_1.articles.build(title: "some new article", description: "description of some new article")
  => #<Article:0x000077352e313780 id: nil, title: "some new article", description: "description of some new article", created_at: nil, updated_at: nil, user_id: 1>
  irb(main):011:0> article = _
  => #<Article:0x000077352e313780 id: nil, title: "some new article", description: "description of some new article", created_at: nil, updated_at: nil, user_id: 1>
  irb(main):012:0> article.save
    TRANSACTION (0.1ms)  begin transaction
    Article Create (0.3ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "some new article"], ["description", "description of some new article"], ["created_at", "2025-06-17 15:32:47.175193"], ["updated_at", "2025-06-17 15:32:47.175193"], ["user_id", 1]]
    TRANSACTION (5.4ms)  commit transaction
  => true
  irb(main):013:0> Article.last
    Article Load (0.2ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Article:0x000077352d3b3fb0 id: 6, title: "some new article", description: "description of some new article", created_at: Wed, 18 Jun 2025 00:32:47.175193000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:32:47.175193000 JST +09:00, user_id: 1>
  irb(main):014:0> user_1.articles
    Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 1]]
  =>
  [#<Article:0x000077352d5af3f0 id: 4, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:28:03.983997000 JST +09:00, user_id: 1>,
  #<Article:0x000077352d5aed10 id: 5, title: "some article", description: "desciption of some article", created_at: Wed, 18 Jun 2025 00:30:02.260052000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:30:02.260052000 JST +09:00, user_id: 1>,
  #<Article:0x000077352d5ae6d0 id: 6, title: "some new article", description: "description of some new article", created_at: Wed, 18 Jun 2025 00:32:47.175193000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:32:47.175193000 JST +09:00, user_id: 1>]

  irb(main):015:0> user_2 = User.last
    User Load (0.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000077352d445000 id: 2, username: "john", created_at: Wed, 18 Jun 2025 00:11:59.305830000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:11:59.305830000 JST +09:00>
  irb(main):016:0> user_2.articles
    Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 2]]
  => []
  irb(main):017:0> article = Article.first
    Article Load (0.1ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<Article:0x000077352d521500 id: 1, title: "first article", description: "description of first article", created_at: Wed, 18 Jun 2025 00:18:42.733026000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:18:42.733026000 JST +09:00, user_id: nil>
  irb(main):018:0> user_2.articles << article
    TRANSACTION (0.1ms)  begin transaction
    Article Update (0.3ms)  UPDATE "articles" SET "updated_at" = ?, "user_id" = ? WHERE "articles"."id" = ?  [["updated_at", "2025-06-17 15:36:48.723286"], ["user_id", 2], ["id", 1]]
    TRANSACTION (161.3ms)  commit transaction
  => [#<Article:0x000077352d521500 id: 1, title: "first article", description: "description of first article", created_at: Wed, 18 Jun 2025 00:18:42.733026000 JST +09:00, updated_at: Wed, 18 Jun 2025 00:36:48.723286000 JST +09:00, user_id: 2>]
  ```

## 126. Create users

`users`テーブルを作るが，ユーザ名とメールアドレスを最初カラムとして追加し，パスワードは後で追加する。

現在はmain (master) ブランチにおりアプリケーションはデプロイ可能である。
これからの作業のためにfeatureブランチを作成し，デプロイできない状態のコードをmainに置かないようにする。

- userテーブル用のマイグレーションを生成する
  ```bash
  rails generate migration create_users
  ```

  - `db/migrate/yyyymmddhhmmss_create_users.rb`
    ```ruby
    class CreateUsers < ActiveRecord::Migration[6.1]
      def change
        create_table :users do |t|
          t.string :username
          t.string :email

          t.timestamps
        end
      end
    end
    ```

  ```bash
  rails db:migrate
  ```

  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
    end
    ```

  ```ruby
  irb(main):002:0> User
  => User(id: integer, username: string, email: string, created_at: datetime, updated_at: datetime)
  irb(main):003:0> User.create(username: "mashrur", email: "mashrur@example.com")
    TRANSACTION (0.0ms)  begin transaction
    User Create (0.2ms)  INSERT INTO "users" ("username", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["username", "mashrur"], ["email", "mashrur@example.com"], ["created_at", "2025-06-26 14:53:40.066628"], ["updated_at", "2025-06-26 14:53:40.066628"]]
    TRANSACTION (171.2ms)  commit transaction                      
  => #<User:0x000074c24dfff670 id: 1, username: "mashrur", email: "mashrur@example.com", created_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00, updated_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00>
  irb(main):004:0> user = User.first
    User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000074c24e4dc878 id: 1, username: "mashrur", email: "mashrur@example.com", created_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00, updated_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00>
  irb(main):006:0> user.email = "mashrur1@example.com"
  => "mashrur1@example.com"
  irb(main):007:0> user.save
    TRANSACTION (0.1ms)  begin transaction
    User Update (0.3ms)  UPDATE "users" SET "email" = ?, "updated_at" = ? WHERE "users"."id" = ?  [["email", "mashrur1@example.com"], ["updated_at", "2025-06-26 14:55:25.814706"], ["id", 1]]
    TRANSACTION (4.2ms)  commit transaction
  => true
  irb(main):009:0> User.all
    User Load (0.3ms)  SELECT "users".* FROM "users"
  => [#<User:0x000074c24e4c7c20 id: 1, username: "mashrur", email: "mashrur1@example.com", created_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00, updated_at: Thu, 26 Jun 2025 23:55:25.814706000 JST +09:00>]
  irb(main):010:0> user = User.first
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000074c24e4ad988 id: 1, username: "mashrur", email: "mashrur1@example.com", created_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00, updated_at: Thu, 26 Jun 2025 23:55:25.814706000 JST +09:00>
  irb(main):011:0> user.destroy
    TRANSACTION (0.1ms)  begin transaction
    User Destroy (0.4ms)  DELETE FROM "users" WHERE "users"."id" = ?  [["id", 1]]
    TRANSACTION (8.6ms)  commit transaction                              
  => #<User:0x000074c24e4ad988 id: 1, username: "mashrur", email: "mashrur1@example.com", created_at: Thu, 26 Jun 2025 23:53:40.066628000 JST +09:00, updated_at: Thu, 26 Jun 2025 23:55:25.814706000 JST +09:00>
  irb(main):012:0> User.all
    User Load (0.1ms)  SELECT "users".* FROM "users"
  => []
  ```
