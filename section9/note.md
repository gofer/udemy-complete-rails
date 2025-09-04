# Section9: Stock Tracker Social Media App

## 241. Finance Tracker Requirements

- 「Finance Trackerというアプリのプロトタイプを作成する」というストーリーで学んでいく
- 要件
  - 認証システム: ユーザーがサインアップ，プロフィールの編集，ログイン・ログアウトができる
  - ユーザーあたり最大10銘柄まで株式の現在の価格をトラックできる
  - ユーザーは銘柄を追加・削除できる
  - ユーザーはアプリを利用している友人を名前かメールアドレスで検索できる
  - 投資のアイデアを得るために，友人のポートフォリオを閲覧できる
  - モバイルデバイスフレンドリーであるために，レスポンシブデザインにする
- 制約
  - 素早い開発が必要
  - 見た目が最も重要ということではないが，見栄えがよい必要はある
  - 現時点ではプロトタイプなので，テストは必要ない
  - 発表まで時間がないので，とにかく素早く機能するアプリを開発することが重要
- この開発で何を学ぶか
  - "rails magic": ラピッドプロトタイピング
  - bootstrapテンプレートジェネレーターなど素早くつ開けるツールの利用
  - ジェネレーターの使い方を学び，必要に応じてカスタマイズする
  - サードパーティ製のgemやツール (認証用のdeviseなど) をインストール，設定，カスタマイズする方法

## 242. Finance Tracker Assignment 1 - Text

- Rails 6系を使って `finance-tracker` アプリを初期化する
- `rails server` で正しく表示できることを確認する
- Gitで初期化コミットを作成する
- `README.md` を更新して，アプリに関する説明を追記する
- 上の変更のコミットを作成する
- GitHubレポジトリなどのリモートレポジトリにプッシュする

## 243. Assignment 1 completion

## 244. Finance Tracker Assignment 2 - Text

- ルートルートを用いてアプリケーションのホームページを作成する
  - `WelcomeController` に `index` アクションを作成する
- `Gemfile` を編集し，`gem sqlite3` を `development` に，`gem pg` を `production` に配置する
- 変更のコミットを作成する
- Herokuへデプロイする

## 245. Assignment 2 completion

- `rails generate controller welcome index`

## 246. Add devise gem for authentication

- 以前は認証システムを自作して構築していた
  - サインアップ・ログイン・ログアウト
  - ハッシュ化されたパスワード
  - 登録するメールアドレス宛にリンクを乗せたメールを送信して確認
  - パスワードを忘れていた際の対応
  - ログイン済みユーザーの維持
- deviseというgemを利用してこれらを実装することなく利用できる
  1. `Gemfile` に `gem devise` を追記
  2. `rails generate devise:install`
    - 必要に応じて `RUBYOPT="-r logger"` をつけておく

## 247. Create users using devise

- deviseを利用してユーザーを作成する
- `rails generate devise User`
- `rails db:migrate`
- `rails console`
  ```ruby
  irb(main):001:0> User.all
    (0.3ms)  SELECT sqlite_version(*)
    User Load (0.1ms)  SELECT "users".* FROM "users"              
  => []
  irb(main):002:0> User
  => User(id: integer, email: string, encrypted_password: string, reset_password_token: string, reset_password_sent_at: datetime, remember_created_at: datetime, created_at: datetime, updated_at: datetime)
  ```
- `app/controllers/application_controller.rb`
  ```ruby
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!
  end
  ```

## 248. Test Authentication system, login, logout

- deviseを利用した認証をテストする
- ホームページにログアウト用のリンクを追加しておく
  - `<%= link_to 'Sign out', destroy_user_session_path, method: :delete %>`
  - ↑だと動かないようなので `<%= button_to 'Sign out', destroy_user_session_path, method: :delete %>` に変更
  - または，GETリクエストになるように，`config/initializers/devise.rb` で以下のように設定を変更する
    ```rb
    # ...
    Devise.setup do |config|
      # ...
      # config.sign_out_via = :delete
      config.sign_out_via = :get
      # ...
    end
    ```
- 実際にサインアップしてみる
- `rails console`
  ```ruby
  irb(main):001:0> User.all
    (0.6ms)  SELECT sqlite_version(*)
    User Load (0.1ms)  SELECT "users".* FROM "users"              
  => [#<User id: 1, email: "user@example.com", created_at: "2025-08-13 00:28:46.360604000 +0900", updated_at: "2025-08-13 00:28:46.360604000 +0900">]
  ```
- 実際にログイン・ログアウトを行ってみる


## 249. Assignment: Add Bootstrap to the application

- フロントのスタイリング用にBootstrap (v4系) を導入する

## 250. Implementation: Add Bootstrap 4 step by step

- Bootstrapを導入してナビゲーションバーを表示する
- (メモ) `yarn add -D @babel/plugin-proposal-private-methods @babel/plugin-proposal-private-property-in-object` が必要だった

## 251. Update views

- サインアップフォームとログインフォームのスタイリングを行う
- deviseの生成するviewはgemが持っている
  - そこでdevise-bootstrap-viewsというgemを利用する
  - `gem 'devise-bootstrap-views', '~> 1.0'` を `Gemfile` に追記
  - `rails generate devise:views:bootstrap_templates`

## 252. Update layout: containers for styling

- アプリケーションのレイアウトを修正する

## 253. Layout Assignment: Add messages and nav partial

- deviseの出すメッセージのスタイリング
- ナビゲーションバーを部分ビューへ移動させる

## 254. Setup and use API key to get stock data

- [IEX Cloud](https://iexcloud.io) のAPIを利用して株価を取得する
  - iex-ruby-clientというgemを利用する
- (メモ) しかし2025年現在サービスを終了しているようだ

## 255. Create Stock model with attributes

- `Stock`モデルを作成する
  - `name`，`ticker`，`last_price`の3つの属性を持つ
- `rails generate model Stock ticker:string name:string last_price:decimal`
- `rails db:migrate`
- `rails console`
  ```ruby
  irb(main):001:0> my_stock = Stock.new(name: 'Alphabet', ticker: 'GOOG', last_price: 1300)
    (0.3ms)  SELECT sqlite_version(*)
  => #<Stock:0x0000761af24edc38 id: nil, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: nil, updated_at: nil>
  irb(main):002:0> my_stock
  => #<Stock:0x0000761af24edc38 id: nil, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: nil, updated_at: nil>
  irb(main):003:0> Stock.all
    Stock Load (0.4ms)  SELECT "stocks".* FROM "stocks"
  => []
  irb(main):004:0> my_stock.save
    TRANSACTION (0.1ms)  begin transaction
    Stock Create (1.3ms)  INSERT INTO "stocks" ("ticker", "name", "last_price", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["ticker", "GOOG"], ["name", "Alphabet"], ["last_price", 1300.0], ["created_at", "2025-08-14 15:03:54.025873"], ["updated_at", "2025-08-14 15:03:54.025873"]]
    TRANSACTION (20.2ms)  commit transaction
  => true
  irb(main):005:0> Stock.all
    Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks"
  => [#<Stock:0x0000761af24b5018 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>]
  irb(main):006:0> google = Stock.find(1)
    Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks" WHERE "stocks"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  => #<Stock:0x0000761acbd9b4b0 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>
  irb(main):007:0> google
  => #<Stock:0x0000761acbd9b4b0 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>
  irb(main):008:0> google.last_price
  => 0.13e4
  ```

## 256. Stock lookup: build class method to lookup stock info

- `Stock`モデルにIEX CloudのAPIから最新の株価を取得するクラスメソッドを追加する
- (メモ) とりあえず固定値を返すモックで対応
- (メモ) [FMP](https://site.financialmodelingprep.com) を利用して株価を取得するクライアントを作成
  - あらかじめユーザー登録とAPIキーの取得を行うこと

## 257. Secure credentials in Rails 6

- APIキーをハードコーディングせずに管理する方法を学ぶ
  - `config/credentials.yml.enc` を利用する
  - このファイルは `config/master.key` で暗号化されている
  - `config/master.key` は `.gitignore` に追加済
  - `rails credentials:edit` で編集する
    - (メモ) `EDITOR="code --wait" RUBYOPT="-r logger" rails credentials:edit`
  - コード側からは `Rails.application.credentials.aws[:access_key_id]` のようにして参照する

## 258. Store secure API key

- 実際にAPIキーをストアする
- (メモ) `Rails.application.credentials.fmp_client[:api_key]`
- `rails c`
  ```ruby
  irb(main):001:0> Stock.new_lookup('AAPL')
  => 227.7
  ```

## 259. Setup front-end structure for stock lookup

- フロントエンド側を完成させる
- `/my_portfolio`ルートを完成させる
  - `config/routes.rb`
    ```ruby
    get 'my_portfolio', to: 'users#my_portfolio'
    ```
- `rails generate controller users my_portfolio`
  ```
  Running via Spring preloader in process 89605
        create  app/controllers/users_controller.rb
        route  get 'users/my_portfolio'
        invoke  erb
        create    app/views/users
        create    app/views/users/my_portfolio.html.erb
        invoke  test_unit
        create    test/controllers/users_controller_test.rb
        invoke  helper
        create    app/helpers/users_helper.rb
        invoke    test_unit
        invoke  assets
        invoke    scss
        create      app/assets/stylesheets/users.scss
  ```

## 260. Build Stock Lookup Form

- ティッカーシンボルの検索フォームを構築する

## 261. Display stock price in browser

- ティッカーシンボルの検索機能を実装する

## 262. Create and display stock objects in browser

- ティッカーシンボルの検索時に名前やティッカーシンボル，株価などの様々な情報を表示できるようにする
- `Stock` オブジェクトを利用する

## 263. Dealing with invalid search results

- 無効なティッカーシンボルを検索した際に発生するエラーのハンドリングを行う

## 264. Use Ajax for from submission

- Ajax通信でページ全体の再描画を防ぐ
  - synchronous JavaScript and XML (Ajax)
  - XMLHttpRequest (XHR)
- `form_tag` ヘルパーで `remote: true` オプションを渡すと，Ajaxリクエストとして送信される

## 265. Setup JavaScript response

- Ajaxリクエストを処理する
- JSONをviewとして扱う
  ```ruby
  respond_to do |format|
    format.js { render partial: 'users/result' }
  end
  ```

## 266. JavaScript responses to invalid search results

- 異常系のレスポンスについてもAjax対応する

## 267. Users and stocks: many-to-many association

- ユーザーと株式の間には多対多の関連がある
  - `user_stocks` という中間リレーションで表現する

## 268. Setup UserStock resource

- 関連をscaffoldする
  - `rails generate resource UserStock user:references stock:references`
  - `app/models/user_stock.rb`
    ```ruby
    class UserStock < ApplicationRecord
      belongs_to :user
      belongs_to :stock
    end
    ```
  - `db/migrate/yyyymmddhhmmss_create_user_stock.rb`
    ```ruby
    class CreateUserStocks < ActiveRecord::Migration[6.1]
      def change
        create_table :user_stocks do |t|
          t.references :user, null: false, foreign_key: true
          t.references :stock, null: false, foreign_key: true

          t.timestamps
        end
      end
    end
    ```
- ユーザと株式にも `has_many` を追加する
  - `app/models/stock.rb`
    ```ruby
    class Stock < ApplicationRecord
      has_many :user_stocks
      has_many :users, through: :user_stocks

      validates :name, :ticker, presence: true

      # ...
    end    
    ``` 
  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      has_many :user_stocks
      has_many :stocks, through: :user_stocks

      # ...
    end
    ```
- `rails db:migrate`
- `rails console`
  ```ruby
  irb(main):001:0> UserStock.all
    (0.3ms)  SELECT sqlite_version(*)
    UserStock Load (0.1ms)  SELECT "user_stocks".* FROM "user_stocks"  
  => []
  irb(main):002:0> Stock.create(ticker: 'AAPL', name: 'Apple inc.')
    (0.1ms)  SELECT sqlite_version(*)
    TRANSACTION (0.0ms)  begin transaction                                                                                
    Stock Create (0.3ms)  INSERT INTO "stocks" ("ticker", "name", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["ticker", "AAPL"], ["name", "Apple inc."], ["created_at", "2025-09-01 15:27:39.693624"], ["updated_at", "2025-09-01 15:27:39.693624"]]
    TRANSACTION (5.4ms)  commit transaction                                                                               
  => #<Stock:0x00007e616fdf0288 id: 2, ticker: "AAPL", name: "Apple inc.", last_price: nil, created_at: Tue, 02 Sep 2025 00:27:39.693624000 JST +09:00, updated_at: Tue, 02 Sep 2025 00:27:39.693624000 JST +09:00>
  irb(main):003:0> Stock.all
  Stock Load (0.6ms)  SELECT "stocks".* FROM "stocks"
  =>                                                                                                                      
  [#<Stock:0x00007e61963efa78 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>,
  #<Stock:0x00007e61963ef938 id: 2, ticker: "AAPL", name: "Apple inc.", last_price: nil, created_at: Tue, 02 Sep 2025 00:27:39.693624000 JST +09:00, updated_at: Tue, 02 Sep 2025 00:27:39.693624000 JST +09:00>]
  irb(main):004:0> user = User.first
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User id: 1, email: "user@example.com", created_at: "2025-08-13 00:28:46.360604000 +0900", updated_at: "2025-08-13 00:28:46.360604000 +0900">
  irb(main):005:0> user.stocks
    Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks" INNER JOIN "user_stocks" ON "stocks"."id" = "user_stocks"."stock_id" WHERE "user_stocks"."user_id" = ?  [["user_id", 1]]
  => []
  irb(main):006:0> stock = Stock.first
    Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks" ORDER BY "stocks"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<Stock:0x00007e616fe7fca8 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>
  irb(main):007:0> user.stocks << stock
    TRANSACTION (0.0ms)  begin transaction
    UserStock Create (0.6ms)  INSERT INTO "user_stocks" ("user_id", "stock_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["user_id", 1], ["stock_id", 1], ["created_at", "2025-09-01 15:29:34.303501"], ["updated_at", "2025-09-01 15:29:34.303501"]]
    TRANSACTION (4.9ms)  commit transaction                                  
  => [#<Stock:0x00007e616fe7fca8 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>]
  irb(main):008:0> UserStock.all
    UserStock Load (0.2ms)  SELECT "user_stocks".* FROM "user_stocks"
  => [#<UserStock:0x00007e616fd95838 id: 1, user_id: 1, stock_id: 1, created_at: Tue, 02 Sep 2025 00:29:34.303501000 JST +09:00, updated_at: Tue, 02 Sep 2025 00:29:34.303501000 JST +09:00>]
  irb(main):009:0> Stock.create(ticker: 'AMZN', name: 'Amazon inc.')
    TRANSACTION (0.1ms)  begin transaction
    Stock Create (0.8ms)  INSERT INTO "stocks" ("ticker", "name", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["ticker", "AMZN"], ["name", "Amazon inc."], ["created_at", "2025-09-01 15:31:33.523748"], ["updated_at", "2025-09-01 15:31:33.523748"]]
    TRANSACTION (4.2ms)  commit transaction                                                                                
  => #<Stock:0x00007e616fec6090 id: 3, ticker: "AMZN", name: "Amazon inc.", last_price: nil, created_at: Tue, 02 Sep 2025 00:31:33.523748000 JST +09:00, updated_at: Tue, 02 Sep 2025 00:31:33.523748000 JST +09:00>
  irb(main):010:0> stock = Stock.last
    Stock Load (0.2ms)  SELECT "stocks".* FROM "stocks" ORDER BY "stocks"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Stock:0x00007e61940b5080 id: 3, ticker: "AMZN", name: "Amazon inc.", last_price: nil, created_at: Tue, 02 Sep 2025 00:31:33.523748000 JST +09:00, updated_at: Tue, 02 Sep 2025 00:31:33.523748000 JST +09:00>
  irb(main):011:0> user.stocks << stock
    TRANSACTION (0.0ms)  begin transaction
    UserStock Create (4.1ms)  INSERT INTO "user_stocks" ("user_id", "stock_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["user_id", 1], ["stock_id", 3], ["created_at", "2025-09-01 15:32:10.263594"], ["updated_at", "2025-09-01 15:32:10.263594"]]
    TRANSACTION (4.7ms)  commit transaction                                                                                
  =>                                                                                                                       
  [#<Stock:0x00007e616fe7fca8 id: 1, ticker: "GOOG", name: "Alphabet", last_price: 0.13e4, created_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00, updated_at: Fri, 15 Aug 2025 00:03:54.025873000 JST +09:00>,
  #<Stock:0x00007e61940b5080 id: 3, ticker: "AMZN", name: "Amazon inc.", last_price: nil, created_at: Tue, 02 Sep 2025 00:31:33.523748000 JST +09:00, updated_at: Tue, 02 Sep 2025 00:31:33.523748000 JST +09:00>]
  irb(main):012:0> stock.users
    User Load (0.2ms)  SELECT "users".* FROM "users" INNER JOIN "user_stocks" ON "users"."id" = "user_stocks"."user_id" WHERE "user_stocks"."stock_id" = ?  [["stock_id", 3]]
  => [#<User id: 1, email: "user@example.com", created_at: "2025-08-13 00:28:46.360604000 +0900", updated_at: "2025-08-13 00:28:46.360604000 +0900">]
  ```

## 269. Stocks listing view

- ユーザーが追跡している株式のリストを表示する

## 270. Cleanup application layout

- レイアウトを整理する

## 271. Track stocks from front-end: browser

- ユーザーがブラウザから株価を追跡できるようにする

## 272. Implement stock tracking restrictions

- ユーザーが株式を追跡できる機能に制約を加える
  - 追跡できる株式は最大10個
  - 同一の株式は複数追跡できない

## 273. Add functionality to remove tracking

- 株式の追跡の停止機能を実装する

## 274. Modify user model

- 基本的なDeviseのカスタマイズ方法について学ぶ
- ユーザーの名前 (姓と名) を `users` テーブルに追加する
- `rails generate migration add_first_last_name_to_users`
  - `db/migrate/yyyymmddhhmmss_add_first_last_name_to_users.rb`
    ```ruby
    class AddFirstLastNameToUsers < ActiveRecord::Migration[6.1]
      def change
        add_column :users, :first_name, :string
        add_column :users, :last_name, :string
      end
    end
    ```
- `rails db:migrate`
- `rails console`
  ```ruby
  irb(main):001:0> User.all
    (0.6ms)  SELECT sqlite_version(*)
    User Load (0.2ms)  SELECT "users".* FROM "users"
  =>
  [#<User id: 1, email: "user@example.com", created_at: "2025-08-13 00:28:46.360604000 +0900", updated_at: "2025-08-13 00:28:46.360604000 +0900", first_name: nil, last_name: nil>,
  #<User id: 2, email: "johndoe@example.com", created_at: "2025-09-02 00:36:00.507256000 +0900", updated_at: "2025-09-02 00:36:00.507256000 +0900", first_name: nil, last_name: nil>]
  irb(main):002:0> user = User.first
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User id: 1, email: "user@example.com", created_at: "2025-08-13 00:28:46.360604000 +0900", updated_at: "2025-08-13 00:28:46.360604000 +0900", first_name: nil, last_name: nil>
  irb(main):003:0> user.first_name = 'Mashrur'
  => "Mashrur"
  irb(main):004:0> user.last_name = 'Hossain'
  => "Hossain"
  irb(main):005:0> user.save
    TRANSACTION (0.1ms)  begin transaction
    User Update (0.3ms)  UPDATE "users" SET "updated_at" = ?, "first_name" = ?, "last_name" = ? WHERE "users"."id" = ?  [["updated_at", "2025-09-04 14:15:58.624120"], ["first_name", "Mashrur"], ["last_name", "Hossain"], ["id", 1]]
    TRANSACTION (8.9ms)  commit transaction
  => true
  ```

## 275. Accept additional fields in app - edit action

- 画面側からユーザーの名前を編集できるようにする

## 276. Complete singup assignment

- サインアップ時にもユーザーの名前を入力できるようにする

## 277. Self referential association - user and friends

- ユーザー同士を友人として結びつける機能を実装する
  - `users` テーブル同士の多対多の関連になる (self referential association)
- `rails generate model Friendship user:references`
  - `db/migrate/yyyymmddhhmmss_create_friendships.rb`
    ```ruby
    class CreateFriendships < ActiveRecord::Migration[6.1]
      def change
        create_table :friendships do |t|
          t.references :user, null: false, foreign_key: true
          t.references :friend, references: :users, foreign_key: { to_table: :users }

          t.timestamps
        end
      end
    end
    ```
  - `app/models/friendship.rb`
    ```ruby
    class Friendship < ApplicationRecord
      belongs_to :user
      belongs_to :friend, class_name: 'User'
    end
    ```
  - `app/models/user.rb`
    ```ruby
    class User < ApplicationRecord
      has_many :user_stocks
      has_many :stocks, through: :user_stocks
      has_many :friendships
      has_many :friends, through: :friendships

      # ...
    end
    ```
- `rails db:migrate`
- `rails console`
  ```ruby
  irb(main):001:0> Friendship.all
    (0.4ms)  SELECT sqlite_version(*)
    Friendship Load (0.1ms)  SELECT "friendships".* FROM "friendships"  
  => []
  irb(main):002:0> Friendship
  => Friendship(id: integer, user_id: integer, friend_id: integer, created_at: datetime, updated_at: datetime)
  irb(main):003:0> user = User.first
    User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User id: 1, email: "user@example.com", created_at: "2025-08-13 00:28:46.360604000 +0900", updated_at: "2025-09-04 23:15:58.624120000 +0900", first_name: "Mashrur", last_name: "Hossain">
  irb(main):004:0> user.friendships
    Friendship Load (0.1ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = ?  [["user_id", 1]]
  => []
  irb(main):005:0> user_2 = User.last
    User Load (0.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<User id: 2, email: "johndoe@example.com", created_at: "2025-09-02 00:36:00.507256000 +0900", updated_at: "2025-09-04 23:32:10.395539000 +0900", first_name: "John", last_name: "Doe">
  rb(main):006:0> user.friends << user_2
    TRANSACTION (0.1ms)  begin transaction
    Friendship Create (0.8ms)  INSERT INTO "friendships" ("user_id", "friend_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["user_id", 1], ["friend_id", 2], ["created_at", "2025-09-04 14:50:33.031342"], ["updated_at", "2025-09-04 14:50:33.031342"]]
    TRANSACTION (4.8ms)  commit transaction                                       
    User Load (0.3ms)  SELECT "users".* FROM "users" INNER JOIN "friendships" ON "users"."id" = "friendships"."friend_id" WHERE "friendships"."user_id" = ?  [["user_id", 1]]
  => [#<User id: 2, email: "johndoe@example.com", created_at: "2025-09-02 00:36:00.507256000 +0900", updated_at: "2025-09-04 23:32:10.395539000 +0900", first_name: "John", last_name: "Doe">]
  irb(main):007:0> user.friends
  => [#<User id: 2, email: "johndoe@example.com", created_at: "2025-09-02 00:36:00.507256000 +0900", updated_at: "2025-09-04 23:32:10.395539000 +0900", first_name: "John", last_name: "Doe">]
  irb(main):008:0> Friendship.all
    Friendship Load (0.1ms)  SELECT "friendships".* FROM "friendships"
  => [#<Friendship:0x00007e7166e43300 id: 1, user_id: 1, friend_id: 2, created_at: Thu, 04 Sep 2025 23:50:33.031342000 JST +09:00, updated_at: Thu, 04 Sep 2025 23:50:33.031342000 JST +09:00>]
  ```

## 278. Assignment completion walkthrough: friends list

- 友達一覧ページを実装する
