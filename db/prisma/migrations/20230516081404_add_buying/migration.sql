-- CreateTable
CREATE TABLE "仕入データ" (
    "仕入番号" VARCHAR(10) NOT NULL,
    "仕入日" TIMESTAMP(6) DEFAULT CURRENT_DATE,
    "仕入先コード" VARCHAR(8) NOT NULL,
    "仕入先枝番" INTEGER DEFAULT 0,
    "仕入担当者コード" VARCHAR(10) NOT NULL,
    "開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "発注番号" VARCHAR(10),
    "部門コード" VARCHAR(6) NOT NULL,
    "仕入金額合計" INTEGER DEFAULT 0,
    "消費税合計" INTEGER NOT NULL DEFAULT 0,
    "備考" VARCHAR(1000),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "updater" VARCHAR(12),

    CONSTRAINT "pk_pu" PRIMARY KEY ("仕入番号")
);

-- CreateTable
CREATE TABLE "仕入データ明細" (
    "仕入番号" VARCHAR(10) NOT NULL,
    "仕入行番号" INTEGER NOT NULL,
    "仕入行表示番号" INTEGER NOT NULL,
    "発注行番号" INTEGER NOT NULL,
    "商品コード" VARCHAR(16) NOT NULL,
    "倉庫コード" VARCHAR(3) NOT NULL,
    "商品名" VARCHAR(10) NOT NULL,
    "仕入単価" INTEGER DEFAULT 0,
    "仕入数量" INTEGER NOT NULL DEFAULT 1,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_pu_details" PRIMARY KEY ("仕入行番号","仕入番号")
);

-- AddForeignKey
ALTER TABLE "仕入データ明細" ADD CONSTRAINT "仕入データ明細_仕入番号_fkey" FOREIGN KEY ("仕入番号") REFERENCES "仕入データ"("仕入番号") ON DELETE RESTRICT ON UPDATE CASCADE;
