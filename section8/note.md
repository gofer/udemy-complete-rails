# Section8: Real-time Rails - MessageMe Chat app using ActionCable and web sockets

## 209. Preview of the app built in this section

- MessageMeというチャットアプリを構築する
- ActionCableを利用してリアルタイム通信を実現する
  - WebSocketを利用する
- Semantic UIでフロントエンドを構築する

## 211. Start new rails app (local, cloud9, AWS cloud9 all 3 for demo)

- Railsアプリの構築を行う
  - Railsは5系を利用する (でも現在はサポート外なので6系で構築してみる)

## 212. Task 1: Version control

- GitとGitHubレポジトリの設定

## 213. Task 2: Root and Login routes

- ルートとログインのルート
  - `config/routes.rb`
    ```ruby
    Rails.application.routes.draw do
      root 'chatroom#index'
      get 'login', to: 'sessions#new'
    end
    ```
- コントローラーの作成
  - `app/controllers/chatroom_controller.rb`
  - `app/controllers/sessions_controller.rb`
- ビューの作成
  - `app/views/chatroom/index.html.erb`
  - `app/views/sessions/new.html.erb`

## 214. Install Semantic-UI for front-end

- フロントエンド用にSemantic UIやjQueryなどの依存関係を準備する

## 215. Add navigation menu

- (メモ) サーバーの起動: `NODE_OPTIONS='--openssl-legacy-provider' RUBYOPT="-r logger" rails s`
- アプリケーションにナビゲーションメニューを追加する

## 216. Enable dropdown functionality and create nav partial

- ドロップダウンが機能するようにjQueryの設定を行う

## 217. Add favicon

- favicon.icoを追加する
