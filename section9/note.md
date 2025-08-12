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
