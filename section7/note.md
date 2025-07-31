# Section7: Many-To-Many Associations and Automated Testing - Integration, Functional, Unit

## 177. Introduction to Section 7

- 多対多の関連付け，自動化テスト (ユニットテスト・機能テスト・統合テスト) について学ぶ
- 記事とカテゴリの間に多対多の関連が入る
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

- カテゴリとコントローラーのテストを追加する

- `rails generate test_unit:scaffold category`

## 184. Create category and test

- カテゴリー作成機能をテストファーストで実装する

## 186. Integration test: Create category business process

- カテゴリー作成機能の統合テストを追加する

- `rails generate integration_test create_category`

## 188. Integration test for invalid category

- 異常系に対する統合テストを追加する

## 190. Integration test and feature: listing categories

- カテゴリのインデックスページに対する統合テストを追加する

## 192. Admin user requirement and test

- カテゴリの作成は管理者のみに許可するよう修正する

## 194. Update navigation

- 管理者が画面からカテゴリを作成できるようにナビゲーションを作成する

## 196. Many-to-many association - introduction

- 記事とカテゴリの間に多対多の関連を追加する
