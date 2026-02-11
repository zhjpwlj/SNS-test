# アーキテクチャ資料

## 現在の構成（安定運用）
- `index.html` 中心の静的アプリ構成
- データ保存先: Google Apps Script + Google スプレッドシート
- PWA 基盤: `manifest.json`, `sw.js`, `index.js`

## 移行先の目標構成（設計書準拠）

### データレイヤー
1. **認証**: Firebase Authentication
2. **ソーシャルグラフ**: Firestore（フォロー・ブロック・Close Friends）
3. **コンテンツ**: Firestore（投稿・コメント・コミュニティ・ストーリー）
4. **リアルタイム**: Realtime Database（プレゼンス・入力中・通知）
5. **メディア**: Supabase Storage（URL/メタ情報は Firestore 参照）

### コレクション例
- `users/{uid}`: プロフィール・設定・集計カウンタ
- `posts/{postId}`: 本文・公開範囲・エンゲージメント集計
- `communities/{communityId}` + `communityPosts/{id}`
- `stories/{storyId}`: `expiresAt` を持つ 24h 系コンテンツ
- `chats/{chatId}` + `messages/{msgId}`
- `notifications/{uid}/{notificationId}`

### フロントの状態管理方針（Vanilla JS）
- 機能別モジュールを動的 import
- メモリストア + IndexedDB 永続化
- Realtime購読でストア更新 → 差分描画

### セキュリティ方針
- Firestore: ロール + 所有者チェック + 入力検証
- Realtime DB: 自身ノードのみ書き込み
- Supabase Storage: ユーザー単位フォルダ隔離

### 無料枠でのトレードオフ
- キャッシュ強化 + 集計フィールド活用で read を削減
- ストーリー/メディアは保持期間を制限
- 高負荷機能は feature flag で段階導入
