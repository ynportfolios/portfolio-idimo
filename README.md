# idimo
〇〇好きならきっとイイ人

## アプリケーションの概要
　不要な身バレを防ぐマッチングアプリです。ユーザがプロフィール画像を公開している場合、相互フォロー時に閲覧することができます。身バレが前提でないことにより失った価値は、好きな動物を共通項にすることにより補いました。コロナ禍でオンライン化に多くの人が寛容になりました。マッチングアプリに興味はあるが、どこか抵抗感を感じている層をターゲットにしています。  
　決済方法は１ヶ月毎のサブスリプション方式を採用します。これにより契約が急激に減らない限り、ある程度定まった収益を得られます。更新時に料金オプションに基づいてメッセージ可能数を付与します。付与されたメッセージ数を超えた場合には課金によって補充します。またマッチングが成就しなかったユーザには継続更新数に応じた割引を行います。  
　まずは既にマッチングアプリを運営している企業がベータ版としてリリースすることが最良であると考えています。ユーザを抱えていなければマッチングアプリとして成り立ちません。従来のマッチングアプリを使用しているユーザから身バレを防ぎたい一定層を取り込みます。ある程度のユーザを得た後にアルファ版とし、新規層を本格的に取り込みます。また満足できなかった層を従来アプリに取り込むことも可能であると考えています。

## アプリケーション内で使用している技術一覧
* Trelloを使用してタスク管理を行なっています。
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

## アプリケーションの機能一覧
* ログイン機能（devise）
  - ゲストユーザでもログインすることができます。
* 登録者数表示機能
* ユーザ検索機能（ransack）
* ページネーション機能（kaminari）
* プロフィール表示機能
* フォロー機能
* 画像アップロード機能実装（carrierwave、fog、mini_magick）
  - ユーザがプロフィール画像を公開している場合、相互フォロー時に閲覧することができます。
* ダイレクトメッセージ機能
  - それぞれのユーザがメッセージを５通ずつ送信している場合、フォローを促します。
