-- CreateTable
CREATE TABLE "支払データ" (
    "支払番号" VARCHAR(10) NOT NULL,
    "支払日" INTEGER DEFAULT 0,
    "部門コード" VARCHAR(6) NOT NULL,
    "部門開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "仕入先コード" VARCHAR(8) NOT NULL,
    "仕入先枝番" INTEGER DEFAULT 0,
    "支払方法区分" INTEGER DEFAULT 1,
    "支払金額" INTEGER DEFAULT 0,
    "消費税合計" INTEGER NOT NULL DEFAULT 0,
    "支払完了フラグ" INTEGER NOT NULL DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_pay" PRIMARY KEY ("支払番号")
);

COMMENT ON COLUMN "支払データ"."支払日" IS '10:10日払い, 99:末日';
COMMENT ON COLUMN "支払データ"."支払方法区分" IS '1:振込, 2:手形';
COMMENT ON COLUMN "支払データ"."支払完了フラグ" IS '0:未完了, 1:完了';
