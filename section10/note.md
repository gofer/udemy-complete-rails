# Section10: Email, Custom Payment Functionality and File Uploads

## 288. Start Photo App

- Alpha Blogでは独自の認証システムをスクラッチで実装し，Finance Trackerではdeviseを利用して認証システムを構築した
- しかし，実際にユーザーの入力したメールアドレスにメールを送信し，そのメールアドレスが有効であるかを検証する必要がある
  - サインアップ時にユーザーの入力したメールアドレス宛にメールが送信され，そのメールに記載されたリンクへアクセスしてもらう
  - ユーザーがメールアドレスの認証を済ませたか否かを表す文字列をユーザーテーブルに保持しておくことで状態を管理する
  - この方法はdeviseで利用できる
- このセクションではPhotoAppを開発する

## 290. Setup Authentication System

- deviseなどのgemを追加して認証システムの基礎を作成する

## 292. Sending Email in Production

- SendGridを利用してHerokuからメールの送信を行えるようにする
  - `heroku addons:create sendgrid:starter`
  - `heroku config:set SENDGRID_PASSWORD=<<API Key>>`
  - `config/environment.rb`
    ```ruby
    # Load the Rails application.
    require_relative "application"

    # Initialize the Rails application.
    Rails.application.initialize!

    ActionMailer::Base.smtp_settings = {
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :plain,
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :domain => 'heroku.com',
      :enable_starttls_auto => true
    }
    ```
  - `config/environments/developement.rb`
    ```ruby
    # ...
    config.action_mailer.delivery_method = :test
    config.action_mailer.default_url_options = { :host => 'http://localhost:3000' }
    # ...
    ```
  - `config/environments/production.rb`
    ```ruby
    # ...
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { :host => 'http://localhost:3000' }
    # ...
    ```
- この状態でサインアップしてみると，Pumaのログ (`rails server`) に送信されたメールが表示される
  - (メモ) `config/environments/developement.rb` で
    ```ruby
    config.action_mailer.delivery_method = :smtp
    ```
    とすればメールがMailHog宛に送信される。ただし，`ActionMailer::Base.smtp_settings`は以下。
    ```ruby
    ActionMailer::Base.smtp_settings = {
      :address => 'udemy-rails-mail',
      :port => 1025,
      :authentication => :plain,
      :user_name => ENV['SENDGRID_USERNAME'] || 'smtp-user',
      :password => ENV['SENDGRID_PASSWORD'] || 'smtp-pass',
      :domain => 'localhost.localdomain',
      :enable_starttls_auto => true
    }
    ```

## 294. Update Layout and Test Email in Production

- アプリのレイアウトを修正する
- (メモ)
  - `bable.config.js`
    ```js
    // ...

    // ↓ '@babel/plugin-proposal-private-methods',
    '@babel/plugin-transform-private-methods',

    // ...

    // ↓ '@babel/plugin-proposal-private-property-in-object',
    '@babel/plugin-transform-private-property-in-object',

    // ...
    ```
  - `export NODE_OPTIONS=--openssl-legacy-provider`
  - `rails asset:precompile`
- `config/initializers/devise.rb`
  ```ruby
  # ...
  config.mailer_sender = '<<ここに自動送信メールのFROMアドレスを入れる>>'
  # ...
  ```

## 296. Build Homepage

- ホームページを構築する

## 298. Stripe and Payment Introduction

- アプリケーションへのサインアップ時に支払いを行えるようにする
  - Stripeで支払いを行う
  - `gem 'sinatra'`
- Stripeの公開可能キーとシークレットキーを設定しておく
  - `config/initializer/stripe.rb`
    ```ruby
    Rails.configuration.stripe = {
      :publishable_key => ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
      :secret_key => ENV['STRIPE_TEST_SECRET_KEY']
    }

    Stripe.api_key = Rails.configuration.stripe[:secret_key]
    ```
