# デプロイガイド

## GitHub Pages
1. `main` ブランチへ push
2. `.github/workflows/deploy.yml` が検証を実行
3. Pages 用アーティファクトを公開

## カスタムドメイン
- ルートの `CNAME` を維持
- DNS 側で `<user>.github.io` への CNAME を設定

## SSL/TLS
- GitHub Pages の管理証明書を利用
- リポジトリ設定で HTTPS を強制

## PWA 配布
- Android / Desktop: インストールプロンプト
- iOS: ホーム画面に追加
