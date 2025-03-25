-- CreateTable
CREATE TABLE "社員マスタ" (
    "社員コード" VARCHAR(10) NOT NULL,
    "社員名" VARCHAR(20),
    "社員名カナ" VARCHAR(40),
    "パスワード" VARCHAR(8),
    "電話番号" VARCHAR(13),
    "FAX番号" VARCHAR(13),
    "部門コード" VARCHAR(6) NOT NULL,
    "開始日" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "職種コード" VARCHAR(2) NOT NULL,
    "承認権限コード" VARCHAR(2) NOT NULL,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_employee" PRIMARY KEY ("社員コード")
);
