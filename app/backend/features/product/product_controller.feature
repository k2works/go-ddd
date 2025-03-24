# language: ja
フィーチャ: 商品コントローラーAPI
  APIを通じて商品を管理するために
  クライアントとして
  HTTPリクエストを介して商品の作成、読み取り、更新、削除ができる必要があります

  シナリオ: APIを介して新しい商品を作成する
    前提 APIのための商品詳細を持っています
      | 名前        | 価格  | 出品者ID                             |
      | テスト商品  | 10.99 | 00000000-0000-0000-0000-000000000001 |
    もし 商品詳細を含めて"/api/v1/products"にPOSTリクエストを送信します
    ならば レスポンスステータスコードは201であるべきです
    かつ レスポンスは作成された商品詳細を含むべきです

  シナリオ: APIを介してすべての商品を取得する
    前提 システムに商品があります
    もし "/api/v1/products"にGETリクエストを送信します
    ならば レスポンスステータスコードは200であるべきです
    かつ レスポンスは商品のリストを含むべきです

  シナリオ: APIを介してIDで商品を取得する
    前提 システムにID "00000000-0000-0000-0000-000000000001"の商品があります
    もし "/api/v1/products/00000000-0000-0000-0000-000000000001"にGETリクエストを送信します
    ならば レスポンスステータスコードは200であるべきです
    かつ レスポンスは商品詳細を含むべきです
