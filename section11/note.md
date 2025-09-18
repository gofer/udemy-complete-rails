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
