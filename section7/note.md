# Section7: Many-To-Many Associations and Automated Testing - Integration, Functional, Unit

## 177. Introduction to Section 7

- 多対多の関連付け，自動化テスト (ユニットテスト・機能テスト・統合テスト) について学ぶ
- 記事とカテゴリの間に多対多の関連が入る
- テストの分類
  - 単体テスト (unit tests): モデル，アプリケーションの個々の機能 (バリデーションなど) が正しく動作するかを確認する
  - 機能テスト (functional tests): コントローラーが正しく動作するかを確認する (未ログインユーザが操作を実行できないよう `before_action` で防ぐなど)
  - 統合テスト (integration tests): 最初から最後まですべての機能 (一貫したビジネスプロセス) が正しく動作するかを確認する (ユーザーがアプリケーションにサインアップできるかなど)
