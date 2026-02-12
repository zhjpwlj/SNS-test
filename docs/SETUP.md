# セットアップガイド

## 1) 現在の運用方式（スプレッドシート連携）

このリポジトリは、静的サイトから Google Apps Script に投稿し、
Google スプレッドシートをデータ保存先として利用しています。

### スプレッドシートの仕組み
1. `index.html` の投稿フォームが `username` と `content` を Apps Script WebアプリURLに送信します。
2. Apps Script の `doPost(e)` が 1 投稿ごとに 1 行を追記します。
3. ブラウザ側の `fetch()` が `doGet(e)` を呼び、全行を JSON で受け取ります。
4. フロント側は 1 行目をヘッダーとして扱い、`slice(1)` で除外します。

### 作るべき列（行）
**1 行目（ヘッダー行）**に、次の 3 列を作成してください。
- `date`
- `username`
- `content`

投稿データは 2 行目以降に入ります。

| A (date) | B (username) | C (content) |
|---|---|---|
| 2026-02-10 10:15:00 | YU1000 | こんにちは |
| 2026-02-10 10:16:30 | user_a | >>>#1 返信です |

> 重要: 1 行目は必ずヘッダーとして残してください（フロント側で除外するため）。

---

## 2) 将来拡張向け（Firebase + Supabase）

設計書に沿った移行準備として、テンプレートを同梱しています。

### Firebase
- Firebase プロジェクトを作成
- Authentication で Email/Password・Google・GitHub を有効化
- Firestore と Realtime Database を作成
- `.env.template` を元に `.env` を作成して値を設定

### Supabase
- Supabase プロジェクトを作成
- バケット作成:
  - `media-public`
  - `media-private`
- `supabase/policies.sql` のポリシーを適用
- `.env` に Supabase URL / anon key を設定

### ローカル起動
```bash
python3 -m http.server 4173
```
`http://localhost:4173` を開いて確認します。
