# Section4: CRUD Operations in Ruby on Rails

## 76. Introduction To Section4: Tables, migrations and naming conventions

- Railsにおける命名規則
  - `Articles`リソース
    - モデル名: `article` (単数形)
      - モデルファイル名: `article.rb`
      - モデルクラス名: `Article` (キャメルケース)
    - テーブル名: `articles` (複数形)
      - `id`は自動で生成され，ユニークになるようRails側で管理される
      - `string`は255文字まで
      - `text`は長い文字列

- マイグレーションの作成
  `rails generate migration create_articles`
  - ファイル名の先頭にタイムスタンプがつく
- マイグレーションの実行
  `rails db:migrate`
  まだ実行されていないマイグレーションを実行する
  - 実行済みのスキーマファイルに変更を加えて実行しても反映されない
    - ロールバック(`rails db:rollback`)する
    - ロールバックは望ましくはないので，変更の度にマイグレーションファイルを作成するべき

## 78. Models and rails console

- モデルの作成
  - `app/models/Article.rb`
    ```ruby
    class Article < ApplicationRecord
    end
    ```
- Railsコンソールでのモデルの操作
  `rails console`または`rails c`
  ```ruby
  Article.all
  # (1.8ms)  SELECT sqlite_version(*)
  # Article Load (0.6ms)  SELECT "articles".* FROM "articles"
  # => []

  Article.create(title: 'first article', description: 'description of first article')
  # TRANSACTION (0.1ms)  begin transaction
  # Article Create (0.8ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "first rticle"], ["description", "description of first article"], ["created_at", "2024-07-11 13:50:59.929388"], ["updated_at", "2024-07-11 13:50:59.929388"]]
  # TRANSACTION (9.5ms)  commit transaction
  # => #<Article:0x00007f569299a210                                                   
  #  id: 1,                                                                        
  #  title: "first article",                                           
  #  description: "description of first article",                      
  #  created_at: Thu, 11 Jul 2024 22:50:59.929388084 JST +09:00,       
  #  updated_at: Thu, 11 Jul 2024 22:50:59.929388084 JST +09:00>

  Article.all
  # (0.7ms)  SELECT sqlite_version(*)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f56923d26c0
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>]

  article = Article.new
  # => #<Article:0x00007f5691914df0

  article.title = 'second article'
  # => "second article"

  article.description = 'description of second article'
  # => "description of second article"

  article
  # => #<Article:0x00007f5691914df0
  #  id: nil,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: nil,
  #  updated_at: nil>

  article.save
  # TRANSACTION (0.1ms)  begin transaction
  # Article Create (0.3ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "second article"], ["description", "description of second article"], ["created_at", "2024-07-11 13:57:01.090116"], ["updated_at", "2024-07-11 13:57:01.090116"]]
  # TRANSACTION (18.0ms)  commit transaction
  # => true

  Article.all
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f56985c1ca0
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f56985c1bd8
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>]

  article
  # => #<Article:0x00007f5691914df0
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116557 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116557 JST +09:00>

  article = Article.new(title: 'third article', description: 'description of third article')
  # => #<Article:0x00007f5691a16ca8

  article
  # => #<Article:0x00007f5691a16ca8
  #  id: nil,
  #  title: "third article",
  #  description: "description of third article",
  #  created_at: nil,
  #  updated_at: nil>

  article.save
  # TRANSACTION (0.1ms)  begin transaction
  # Article Create (0.4ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "third article"], ["description", "description of third article"], ["created_at", "2024-07-11 14:00:49.783965"], ["updated_at", "2024-07-11 14:00:49.783965"]]
  # TRANSACTION (14.1ms)  commit transaction
  # => true

  Article.all
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f5693010810
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f5693010748
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>,
  #  #<Article:0x00007f5693010680
  #   id: 3,
  #   title: "third article",
  #   description: "description of third article",
  #   created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>]

  exit
  ```

## 80. CRUD operations from rails console

- RailsコンソールでのCRUD処理
  ```ruby
  Article.all
  # (0.4ms)  SELECT sqlite_version(*)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f56928dd958
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f569289f8d8
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>,
  #  #<Article:0x00007f569289f810
  #   id: 3,
  #   title: "third article",
  #   description: "description of third article",
  #   created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>]

  Article.find(2)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f5692393998
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  Article.first
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 1]]
  # => #<Article:0x00007f56924012e0
  #  id: 1,
  #  title: "first article",
  #  description: "description of first article",
  #  created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>

  Article.last
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
  # => #<Article:0x00007f5692906290
  #  id: 3,
  #  title: "third article",
  #  description: "description of third article",
  #  created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>

  article = Article.find(2)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f56923e6b70

  articles = Article.all
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f5698f372f8

  article
  # => #<Article:0x00007f56923e6b70
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  articles
  # => [#<Article:0x00007f5698f372f8
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f5698f36df8
  #   id: 2,
  #   title: "second article",
  #   description: "description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>,
  #  #<Article:0x00007f5698f36cb8
  #   id: 3,
  #   title: "third article",
  #   description: "description of third article",
  #   created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>]

  article.title
  # => "second article"

  article.description
  # => "description of second article"

  article.description = 'edited - description of second article'
  # => "edited - description of second article"

  article
  # => #<Article:0x00007f56923e6b70
  #  id: 2,
  #  title: "second article",
  #  description: "edited - description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  Article.find(2)
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f56923545b8
  #  id: 2,
  #  title: "second article",
  #  description: "description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00>

  article.save
  # TRANSACTION (0.1ms)  begin transaction
  # Article Update (0.4ms)  UPDATE "articles" SET "description" = ?, "updated_at" = ? WHERE "articles"."id" = ?  [["description", "edited - description of second article"], ["updated_at", "2024-07-11 14:14:48.035293"], ["id", 2]]
  # TRANSACTION (18.0ms)  commit transaction
  # => true

  Article.find(2)
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  # => #<Article:0x00007f56923dec40
  #  id: 2,
  #  title: "second article",
  #  description: "edited - description of second article",
  #  created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 23:14:48.035293000 JST +09:00>

  article = Article.last
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
  # => #<Article:0x00007f5698491880

  article.destroy
  # TRANSACTION (0.1ms)  begin transaction
  # Article Destroy (0.3ms)  DELETE FROM "articles" WHERE "articles"."id" = ?  [["id", 3]]
  # TRANSACTION (10.7ms)  commit transaction
  # => #<Article:0x00007f5698491880
  #  id: 3,
  #  title: "third article",
  #  description: "description of third article",
  #  created_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00,
  #  updated_at: Thu, 11 Jul 2024 23:00:49.783965000 JST +09:00>

  Article.all
  # Article Load (0.1ms)  SELECT "articles".* FROM "articles"
  # => [#<Article:0x00007f5692957f78
  #   id: 1,
  #   title: "first article",
  #   description: "description of first article",
  #   created_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 22:50:59.929388000 JST +09:00>,
  #  #<Article:0x00007f5692957eb0
  #   id: 2,
  #   title: "second article",
  #   description: "edited - description of second article",
  #   created_at: Thu, 11 Jul 2024 22:57:01.090116000 JST +09:00,
  #   updated_at: Thu, 11 Jul 2024 23:14:48.035293000 JST +09:00>]
  ```

## 82. Validations

- バリデーション
  - `app/models/article.rb`
    ```ruby
    class Article < ApplicationRecord
      validates :title, presence: true
    end
    ```
  - `rails c`
    ```ruby
    # アプリケーションを変更したらコンソールでもリロードする
    reload!
    # Reloading...
    # => true

    article = Article.new
    # (0.1ms)  SELECT sqlite_version(*)
    # => #<Article:0x00007f569847f9c8

    article.save
    # => false

    article.errors
    # => #<ActiveModel::Errors:0x00007f5692957870
    #  @base=
    #   #<Article:0x00007f569847f9c8
    #    id: nil,
    #    title: nil,
    #    description: nil,
    #    created_at: nil,
    #    updated_at: nil>,
    #  @errors=[#<ActiveModel::Error attribute=title, type=blank, options={}>]>

    article.errors.full_messages
    # => ["Title can't be blank"]
    ```

  - `app/models/article.rb`
    ```ruby
    class Article < ApplicationRecord
      validates :title, presence: true
      validates :description, presence: true
    end
    ```
  - `rails c`
    ```ruby
    reload!
    # Reloading...
    # => true

    article = Article.new
    # (0.1ms)  SELECT sqlite_version(*)
    # => #<Article:0x00007f5698602200

    article.save
    # => false

    article.errors.full_messages
    # => ["Title can't be blank", "Description can't be blank"]

    article.title = 'test article'
    # => "test article"

    article.save
    # => false

    article.errors.full_messages
    # => ["Description can't be blank"]

    article.description = 'Test description'
    # => "Test description"

    article.save
    # TRANSACTION (0.1ms)  begin transaction
    # Article Create (0.4ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "test article"], ["description", "Test description"], ["created_at", "2024-07-11 14:28:35.578058"], ["updated_at", "2024-07-11 14:28:35.578058"]]
    # TRANSACTION (14.1ms)  commit transaction
    # => true
    ```

  - `app/models/article.rb`
    ```ruby
    class Article < ApplicationRecord
      validates :title, presence: true, length: { minimum: 6, maximum: 100 }
      validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    end
    ```
  - `rails c`
    ```ruby
    reload!
    # Reloading...
    # => true

    article = Article.new(title: 'a', description: 'b')
    # (0.1ms)  SELECT sqlite_version(*)
    # => #<Article:0x00007f569285d5a0

    article.save
    # => false

    article.errors.full_messages
    # => ["Title is too short (minimum is 6 characters)", "Description is too short (minimum is 10 characters)"]

    article.title = 'this should pass validation'
    # => "this should pass validation"

    article.description = 'edited article description'
    # => "edited article description"

    article.save
    # TRANSACTION (0.1ms)  begin transaction
    # Article Create (0.4ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "this should pass validation"], ["description", "edited article description"], ["created_at", "2024-07-11 14:33:08.780853"], ["updated_at", "2024-07-11 14:33:08.780853"]]
    # TRANSACTION (17.2ms)  commit transaction
    # => true
    ```

## 84. Show articles (route, action and view)

- Railsアプリケーション
  ```plain
                Rails Application
  browser ----> route (config/routes.rb) --------------------------+
    ^                                                              |                       
    |                                                              v
    +---------- view (app/views/articles/show.html.erb) <-----  controller (app/controllers/article_controller.rb)
                                                                   |
                                                                   v
                                                                model (app/models/article.rb)
                                                                   ^
                                                                   |
                                                                   v
                                                                database
  ```

- ルーティング
  - `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      # resources :articles
      resources :articles, only: [:show]
    end
    ```

- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      def show
      end
    end
    ```

- ビュー
  - `app/views/articles/show.html.erb`
    ```erb
    <h1>Showing article details</h1>
    ```

- モデルの内容を表示する
  - コントローラー
    - `app/controllers/articles_controller.rb`
      ```ruby
      class ArticlesController < ApplicationController
        def show
          @article = Article.find(params[:id])
        end
      end
      ```

  - ビュー
    - `app/views/articles/show.html.erb`
      ```erb
      <h1>Showing article details</h1>

      <p><strong>Title: </strong><%= @article.title %></p>
      <p><strong>Description: </strong><%= @article.description %></p>
      ```

## 86. Articles index

- 一覧ページ(index)を作る
- ルーティング
  - `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      resources :articles, only: [:show, :index]
    end
    ```
- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def index
        @articles = Article.all
      end
    end
    ```
- ビュー
  - `app/views/articles/index.html.erb`
    ```erb
    <table>
      <thead>
        <tr>
          <th>Title</th>
          <th>Description</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% @articles.each do |article| %>
        <tr>
          <td><%= article.title %></td>
          <td><%= article.description %></td>
          <td>Placeholder</td>
        </tr>
        <% end %>
      </tbody>
    </table>
    ```

## 88. Forms - build a new article creation form

- 新規作成画面をつくる
- ルーティング
  - `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      resources :articles, only: [:show, :index, :new, :create]
    end
    ```
- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def new
      end

      def create
        render plain: params[:article]
      end
    end
    ```
- ビュー
  - `app/views/articles/new.html.erb`
    ```erb
    <%= form_with scope: :article, url: articles_path, local: true do |f| %>

      <p>
        <%= f.label :title %><br />
        <%= f.text_field :title %>
      </p>

      <p>
        <%= f.label :description %><br />
        <%= f.text_area :description %>
      </p>

      <p>
        <%= f.submit %>
      </p>
    <% end %>
    ```

## 90. Create action - save newly created articles

- 新規作成機能をつくる
- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def new
      end

      def create
        # @article = Article.new(params[:article])
        @article = Article.new(params.require(:article).permit(:title, :description))
        @article.save

        # redirect_to article_path(@article)
        redirect_to @article
      end
    end
    ```

## 92. Messaging - validation and flash messages

- バリデーションとフラッシュメッセージの実装
- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def new
        # for `if @article.errors.any?`
        @article = Article.new
      end

      def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
          flash[:notice] = 'Article was created successfully.'
          redirect_to @article
        else
          render 'new'
        end
      end
    end
    ```
- ビュー
  - `app/views/articles/new.html.erb`
    ```erb
    <% if @article.errors.any? %>
      <h2>The following errors prevented the article from being saved</h2>
      <ul>
      <% @article.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    <% end %>
    ```
  - `app/views/layouts/application.html.erb`
    ```erb
    <!-- ... -->
    <body>
      <% flash.each do |name, msg| %>
        <%= msg %>
      <% end %>
      <%= yield %>
    </body>
    <!-- ... -->
    ```

## 94. Edit and update: update existing articles

- 編集画面と機能を作成する
- ルーティング
  - `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      resources :articles, only: [:show, :index, :new, :create, :edit, :update]
    end
    ```
- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def edit
        @article = Article.find(params[:id])
      end

      def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
          flash[:notice] = 'Article was updated successfully.'
          redirect_to @article
        else
          render 'edit'
        end
      end
    end
    ```
- ビュー
  - `app/views/articles/edit.html.erb`
    ```erb
    <%= form_with(model: @article, local: true) do |f| %>
      <p>
        <%= f.label :title %><br />
        <%= f.text_field :title %>
      </p>

      <p>
        <%= f.label :description %><br />
        <%= f.text_area :description %>
      </p>

      <p>
        <%= f.submit %>
      </p>
    <% end %>
    ```

## 96. Delete: delete articles

- 削除機能を作成する
- ルーティング
  - `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
      resources :articles
    end
    ```
  - REST (Representational state transfer)はHTTP動詞をCRUDのアクションに対応させる
  - `resources`ではRailsリソースに対するRESTfulなルートをすべて定義する
- コントローラー
  - `app/controllers/articles_controller.rb`
    ```ruby
    class ArticlesController < ApplicationController
      # ...

      def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
      end
    end
    ```
- ビュー
  - `app/views/articles/index.html.erb`
    ```erb
    <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.description %></td>
      <td><%= link_to 'Delete', article_path(article), method: :delete %></td>
    </tr>
    <% end %>
    ```