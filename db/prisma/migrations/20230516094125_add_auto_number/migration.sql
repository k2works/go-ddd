-- CreateTable
CREATE TABLE "自動採番マスタ" (
    "伝票種別コード" VARCHAR(2) NOT NULL,
    "年月" TIMESTAMP(6) NOT NULL,
    "最終伝票番号" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "自動採番マスタ_pkey" PRIMARY KEY ("伝票種別コード","年月")
);
