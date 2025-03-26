# マーケットプレイスフロントエンド

マーケットプレイスAPIのためのReact TypeScript Electronクライアントアプリケーションです。

## 前提条件

- Node.js (v14以降)
- npm (v6以降)

## セットアップ

1. 依存関係をインストール：

```bash
npm install
```

2. Swagger仕様からAPIクライアントを生成：

```bash
# スクリプトを実行可能にする
chmod +x generate-api.sh

# スクリプトを実行
./generate-api.sh
```

これにより、バックエンドのSwagger仕様に基づいて`src/api`ディレクトリにAPIクライアントコードが生成されます。

## 開発

開発モードでアプリケーションを実行するには：

```bash
npm run dev
```

これにより：
1. TypeScriptファイルをコンパイルするためにウォッチモードでWebpackが起動します
2. コンパイルが完了するとElectronが起動します

## ビルド

アプリケーションをビルドするには：

```bash
npm run build
```

これにより、TypeScriptファイルが`dist`ディレクトリにJavaScriptにコンパイルされます。

## 実行

ビルドしたアプリケーションを実行するには：

```bash
npm start
```

## プロジェクト構造

- `src/`: ソースコードディレクトリ
  - `api/`: 生成されたAPIクライアントコード
  - `components/`: Reactコンポーネント
  - `styles/`: CSSスタイル
  - `main.ts`: Electronメインプロセス
  - `renderer.tsx`: Reactレンダラープロセス
  - `index.html`: HTMLテンプレート

## 機能

- 商品一覧の表示
- 新しい商品の作成

## API連携

このアプリケーションは、生成されたTypeScriptクライアントを使用してマーケットプレイスAPIと連携します。クライアントは`../backend/docs/swagger.json`にあるSwagger仕様から生成されます。

### APIクライアントの使用方法

```typescript
import { ProductsApi, Configuration } from '../api';

// APIクライアントの設定
const configuration = new Configuration({
  basePath: 'http://localhost:9090/api/v1',
});

// APIクライアントのインスタンス化
const api = new ProductsApi(configuration);

// 商品一覧の取得
const response = await api.productsGet();
const products = response.data;

// 商品の作成
await api.productsPost({
  data: {
    name: 'Product Name',
    price: 100
  }
});
```

APIに変更があった後にAPIクライアントを再生成するには：

```bash
npm run generate-api
```
