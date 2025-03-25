-- CreateTable
CREATE TABLE "受注データ" (
    "受注番号" VARCHAR(10) NOT NULL,
    "受注日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "部門コード" VARCHAR(6) NOT NULL,
    "部門開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "顧客コード" VARCHAR(8) NOT NULL,
    "顧客枝番" INTEGER,
    "社員コード" VARCHAR(10) NOT NULL,
    "希望納期" TIMESTAMP(6),
    "客先注文番号" VARCHAR(20),
    "倉庫コード" VARCHAR(3) NOT NULL,
    "受注金額合計" INTEGER NOT NULL DEFAULT 0,
    "消費税合計" INTEGER NOT NULL DEFAULT 0,
    "備考" VARCHAR(1000),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_orders" PRIMARY KEY ("受注番号")
);

-- CreateTable
CREATE TABLE "受注データ明細" (
    "受注番号" VARCHAR(10) NOT NULL,
    "受注行番号" INTEGER NOT NULL,
    "商品コード" VARCHAR(16) NOT NULL,
    "商品名" VARCHAR(10) NOT NULL,
    "販売単価" INTEGER NOT NULL DEFAULT 0,
    "受注数量" INTEGER NOT NULL DEFAULT 1,
    "消費税率" INTEGER DEFAULT 0,
    "引当数量" INTEGER DEFAULT 0,
    "出荷指示数量" INTEGER DEFAULT 0,
    "出荷済数量" INTEGER DEFAULT 0,
    "完了フラグ" INTEGER NOT NULL DEFAULT 0,
    "値引金額" INTEGER NOT NULL DEFAULT 0,
    "納期" TIMESTAMP(6),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "受注データ明細_pkey" PRIMARY KEY ("受注番号","受注行番号")
);

COMMENT ON COLUMN "受注データ明細"."完了フラグ" IS '0:未完了, 1:完了';

-- AddForeignKey
ALTER TABLE "受注データ明細" ADD CONSTRAINT "受注データ明細_受注番号_fkey" FOREIGN KEY ("受注番号") REFERENCES "受注データ"("受注番号") ON DELETE RESTRICT ON UPDATE CASCADE;
