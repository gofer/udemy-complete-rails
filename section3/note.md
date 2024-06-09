# Section3: Introduction to Ruby on Rails

## 53. Introduction to Section 3 and Ruby on Rails kickoff

- Ruby on Rails (略してRails)はWebアプリケーション開発フレームワーク
  - シンプルなものから複雑なエンタープライズアプリケーションまで対応
  - 様々なアプリケーションに利用されている
    - Airbnb，GitHub，(初期の)Twitterなど
- 2019年中盤にRails 6がリリース
- David Heinemeier Hansson (DHH)によって開発された
- オープンソースで開発されている
  - 世界各地でミートアップが開催されているなど，コミュニティが活発
  - コードレポジトリは[GitHub](https://github.com/rails/rails)にある
- 役に立つgemがいっぱい
  - 認証用の[devise](https://github.com/heartcombo/devise)とか

この講座ではまず自分で作ってみて，その後にgemを導入する。
そのほうがより理解できる。

ドキュメントは[rubyonrails.org](https://rubyonrails.org)にある。
- [Ruby on Rails Guides](https://guides.rubyonrails.org)
- [Ruby on Rails API](https://api.rubyonrails.org)

## 55. Model, View, Controller and Rails App Structure

### MVC; Model-View-Controller

プレゼンテーション層 (フロントエンド; ユーザがブラウザやモバイルデバイスでアプリケーションを閲覧するもの) と ビジネスロジック (バックエンド; ユーザからは見えない) を分離する

- モデル
  - モデルはアプリ内のリソース
    - 例; ユーザ，ブログ投稿，記事，友人，株式など
  - データベースなどで永続化する
    - Railsはモデルを利用してデータベースと通信する
- ビュー
  - アプリケーションのユーザから見える層
  - HTML / CSS / JacaScriptなどで構成される
  - テンプレートを使用して作業する
    - 埋め込みRuby (embedded-ruby, `.erb`ファイル)
- コントローラー
  - バックエンドに該当
  - アプリケーションの頭脳として…

    - ユーザのリクエストを処理
    - ルーティング
    
    などを担う。

### Rails app structure

Rails 6に基づくRailsアプリケーションの構造

- `app`
  - `controllers`

    コントローラー
  - `models`

    モデル
  - `views`
    
    ビューのテンプレート

## 58. Root route, controller, more MVC and say 'Hello World!'

`rails s`コマンドで開発用サーバーが起動する

- ルーティング情報は`config/routes.rb`へ記述する。

  `controller#action`の形式で記述する。
  
    `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      root 'application#hello'
    end
    ```

- コントローラーは`{コントローラー名}_controller.rb`というファイル名で作成する。
  - `render`メソッドでレンダリングを行う。

    `app/controllers/application_controller.rb`
    ```ruby
    class ApplicationController < ActionController::Base
      def hello
        render html: 'Hello World!'
      end
    end
    ```


`rails generate controller {コントローラー名}`でコントローラーを生成できる。

アクションに対応するビューは`app/views/{コントローラー名}/{アクション名}.html.erb`で作成する。

- `app/controllers/pages_controller.rb`
    ```ruby
    class PagesController < ApplicationController
      def home
      end
    end
    ```

- `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      root 'pages#hello'
    end
    ```

- `app/views/pages/home.html.erb`
    ```erb
    Hello World!
    ```
