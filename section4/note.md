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
