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

## 128. Add user validations

- `User`クラスにバリデーションを追加する
  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      validates :username, presence: true, length: { minimum: 3, maximum: 25 }
    end
    ```

  - 確認する
    ```ruby
    irb(main):001:0> user = User.new(username: "aa", email: "aa@example.com")
      (0.3ms)  SELECT sqlite_version(*)
    => #<User:0x000074c24e5b8350 id: nil, username: "aa", email: "aa@example.com", created_at: nil, updated_at: nil>
    irb(main):002:0> user.valid?
    => false
    irb(main):003:0> user.errors.full_messages
    => ["Username is too short (minimum is 3 characters)"]

    irb(main):004:0> user = User.new(username: "a", email: "aa@example.com")
    => #<User:0x000074c24e477f90 id: nil, username: "a", email: "aa@example.com", created_at: nil, updated_at: nil>
    irb(main):005:0> user.errors.full_messages
    => []
    irb(main):006:0> user.save
    => false
    irb(main):007:0> user.errors.full_messages
    => ["Username is too short (minimum is 3 characters)"]
    ```

  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
      validates :email, presence: true, length: { maximum: 105 }
    end
    ```

  - 確認する
    ```ruby
    irb(main):009:0> reload!
    Reloading...
    => true

    irb(main):010:0> User.all
      (0.0ms)  SELECT sqlite_version(*)
      User Load (0.1ms)  SELECT "users".* FROM "users"
    => []
    irb(main):011:0> user = User.new(username: "aaa", email: "aaa@example.com")
    => #<User:0x000074c24d239860 id: nil, username: "aaa", email: "aaa@example.com", created_at: nil, updated_at: nil>
    irb(main):012:0> user.save
      TRANSACTION (0.1ms)  begin transaction
      User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."username" = ? LIMIT ?  [["username", "aaa"], ["LIMIT", 1]]
      User Create (0.2ms)  INSERT INTO "users" ("username", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["username", "aaa"], ["email", "aaa@example.com"], ["created_at", "2025-06-26 15:18:45.645020"], ["updated_at", "2025-06-26 15:18:45.645020"]]
      TRANSACTION (157.8ms)  commit transaction
    => true
    irb(main):013:0> User.all
      User Load (4.2ms)  SELECT "users".* FROM "users"
    => [#<User:0x000074c24e4556e8 id: 2, username: "aaa", email: "aaa@example.com", created_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00>]

    irb(main):014:0> user = User.new(username: "aaa", email: "aaa@example.com")
    => #<User:0x000074c24c445268 id: nil, username: "aaa", email: "aaa@example.com", created_at: nil, updated_at: nil>
    irb(main):015:0> user.valid?
      User Exists? (0.4ms)  SELECT 1 AS one FROM "users" WHERE "users"."username" = ? LIMIT ?  [["username", "aaa"], ["LIMIT", 1]]
    => false
    irb(main):016:0> user.errors.full_messages
    => ["Username has already been taken"]

    irb(main):017:0> user = User.new(username: "Aaa", email: "aaa@example.com")
    => #<User:0x000074c24dfe2d90 id: nil, username: "Aaa", email: "aaa@example.com", created_at: nil, updated_at: nil>
    irb(main):018:0> user.valid?
      User Exists? (0.6ms)  SELECT 1 AS one FROM "users" WHERE "users"."username" = ? LIMIT ?  [["username", "Aaa"], ["LIMIT", 1]]
    => true
    ```

  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
      validates :email, presence: true, length: { maximum: 105 }
    end
    ```

  - 確認する
    ```ruby
    irb(main):019:0> reload!
    Reloading...
    => true
    irb(main):020:0> user = User.new(username: "Aaa", email: "aaa@example.com")
      (0.1ms)  SELECT sqlite_version(*)
    => #<User:0x000074c24d256258 id: nil, username: "Aaa", email: "aaa@example.com", created_at: nil, updated_at: nil>
    irb(main):021:0> user.valid?
      User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) LIMIT ?  [["username", "Aaa"], ["LIMIT", 1]]
    => false
    irb(main):022:0> user.errors.full_messages
    => ["Username has already been taken"]
    ```

  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      validates :username,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 25 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { maximum: 105 },
        format: { with: VALID_EMAIL_REGEX }
    end
    ```

  - 確認する
    ```ruby
    irb(main):023:0> reload!
    Reloading...
    => true
    irb(main):024:0> user = User.new(username: "mashrur", email: "mashrur@com")
      (0.1ms)  SELECT sqlite_version(*)
    => #<User:0x000074c24e40b688 id: nil, username: "mashrur", email: "mashrur@com", created_at: nil, updated_at: nil>
    irb(main):025:0> user.valid?
      User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) LIMIT ?  [["username", "mashrur"], ["LIMIT", 1]]
      User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "mashrur@com"], ["LIMIT", 1]]
    => false
    irb(main):026:0> user.errors.full_messages
    => ["Email is invalid"]

    irb(main):027:0> user = User.new(username: "mashrur", email: "mashrur@example.com")
    => #<User:0x000074c24e55da40 id: nil, username: "mashrur", email: "mashrur@example.com", created_at: nil, updated_at: nil>
    irb(main):028:0> user.valid?
      User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) LIMIT ?  [["username", "mashrur"], ["LIMIT", 1]]
      User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "mashrur@example.com"], ["LIMIT", 1]]
    => true
    irb(main):029:0> user.save
      TRANSACTION (0.1ms)  begin transaction
      User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) LIMIT ?  [["username", "mashrur"], ["LIMIT", 1]]
      User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "mashrur@example.com"], ["LIMIT", 1]]
      User Create (0.3ms)  INSERT INTO "users" ("username", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["username", "mashrur"], ["email", "mashrur@example.com"], ["created_at", "2025-06-26 15:33:48.494953"], ["updated_at", "2025-06-26 15:33:48.494953"]]
      TRANSACTION (5.6ms)  commit transaction
    => true
    ```

## 130. One to many association

- `User`と`Article`の関連付け

  ```bash
  rails generate migration add_user_id_to_articles
  ```

  - `db/migrate/yyyymmddhhmmss_add_user_id_to_articles.rb`
    ```ruby
    class AddUserIdToArticles < ActiveRecord::Migration[6.1]
      def change
        add_column :articles, :user_id, :int
      end
    end
    ```


  ```bash
  rails db:migrate
  ```

  - `rails console`
    ```ruby
    irb(main):001:0> Article.all
      (0.3ms)  SELECT sqlite_version(*)
      Article Load (0.1ms)  SELECT "articles".* FROM "articles"
    =>
    [#<Article:0x00007fcafc049380 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, user_id: nil>,
    #<Article:0x00007fcae75d6ec0 id: 2, title: "hogehoge", description: "hogehoge foo bar\r\n\r\n1. sample\r\n2. hogehoge\r\n3. foobar", created_at: Tue, 10 Jun 2025 23:12:09.503475000 JST +09:00, updated_at: Wed, 11 Jun 2025 00:13:29.153886000 JST +09:00, user_id: nil>]
    irb(main):002:0> Article
    => Article(id: integer, title: string, description: text, created_at: datetime, updated_at: datetime, user_id: integer)
    irb(main):003:0> article = Article.first
      Article Load (0.2ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 1]]
    => #<Article:0x00007fcae74ab730 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, user_id: nil>
    irb(main):004:0> article.user
    /home/user/.gem/gems/activemodel-6.1.7.8/lib/active_model/attribute_methods.rb:469:in `method_missing': undefined method `user' for #<Article id: 1, title: "sample", description: "this is sample article.", created_at: "2025-06-10 23:08:45.698320000 +0900", updated_at: "2025-06-10 23:08:45.698320000 +0900", user_id: nil> (NoMethodError)              
    Did you mean?  user_id
    ```

  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      has_many :articles
      validates :username,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 25 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { maximum: 105 },
        format: { with: VALID_EMAIL_REGEX }
    end
    ```

  - `app/models/article.rb`
    ```ruby
    class Article < ApplicationRecord
      belongs_to :user
      validates :title, presence: true, length: { minimum: 6, maximum: 100 }
      validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    end
    ```

  - `rails console`
    ```bash
    irb(main):005:0> reload!
    Reloading...
    => true
    irb(main):006:0> article = Article.first
      (0.1ms)  SELECT sqlite_version(*)
      Article Load (0.1ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 1]]
    => #<Article:0x00007fcae753abd8 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, user_id: nil>
    irb(main):007:0> article.user
    => nil
    irb(main):008:0> user = User.first
      User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
    => #<User:0x00007fcafd535f78 id: 2, username: "aaa", email: "aaa@example.com", created_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00>
    irb(main):009:0> user.articles
      Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 2]]
    => []
    irb(main):010:0> user.articles << article
      TRANSACTION (0.1ms)  begin transaction
      Article Update (0.3ms)  UPDATE "articles" SET "updated_at" = ?, "user_id" = ? WHERE "articles"."id" = ?  [["updated_at", "2025-07-03 15:04:26.743915"], ["user_id", 2], ["id", 1]]
      TRANSACTION (8.3ms)  commit transaction
    => [#<Article:0x00007fcae753abd8 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:04:26.743915707 JST +09:00, user_id: 2>]
    irb(main):011:0> user.articles
    => [#<Article:0x00007fcae753abd8 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:04:26.743915707 JST +09:00, user_id: 2>]
    irb(main):012:0> article.user
    => #<User:0x00007fcafd535f78 id: 2, username: "aaa", email: "aaa@example.com", created_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00>
    irb(main):013:0> article.user.username
    => "aaa"
    ```

- ログインしたユーザが記事を作成・編集できるようにする
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def create
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
          flash[:notice] = 'Article was created successfully.'
          redirect_to @article
        else
          render 'new'
        end
      end

      # ...
    end
    ```

  - `rails console`
    ```ruby
    irb(main):001:0> Article.update_all(user_id: User.first.id)
      (0.3ms)  SELECT sqlite_version(*)
      User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]             
      Article Update All (8.1ms)  UPDATE "articles" SET "user_id" = ?  [["user_id", 2]]                              
    => 2
    irb(main):002:0> Article.all
      Article Load (0.1ms)  SELECT "articles".* FROM "articles"
    =>                                                                                                               
    [#<Article:0x00007fcae6f90c00 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:04:26.743915000 JST +09:00, user_id: 2>,
    #<Article:0x00007fcae6f78830 id: 2, title: "hogehoge", description: "hogehoge foo bar\r\n\r\n1. sample\r\n2. hogehoge\r\n3. foobar", created_at: Tue, 10 Jun 2025 23:12:09.503475000 JST +09:00, updated_at: Wed, 11 Jun 2025 00:13:29.153886000 JST +09:00, user_id: 2>]
    ```

## 132. Show user info in articles

- 記事ページにユーザ情報を表示する
  - `app/views/articles/index.html.erb`
    ```erb
    <!-- ... -->
    <div class="card-header font-italic">
      by <%= article.user.username if article.user %>
    </div>
    <!-- ... -->
    ```

  - `app/views/articles/show.html.erb`
    ```erb
    <!-- ... -->
    <div class="card-header font-italic">
      by <%= @article.user.username if @article.user %>
    </div>
    <!-- ... -->
    ```

## 134. Alter object state before_save

- `before_save`メソッドを利用してDBへ格納する前にメールアドレスを小文字に変換してストアする
  - `rails console`
    ```ruby
    irb(main):001:0> User.create(username: "janedoe", email: "JanEDoE@example.com")
      (0.4ms)  SELECT sqlite_version(*)
      TRANSACTION (0.0ms)  begin transaction
      User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) LIMIT ?  [["username", "janedoe"], ["LIMIT", 1]]
      User Exists? (0.0ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "JanEDoE@example.com"], ["LIMIT", 1]]
      User Create (0.2ms)  INSERT INTO "users" ("username", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["username", "janedoe"], ["email", "JanEDoE@example.com"], ["created_at", "2025-07-03 15:26:47.372483"], ["updated_at", "2025-07-03 15:26:47.372483"]]
      TRANSACTION (5.5ms)  commit transaction
    => #<User:0x00007fcafc03f0b0 id: 4, username: "janedoe", email: "JanEDoE@example.com", created_at: Fri, 04 Jul 2025 00:26:47.372483000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:26:47.372483000 JST +09:00>
    ```

  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      before_save { self.email = email.downcase }
      # ...
    end
    ```

  - `rails console`
    ```ruby
    irb(main):002:0> reload!
    Reloading...
    => true
    irb(main):003:0> User.create(username: "janetdoe", email: "JanETDoE@example.com")
      (0.0ms)  SELECT sqlite_version(*)
      TRANSACTION (0.0ms)  begin transaction
      User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) LIMIT ?  [["username", "janetdoe"], ["LIMIT", 1]]
      User Exists? (0.0ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "JanETDoE@example.com"], ["LIMIT", 1]]
      User Create (0.2ms)  INSERT INTO "users" ("username", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["username", "janetdoe"], ["email", "janetdoe@example.com"], ["created_at", "2025-07-03 15:29:10.089270"], ["updated_at", "2025-07-03 15:29:10.089270"]]
      TRANSACTION (4.1ms)  commit transaction
    => #<User:0x00007fcae75e7540 id: 5, username: "janetdoe", email: "janetdoe@example.com", created_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00>
    ```

## 136. Add secure password

- ユーザーが登録できるように認証システムを実装する
- Deviseという人気のgemがあるが，今回はどのように認証が行われるかを理解するため自前で実装する
- ユーザーテーブル
    | `id` | `username` | `email` | `password` |
    | `1` | `mashrur` | `mash@example.com` | <s>`password123`</s> → `$2a$12$eOvhlQY4zy/j79bMvtDWgub8zPf/kz/vwPda5VileM9L6aaY.a4BC` |

  - パスワードをハッシュ化する (一方向にしか変換できない)
  - ハッシュアルゴリズムは攻撃者にも既知である
  - 数多くの元のメッセージとハッシュ値のテーブルから予測してパスワードを復元できるかもしれない (レインボー攻撃)
  - そのためにソルトというランダムな文字列を付与する

- `app/models/user.rb`
  ```ruby
  class User < ApplicationRecord
    # ...  
    has_secure_password
  end
  ```
- `rails generate migration add_password_digest_to_users`
- `db/migrate/yyyymmddhhmmss_add_password_digest_to_users.rb`
  ```ruby
  class AddPasswordDigestToUsers < ActiveRecord::Migration[6.1]
    def change
      add_column :users, :password_digest, :string
    end
  end
  ```
- `rails db:migrate`
- `rails console`
  ```ruby
  irb(main):001:0> User.all
    (0.2ms)  SELECT sqlite_version(*)
    User Load (0.1ms)  SELECT "users".* FROM "users"
  =>
  [#<User:0x000079dfdf124b50 id: 2, username: "aaa", email: "aaa@example.com", created_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, password_digest: nil>,
  #<User:0x000079dfdf0e47f8 id: 3, username: "mashrur", email: "mashrur@example.com", created_at: Fri, 27 Jun 2025 00:33:48.494953000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:33:48.494953000 JST +09:00, password_digest: nil>,
  #<User:0x000079dfdf0e45c8 id: 4, username: "janedoe", email: "JanEDoE@example.com", created_at: Fri, 04 Jul 2025 00:26:47.372483000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:26:47.372483000 JST +09:00, password_digest: nil>,
  #<User:0x000079dfdf0eb918 id: 5, username: "janetdoe", email: "janetdoe@example.com", created_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, password_digest: nil>]
  irb(main):002:0> BCrypt::Password.create("password")
  => "$2a$12$joiUbiNk.B8qEI2iggl61ecEHJptm4yC5FPRQe19gZRzQlIY6102u"
  irb(main):003:0> BCrypt::Password.create("password")
  => "$2a$12$f3td.qfVBilgI6xI2TTABuWTLK1FVTXIkyi8xVMW2sentPjRHmozi"
  irb(main):004:0> password = _
  => "$2a$12$f3td.qfVBilgI6xI2TTABuWTLK1FVTXIkyi8xVMW2sentPjRHmozi"
  irb(main):005:0> password
  => "$2a$12$f3td.qfVBilgI6xI2TTABuWTLK1FVTXIkyi8xVMW2sentPjRHmozi"
  irb(main):006:0> password.salt
  => "$2a$12$f3td.qfVBilgI6xI2TTABu"
  irb(main):007:0> user = User.last
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<User:0x000079dfdeed0110 id: 5, username: "janetdoe", email: "janetdoe@example.com", created_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, password_digest: nil>
  irb(main):008:0> user.password =  "password123"
  => "password123"
  irb(main):009:0> user.save
    TRANSACTION (0.1ms)  begin transaction
    User Exists? (0.1ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."username") = LOWER(?) AND "users"."id" != ? LIMIT ?  [["username", "janetdoe"], ["id", 5], ["LIMIT", 1]]
    User Exists? (0.0ms)  SELECT 1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) AND "users"."id" != ? LIMIT ?  [["email", "janetdoe@example.com"], ["id", 5], ["LIMIT", 1]]
    User Update (0.2ms)  UPDATE "users" SET "updated_at" = ?, "password_digest" = ? WHERE "users"."id" = ?  [["updated_at", "2025-07-22 13:02:00.649839"], ["password_digest", "$2a$12$HYrlPRkuXzCCXe93mSojAOFbqnKyuEmHkkapanDPfFiRY5NsCu8Hm"], ["id", 5]]
    TRANSACTION (8.4ms)  commit transaction
  => true
  irb(main):010:0> User.all
    User Load (0.1ms)  SELECT "users".* FROM "users"
  =>
  [#<User:0x000079dfddc48240 id: 2, username: "aaa", email: "aaa@example.com", created_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:18:45.645020000 JST +09:00, password_digest: nil>,
  #<User:0x000079dfddc48128 id: 3, username: "mashrur", email: "mashrur@example.com", created_at: Fri, 27 Jun 2025 00:33:48.494953000 JST +09:00, updated_at: Fri, 27 Jun 2025 00:33:48.494953000 JST +09:00, password_digest: nil>,
  #<User:0x000079dfddc48010 id: 4, username: "janedoe", email: "JanEDoE@example.com", created_at: Fri, 04 Jul 2025 00:26:47.372483000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:26:47.372483000 JST +09:00, password_digest: nil>,
  #<User:0x000079dfddc4fea0 id: 5, username: "janetdoe", email: "janetdoe@example.com", created_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, updated_at: Tue, 22 Jul 2025 22:02:00.649839000 JST +09:00, password_digest: "[FILTERED]">]
  irb(main):011:0> user
  => #<User:0x000079dfdeed0110 id: 5, username: "janetdoe", email: "janetdoe@example.com", created_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, updated_at: Tue, 22 Jul 2025 22:02:00.649839000 JST +09:00, password_digest: "[FILTERED]">
  irb(main):012:0> user.authenticate("wrongpassword")
  => false
  irb(main):013:0> user.authenticate("password")
  => false
  irb(main):014:0> user.authenticate("password123")
  => #<User:0x000079dfdeed0110 id: 5, username: "janetdoe", email: "janetdoe@example.com", created_at: Fri, 04 Jul 2025 00:29:10.089270000 JST +09:00, updated_at: Tue, 22 Jul 2025 22:02:00.649839000 JST +09:00, password_digest: "[FILTERED]">
  ```

## 138. New user signup form

- ユーザー登録フォームを作成する
  - `UserController` (`app/controllers/users_controller.rb`)

## 140. Create new users (back-end)

- ユーザー登録リクエストをバックエンド側で処理する

## 142. Edit users

- ユーザーの編集機能を実装する
