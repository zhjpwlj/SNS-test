# この掲示板について
この掲示板は、**ユーザー名**と**投稿内容**を入力し、投稿すると掲示板として投稿できるシステムです。
# 主な仕組み
### 投稿者の入力
どちらかでも入力されていないと、投稿できないようになっています。
### 投稿機能
投稿ボタンが押されると、スプレッドシートにデータが送信されます。投稿を受け取るプログラムは、Apps Scriptを使用して受け取っています。
# サーバー稼働状況
サーバーは、独自サーバーを使用しておらず、スプレッドシートを利用しています。  
サーバー稼働状況は、[こちら](https://www.google.com/appsstatus/dashboard/#:~:text=Apps%20スクリプト)で確認できます。
# スパム対策
スパムに関しては、スプレッドシートの行を一気に削除することで対策できます。  
迷惑なスパムが続く場合、サービスを停止する場合がありますので、ご了承ください。
# 自分が管理者になる方法
掲示板の管理者にならないと、投稿の管理ができません。これから、管理者になる方法を説明します。
### このリポジトリをフォーク
このリポジトリをフォークします。
### プログラムを編集
#### スプレッドシートでApps Scriptを作成
スプレッドシートで、Apps Scriptを作成します。プログラムは、以下を入力します。
```
function doGet(e) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var data = sheet.getDataRange().getValues();
  var jsonData = JSON.stringify(data);
  return ContentService.createTextOutput(jsonData).setMimeType(ContentService.MimeType.JSON);
}
function doPost(e) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var date = new Date();
  var username = e.parameter.username;
  var content = e.parameter.content;
  sheet.appendRow([date, username, content]);
  return ContentService.createTextOutput("投稿が完了しました！");
}
```
入力したら、  
デプロイ>新しいデプロイ>デプロイタイプ>ウェブアプリ>アクセスできるユーザー>全員>デプロイ  
と操作し、デプロイが更新されたら、ウェブアプリのURLをコピーしておきます。
#### index.htmlの更新
65行目のプログラムを、以下に変更します。
```
<form id="postForm" action="さっきコピーしたURL" method="POST">
```
また、  
80行目のプログラムを、以下に変更します。
```
const response = await fetch('さっきコピーしたURL');
```
さっきコピーしたURLの部分は、ちゃんと置き換えておきます。
### 列の準備
1行目からはデータを抽出しませんのでわかりやすい列を作っておきます。
![列の見本](イメージ図)
### GitHubPageを公開
GitHubPageを公開して自分が管理者の掲示板の完成です。
# 改造について
改造は基本的に許容しています。  
ですが、改造をしないとしても複製する場合は、**CAPTCHA認証はコードを改めて**ください。CAPTCHAが有効になりません。
![列の見本](無効)
# ライセンス
MIT licenseに、基づいて利用してください。
# アップデート履歴
## 2025/03/20
以下の変更点があります。  
・新しい投稿が上に積み上がっていくようになりました。  
・それぞれの投稿に投稿ナンバーをつけました。  
・それぞれの投稿に報告ボタンを実装され、Googleフォームで報告できるようになりました。
## 2025/03/22
Cloudflare認証を導入しました。
## 2025/03/26
Cloudflare認証ができないという事例が上がったため、Google reCAPTCHAに変更しました。
## 2025/03/28
URLを以下に変更しました。以前のURLにアクセスした場合でも、自動でリダイレクトされます。  
https://gamma.f5.si
## 2025/05/07
ファビコンを追加しました。  
その他、再度Googleにクローリング申し出しました。
## 2025/05/25
リアルタイム通信(5秒ごと)で投稿が更新されるようになりました。  
また、ホーム画面に追加した時ネイティブアプリとして動作するようになりました。
## 2025/06/03
利用者(yir001さん)のアイデアで、背景変更機能を実装しました。  
yir001さん、ありがとうございます。
## 2025/06/04
利用者(ぽんづさん)のアイデアで、背景端末挿入機能を実装しました。  
ぽんづさん、ありがとうございます。
## 2025/06/07
返信機能を追加しました。
# API
APIでは、投稿情報を取得できます。  
https://api.gamma.f5.si/post/1  
のように、post/の後に投稿ナンバーをつけたURLで取得できます。
# 貢献者
<img src="YU-TechnicalDepartment" width="50"> <img src="sadaramagura" width="50"> <img src="Copilot" width="50">  
ご協力いただき、ありがとうございます。  
また、アイデアもお願いします。

---

## 追加ドキュメント（拡張設計）
このリポジトリは既存の掲示板機能を壊さない方針で、将来拡張用のドキュメントとテンプレートを追加しています。

- セットアップ: `docs/SETUP.md`
- アーキテクチャ: `docs/ARCHITECTURE.md`
- デプロイ: `docs/DEPLOYMENT.md`
- 保守運用: `docs/MAINTENANCE.md`
- 環境変数テンプレート: `.env.template`
- Firebase設定テンプレート: `firebase.json`
- Supabaseストレージポリシー: `supabase/policies.sql`
- GitHub Pagesデプロイ: `.github/workflows/deploy.yml`

