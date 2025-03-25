-- CreateTable
CREATE TABLE "部品表" (
    "商品コード" VARCHAR(16) NOT NULL,
    "部品コード" VARCHAR(16) NOT NULL,
    "部品数量" INTEGER NOT NULL DEFAULT 1,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_bom" PRIMARY KEY ("商品コード","部品コード")
);

-- AddForeignKey
ALTER TABLE "部品表" ADD CONSTRAINT "部品表_商品コード_fkey" FOREIGN KEY ("商品コード") REFERENCES "商品マスタ"("商品コード") ON DELETE RESTRICT ON UPDATE CASCADE;
