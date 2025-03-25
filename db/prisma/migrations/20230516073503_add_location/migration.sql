-- CreateTable
CREATE TABLE "棚番マスタ" (
    "倉庫コード" VARCHAR(3) NOT NULL,
    "棚番コード" VARCHAR(4) NOT NULL,
    "商品コード" VARCHAR(16) NOT NULL,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_location_mst" PRIMARY KEY ("倉庫コード","棚番コード","商品コード")
);

-- AddForeignKey
ALTER TABLE "棚番マスタ" ADD CONSTRAINT "棚番マスタ_倉庫コード_fkey" FOREIGN KEY ("倉庫コード") REFERENCES "倉庫マスタ"("倉庫コード") ON DELETE RESTRICT ON UPDATE CASCADE;
