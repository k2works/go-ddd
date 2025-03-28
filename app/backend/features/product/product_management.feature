# language: ja
フィーチャ: 商品管理
  システム内の商品を管理するために
  ユーザーとして
  商品の作成、読み取り、更新、削除ができる必要があります

  シナリオ: 新しい商品を作成する
    前提 商品の詳細を持っています
      | 名前        | 価格  |
      | テスト商品  | 10.99 |
    かつ 出品者を持っています
    もし 新しい商品を作成します
    ならば 商品がシステムに保存されるべきです
    かつ IDで商品を取得できるべきです

  シナリオ: 既存の商品を更新する
    前提 既存の商品を持っています
    もし 商品の詳細を更新します
      | 名前           | 価格  |
      | 更新された商品 | 15.99 |
    ならば 商品の詳細がシステムで更新されるべきです

  シナリオ: 商品を削除する
    前提 既存の商品を持っています
    もし 商品を削除します
    ならば 商品がシステムから削除されるべきです
