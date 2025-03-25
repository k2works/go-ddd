-- CreateTable
CREATE TABLE "与信残高データ" (
    "取引先コード" VARCHAR(8) NOT NULL,
    "受注残高" INTEGER DEFAULT 0,
    "債権残高" INTEGER DEFAULT 0,
    "債務残高" INTEGER DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_credit_balance" PRIMARY KEY ("取引先コード")
);
