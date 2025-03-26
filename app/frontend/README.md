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
# Gulpタスクを使用してAPIクライアントを生成（Windows/Mac/Linux対応）
npm run generate-api
```

これにより、バックエンドのSwagger仕様に基づいて`src/api`ディレクトリにAPIクライアントコードが生成されます。

> **注意**: 以前は`generate-api.sh`シェルスクリプトを使用していましたが、クロスプラットフォーム対応のためGulpタスクに置き換えられました。

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

### APIクライアント生成の仕組み

APIクライアントの生成には、Gulpタスクを使用しています。このタスクは以下の処理を行います：

1. OpenAPI Generator CLIがインストールされていない場合は自動的にインストール
2. バックエンドのSwagger仕様（`../backend/docs/swagger.json`）からTypeScript Axiosクライアントを生成
3. 生成されたコードを`src/api`ディレクトリに配置

このGulpタスクは、Windows、Mac、Linuxなど、すべてのプラットフォームで動作します。

詳細は`gulpfile.js`を参照してください。
