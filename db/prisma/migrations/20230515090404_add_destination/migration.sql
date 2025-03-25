-- CreateTable
CREATE TABLE "出荷先マスタ" (
    "顧客コード" VARCHAR(8) NOT NULL,
    "顧客枝番" INTEGER NOT NULL,
    "出荷先番号" INTEGER NOT NULL,
    "出荷先名" VARCHAR(40) NOT NULL,
    "地域コード" VARCHAR(10) NOT NULL,
    "出荷先郵便番号" CHAR(8),
    "出荷先住所１" VARCHAR(40),
    "出荷先住所２" VARCHAR(40),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_destinations" PRIMARY KEY ("顧客コード","出荷先番号","顧客枝番")
);

-- CreateTable
CREATE TABLE "地域マスタ" (
    "地域コード" VARCHAR(10) NOT NULL,
    "地域名" VARCHAR(20),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_area" PRIMARY KEY ("地域コード")
);

-- AddForeignKey
ALTER TABLE "出荷先マスタ" ADD CONSTRAINT "出荷先マスタ_顧客コード_顧客枝番_fkey" FOREIGN KEY ("顧客コード", "顧客枝番") REFERENCES "顧客マスタ"("顧客コード", "顧客枝番") ON DELETE RESTRICT ON UPDATE CASCADE;
