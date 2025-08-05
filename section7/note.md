# Section7: Many-To-Many Associations and Automated Testing - Integration, Functional, Unit

## 177. Introduction to Section 7

- 多対多の関連付け，自動化テスト (ユニットテスト・機能テスト・統合テスト) について学ぶ
- 記事とカテゴリーの間に多対多の関連が入る
- テストの分類
  - 単体テスト (unit tests): モデル，アプリケーションの個々の機能 (バリデーションなど) が正しく動作するかを確認する
  - 機能テスト (functional tests): コントローラーが正しく動作するかを確認する (未ログインユーザが操作を実行できないよう `before_action` で防ぐなど)
  - 統合テスト (integration tests): 最初から最後まですべての機能 (一貫したビジネスプロセス) が正しく動作するかを確認する (ユーザーがアプリケーションにサインアップできるかなど)

## 178. Category model and testing

- テストファーストでカテゴリを導入する
- Minitestというテストライブラリを利用する

- `test/models/category_test.rb`
  ```ruby
  require 'test_helper'
  ```

  - `rails test`
    ```plain
    Running via Spring preloader in process 13229
    Running via Spring preloader in process 13235
    Run options: --seed 3609

    # Running:



    Finished in 0.141379s, 0.0000 runs/s, 0.0000 assertions/s.
    0 runs, 0 assertions, 0 failures, 0 errors, 0 skips
    ```

- `test/models/category_test.rb`
  ```ruby
  class CategoryTest < ActiveSupport::TestCase
    test "category should be valid" do
      @category = Category.new(name: "Sports")
      assert @category.valid?
    end
  end
  ```

  - `rails test`
    ```plain
    Running via Spring preloader in process 13508
    Run options: --seed 41108

    # Running:

    E

    Error:
    CategoryTest#test_category_should_be_valid:
    NameError: uninitialized constant CategoryTest::Category
        test/models/category_test.rb:5:in `block in <class:CategoryTest>'


    rails test test/models/category_test.rb:4



    Finished in 0.203474s, 4.9146 runs/s, 0.0000 assertions/s.
    1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
    ```

- `app/models/category.rb`
  ```ruby
  class Category < ApplicationRecord  
  end
  ```

  - `rails test`
    ```plain
    Running via Spring preloader in process 13727
    Run options: --seed 28664

    # Running:

    E

    Error:
    CategoryTest#test_category_should_be_valid:
    ActiveRecord::StatementInvalid: Could not find table 'categories'
        test/models/category_test.rb:5:in `block in <class:CategoryTest>'


    rails test test/models/category_test.rb:4



    Finished in 0.202320s, 4.9427 runs/s, 0.0000 assertions/s.
    1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
    ```

- `rails generate migration create_category`
  - `db/migrate/yyyymmddhhmmss_create_categories.rb`
    ```ruby
    class CreateCategory < ActiveRecord::Migration[6.1]
      def change
        create_table :categories do |t|
          t.string :name
          t.timestamps
        end
      end
    end
    ```

  - `rails db:migrate`

  - `rails test`
    ```plain
    Running via Spring preloader in process 13988
    Running via Spring preloader in process 13993
    Run options: --seed 32284

    # Running:

    .

    Finished in 0.204957s, 4.8791 runs/s, 4.8791 assertions/s.
    1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
    ```

- `rails console`
  ```ruby
  irb(main):001:0> Category.all
    (0.3ms)  SELECT sqlite_version(*)
    Category Load (0.1ms)  SELECT "categories".* FROM "categories"    
  => []
  irb(main):002:0> Category
  => Category(id: integer, name: string, created_at: datetime, updated_at: datetime)
  irb(main):003:0> @category = Category.new(name: "sports")
  => #<Category:0x00007cd2a6044ea8 id: nil, name: "sports", created_at: nil, updated_at: nil>
  irb(main):004:0> @category.valid?
  => true
  ```

## 180. Validations using unit tests

- さらにテストを追加する

- `test/models/category_test.rb`
  ```ruby
  class CategoryTest < ActiveSupport::TestCase
    def setup
      @category = Category.new(name: "Sports")
    end

    test "category should be valid" do
      assert @category.valid?
    end

    test "name should be present" do
      @category.name = " "
      assert_not @category.valid?
    end

    test "name should be unique" do
      @category.save
      @category2 = Category.new(name: "Sports")
      assert_not @category2.valid?
    end

    test "name should not be too long" do
      @category.name = "a" * 26
      assert_not @category.valid?
    end

    test "name should not be too short" do
      @category.name = "aa"
      assert_not @category.valid?
    end
  end
  ```

- `app/models/category.rb`
  ```ruby
  class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates_uniqueness_of :name
  end
  ```

- `rails test`
  ```plain
  Running via Spring preloader in process 15443
  Run options: --seed 1656

  # Running:

  .....

  Finished in 0.206683s, 24.1916 runs/s, 24.1916 assertions/s.
  5 runs, 5 assertions, 0 failures, 0 errors, 0 skips
  ```

## 182. Categories controller and tests

- カテゴリーとコントローラーのテストを追加する

- `rails generate test_unit:scaffold category`

## 184. Create category and test

- カテゴリー作成機能をテストファーストで実装する

## 186. Integration test: Create category business process

- カテゴリー作成機能の統合テストを追加する

- `rails generate integration_test create_category`

## 188. Integration test for invalid category

- 異常系に対する統合テストを追加する

## 190. Integration test and feature: listing categories

- カテゴリーのインデックスページに対する統合テストを追加する

## 192. Admin user requirement and test

- カテゴリーの作成は管理者のみに許可するよう修正する

## 194. Update navigation

- 管理者が画面からカテゴリーを作成できるようにナビゲーションを作成する

## 196. Many-to-many association - introduction

- 記事とカテゴリーの間に多対多の関連を追加する

## 197. Many-to-many association - back-end implementation

- 記事とカテゴリーの間に多対多の関連を実装する

- `rails generate migration create_article_categories`
  - `db/migrate/yyyymmddhhmmss_create_article_categories.rb`
    ```ruby
    class CreateArticleCategories < ActiveRecord::Migration[6.1]
      def change
        create_table :article_categories do |t|
          t.integer :article_id
          t.integer :category_id
        end
      end
    end
    ```
  - `rails db:migrate`

- `app/models/article_category.rb`
  ```ruby
  class ArticleCategory < ApplicationRecord
  end
  ```

- `rails console`
  ```ruby
  irb(main):001:0> ArticleCategory.all
    (0.3ms)  SELECT sqlite_version(*)
    ArticleCategory Load (0.1ms)  SELECT "article_categories".* FROM "article_categories"
  => []
  irb(main):002:0> ArticleCategory
  => ArticleCategory(id: integer, article_id: integer, category_id: integer)
  ```

- `app/models/article_category.rb`
  ```ruby
  class ArticleCategory < ApplicationRecord
    belongs_to :article
    belongs_to :category
  end
  ```
- `app/models/article.rb`
  ```ruby
  class Article < ApplicationRecord
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    # ...
  end
  ```
- `app/models/category.rb`
  ```ruby
  class Category < ApplicationRecord
    # ...
    has_many :article_categories
    has_many :articles, through: :article_categories
  end
  ```

- `rails console`
  ```ruby
  irb(main):001:0> article = Article.last
    (0.3ms)  SELECT sqlite_version(*)
    Article Load (0.1ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Article:0x000077eedad48af0 id: 6, title: "sample title", description: "sample description", created_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, updated_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, user_id: 8>
  irb(main):002:0> article.categories
    Category Load (0.1ms)  SELECT "categories".* FROM "categories" INNER JOIN "article_categories" ON "categories"."id" = "article_categories"."category_id" WHERE "article_categories"."article_id" = ?  [["article_id", 6]]
  => []
  irb(main):003:0> category = Category.last
    Category Load (4.2ms)  SELECT "categories".* FROM "categories" ORDER BY "categories"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Category:0x000077eed92494c0 id: 6, name: "Physical fitness", created_at: Sat, 26 Jul 2025 22:10:38.130631000 JST +09:00, updated_at: Sat, 26 Jul 2025 22:10:38.130631000 JST +09:00>
  irb(main):004:0> category.articles
    Article Load (0.3ms)  SELECT "articles".* FROM "articles" INNER JOIN "article_categories" ON "articles"."id" = "article_categories"."article_id" WHERE "article_categories"."category_id" = ?  [["category_id", 6]]
  => []
  irb(main):005:0> category.articles << article
    TRANSACTION (0.1ms)  begin transaction
    ArticleCategory Create (0.7ms)  INSERT INTO "article_categories" ("article_id", "category_id") VALUES (?, ?)  [["article_id", 6], ["category_id", 6]]
    TRANSACTION (7.7ms)  commit transaction                                    
  => [#<Article:0x000077eedad48af0 id: 6, title: "sample title", description: "sample description", created_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, updated_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, user_id: 8>]
  irb(main):006:0> category.articles
  => [#<Article:0x000077eedad48af0 id: 6, title: "sample title", description: "sample description", created_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, updated_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, user_id: 8>]
  irb(main):007:0> category.articles << Article.first
    Article Load (6.3ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 1]]
    TRANSACTION (0.0ms)  begin transaction                                                
    ArticleCategory Create (0.2ms)  INSERT INTO "article_categories" ("article_id", "category_id") VALUES (?, ?)  [["article_id", 1], ["category_id", 6]]
    TRANSACTION (3.7ms)  commit transaction                                               
  =>                                                                                      
  [#<Article:0x000077eedad48af0 id: 6, title: "sample title", description: "sample description", created_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, updated_at: Wed, 23 Jul 2025 23:49:51.286630000 JST +09:00, user_id: 8>,
  #<Article:0x000077eeda4989f0 id: 1, title: "sample", description: "this is sample article.", created_at: Tue, 10 Jun 2025 23:08:45.698320000 JST +09:00, updated_at: Fri, 04 Jul 2025 00:04:26.743915000 JST +09:00, user_id: 2>]
  irb(main):008:0> category.articles.count
    (0.4ms)  SELECT COUNT(*) FROM "articles" INNER JOIN "article_categories" ON "articles"."id" = "article_categories"."article_id" WHERE "article_categories"."category_id" = ?  [["category_id", 6]]
  => 2
  irb(main):009:0> article.categories
  => []
  irb(main):010:0> article.categories << Category.first
    Category Load (0.1ms)  SELECT "categories".* FROM "categories" ORDER BY "categories"."id" ASC LIMIT ?  [["LIMIT", 1]]
    TRANSACTION (0.0ms)  begin transaction                                                    
    ArticleCategory Create (0.2ms)  INSERT INTO "article_categories" ("article_id", "category_id") VALUES (?, ?)  [["article_id", 6], ["category_id", 1]]
    TRANSACTION (8.2ms)  commit transaction                                                   
  => [#<Category:0x000077eed8c09fd8 id: 1, name: "Travel", created_at: Sat, 26 Jul 2025 21:33:40.461314000 JST +09:00, updated_at: Sat, 26 Jul 2025 21:33:40.461314000 JST +09:00>]
  irb(main):011:0> article.categories.count
    (0.2ms)  SELECT COUNT(*) FROM "categories" INNER JOIN "article_categories" ON "categories"."id" = "article_categories"."category_id" WHERE "article_categories"."article_id" = ?  [["article_id", 6]]
  => 2
  ```

## 199. Add association from UI

- 記事の作成時にカテゴリーを追加できるようにする

- `rails console`
  ```ruby
  irb(main):001:0> article = Article.new(title: "some title", description: "some description", user: User.last, category_ids: [1, 2])
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT ?  [["LIMIT", 1]]
    Category Load (0.4ms)  SELECT "categories".* FROM "categories" WHERE "categories"."id" IN (?, ?)  [["id", 1], ["id", 2]]                        
  => #<Article:0x00007effc43cfc38 id: nil, title: "some title", description: "some description", created_at: nil, updated_at: nil, user_id: 8>
  irb(main):002:0> article.valid?
    Category Exists? (0.2ms)  SELECT 1 AS one FROM "categories" WHERE "categories"."name" = ? AND "categories"."id" != ? LIMIT ?  [["name", "Travel"], ["id", 1], ["LIMIT", 1]]
    Category Exists? (0.1ms)  SELECT 1 AS one FROM "categories" WHERE "categories"."name" = ? AND "categories"."id" != ? LIMIT ?  [["name", "Sports"], ["id", 2], ["LIMIT", 1]]
  => true
  irb(main):003:0> article
  => #<Article:0x00007effc43cfc38 id: nil, title: "some title", description: "some description", created_at: nil, updated_at: nil, user_id: 8>
  irb(main):004:0> article.save
    TRANSACTION (0.2ms)  begin transaction
    Category Exists? (0.3ms)  SELECT 1 AS one FROM "categories" WHERE "categories"."name" = ? AND "categories"."id" != ? LIMIT ?  [["name", "Travel"], ["id", 1], ["LIMIT", 1]]
    Category Exists? (0.0ms)  SELECT 1 AS one FROM "categories" WHERE "categories"."name" = ? AND "categories"."id" != ? LIMIT ?  [["name", "Sports"], ["id", 2], ["LIMIT", 1]]
    Article Create (1.2ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "some title"], ["description", "some description"], ["created_at", "2025-08-05 14:06:35.465148"], ["updated_at", "2025-08-05 14:06:35.465148"], ["user_id", 8]]                                           
    ArticleCategory Create (0.4ms)  INSERT INTO "article_categories" ("article_id", "category_id") VALUES (?, ?)  [["article_id", 9], ["category_id", 1]]
    ArticleCategory Create (0.0ms)  INSERT INTO "article_categories" ("article_id", "category_id") VALUES (?, ?)  [["article_id", 9], ["category_id", 2]]
    TRANSACTION (4.1ms)  commit transaction
  => true
  irb(main):005:0> article
  => #<Article:0x00007effc43cfc38 id: 9, title: "some title", description: "some description", created_at: Tue, 05 Aug 2025 23:06:35.465148877 JST +09:00, updated_at: Tue, 05 Aug 2025 23:06:35.465148877 JST +09:00, user_id: 8>
  irb(main):006:0> article.categories
  => 
  [#<Category:0x00007effc438e008 id: 1, name: "Travel", created_at: Sat, 26 Jul 2025 21:33:40.461314000 JST +09:00, updated_at: Sat, 26 Jul 2025 21:33:40.461314000 JST +09:00>,
  #<Category:0x00007effc44cf700 id: 2, name: "Sports", created_at: Sat, 26 Jul 2025 22:08:40.354885000 JST +09:00, updated_at: Sat, 26 Jul 2025 22:08:40.354885000 JST +09:00>]
  ```

## 201. Update article views to display categories

- 記事一覧ページ・記事ページにカテゴリーを表示する
  - ユーザーページの記事にもカテゴリーが表示される (partial)
