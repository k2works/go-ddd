-- CreateTable
CREATE TABLE "部門マスタ" (
    "部門コード" VARCHAR(6) NOT NULL,
    "開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "終了日" TIMESTAMP(6) DEFAULT '2100-12-31 00:00:00'::timestamp without time zone,
    "部門名" VARCHAR(40),
    "組織階層" INTEGER NOT NULL DEFAULT 0,
    "部門パス" VARCHAR(100) NOT NULL,
    "最下層区分" INTEGER NOT NULL DEFAULT 0,
    "伝票入力可否" INTEGER NOT NULL DEFAULT 1,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_dept_mst" PRIMARY KEY ("部門コード","開始日")
);

COMMENT ON COLUMN 部門マスタ.伝票入力可否 IS '0:不可 1:可能';
