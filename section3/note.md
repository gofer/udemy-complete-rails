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

## 60. Structure of a Rails application

Rails 6のその他のファイルやフォルダーについて

- `app`
  - `assets`

      画像(`images`)やスタイルシート(`stylesheets`)などの静的アセットを格納するフォルダー (`app/views`以下などから参照する)
  - `channels`

    リアルタイム通信のためのActionCableのためのフォルダー
  - `controllers`

    コントローラーを格納するフォルダー

    `application_controller.rb`にある`ApplicationController`は`ActionController::Base`を継承

      - `app/controllers/application_controller.rb`
        ```ruby
        class ApplicationController < ActionController::Base
          # ...
        end
        ```

    さらに，各コントローラーは`ApplicationController`を継承している

      - `app/controllers/pages_controller.rb`
        ```ruby
        class PagesController < ApplicationController
          # ...
        end
        ```
  - `helpers`

      ヘルパー関数を格納するフォルダー (ビューテンプレートで利用する)
  - `javascript`
      古いバージョンでは`assets`以下にあったが，Rails 6以降ではWebpackにより処理される
      - `packs/application.js`

        JavaScriptのマニフェストファイル
  - `models`

    モデルを格納するフォルダー

    `application_record.rb`にある`ApplicationRecord`は`ActiveRecord::Base`を継承
    - `app/models/application_record.rb`
      ```ruby
      class ApplicationRecord < ActiveRecord::Base
        # ...
      end
      ```
    
    さらに，各モデルは`ApplicationRecord`を継承
    - `app/models/stock.rb`
      ```ruby
      class Stock < ApplicationRecord
        # ...
      end
      ```
  - `views`
    
    ビューのテンプレートファイルを格納するフォルダー

    - `layouts`
      
      レイアウトになるテンプレートファイルを格納する
      
      `<%= yield %>`に本文が埋め込まれる

      - `app/views/layouts/application.html.erb`
        ```erb
        <!DOCTYPE html>
        <html>
          <head>
            <title>TestApp6</title>
            <meta name="viewport" content="width=device-width,initial-scale=1">
            <%= csrf_meta_tags %>
            <%= csp_meta_tag %>

            <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
            <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
          </head>

          <body>
            <%= yield %>
          </body>
        </html>
        ```
- `bin`

  バイナリ実行可能ファイルを格納
- `config`

  アプリケーションの設定を格納するフォルダー

  - `environments`

    環境 (開発・本番など) ごとの設定を定義する

  - `routes.rb`

    アプリケーションのルーティングを設定する

    - `config/routes.rb`
      ```ruby
      Rails.application.routes.draw do
        # ...
      end
      ```
- `db`

  開発用・テスト用のデータベース関連ファイルを格納するフォルダー

  開発時・テスト時にはSQLiteを利用することが多い

  マイグレーションファイルもこのフォルダーに格納される
- `Gemfile` / `Gemfile.lock`
  
  Railsアプリケーションの依存関係にあたるgemを記述する
- `package.json`

  yarnを利用してJavaScriptの依存関係を記述・インストールする
- `README.md`

  READMEを記述する

  GitHubなどの公開レポジトリではサイト上にこれが表示される

## 62. Version control with Git

- Gitによるバージョン管理は開発において非常に重要
  - 誤りがあっても以前の状態に戻せる
- バージョン管理のプロセス
  1. ファイルのトラッキング

      アプリケーションのファイルとフォルダーを追跡するよう登録する

  1. コミット

      変更を確定し，必要に応じてコミットメッセージを付与する

      内部ではコミットの度にアプリケーションをコピーして保存する

  1. コミット履歴

      以前のコミット情報は残り，コミット履歴になる

      必要に応じて以前の状態に戻せる
- Git
  - [公式ドキュメント](https://git-scm.com/doc)
    - [Pro Git](https://git-scm.com/book/ja/v2)
  - 設定

      Gitの設定内容は`git config --list`で確認できる
  - トラッキング

     Gitのトラッキングは`git add -A`で行う

     トラックングしたくないファイルは`git rm --cache`で取り除く

     `.gitignore`ファイルでトラッキングしないよう指定できる
  - コミット

    Gitのコミットは`git commit -m "{コミットメッセージ}"`で行う

    `git status`で現在の状態を確認できる

## 64. Setup online code repository with GitHub

## 66. Front-end: Learn and practice HTML and CSS

- HTMLタグとは何か
  - `h1` / `p`など
- CSSを用いてidやclassを用いてスタイルを適用する
- インラインと外部ファイルによるCSSの違い
- 基本的なフォームやテーブルの作り方

MDNのドキュメントを読む
- [ウェブ入門 - ウェブ開発を学ぶ | MDN](https://developer.mozilla.org/ja/docs/Learn/Getting_started_with_the_web)
- [HTML の基本 - ウェブ開発を学ぶ | MDN](https://developer.mozilla.org/ja/docs/Learn/Getting_started_with_the_web/HTML_basics)
- [CSS の基本 - ウェブ開発を学ぶ | MDN](https://developer.mozilla.org/ja/docs/Learn/Getting_started_with_the_web/CSS_basics)

良いチュートリアル
- [Learn to Code HTML & CSS - Beginner & Advanced](https://learn.shayhowe.com)

## 68. Add About page and homework assignment

`/about`にAboutページを表示させる

`config/routes.rb`でGETメソッドに対応するルートを定義するには`get`を用いる

`get {ルート}, to: '{コントローラー名}#{アクション名}'`で定義する

- `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      root 'pages#home'
      get 'about', to: 'pages#about'
    end
    ```
- `app/controller/pages_controller.rb`
    ```ruby
    class PagesController < ApplicationController
      def home
      end

      def about
      end
    end
    ```
- `app/views/pages/about.html.erb`
    ```erb
    <h1>This is the About page</h1>
    ```

## 70. Production Deploy!

herokuを用いた本番環境へのデプロイ

本番環境ではsqliteではなくPostgreSQLなど利用する。

## 72. The back-end: Database and tables in Rails

- データベースは通常複数のテーブルで構成されている
  - テーブルはExcelのスプレッドシートのようなもの
  - テーブルは共通の情報をもつ列を利用して他のテーブルとリンクできる

    以下の例では`users`の`id`と`articles`の`user_id`で対応付けている

    - `users`
      | id | name | email | password |
      |:--:|------|-------|----------|
      | 1 |  |  |  |
      | **2** |  |  |  |
      | 3 |  |  |  |
      | 4 |  |  |  |
    - `articles`
      | id | title | description | user_id |
      |:--:|-------|-------------|:-------:|
      | 1 | first article | description of first article | **2** |
      | 2 | second article | desciption of second | **2** |
      | 3 | some fun article | this article is a lot of fun | 1 |
      | 4 | programming | programming is alot of fun | 3 |
- データベースに対する処理; CRUD
  - C; Create articles
  - R; Read articles
  - U; Update articles
  - D; Delete articles
- データベースへのクエリを表現する言語; SQL (Structured Query Langeuage)
  - データベース管理システムには若干違いがある
  - Microsoft SQL Server / PostgreSQL / Oracleなど
- RailsではActive RecordというORM(Object Relational Mapper)を利用する
  - Railsアプリケーションとデータベースの橋渡し役
  - 基本的に直接SQLを記述する必要はない
  - Active RecordはActive Recordパターンと呼ばれるデザインパターンをRailsように実装したもの
- これらがRailsのモデル層を構成する

## 73. The back-end: CRUD, scaffold and warp-up section 3

- `rails generate scaffold`コマンドでリソース周りのコードを一括で生成できる
  - `rails generate scaffold {モデル名} [{カラム名}:{型} ...]`
  - 型は`string`や`text`など

- マイグレーションファイル
  - `db/migrate/yyyymmddhhmss_create_articles.rb`
    ```ruby
    class CreateArticles < ActiveRecord::Migration[6.1]
      def change
        create_table :articles do |t|
          t.string :title
          t.text :description

          t.timestamps
        end
      end
    end
    ```
    - `t.timestamps`は`created_at`と`updated_at`のタイムスタンプを生成する
 - マイグレーションは`rails db:migrate`で行う
   - `db/schema.rb`が更新される
- モデルは`app/models/{モデル名}.rb`
  - モデル名は単数形
- コントローラーは`app/controllers/{モデル名}_controller.rb`
  - モデル名は複数形
- ルーティング定義は`config/routes.rb`に追記
  - `resources :{モデル名}`
  - モデル名は複数形
  - `rails routes --expanded`で詳細表示
