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
