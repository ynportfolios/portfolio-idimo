# idimo
〇〇好きならきっとイイ人

## コンセプト
不要な身バレを防ぐマッチングアプリ

## バージョン
* Ruby 2.5.8  
* Rails 5.2.4.4

## 概要
　ユーザがプロフィール画像を公開している場合、相互フォロー時に閲覧することができます。プロフィール画像以外の相手ユーザ情報の閲覧、ダイレクトメッセージでのやりとりは相互フォロー時でなくとも可能です。身バレが前提でないことにより失った価値は、好きな動物を共通項にすることにより補いました。コロナ禍でオンライン化に多くの人が寛容になりました。マッチングアプリに興味はあるが、どこか抵抗感を感じている層をターゲットにしています。  
　決済方法は１ヶ月毎のサブスリプション方式を採用します。これにより契約が急激に減らない限り、ある程度定まった収益を得られます。更新時に料金オプションに基づいてメッセージ可能数を付与します。付与されたメッセージ数を超えた場合には課金によって補充します。またマッチングが成就しなかったユーザには継続更新数に応じた割引を行います。  
　まずは既にマッチングアプリを運営している企業がベータ版としてリリースすることが最良であると考えています。ユーザを抱えていなければマッチングアプリとして成り立ちません。従来のマッチングアプリを使用しているユーザから身バレを防ぎたい一定層を取り込みます。ある程度のユーザを得た後にアルファ版とし、新規層を本格的に取り込みます。また満足できなかった層を従来アプリに取り込むことも可能であると考えています。

## 技術一覧
* WebフレームワークにRuby on Railsを使用しています。
* 独自ドメインを設定しています。
* https化しています。
* Rspecを使用してテストを作成しています。
* レスポンシブ対応のためにBootstrapを使用しています。
* CircleCIを使用してCIを構築しています。
* Dockerコンテナで開発を行いAWSで本番運用しています。
  - ECS・EC2
  - ECR
  - RDS・PostgreSQL
  - S3
  - ACM
  - ELB・ALB
  - VPC

## 機能一覧
* ログイン機能
  - ゲストユーザでもログインすることができます。
* ユーザ登録機能
  - Eメール、ユーザ名、好きな動物、性別、生年月日、パスワードは必須です。
* ユーザ編集機能
  - 必須項目以外にプロフィール画像、自己紹介も編集できます。
* パスワード再設定機能
* ユーザ一覧表示・検索機能
  - 各ユーザのユーザ名、好きな動物、自己紹介を表示します。
  - キーワード（ユーザ名、好きな動物、自己紹介）、性別、生年月日で検索できます。
  - ５ユーザごとにページネーションを行います。
* ユーザ詳細表示機能
  - 該当ユーザが設定したユーザ名、好きな動物、性別、年齢、自己紹介を表示します。
  - 相互フォロー時または自分自身のプロフィールである場合、該当ユーザのプロフィール画像を表示します。
  - 該当ユーザへフォロー・フォロー解除を行います。
  - 該当ユーザとのダイレクトメッセージ画面へ遷移できます。
* フォロー機能
  - 該当ユーザへフォロー・フォロー解除ができます。
* フォロー中ユーザ一覧表示機能
  - フォロー中ユーザのユーザ名、好きな動物、自己紹介を表示します。
* フォロワーユーザ一覧表示機能
  - フォロワーのユーザ名、好きな動物、自己紹介を表示します。
* ダイレクトメッセージ機能
  - 該当ユーザへメッセージを送信できます。
  - それぞれのユーザがメッセージを５通ずつ送信している場合、フォローを促します。
* ダイレクトメッセージ一覧表示機能
  - ダイレクトメッセージを行った各ユーザのユーザ名、好きな動物を表示します。
  - ダイレクトメッセージを行った各ユーザとの最後のメッセージを表示します。

## カタログ設計
https://docs.google.com/spreadsheets/d/1qKLTuAGL1qU3xmecncMPBQARYw2Wizvdr8rPZNGYOs0/edit?usp=sharing

## テーブル定義・ER図
https://docs.google.com/spreadsheets/d/1FNDnS8KO7vljwhsnVsWhY7xD_cpqVaUWV_SGNpt4ahw/edit?usp=sharing

## 画面遷移図
https://docs.google.com/spreadsheets/d/1g111Cza5JvebZCXovtTbnMH-ZhcXAijl9TApjL3c-aU/edit?usp=sharing

## ワイヤーフレーム
https://docs.google.com/spreadsheets/d/18cSMkrrpCPFrS1DsgRc-4-cBELlbcQgkOaRMs58JMHU/edit?usp=sharing

## 使用Gem
* devise
* devise-i18n
* rails-i18n
* ransack
* kaminari
* carrierwave
* fog
* mini_magick
* bootstrap
* jquery-rails
* dotenv-rails
* faker
* factory_bot_rails
* rspec-rails
* rubocop

## ローカルでの実行方法
**前提：git、docker、docker-composeをインストールしていること**
* gitからportfolio-idimoをクローン
  - ```git clone https://github.com/ynportfolios/portfolio-idimo.git```
* portfolio-idimoフォルダに移動
  - ```cd portfolio-idimo```
* portfolio-idimoフォルダ直下に.envファイル（環境変数）を作成
  - メイラーとして使用するgoogleアカウントのメールアドレス・パスワードを入力
  - 記入例：  
  MAIL_USERNAME = `youremail@gmail.com`  
  MAIL_PASSWORD = yourpassword
* dockerコンテナ（web・db）を起動
  - ```docker-compose up --build -d```
* dockerコンテナ（web）に入る
  - ```docker-compose exec web bash```
* データベースの作成
  - ```rails db:create```
* マイグレーションを実行
  - ```rails db:migrate```
* seedデータの投入
  - ```rails db:seed```
* サーバの実行・アクセス
  - ```rails s -b 0.0.0.0```
  - ブラウザでlocalhost:3000にアクセス