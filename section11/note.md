# Section11: Software as as Service Project Management App

## 320. Start the new SaaS app

- プロジェクト管理を行うSaaSアプリを開発する
  - マルチテナント構成のアプリになる
  - 複数の組織に，複数のユーザーが所属している
- `rails new saas-project-app -d postgresql`
- `config/database.yml`
  ```yaml
  # PostgreSQL. Versions 9.3 and up are supported.
  # ...

  default: &default
    username: postgres
    password: postgrespass
    host: db
  
  development:
    <<: *default
    database: saas_project_app_development
  ```
    - evelopment ではなく default に host等を指定しないとdocker-composeの環境では db:create などのコマンドがうまく動かない
- ホームページを生成する
  - `rails generate controller home index`

## 322. Setup email

- メールの送信機能を準備する
  - HerokuではSendGridを利用する
    - `heroku config:set SENDGRID_USERNAME <<SendGridのユーザー名>>`
    - `heroku config:set SENDGRID_PASSWORD <<SendGridのパスワード>>`
- `config/environment.rb`
  ```ruby
  # ...
  ActionMailer::Base.smtp_settings = {
    :address => 'smtp.sendgrid.net',
    :port=> '587',
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :domain => 'heroku.com',
    :enable_starttls_auto => true
  }
  ```
- `config/environments/development.rb`
  ```ruby
  require "active_support/core_ext/integer/time"

  Rails.application.configure do
    # ...
    config.action_mailer.delivery_method = :test
    config.action_mailer.default_url_options = { :host => 'http://localhost:3000' }
    #...
  end
  ```
- `config/environments/production.rb`
  ```ruby
  require "active_support/core_ext/integer/time"

  Rails.application.configure do
    # ...
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { :host => 'ruby-on-rails-app.herokuapp.com', :protocol => 'https' }
    #...
  end 
  ```
- Gemfileとjavascriptファイルからturbolinkを除去する

## 324. Setup Milia and Devise

- DeviseとMiliaのセットアップを行う
  - Miliaはマルチテナントアプリを作成するためのgem
  - (メモ) Miliaのサポートが切れているため，Philiaを利用する。
  - (メモ) Rails 6.xを利用する際は，
    - `~/.gem/bundler/gems/philia-64ca74a7c10d/lib/generators/philia/install_generator.rb` の
      - `gem 'activerecord-session_store', github: 'rails/activerecord-session_store'` を
      - `gem 'activerecord-session_store', github: 'rails/activerecord-session_store', ref: '78e0047'` へ変更してからジェネレートコマンドを実行する
  - `rails g milia:install --org_email='do-not-reply@example.com'`
    - (メモ) `rails g philia:install --org_email='do-not-reply@example.com'`
- `rails db:migrate`
