-- CreateTable
CREATE TABLE "発注データ" (
    "発注番号" VARCHAR(10) NOT NULL,
    "発注日" TIMESTAMP(6),
    "受注番号" VARCHAR(10) NOT NULL,
    "仕入先コード" VARCHAR(8) NOT NULL,
    "仕入先枝番" INTEGER DEFAULT 0,
    "発注担当者コード" VARCHAR(10) NOT NULL,
    "指定納期" TIMESTAMP(6),
    "倉庫コード" VARCHAR(3) NOT NULL,
    "発注金額合計" INTEGER DEFAULT 0,
    "消費税合計" INTEGER NOT NULL DEFAULT 0,
    "備考" VARCHAR(1000),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_purchase_orders" PRIMARY KEY ("発注番号")
);

-- CreateTable
CREATE TABLE "発注データ明細" (
    "発注番号" VARCHAR(10) NOT NULL,
    "発注行番号" INTEGER NOT NULL,
    "発注行表示番号" INTEGER NOT NULL,
    "受注番号" VARCHAR(10) NOT NULL,
    "受注行番号" INTEGER NOT NULL,
    "商品コード" VARCHAR(16) NOT NULL,
    "商品名" VARCHAR(10) NOT NULL,
    "発注単価" INTEGER DEFAULT 0,
    "発注数量" INTEGER NOT NULL DEFAULT 1,
    "入荷数量" INTEGER NOT NULL DEFAULT 1,
    "完了フラグ" INTEGER NOT NULL DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "発注データ明細_pkey" PRIMARY KEY ("発注行番号","発注番号")
);

COMMENT ON COLUMN "発注データ明細"."完了フラグ" IS '0:未完了 1:完了';

-- AddForeignKey
ALTER TABLE "発注データ明細" ADD CONSTRAINT "発注データ明細_発注番号_fkey" FOREIGN KEY ("発注番号") REFERENCES "発注データ"("発注番号") ON DELETE RESTRICT ON UPDATE CASCADE;
