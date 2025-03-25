-- CreateTable
CREATE TABLE "売上データ" (
    "売上番号" VARCHAR(10) NOT NULL,
    "受注番号" VARCHAR(10) NOT NULL,
    "売上日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "売上区分" INTEGER DEFAULT 1,
    "部門コード" VARCHAR(6) NOT NULL,
    "部門開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "取引先コード" VARCHAR(8) NOT NULL,
    "社員コード" VARCHAR(10) NOT NULL,
    "売上金額合計" INTEGER NOT NULL DEFAULT 0,
    "消費税合計" INTEGER NOT NULL DEFAULT 0,
    "備考" VARCHAR(1000),
    "赤黒伝票番号" INTEGER,
    "元伝票番号" VARCHAR(10),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_sales" PRIMARY KEY ("売上番号")
);

-- CreateTable
CREATE TABLE "売上データ明細" (
    "売上番号" VARCHAR(10) NOT NULL,
    "売上行番号" INTEGER NOT NULL,
    "商品コード" VARCHAR(16) NOT NULL,
    "商品名" VARCHAR(10) NOT NULL,
    "販売単価" INTEGER NOT NULL DEFAULT 0,
    "出荷数量" INTEGER DEFAULT 0,
    "売上数量" INTEGER NOT NULL DEFAULT 1,
    "値引金額" INTEGER NOT NULL DEFAULT 0,
    "請求日" TIMESTAMP(6),
    "請求番号" VARCHAR(10),
    "請求遅延区分" INTEGER,
    "自動仕訳日" TIMESTAMP(6),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_sales_details" PRIMARY KEY ("売上番号","売上行番号")
);

-- AddForeignKey
ALTER TABLE "売上データ明細" ADD CONSTRAINT "売上データ明細_売上番号_fkey" FOREIGN KEY ("売上番号") REFERENCES "売上データ"("売上番号") ON DELETE RESTRICT ON UPDATE CASCADE;
