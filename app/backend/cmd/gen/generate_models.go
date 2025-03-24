package main

import (
	"log"

	"github.com/sklinkert/go-ddd/internal/infrastructure/db/postgres"
	"gorm.io/gen"
)

func main() {
	// Generator Config 定義
	g := gen.NewGenerator(gen.Config{
		OutPath: "./internal/infrastructure/db/postgres/gen/query", // 出力パス
		Mode: gen.WithoutContext | // コンテキスト無し
			gen.WithDefaultQuery | // デフォルトのクエリ構築を生成
			gen.WithQueryInterface, // クエリのインタフェースを生成
		FieldWithIndexTag: true, // 構造体のフィールドに "index" タグを付与
		FieldWithTypeTag:  true, // フィールドに型情報をタグとして出力
		FieldNullable:     true, // Nullable サポート
	})

	// データベース接続を取得
	db, err := postgres.NewConnection()
	if err != nil {
		log.Fatalf("Failed to connect to the database: %v", err)
	}

	// データベースを使用するために生成器を初期化
	g.UseDB(db)

	// 全テーブル取得
	all := g.GenerateAllTable()

	// ベーシック構造を適用
	g.ApplyBasic(all...)

	// コードを生成
	g.Execute()
}
