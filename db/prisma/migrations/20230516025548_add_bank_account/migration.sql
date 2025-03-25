-- CreateTable
CREATE TABLE "入金口座マスタ" (
    "入金口座コード" VARCHAR(8) NOT NULL,
    "入金口座名" VARCHAR(30),
    "適用開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "適用終了日" TIMESTAMP(6) DEFAULT '2100-12-31 00:00:00'::timestamp without time zone,
    "適用開始後入金口座名" VARCHAR(30),
    "入金口座区分" VARCHAR(1),
    "入金口座番号" VARCHAR(12),
    "銀行口座種別" VARCHAR(1),
    "口座名義人" VARCHAR(20),
    "部門コード" VARCHAR(6) NOT NULL,
    "部門開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "全銀協銀行コード" VARCHAR(4),
    "全銀協支店コード" VARCHAR(3),
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),
    "プログラム更新日時" TIMESTAMP(6) DEFAULT CURRENT_DATE,
    "更新プログラム名" VARCHAR(50),

    CONSTRAINT "pk_bank_acut_mst" PRIMARY KEY ("入金口座コード")
);

COMMENT ON COLUMN "入金口座マスタ"."入金口座区分" IS 'B:銀行, P:郵便局';
COMMENT ON COLUMN "入金口座マスタ"."入金口座番号" IS '銀行:7桁 郵便局:12桁';
COMMENT ON COLUMN "入金口座マスタ"."銀行口座種別" IS 'O:普通 C:当座';
