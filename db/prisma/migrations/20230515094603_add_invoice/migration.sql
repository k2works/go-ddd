-- CreateTable
CREATE TABLE "請求データ" (
    "請求番号" VARCHAR(10) NOT NULL,
    "請求日" TIMESTAMP(6),
    "取引先コード" VARCHAR(8) NOT NULL,
    "顧客枝番" INTEGER DEFAULT 0,
    "前回入金額" INTEGER DEFAULT 0,
    "当月売上額" INTEGER DEFAULT 0,
    "当月入金額" INTEGER DEFAULT 0,
    "当月請求額" INTEGER DEFAULT 0,
    "消費税金額" INTEGER NOT NULL DEFAULT 0,
    "請求消込金額" INTEGER DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_invoice" PRIMARY KEY ("請求番号")
);

-- CreateTable
CREATE TABLE "請求データ明細" (
    "請求番号" VARCHAR(10) NOT NULL,
    "売上番号" VARCHAR(10) NOT NULL,
    "売上行番号" INTEGER NOT NULL,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_invoice_details" PRIMARY KEY ("請求番号","売上番号","売上行番号")
);

-- AddForeignKey
ALTER TABLE "請求データ明細" ADD CONSTRAINT "請求データ明細_請求番号_fkey" FOREIGN KEY ("請求番号") REFERENCES "請求データ"("請求番号") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "請求データ明細" ADD CONSTRAINT "請求データ明細_売上番号_売上行番号_fkey" FOREIGN KEY ("売上番号", "売上行番号") REFERENCES "売上データ明細"("売上番号", "売上行番号") ON DELETE RESTRICT ON UPDATE CASCADE;
