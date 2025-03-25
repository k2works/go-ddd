-- AlterTable
ALTER TABLE "発注データ明細" RENAME CONSTRAINT "発注データ明細_pkey" TO "pk_purchase_order_details";

-- CreateTable
CREATE TABLE "倉庫マスタ" (
    "倉庫コード" VARCHAR(3) NOT NULL,
    "倉庫名" VARCHAR(20),
    "倉庫区分" VARCHAR(1) DEFAULT 'N',
    "郵便番号" CHAR(8),
    "都道府県" VARCHAR(4),
    "住所１" VARCHAR(40),
    "住所２" VARCHAR(40),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_wh_mst" PRIMARY KEY ("倉庫コード")
);

COMMENT ON COLUMN "倉庫マスタ"."倉庫区分" IS 'N:通常倉庫, C:得意先, S:仕入先, D:部門倉庫, P:製品倉庫, M:原材料倉庫';
-- CreateTable
CREATE TABLE "倉庫部門マスタ" (
    "倉庫コード" VARCHAR(3) NOT NULL,
    "部門コード" VARCHAR(6) NOT NULL,
    "開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_wh_dept_mst" PRIMARY KEY ("倉庫コード","部門コード","開始日")
);

-- CreateTable
CREATE TABLE "在庫データ" (
    "倉庫コード" VARCHAR(3) NOT NULL,
    "商品コード" VARCHAR(16) NOT NULL,
    "ロット番号" VARCHAR(20) NOT NULL,
    "在庫区分" VARCHAR(1) NOT NULL DEFAULT '1',
    "良品区分" VARCHAR(1) NOT NULL DEFAULT 'G',
    "実在庫数" INTEGER NOT NULL DEFAULT 1,
    "有効在庫数" INTEGER NOT NULL DEFAULT 1,
    "最終出荷日" TIMESTAMP(6),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_stock" PRIMARY KEY ("倉庫コード","商品コード","ロット番号","在庫区分","良品区分")
);
COMMENT ON COLUMN "在庫データ"."在庫区分" IS '1:自社在庫, 2:預り在庫,';
COMMENT ON COLUMN "在庫データ"."良品区分" IS 'G:良品, F:不良品, U:未検品';
-- AddForeignKey
ALTER TABLE "倉庫部門マスタ" ADD CONSTRAINT "倉庫部門マスタ_倉庫コード_fkey" FOREIGN KEY ("倉庫コード") REFERENCES "倉庫マスタ"("倉庫コード") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "倉庫部門マスタ" ADD CONSTRAINT "倉庫部門マスタ_部門コード_開始日_fkey" FOREIGN KEY ("部門コード", "開始日") REFERENCES "部門マスタ"("部門コード", "開始日") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "在庫データ" ADD CONSTRAINT "在庫データ_倉庫コード_fkey" FOREIGN KEY ("倉庫コード") REFERENCES "倉庫マスタ"("倉庫コード") ON DELETE RESTRICT ON UPDATE CASCADE;
