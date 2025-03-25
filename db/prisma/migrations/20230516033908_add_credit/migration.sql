-- CreateTable
CREATE TABLE "入金データ" (
    "入金番号" VARCHAR(10) NOT NULL,
    "入金日" TIMESTAMP(6),
    "部門コード" VARCHAR(6) NOT NULL,
    "開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "顧客コード" VARCHAR(8) NOT NULL,
    "顧客枝番" INTEGER DEFAULT 0,
    "支払方法区分" INTEGER DEFAULT 1,
    "入金口座コード" VARCHAR(8),
    "入金金額" INTEGER DEFAULT 0,
    "消込金額" INTEGER DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),
    "プログラム更新日時" TIMESTAMP(6) DEFAULT CURRENT_DATE,
    "更新プログラム名" VARCHAR(50),

    CONSTRAINT "pk_credit" PRIMARY KEY ("入金番号")
);

COMMENT ON COLUMN "入金データ"."支払方法区分" IS '1:振込 2:手形';
