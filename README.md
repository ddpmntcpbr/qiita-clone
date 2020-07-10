# README
## URL

## 概要
Qiitaのクローンサイト。

[Take off rails](https://freelance.cat-algorithm.com/lp/take-off-rails) の開発成果物。

## Take off railsとは?
「Ruby や Rails を勉強したレベルの方を対象に Rails を使って実際に仕事ができるレベルまで持っていくこと」を目的に
作成された学習教材。

現役エンジニアによるコードレビューを通じて、現場で通用するスキルの学習を目指す。

- githubリポジトリへのPRを通じた、現役エンジニアによるコードレビュー
- Javascriptフレームワークとの連携を意識した Rails API モードでの開発
- Rspecによるテスト実装

あくまで Rails の学習をものとしたものであるため、Javascriptフレームワーク
(Vue.js)は完成品を使用。

## 機能一覧
- ユーザー登録・認証
- 投稿記事のCRUD
- 下書き保存・編集
- マイページ
- Markdown形式のリアルタイムレビュー

## 使用技術

**Back end**
- 言語: Ruby 2.6.2
- フレームワーク: Rails 5 (API)
- 主要gem
  - rspec: テストフレームワーク
  - faker/factory_bot_rails: テストデータ自動生成
  - rubocop: 静的コード解析
  - devise_token_auth: トークンによるユーザー登録・認証
  - webpacker: Javascriptフレームワークの導入
  - active_model_serializers: JSON の制御

**Front end**
- フレームワーク: Vue.js (ソースコードは完成品を使用。Rails APIとの繋ぎ込み方のみに注力)

**Infra**
- バージョン管理: git/github
- DB: MySQL 5.7
- DB環境構築: docker/docker-compose
- CI/CD: CircleCI
- heroku
