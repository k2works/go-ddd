-- CreateTable
CREATE TABLE "取引先マスタ" (
    "取引先コード" VARCHAR(8) NOT NULL,
    "取引先名" VARCHAR(40) NOT NULL,
    "取引先名カナ" VARCHAR(40),
    "仕入先区分" INTEGER DEFAULT 0,
    "郵便番号" CHAR(8),
    "都道府県" VARCHAR(4),
    "住所１" VARCHAR(40),
    "住所２" VARCHAR(40),
    "取引禁止フラグ" INTEGER DEFAULT 0,
    "雑区分" INTEGER DEFAULT 0,
    "取引先グループコード" VARCHAR(4) NOT NULL,
    "与信限度額" INTEGER DEFAULT 0,
    "与信一時増加枠" INTEGER DEFAULT 0,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_companys_mst" PRIMARY KEY ("取引先コード")
);

-- CreateTable
CREATE TABLE "顧客マスタ" (
    "顧客コード" VARCHAR(8) NOT NULL,
    "顧客枝番" INTEGER NOT NULL,
    "顧客区分" INTEGER DEFAULT 0,
    "請求先コード" VARCHAR(8) NOT NULL,
    "請求先枝番" INTEGER,
    "回収先コード" VARCHAR(8) NOT NULL,
    "回収先枝番" INTEGER,
    "顧客名" VARCHAR(40) NOT NULL,
    "顧客名カナ" VARCHAR(40),
    "自社担当者コード" VARCHAR(10) NOT NULL,
    "顧客担当者名" VARCHAR(20),
    "顧客部門名" VARCHAR(40),
    "顧客郵便番号" CHAR(8),
    "顧客都道府県" VARCHAR(4),
    "顧客住所１" VARCHAR(40),
    "顧客住所２" VARCHAR(40),
    "顧客電話番号" VARCHAR(13),
    "顧客ＦＡＸ番号" VARCHAR(13),
    "顧客メールアドレス" VARCHAR(100),
    "顧客請求区分" INTEGER DEFAULT 0,
    "顧客締日１" INTEGER NOT NULL,
    "顧客支払月１" INTEGER DEFAULT 1,
    "顧客支払日１" INTEGER,
    "顧客支払方法１" INTEGER DEFAULT 1,
    "顧客締日２" INTEGER NOT NULL,
    "顧客支払月２" INTEGER DEFAULT 1,
    "顧客支払日２" INTEGER,
    "顧客支払方法２" INTEGER DEFAULT 1,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_customer" PRIMARY KEY ("顧客コード","顧客枝番")
);

COMMENT ON COLUMN 顧客マスタ.顧客請求区分 IS '1:都度請求 2:締請求';
COMMENT ON COLUMN 顧客マスタ.顧客締日１ IS '15:15日締め';
COMMENT ON COLUMN 顧客マスタ.顧客支払月１ IS '0:当月 1:翌月 2:翌々月';
COMMENT ON COLUMN 顧客マスタ.顧客支払日１ IS '10:10日払い 99:末日';
COMMENT ON COLUMN 顧客マスタ.顧客支払方法１ IS '1:振込 2:手形';
COMMENT ON COLUMN 顧客マスタ.顧客締日２ IS '15:15日締め';
COMMENT ON COLUMN 顧客マスタ.顧客支払月２ IS '0:当月 1:翌月 2:翌々月';
COMMENT ON COLUMN 顧客マスタ.顧客支払日２ IS '10:10日払い 99:末日';
COMMENT ON COLUMN 顧客マスタ.顧客支払方法２ IS '1:振込 2:手形';

-- CreateTable
CREATE TABLE "仕入先マスタ" (
    "仕入先コード" VARCHAR(8) NOT NULL,
    "仕入先枝番" INTEGER NOT NULL,
    "仕入先名" VARCHAR(40) NOT NULL,
    "仕入先名カナ" VARCHAR(40),
    "仕入先担当者名" VARCHAR(20),
    "仕入先部門名" VARCHAR(40),
    "仕入先郵便番号" CHAR(8),
    "仕入先都道府県" VARCHAR(4),
    "仕入先住所１" VARCHAR(40),
    "仕入先住所２" VARCHAR(40),
    "仕入先電話番号" VARCHAR(13),
    "仕入先ＦＡＸ番号" VARCHAR(13),
    "仕入先メールアドレス" VARCHAR(100),
    "仕入先締日" INTEGER NOT NULL,
    "仕入先支払月" INTEGER DEFAULT 1,
    "仕入先支払日" INTEGER,
    "仕入先支払方法" INTEGER DEFAULT 1,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "pk_supplier" PRIMARY KEY ("仕入先コード","仕入先枝番")
);
COMMENT ON COLUMN 仕入先マスタ.仕入先締日 IS '15:15日締め';
COMMENT ON COLUMN 仕入先マスタ.仕入先支払月 IS '0:当月 1:翌月 2:翌々月';
COMMENT ON COLUMN 仕入先マスタ.仕入先支払日 IS '10:10日払い 99:末日';
COMMENT ON COLUMN 仕入先マスタ.仕入先支払方法 IS '1:振込 2:手形';

-- CreateTable
CREATE TABLE "個人客マスタ" (
    "個人客コード" VARCHAR(16) NOT NULL,
    "姓" VARCHAR(20) NOT NULL,
    "名" VARCHAR(20) NOT NULL,
    "姓カナ" VARCHAR(40) NOT NULL,
    "名カナ" VARCHAR(40) NOT NULL,
    "ログインＩＤ" VARCHAR(256) NOT NULL,
    "メールアドレス" VARCHAR(256) NOT NULL,
    "パスワード" VARCHAR(16) NOT NULL,
    "生年月日" TIMESTAMP(6) NOT NULL,
    "性別" INTEGER NOT NULL,
    "ログイン日時" TIMESTAMP(6),
    "ポイント残高" INTEGER,
    "作成日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "作成者名" VARCHAR(12),
    "更新日時" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_DATE,
    "更新者名" VARCHAR(12),

    CONSTRAINT "customer_pk" PRIMARY KEY ("個人客コード")
);

-- AddForeignKey
ALTER TABLE "顧客マスタ" ADD CONSTRAINT "顧客マスタ_顧客コード_fkey" FOREIGN KEY ("顧客コード") REFERENCES "取引先マスタ"("取引先コード") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "仕入先マスタ" ADD CONSTRAINT "仕入先マスタ_仕入先コード_fkey" FOREIGN KEY ("仕入先コード") REFERENCES "取引先マスタ"("取引先コード") ON DELETE RESTRICT ON UPDATE CASCADE;
