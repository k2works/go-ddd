-- CreateTable
CREATE TABLE "取引先グループマスタ" (
    "取引先グループコード" VARCHAR(4) NOT NULL,
    "取引先グループ名" VARCHAR(40),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_company_group_mst" PRIMARY KEY ("取引先グループコード")
);

-- CreateTable
CREATE TABLE "取引先分類種別マスタ" (
    "取引先分類種別コード" VARCHAR(2) NOT NULL,
    "取引先分類種別名" VARCHAR(20),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_category_type" PRIMARY KEY ("取引先分類種別コード")
);

-- CreateTable
CREATE TABLE "取引先分類マスタ" (
    "取引先分類種別コード" VARCHAR(2) NOT NULL,
    "取引先分類コード" VARCHAR(8) NOT NULL,
    "取引先分類名" VARCHAR(30),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_company_category" PRIMARY KEY ("取引先分類種別コード","取引先分類コード")
);

-- CreateTable
CREATE TABLE "取引先分類所属マスタ" (
    "取引先分類種別コード" VARCHAR(2) NOT NULL,
    "取引先分類コード" VARCHAR(8) NOT NULL,
    "取引先コード" VARCHAR(8) NOT NULL,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_company_category_group" PRIMARY KEY ("取引先分類種別コード","取引先コード","取引先分類コード")
);

-- AddForeignKey
ALTER TABLE "取引先分類マスタ" ADD CONSTRAINT "取引先分類マスタ_取引先分類種別コード_fkey" FOREIGN KEY ("取引先分類種別コード") REFERENCES "取引先分類種別マスタ"("取引先分類種別コード") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "取引先分類所属マスタ" ADD CONSTRAINT "取引先分類所属マスタ_取引先分類コード__fkey" FOREIGN KEY ("取引先分類コード", "取引先分類種別コード") REFERENCES "取引先分類マスタ"("取引先分類コード", "取引先分類種別コード") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "取引先分類所属マスタ" ADD CONSTRAINT "取引先分類所属マスタ_取引先コード_fkey" FOREIGN KEY ("取引先コード") REFERENCES "取引先マスタ"("取引先コード") ON DELETE RESTRICT ON UPDATE CASCADE;
