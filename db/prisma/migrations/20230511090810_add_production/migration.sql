-- CreateTable
CREATE TABLE "商品分類マスタ" (
    "商品分類コード" VARCHAR(8) NOT NULL,
    "商品分類名" VARCHAR(30),
    "商品分類階層" INTEGER NOT NULL DEFAULT 0,
    "商品分類パス" VARCHAR(100),
    "最下層区分" INTEGER DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_product_category" PRIMARY KEY ("商品分類コード")
);

-- CreateTable
CREATE TABLE "商品マスタ" (
    "商品コード" VARCHAR(16) NOT NULL,
    "商品正式名" VARCHAR(40) NOT NULL,
    "商品略称" VARCHAR(10) NOT NULL,
    "商品名カナ" VARCHAR(20) NOT NULL,
    "商品区分" VARCHAR(1),
    "製品型番" VARCHAR(40),
    "販売単価" INTEGER NOT NULL DEFAULT 0,
    "仕入単価" INTEGER DEFAULT 0,
    "売上原価" INTEGER NOT NULL DEFAULT 0,
    "税区分" INTEGER NOT NULL DEFAULT 1,
    "商品分類コード" VARCHAR(8),
    "雑区分" INTEGER,
    "在庫管理対象区分" INTEGER DEFAULT 1,
    "在庫引当区分" INTEGER,
    "仕入先コード" VARCHAR(8) NOT NULL,
    "仕入先枝番" INTEGER,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_products" PRIMARY KEY ("商品コード")
);

COMMENT ON COLUMN 商品マスタ.商品区分 IS '1:商品 2:製品 3:原材料 4:間接材';
COMMENT ON COLUMN 商品マスタ.在庫管理対象区分 IS '0:対象外 1:在庫管理対象';
COMMENT ON COLUMN 商品マスタ.在庫引当区分 IS '0:対象外 1:即時 2:まとめ 3:手配品';

-- CreateTable
CREATE TABLE "顧客別販売単価" (
    "商品コード" VARCHAR(16) NOT NULL,
    "取引先コード" VARCHAR(8) NOT NULL,
    "販売単価" INTEGER NOT NULL DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_pricebycustomer" PRIMARY KEY ("商品コード","取引先コード")
);

-- CreateTable
CREATE TABLE "代替商品" (
    "商品コード" VARCHAR(16) NOT NULL,
    "代替商品コード" VARCHAR(16) NOT NULL,
    "優先順位" INTEGER DEFAULT 1,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_alternate_products" PRIMARY KEY ("商品コード","代替商品コード")
);

-- AddForeignKey
ALTER TABLE "顧客別販売単価" ADD CONSTRAINT "顧客別販売単価_商品コード_fkey" FOREIGN KEY ("商品コード") REFERENCES "商品マスタ"("商品コード") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "代替商品" ADD CONSTRAINT "代替商品_商品コード_fkey" FOREIGN KEY ("商品コード") REFERENCES "商品マスタ"("商品コード") ON DELETE RESTRICT ON UPDATE CASCADE;
