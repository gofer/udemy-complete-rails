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

## 218. Build Chatroom Homepage

- ホームページを作成する

## 219. Complete Chatroom

- メッセージ入力用のテキストボックスを追加する

## 220. Task 3: Build login page

- ログインページの構築を行う

## 221. Explore the back-end design

- バックエンドの基本的な設計を確認する

## 222. Task 4: Build User resource

- ユーザーのモデル部分の構築を行う

## 223. Task 5: Build Message resource

- メッセージのモデル部分の構築を行う

## 224. Task 6: Add actual messages from table

- メッセージを画面表に表示する

## 225. Add message pratial and refactor some code

- メッセージを部分ビューに切り出す

## 226. Task 7: Start authentication system

- 認証を実装する
- ビューとコントローラーで利用するヘルパーメソッドを実装する
  - `current_user`
  - `logged_in?`
  - 'require_user`

## 227. Add authentication system - create and destroy sessions

- ログイン・ログアウト用のエンドポイントを追加する
- ナビゲーションの修正

## 228. Enable flash messages display

- フラッシュメッセージを表示する

## 229. Restrict views at controller layer

- ログイン済みユーザーにのみがチャットルームへ遷移にできるよう修正する
- 未ログインユーザーのみがログインページへ遷移にできるよう修正する

## 230. Add messages from UI

- メッセージ入力のテキストフィールドからメッセージを投稿できるようにする

## 231. Introduction to WebSocket protocol

- チャットアプリのメッセージ機能をリアルタイムにするためにWebSocketプロトコルを利用する
- HTTPはクライアント・サーバー間の一方向の通信だが，WebSocketでは双方向の通信が可能になる
  - クライアント・サーバー間の全二重通信が実現できる
- RailsではActionCableを用いてWebSocketを簡単に実装できる

## 232. Implementing real-time with ActionCable overview

- チャネルと呼ばれる方法でサーバー側はメッセージの送受信を制御する
- 今回のアプリではRails側でChatRoom Channelでサーバ側はメッセージを制御し，クライアント側はJavaScriptで行う
  1. チャットルームのチャネルを作成
  2. `MessagesController`を改修し，チャットルームチャネルでデータをブロードキャストできるようにする
  3. JavaScriptを記述し，データの受信とウィンドウへの追記を行う
  4. スクロール対応など，スタイルの改修を行う

## 233. Generate a Chatroom channel

- チャットルームチャネル (`app/channels/chatroom_channel.rb`) を作成する
  - `rails generate channel chatroom`
  - `app/channels/chatroom_channel.rb`
    ```ruby
    class ChatroomChannel < ApplicationCable::Channel
      def subscribed
        # stream_from "some_channel"
      end

      def unsubscribed
        # Any cleanup needed when channel is unsubscribed
      end
    end
    ```
  - `app/javascript/channels/chatroom_channel.js`
    ```js
    import consumer from "./consumer"

    consumer.subscriptions.create("ChatroomChannel", {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
      }
    });
    ```

## 234. Modify and broadcast messages

- ActionCableを利用して新しいメッセージをCreateした後にブロードキャストする

## 235. Display messages using partial

- クライアント (ブラウザ) 側でブロードキャストされたメッセージを表示する
- 部分ビューを利用するために，ActionCableで部分ビューのレンダリング結果をブロードキャストする
