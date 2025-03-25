\connect
sales
CREATE TABLE consumer
(
    consumer_code   VARCHAR(16)                    NOT NULL,
    last_name       VARCHAR(20)                    NOT NULL,
    first_name      VARCHAR(20)                    NOT NULL,
    last_name_kana  VARCHAR(40)                    NOT NULL,
    first_name_kana VARCHAR(40)                    NOT NULL,
    login_id        VARCHAR(256)                   NOT NULL,
    email           VARCHAR(256)                   NOT NULL,
    pwd             VARCHAR(16)                    NOT NULL,
    birth_date      TIMESTAMP                      NOT NULL,
    sex             INTEGER                        NOT NULL,
    login_datetime  TIMESTAMP,
    rest_point      INTEGER,
    withdrawal_date TIMESTAMP,
    create_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator         VARCHAR(12),
    update_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE consumer
    ADD CONSTRAINT customer_pk PRIMARY KEY (consumer_code)
;
COMMENT
ON TABLE consumer IS '個人客,顧客'
;
COMMENT
ON COLUMN consumer.consumer_code IS '個人客コード'
;
COMMENT
ON COLUMN consumer.last_name IS '姓'
;
COMMENT
ON COLUMN consumer.first_name IS '名'
;
COMMENT
ON COLUMN consumer.last_name_kana IS '姓カナ'
;
COMMENT
ON COLUMN consumer.first_name_kana IS '名カナ'
;
COMMENT
ON COLUMN consumer.login_id IS 'ログインid'
;
COMMENT
ON COLUMN consumer.email IS 'メールアドレス'
;
COMMENT
ON COLUMN consumer.pwd IS 'パスワード'
;
COMMENT
ON COLUMN consumer.birth_date IS '生年月日'
;
COMMENT
ON COLUMN consumer.sex IS '性別'
;
COMMENT
ON COLUMN consumer.login_datetime IS 'ログイン日時'
;
COMMENT
ON COLUMN consumer.rest_point IS 'ポイント残高'
;
COMMENT
ON COLUMN consumer.withdrawal_date IS '退会日'
;
COMMENT
ON COLUMN consumer.create_date IS '作成日時'
;
COMMENT
ON COLUMN consumer.creator IS '作成者名'
;
COMMENT
ON COLUMN consumer.update_date IS '更新日時'
;
COMMENT
ON COLUMN consumer.updater IS '更新者名'
;
-- CREATE INDEX CUSTOMER_IX4
--     ON CUSTOMER ("LAST_NAME"||"FIRST_NAME", "LAST_NAME_KANA"||"FIRST_NAME_KANA")
--     TABLESPACE TS_CUSTOMER_I01
-- /
;
CREATE TABLE customers_mst
(
    cust_code          VARCHAR(8)                     NOT NULL,
    cust_sub_no        INTEGER                        NOT NULL,
    cust_type          INTEGER   DEFAULT 0,
    ar_code            VARCHAR(8)                     NOT NULL,
    ar_sub_no          INTEGER,
    payer_code         VARCHAR(8)                     NOT NULL,
    payer_sub_no       INTEGER,
    cust_name          VARCHAR(40)                    NOT NULL,
    cust_kana          VARCHAR(40),
    emp_code           VARCHAR(10)                    NOT NULL,
    cust_user_name     VARCHAR(20),
    cust_user_dep_name VARCHAR(40),
    cust_zip_code      CHAR(8),
    cust_state         VARCHAR(4),
    cust_address1      VARCHAR(40),
    cust_address2      VARCHAR(40),
    cust_tel           VARCHAR(13),
    cust_fax           VARCHAR(13),
    cust_email         VARCHAR(100),
    cust_ar_flag       INTEGER,
    cust_close_date1   INTEGER                        NOT NULL,
    cust_pay_months1   INTEGER   DEFAULT 1,
    cust_pay_dates1    INTEGER,
    cust_pay_method1   INTEGER   DEFAULT 1,
    cust_close_date2   INTEGER                        NOT NULL,
    cust_pay_months2   INTEGER   DEFAULT 1,
    cust_pay_dates2    INTEGER,
    cust_pay_method2   INTEGER   DEFAULT 1,
    create_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator            VARCHAR(12),
    update_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE customers_mst
    ADD CONSTRAINT pk_customers_mst PRIMARY KEY (cust_code, cust_sub_no)
;
COMMENT
ON TABLE customers_mst IS '顧客マスタ'
;
COMMENT
ON COLUMN customers_mst.cust_code IS '顧客コード'
;
COMMENT
ON COLUMN customers_mst.cust_sub_no IS '顧客枝番'
;
COMMENT
ON COLUMN customers_mst.cust_type IS '顧客区分'
;
COMMENT
ON COLUMN customers_mst.ar_code IS '請求先コード'
;
COMMENT
ON COLUMN customers_mst.ar_sub_no IS '請求先枝番'
;
COMMENT
ON COLUMN customers_mst.payer_code IS '回収先コード'
;
COMMENT
ON COLUMN customers_mst.payer_sub_no IS '回収先枝番'
;
COMMENT
ON COLUMN customers_mst.cust_name IS '顧客名'
;
COMMENT
ON COLUMN customers_mst.cust_kana IS '顧客名カナ'
;
COMMENT
ON COLUMN customers_mst.emp_code IS '自社担当者コード'
;
COMMENT
ON COLUMN customers_mst.cust_user_name IS '顧客担当者名'
;
COMMENT
ON COLUMN customers_mst.cust_user_dep_name IS '顧客部門名'
;
COMMENT
ON COLUMN customers_mst.cust_zip_code IS '顧客郵便番号'
;
COMMENT
ON COLUMN customers_mst.cust_state IS '顧客都道府県'
;
COMMENT
ON COLUMN customers_mst.cust_address1 IS '顧客住所１'
;
COMMENT
ON COLUMN customers_mst.cust_address2 IS '顧客住所２'
;
COMMENT
ON COLUMN customers_mst.cust_tel IS '顧客電話番号'
;
COMMENT
ON COLUMN customers_mst.cust_fax IS '顧客fax番号'
;
COMMENT
ON COLUMN customers_mst.cust_email IS '顧客メールアドレス'
;
COMMENT
ON COLUMN customers_mst.cust_ar_flag IS '顧客請求区分,1:都度請求,2:締請求'
;
COMMENT
ON COLUMN customers_mst.cust_close_date1 IS '顧客締日１,15:15日締め'
;
COMMENT
ON COLUMN customers_mst.cust_pay_months1 IS '顧客支払月１,0:当月,1:翌月,2:翌々月'
;
COMMENT
ON COLUMN customers_mst.cust_pay_dates1 IS '顧客支払日１,10:10日払い,99：末日'
;
COMMENT
ON COLUMN customers_mst.cust_pay_method1 IS '顧客支払方法１,1:振込,2:手形'
;
COMMENT
ON COLUMN customers_mst.cust_close_date2 IS '顧客締日２,99:末締め'
;
COMMENT
ON COLUMN customers_mst.cust_pay_months2 IS '顧客支払月２,0:当月,1:翌月,2:翌々月'
;
COMMENT
ON COLUMN customers_mst.cust_pay_dates2 IS '顧客支払日２,10:10日払い,99：末日'
;
COMMENT
ON COLUMN customers_mst.cust_pay_method2 IS '顧客支払方法２,1:振込,2:手形'
;
COMMENT
ON COLUMN customers_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN customers_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN customers_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN customers_mst.updater IS '更新者名'
;
CREATE TABLE pricebycustomer
(
    prod_code   VARCHAR(16)                    NOT NULL,
    comp_code   VARCHAR(8)                     NOT NULL,
    unitprice   INTEGER   DEFAULT 0            NOT NULL,
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE pricebycustomer
    ADD CONSTRAINT pk_pricebycustomer PRIMARY KEY (prod_code, comp_code)
;
COMMENT
ON TABLE pricebycustomer IS '顧客別販売単価'
;
COMMENT
ON COLUMN pricebycustomer.prod_code IS '商品コード'
;
COMMENT
ON COLUMN pricebycustomer.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN pricebycustomer.unitprice IS '販売単価'
;
COMMENT
ON COLUMN pricebycustomer.create_date IS '作成日時'
;
COMMENT
ON COLUMN pricebycustomer.creator IS '作成者名'
;
COMMENT
ON COLUMN pricebycustomer.update_date IS '更新日時'
;
COMMENT
ON COLUMN pricebycustomer.updater IS '更新者名'
;
CREATE TABLE stock
(
    wh_code            VARCHAR(3)                      NOT NULL,
    prod_code          VARCHAR(16)                     NOT NULL,
    rot_no             VARCHAR(20)                     NOT NULL,
    stock_type         VARCHAR(1) DEFAULT '1'          NOT NULL,
    quality_type       VARCHAR(1) DEFAULT 'G'          NOT NULL,
    actual             INTEGER    DEFAULT 1            NOT NULL,
    valid              INTEGER    DEFAULT 1            NOT NULL,
    last_delivery_date TIMESTAMP,
    create_date        TIMESTAMP  DEFAULT CURRENT_DATE NOT NULL,
    creator            VARCHAR(12),
    update_date        TIMESTAMP  DEFAULT CURRENT_DATE NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE stock
    ADD CONSTRAINT pk_stock PRIMARY KEY (wh_code, prod_code, rot_no, stock_type, quality_type)
;
COMMENT
ON TABLE stock IS '在庫データ'
;
COMMENT
ON COLUMN stock.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN stock.prod_code IS '商品コード'
;
COMMENT
ON COLUMN stock.rot_no IS 'ロット番号'
;
COMMENT
ON COLUMN stock.stock_type IS '在庫区分,1:自社在庫 2:預り在庫'
;
COMMENT
ON COLUMN stock.quality_type IS '良品区分,G:良品 F:不良品 U:未検品'
;
COMMENT
ON COLUMN stock.actual IS '実在庫数'
;
COMMENT
ON COLUMN stock.valid IS '有効在庫数'
;
COMMENT
ON COLUMN stock.last_delivery_date IS '最終出荷日'
;
COMMENT
ON COLUMN stock.create_date IS '作成日時'
;
COMMENT
ON COLUMN stock.creator IS '作成者名'
;
COMMENT
ON COLUMN stock.update_date IS '更新日時'
;
COMMENT
ON COLUMN stock.updater IS '更新者名'
;
CREATE TABLE pu
(
    pu_no        VARCHAR(10)                    NOT NULL,
    pu_date      TIMESTAMP DEFAULT CURRENT_DATE,
    sup_code     VARCHAR(8)                     NOT NULL,
    sup_sub_no   INTEGER,
    emp_code     VARCHAR(10)                    NOT NULL,
    start_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    po_no        VARCHAR(10),
    dept_code    VARCHAR(6)                     NOT NULL,
    pu_ammount   INTEGER,
    cmp_tax      INTEGER   DEFAULT 0            NOT NULL,
    slip_comment VARCHAR(1000),
    create_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator      VARCHAR(12),
    update_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater      VARCHAR(12)
)
;
ALTER TABLE pu
    ADD CONSTRAINT pk_pu PRIMARY KEY (pu_no)
;
COMMENT
ON TABLE pu IS '仕入データ'
;
COMMENT
ON COLUMN pu.pu_no IS '仕入番号'
;
COMMENT
ON COLUMN pu.pu_date IS '仕入日'
;
COMMENT
ON COLUMN pu.sup_code IS '仕入先コード'
;
COMMENT
ON COLUMN pu.sup_sub_no IS '仕入先枝番'
;
COMMENT
ON COLUMN pu.emp_code IS '仕入担当者コード'
;
COMMENT
ON COLUMN pu.start_date IS '開始日'
;
COMMENT
ON COLUMN pu.po_no IS '発注番号'
;
COMMENT
ON COLUMN pu.dept_code IS '部門コード'
;
COMMENT
ON COLUMN pu.pu_ammount IS '仕入金額合計'
;
COMMENT
ON COLUMN pu.cmp_tax IS '消費税金額'
;
COMMENT
ON COLUMN pu.slip_comment IS '備考'
;
COMMENT
ON COLUMN pu.create_date IS '作成日時'
;
COMMENT
ON COLUMN pu.creator IS '作成者名'
;
COMMENT
ON COLUMN pu.update_date IS '更新日時'
;
COMMENT
ON COLUMN pu.updater IS '更新者名'
;
CREATE TABLE pu_details
(
    pu_no         VARCHAR(10)                    NOT NULL,
    pu_row_no     INTEGER                        NOT NULL,
    pu_row_dsp_no INTEGER                        NOT NULL,
    po_row_no     INTEGER                        NOT NULL,
    prod_code     VARCHAR(16)                    NOT NULL,
    wh_code       VARCHAR(3)                     NOT NULL,
    prod_name     VARCHAR(10)                    NOT NULL,
    po_price      INTEGER   DEFAULT 0,
    pu_quantity   INTEGER   DEFAULT 1            NOT NULL,
    create_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator       VARCHAR(12),
    update_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE pu_details
    ADD CONSTRAINT pk_pu_details PRIMARY KEY (pu_row_no, pu_no)
;
COMMENT
ON TABLE pu_details IS '仕入データ明細'
;
COMMENT
ON COLUMN pu_details.pu_no IS '仕入番号'
;
COMMENT
ON COLUMN pu_details.pu_row_no IS '仕入行番号'
;
COMMENT
ON COLUMN pu_details.pu_row_dsp_no IS '仕入行表示番号'
;
COMMENT
ON COLUMN pu_details.po_row_no IS '発注行番号'
;
COMMENT
ON COLUMN pu_details.prod_code IS '商品コード'
;
COMMENT
ON COLUMN pu_details.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN pu_details.prod_name IS '商品名'
;
COMMENT
ON COLUMN pu_details.po_price IS '仕入単価'
;
COMMENT
ON COLUMN pu_details.pu_quantity IS '仕入数量'
;
COMMENT
ON COLUMN pu_details.create_date IS '作成日時'
;
COMMENT
ON COLUMN pu_details.creator IS '作成者名'
;
COMMENT
ON COLUMN pu_details.update_date IS '更新日時'
;
COMMENT
ON COLUMN pu_details.updater IS '更新者名'
;
CREATE TABLE supplier_mst
(
    sup_code        VARCHAR(8)                     NOT NULL,
    sup_sub_no      INTEGER                        NOT NULL,
    sup_name        VARCHAR(40)                    NOT NULL,
    sup_kana        VARCHAR(40),
    sup_emp_name    VARCHAR(20),
    sup_dep_name    VARCHAR(40),
    sup_zip_code    CHAR(8),
    sup_state       VARCHAR(4),
    sup_address1    VARCHAR(40),
    sup_address2    VARCHAR(40),
    sup_tel         VARCHAR(13),
    sup_fax         VARCHAR(13),
    sup_email       VARCHAR(100),
    sup_close_date  INTEGER                        NOT NULL,
    sup_pay_months  INTEGER   DEFAULT 1,
    sup_pay_dates   INTEGER,
    pay_method_type INTEGER   DEFAULT 1,
    create_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator         VARCHAR(12),
    update_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE supplier_mst
    ADD CONSTRAINT pk_supplier_mst PRIMARY KEY (sup_code, sup_sub_no)
;
ALTER TABLE supplier_mst
    ADD CHECK (pay_method_type IN (1, 2))
;
COMMENT
ON TABLE supplier_mst IS '仕入先マスタ'
;
COMMENT
ON COLUMN supplier_mst.sup_code IS '仕入先コード'
;
COMMENT
ON COLUMN supplier_mst.sup_sub_no IS '仕入先枝番'
;
COMMENT
ON COLUMN supplier_mst.sup_name IS '仕入先名'
;
COMMENT
ON COLUMN supplier_mst.sup_kana IS '仕入先名カナ'
;
COMMENT
ON COLUMN supplier_mst.sup_emp_name IS '仕入先担当者名'
;
COMMENT
ON COLUMN supplier_mst.sup_dep_name IS '仕入先部門名'
;
COMMENT
ON COLUMN supplier_mst.sup_zip_code IS '仕入先郵便番号'
;
COMMENT
ON COLUMN supplier_mst.sup_state IS '仕入先都道府県'
;
COMMENT
ON COLUMN supplier_mst.sup_address1 IS '仕入先住所１'
;
COMMENT
ON COLUMN supplier_mst.sup_address2 IS '仕入先住所２'
;
COMMENT
ON COLUMN supplier_mst.sup_tel IS '仕入先電話番号'
;
COMMENT
ON COLUMN supplier_mst.sup_fax IS '仕入先fax番号'
;
COMMENT
ON COLUMN supplier_mst.sup_email IS '仕入先メールアドレス'
;
COMMENT
ON COLUMN supplier_mst.sup_close_date IS '仕入先締日,15:15日締め'
;
COMMENT
ON COLUMN supplier_mst.sup_pay_months IS '仕入先支払月,0:当月,1:翌月,2:翌々月'
;
COMMENT
ON COLUMN supplier_mst.sup_pay_dates IS '仕入先支払日,10:10日払い,99：末日'
;
COMMENT
ON COLUMN supplier_mst.pay_method_type IS '支払方法区分,1:振込,2:手形'
;
COMMENT
ON COLUMN supplier_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN supplier_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN supplier_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN supplier_mst.updater IS '更新者名'
;
CREATE TABLE pay
(
    pay_no          VARCHAR(10)                    NOT NULL,
    pay_date        INTEGER,
    dept_code       VARCHAR(6)                     NOT NULL,
    start_date      TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    sup_code        VARCHAR(8)                     NOT NULL,
    sup_sub_no      INTEGER,
    pay_method_type INTEGER   DEFAULT 1,
    pay_amnt        INTEGER,
    cmp_tax         INTEGER   DEFAULT 0            NOT NULL,
    complete_flg    INTEGER   DEFAULT 0            NOT NULL,
    create_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator         VARCHAR(12),
    update_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE pay
    ADD CONSTRAINT pk_pay PRIMARY KEY (pay_no)
;
ALTER TABLE pay
    ADD CHECK (pay_method_type IN (1, 2))
;
ALTER TABLE pay
    ADD CHECK (complete_flg IN (0, 1))
;
COMMENT
ON TABLE pay IS '支払データ'
;
COMMENT
ON COLUMN pay.pay_no IS '支払番号'
;
COMMENT
ON COLUMN pay.pay_date IS '支払日,10:10日払い,99：末日'
;
COMMENT
ON COLUMN pay.dept_code IS '部門コード'
;
COMMENT
ON COLUMN pay.start_date IS '部門開始日'
;
COMMENT
ON COLUMN pay.sup_code IS '仕入先コード'
;
COMMENT
ON COLUMN pay.sup_sub_no IS '仕入先枝番'
;
COMMENT
ON COLUMN pay.pay_method_type IS '支払方法区分,1:振込,2:手形'
;
COMMENT
ON COLUMN pay.pay_amnt IS '支払金額'
;
COMMENT
ON COLUMN pay.cmp_tax IS '消費税金額'
;
COMMENT
ON COLUMN pay.complete_flg IS '支払完了フラグ,0:未完了, 1:完了'
;
COMMENT
ON COLUMN pay.create_date IS '作成日時'
;
COMMENT
ON COLUMN pay.creator IS '作成者名'
;
COMMENT
ON COLUMN pay.update_date IS '更新日時'
;
COMMENT
ON COLUMN pay.updater IS '更新者名'
;
CREATE TABLE auto_number
(
    slip_type    VARCHAR(2)        NOT NULL,
    yearmonth    TIMESTAMP         NOT NULL,
    last_silp_no INTEGER DEFAULT 0 NOT NULL
)
;
ALTER TABLE auto_number
    ADD PRIMARY KEY (slip_type, yearmonth)
;
COMMENT
ON TABLE auto_number IS '自動採番マスタ'
;
COMMENT
ON COLUMN auto_number.slip_type IS '伝票種別コード'
;
COMMENT
ON COLUMN auto_number.yearmonth IS '年月'
;
COMMENT
ON COLUMN auto_number.last_silp_no IS '最終伝票番号'
;
CREATE TABLE employee
(
    emp_code       VARCHAR(10)                    NOT NULL,
    emp_name       VARCHAR(20),
    emp_kana       VARCHAR(40),
    login_password VARCHAR(8),
    tel            VARCHAR(13),
    fax            VARCHAR(13),
    dept_code      VARCHAR(6)                     NOT NULL,
    start_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    occu_code      VARCHAR(2)                     NOT NULL,
    approval_code  VARCHAR(2)                     NOT NULL,
    create_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator        VARCHAR(12),
    update_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE employee
    ADD CONSTRAINT pk_employee PRIMARY KEY (emp_code)
;
COMMENT
ON TABLE employee IS '社員マスタ'
;
COMMENT
ON COLUMN employee.emp_code IS '社員コード'
;
COMMENT
ON COLUMN employee.emp_name IS '社員名'
;
COMMENT
ON COLUMN employee.emp_kana IS '社員名カナ'
;
COMMENT
ON COLUMN employee.login_password IS 'パスワード'
;
COMMENT
ON COLUMN employee.tel IS '電話番号'
;
COMMENT
ON COLUMN employee.fax IS 'fax番号'
;
COMMENT
ON COLUMN employee.dept_code IS '部門コード'
;
COMMENT
ON COLUMN employee.start_date IS '開始日'
;
COMMENT
ON COLUMN employee.occu_code IS '職種コード'
;
COMMENT
ON COLUMN employee.approval_code IS '承認権限コード'
;
COMMENT
ON COLUMN employee.create_date IS '作成日時'
;
COMMENT
ON COLUMN employee.creator IS '作成者名'
;
COMMENT
ON COLUMN employee.update_date IS '更新日時'
;
COMMENT
ON COLUMN employee.updater IS '更新者名'
;
CREATE TABLE company_group_mst
(
    comp_group_code VARCHAR(4)                     NOT NULL,
    group_name      VARCHAR(40),
    create_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator         VARCHAR(12),
    update_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE company_group_mst
    ADD CONSTRAINT pk_company_group_mst PRIMARY KEY (comp_group_code)
;
COMMENT
ON TABLE company_group_mst IS '取引先グループマスタ'
;
COMMENT
ON COLUMN company_group_mst.comp_group_code IS '取引先グループコード'
;
COMMENT
ON COLUMN company_group_mst.group_name IS '取引先グループ名'
;
COMMENT
ON COLUMN company_group_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN company_group_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN company_group_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN company_group_mst.updater IS '更新者名'
;
CREATE TABLE companys_mst
(
    comp_code       VARCHAR(8)                     NOT NULL,
    comp_name       VARCHAR(40)                    NOT NULL,
    comp_kana       VARCHAR(40),
    sup_type        INTEGER   DEFAULT 0,
    zip_code        CHAR(8),
    state           VARCHAR(4),
    address1        VARCHAR(40),
    address2        VARCHAR(40),
    no_sales_flg    INTEGER   DEFAULT 0,
    wide_use_type   INTEGER,
    comp_group_code VARCHAR(4)                     NOT NULL,
    max_credit      INTEGER,
    temp_credit_up  INTEGER   DEFAULT 0,
    create_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator         VARCHAR(12),
    update_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE companys_mst
    ADD CONSTRAINT pk_companys_mst PRIMARY KEY (comp_code)
;
ALTER TABLE companys_mst
    ADD CHECK (no_sales_flg IN (0, 1))
;
COMMENT
ON TABLE companys_mst IS '取引先マスタ'
;
COMMENT
ON COLUMN companys_mst.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN companys_mst.comp_name IS '取引先名'
;
COMMENT
ON COLUMN companys_mst.comp_kana IS '取引先名カナ'
;
COMMENT
ON COLUMN companys_mst.sup_type IS '仕入先区分'
;
COMMENT
ON COLUMN companys_mst.zip_code IS '郵便番号'
;
COMMENT
ON COLUMN companys_mst.state IS '都道府県'
;
COMMENT
ON COLUMN companys_mst.address1 IS '住所１'
;
COMMENT
ON COLUMN companys_mst.address2 IS '住所２'
;
COMMENT
ON COLUMN companys_mst.no_sales_flg IS '取引禁止フラグ'
;
COMMENT
ON COLUMN companys_mst.wide_use_type IS '雑区分'
;
COMMENT
ON COLUMN companys_mst.comp_group_code IS '取引先グループコード'
;
COMMENT
ON COLUMN companys_mst.max_credit IS '与信限度額'
;
COMMENT
ON COLUMN companys_mst.temp_credit_up IS '与信一時増加枠'
;
COMMENT
ON COLUMN companys_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN companys_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN companys_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN companys_mst.updater IS '更新者名'
;
CREATE TABLE company_category
(
    category_type  VARCHAR(2)                     NOT NULL,
    comp_cate_code VARCHAR(8)                     NOT NULL,
    comp_cate_name VARCHAR(30),
    create_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator        VARCHAR(12),
    update_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE company_category
    ADD CONSTRAINT pk_company_category PRIMARY KEY (comp_cate_code, category_type)
;
COMMENT
ON TABLE company_category IS '取引先分類マスタ'
;
COMMENT
ON COLUMN company_category.category_type IS '取引先分類種別コード'
;
COMMENT
ON COLUMN company_category.comp_cate_code IS '取引先分類コード'
;
COMMENT
ON COLUMN company_category.comp_cate_name IS '取引先分類名'
;
COMMENT
ON COLUMN company_category.create_date IS '作成日時'
;
COMMENT
ON COLUMN company_category.creator IS '作成者名'
;
COMMENT
ON COLUMN company_category.update_date IS '更新日時'
;
COMMENT
ON COLUMN company_category.updater IS '更新者名'
;
CREATE TABLE category_type
(
    category_type_code VARCHAR(2)                     NOT NULL,
    cate_type_name     VARCHAR(20),
    create_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator            VARCHAR(12),
    update_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE category_type
    ADD CONSTRAINT pk_category_type PRIMARY KEY (category_type_code)
;
COMMENT
ON TABLE category_type IS '取引先分類種別マスタ'
;
COMMENT
ON COLUMN category_type.category_type_code IS '取引先分類種別コード'
;
COMMENT
ON COLUMN category_type.cate_type_name IS '取引先分類種別名'
;
COMMENT
ON COLUMN category_type.create_date IS '作成日時'
;
COMMENT
ON COLUMN category_type.creator IS '作成者名'
;
COMMENT
ON COLUMN category_type.update_date IS '更新日時'
;
COMMENT
ON COLUMN category_type.updater IS '更新者名'
;
CREATE TABLE company_category_group
(
    category_type  VARCHAR(2)                     NOT NULL,
    comp_cate_code VARCHAR(8)                     NOT NULL,
    comp_code      VARCHAR(8)                     NOT NULL,
    create_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator        VARCHAR(12),
    update_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE company_category_group
    ADD CONSTRAINT pk_company_category_group PRIMARY KEY (category_type, comp_code, comp_cate_code)
;
COMMENT
ON TABLE company_category_group IS '取引先分類所属マスタ'
;
COMMENT
ON COLUMN company_category_group.category_type IS '取引先分類種別コード'
;
COMMENT
ON COLUMN company_category_group.comp_cate_code IS '取引先分類コード'
;
COMMENT
ON COLUMN company_category_group.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN company_category_group.create_date IS '作成日時'
;
COMMENT
ON COLUMN company_category_group.creator IS '作成者名'
;
COMMENT
ON COLUMN company_category_group.update_date IS '更新日時'
;
COMMENT
ON COLUMN company_category_group.updater IS '更新者名'
;
CREATE TABLE orders
(
    order_no      VARCHAR(10)                    NOT NULL,
    order_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    dept_code     VARCHAR(6)                     NOT NULL,
    start_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    cust_code     VARCHAR(8)                     NOT NULL,
    cust_sub_no   INTEGER,
    emp_code      VARCHAR(10)                    NOT NULL,
    required_date TIMESTAMP,
    custorder_no  VARCHAR(20),
    wh_code       VARCHAR(3)                     NOT NULL,
    order_amnt    INTEGER   DEFAULT 0            NOT NULL,
    cmp_tax       INTEGER   DEFAULT 0            NOT NULL,
    slip_comment  VARCHAR(1000),
    create_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator       VARCHAR(12),
    update_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE orders
    ADD CONSTRAINT pk_orders PRIMARY KEY (order_no)
;
COMMENT
ON TABLE orders IS '受注データ'
;
COMMENT
ON COLUMN orders.order_no IS '受注番号'
;
COMMENT
ON COLUMN orders.order_date IS '受注日'
;
COMMENT
ON COLUMN orders.dept_code IS '部門コード'
;
COMMENT
ON COLUMN orders.start_date IS '部門開始日'
;
COMMENT
ON COLUMN orders.cust_code IS '顧客コード'
;
COMMENT
ON COLUMN orders.cust_sub_no IS '顧客枝番'
;
COMMENT
ON COLUMN orders.emp_code IS '社員コード'
;
COMMENT
ON COLUMN orders.required_date IS '希望納期'
;
COMMENT
ON COLUMN orders.custorder_no IS '客先注文番号'
;
COMMENT
ON COLUMN orders.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN orders.order_amnt IS '受注金額合計'
;
COMMENT
ON COLUMN orders.cmp_tax IS '消費税金額'
;
COMMENT
ON COLUMN orders.slip_comment IS '備考'
;
COMMENT
ON COLUMN orders.create_date IS '作成日時'
;
COMMENT
ON COLUMN orders.creator IS '作成者名'
;
COMMENT
ON COLUMN orders.update_date IS '更新日時'
;
COMMENT
ON COLUMN orders.updater IS '更新者名'
;
CREATE TABLE order_details
(
    order_no           VARCHAR(10)                    NOT NULL,
    so_row_no          INTEGER                        NOT NULL,
    prod_code          VARCHAR(16)                    NOT NULL,
    prod_name          VARCHAR(10)                    NOT NULL,
    unitprice          INTEGER   DEFAULT 0            NOT NULL,
    quantity           INTEGER   DEFAULT 1            NOT NULL,
    cmp_tax_rate       INTEGER,
    reserve_qty        INTEGER   DEFAULT 0,
    delivery_order_qty INTEGER   DEFAULT 0,
    delivered_qty      INTEGER   DEFAULT 0,
    complete_flg       INTEGER   DEFAULT 0            NOT NULL,
    discount           INTEGER   DEFAULT 0            NOT NULL,
    delivery_date      TIMESTAMP,
    create_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator            VARCHAR(12),
    update_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_no, so_row_no)
;
ALTER TABLE order_details
    ADD CHECK (delivered_qty >= 0)
;
ALTER TABLE order_details
    ADD CHECK (complete_flg IN (0, 1))
;
COMMENT
ON TABLE order_details IS '受注データ明細'
;
COMMENT
ON COLUMN order_details.order_no IS '受注番号'
;
COMMENT
ON COLUMN order_details.so_row_no IS '受注行番号'
;
COMMENT
ON COLUMN order_details.prod_code IS '商品コード'
;
COMMENT
ON COLUMN order_details.prod_name IS '商品名'
;
COMMENT
ON COLUMN order_details.unitprice IS '販売単価'
;
COMMENT
ON COLUMN order_details.quantity IS '受注数量'
;
COMMENT
ON COLUMN order_details.cmp_tax_rate IS '消費税率'
;
COMMENT
ON COLUMN order_details.reserve_qty IS '引当数量'
;
COMMENT
ON COLUMN order_details.delivery_order_qty IS '出荷指示数量'
;
COMMENT
ON COLUMN order_details.delivered_qty IS '出荷済数量'
;
COMMENT
ON COLUMN order_details.complete_flg IS '完了フラグ,0:未完了, 1:完了'
;
COMMENT
ON COLUMN order_details.discount IS '値引金額'
;
COMMENT
ON COLUMN order_details.delivery_date IS '納期'
;
COMMENT
ON COLUMN order_details.create_date IS '作成日時'
;
COMMENT
ON COLUMN order_details.creator IS '作成者名'
;
COMMENT
ON COLUMN order_details.update_date IS '更新日時'
;
COMMENT
ON COLUMN order_details.updater IS '更新者名'
;
CREATE TABLE destinations_mst
(
    comp_code   VARCHAR(8)                     NOT NULL,
    comp_sub_no INTEGER                        NOT NULL,
    dist_no     INTEGER                        NOT NULL,
    dist_name   VARCHAR(40)                    NOT NULL,
    area_code   VARCHAR(10)                    NOT NULL,
    zip_code    CHAR(8),
    address1    VARCHAR(40),
    address2    VARCHAR(40),
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE destinations_mst
    ADD CONSTRAINT pk_destinations_mst PRIMARY KEY (comp_code, dist_no, comp_sub_no)
;
COMMENT
ON TABLE destinations_mst IS '出荷先マスタ'
;
COMMENT
ON COLUMN destinations_mst.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN destinations_mst.comp_sub_no IS '顧客枝番'
;
COMMENT
ON COLUMN destinations_mst.dist_no IS '出荷先番号'
;
COMMENT
ON COLUMN destinations_mst.dist_name IS '出荷先名'
;
COMMENT
ON COLUMN destinations_mst.area_code IS '地域コード'
;
COMMENT
ON COLUMN destinations_mst.zip_code IS '出荷先郵便番号'
;
COMMENT
ON COLUMN destinations_mst.address1 IS '出荷先住所１'
;
COMMENT
ON COLUMN destinations_mst.address2 IS '出荷先住所２'
;
COMMENT
ON COLUMN destinations_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN destinations_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN destinations_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN destinations_mst.updater IS '更新者名'
;
CREATE TABLE products
(
    prod_code          VARCHAR(16)                    NOT NULL,
    prod_fullname      VARCHAR(40)                    NOT NULL,
    prod_name          VARCHAR(10)                    NOT NULL,
    prod_kana          VARCHAR(20)                    NOT NULL,
    prod_type          VARCHAR(1),
    serial_no          VARCHAR(40),
    unitprice          INTEGER   DEFAULT 0            NOT NULL,
    po_price           INTEGER   DEFAULT 0,
    prime_cost         INTEGER   DEFAULT 0            NOT NULL,
    tax_type           INTEGER   DEFAULT 1            NOT NULL,
    category_code      VARCHAR(8),
    wide_use_type      INTEGER,
    stock_manage_type  INTEGER   DEFAULT 1,
    stock_reserve_type INTEGER,
    sup_code           VARCHAR(8)                     NOT NULL,
    sup_sub_no         INTEGER,
    create_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator            VARCHAR(12),
    update_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE products
    ADD CONSTRAINT pk_products PRIMARY KEY (prod_code)
;
ALTER TABLE products
    ADD CHECK (tax_type IN (0, 1))
;
COMMENT
ON TABLE products IS '商品マスタ'
;
COMMENT
ON COLUMN products.prod_code IS '商品コード'
;
COMMENT
ON COLUMN products.prod_fullname IS '商品正式名'
;
COMMENT
ON COLUMN products.prod_name IS '商品名'
;
COMMENT
ON COLUMN products.prod_kana IS '商品名カナ'
;
COMMENT
ON COLUMN products.prod_type IS '商品区分,1:商品 2:製品 3:原材料 4:間接材'
;
COMMENT
ON COLUMN products.serial_no IS '製品型番'
;
COMMENT
ON COLUMN products.unitprice IS '販売単価'
;
COMMENT
ON COLUMN products.po_price IS '仕入単価'
;
COMMENT
ON COLUMN products.prime_cost IS '売上原価'
;
COMMENT
ON COLUMN products.tax_type IS '税区分,1:外税 2:内税'
;
COMMENT
ON COLUMN products.category_code IS '商品分類コード'
;
COMMENT
ON COLUMN products.wide_use_type IS '雑区分'
;
COMMENT
ON COLUMN products.stock_manage_type IS '在庫管理対象区分,0:対象外 1:在庫管理対象'
;
COMMENT
ON COLUMN products.stock_reserve_type IS '在庫引当区分,0:対象外 1:即時 2:まとめ 3:手配品'
;
COMMENT
ON COLUMN products.sup_code IS '仕入先コード'
;
COMMENT
ON COLUMN products.sup_sub_no IS '仕入先枝番'
;
COMMENT
ON COLUMN products.create_date IS '作成日時'
;
COMMENT
ON COLUMN products.creator IS '作成者名'
;
COMMENT
ON COLUMN products.update_date IS '更新日時'
;
COMMENT
ON COLUMN products.updater IS '更新者名'
;
CREATE TABLE product_category
(
    category_code  VARCHAR(8)                     NOT NULL,
    prod_cate_name VARCHAR(30),
    category_layer INTEGER   DEFAULT 0            NOT NULL,
    category_path  VARCHAR(100),
    lowest_flug    INTEGER   DEFAULT 0,
    create_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator        VARCHAR(12),
    update_date    TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE product_category
    ADD CONSTRAINT pk_product_category PRIMARY KEY (category_code)
;
COMMENT
ON TABLE product_category IS '商品分類マスタ'
;
COMMENT
ON COLUMN product_category.category_code IS '商品分類コード'
;
COMMENT
ON COLUMN product_category.prod_cate_name IS '商品分類名'
;
COMMENT
ON COLUMN product_category.category_layer IS '商品分類階層'
;
COMMENT
ON COLUMN product_category.category_path IS '商品分類パス'
;
COMMENT
ON COLUMN product_category.lowest_flug IS '最下層区分'
;
COMMENT
ON COLUMN product_category.create_date IS '作成日時'
;
COMMENT
ON COLUMN product_category.creator IS '作成者名'
;
COMMENT
ON COLUMN product_category.update_date IS '更新日時'
;
COMMENT
ON COLUMN product_category.updater IS '更新者名'
;
CREATE TABLE invoice
(
    invoice_no       VARCHAR(10)                    NOT NULL,
    invoiced_date    TIMESTAMP,
    comp_code        VARCHAR(8)                     NOT NULL,
    cust_sub_no      INTEGER,
    last_received    INTEGER,
    month_sales      INTEGER,
    month_received   INTEGER,
    month_invoice    INTEGER,
    cmp_tax          INTEGER   DEFAULT 0            NOT NULL,
    invoice_received INTEGER   DEFAULT 0,
    create_date      TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator          VARCHAR(12),
    update_date      TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater          VARCHAR(12)
)
;
ALTER TABLE invoice
    ADD CONSTRAINT pk_invoice PRIMARY KEY (invoice_no)
;
COMMENT
ON TABLE invoice IS '請求データ'
;
COMMENT
ON COLUMN invoice.invoice_no IS '請求番号'
;
COMMENT
ON COLUMN invoice.invoiced_date IS '請求日'
;
COMMENT
ON COLUMN invoice.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN invoice.cust_sub_no IS '顧客枝番'
;
COMMENT
ON COLUMN invoice.last_received IS '前回入金額'
;
COMMENT
ON COLUMN invoice.month_sales IS '当月売上額'
;
COMMENT
ON COLUMN invoice.month_received IS '当月入金額'
;
COMMENT
ON COLUMN invoice.month_invoice IS '当月請求額'
;
COMMENT
ON COLUMN invoice.cmp_tax IS '消費税金額'
;
COMMENT
ON COLUMN invoice.invoice_received IS '請求消込金額'
;
COMMENT
ON COLUMN invoice.create_date IS '作成日時'
;
COMMENT
ON COLUMN invoice.creator IS '作成者名'
;
COMMENT
ON COLUMN invoice.update_date IS '更新日時'
;
COMMENT
ON COLUMN invoice.updater IS '更新者名'
;
CREATE TABLE invoice_details
(
    invoice_no  VARCHAR(10)                    NOT NULL,
    sales_no    VARCHAR(10)                    NOT NULL,
    row_no      INTEGER                        NOT NULL,
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE invoice_details
    ADD CONSTRAINT pk_invoice_details PRIMARY KEY (invoice_no, sales_no, row_no)
;
COMMENT
ON TABLE invoice_details IS '請求データ明細'
;
COMMENT
ON COLUMN invoice_details.invoice_no IS '請求番号'
;
COMMENT
ON COLUMN invoice_details.sales_no IS '売上番号'
;
COMMENT
ON COLUMN invoice_details.row_no IS '売上行番号'
;
COMMENT
ON COLUMN invoice_details.create_date IS '作成日時'
;
COMMENT
ON COLUMN invoice_details.creator IS '作成者名'
;
COMMENT
ON COLUMN invoice_details.update_date IS '更新日時'
;
COMMENT
ON COLUMN invoice_details.updater IS '更新者名'
;
CREATE TABLE wh_mst
(
    wh_code     VARCHAR(3)                      NOT NULL,
    wh_name     VARCHAR(20),
    wh_type     VARCHAR(1) DEFAULT 'N',
    zip_code    CHAR(8),
    state       VARCHAR(4),
    address1    VARCHAR(40),
    address2    VARCHAR(40),
    create_date TIMESTAMP  DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP  DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE wh_mst
    ADD CONSTRAINT pk_wh_mst PRIMARY KEY (wh_code)
;
COMMENT
ON TABLE wh_mst IS '倉庫マスタ'
;
COMMENT
ON COLUMN wh_mst.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN wh_mst.wh_name IS '倉庫名'
;
COMMENT
ON COLUMN wh_mst.wh_type IS '倉庫区分,N:通常倉庫 C:得意先 S:仕入先 D:部門倉庫 P:製品倉庫 M:原材料倉庫'
;
COMMENT
ON COLUMN wh_mst.zip_code IS '郵便番号'
;
COMMENT
ON COLUMN wh_mst.state IS '都道府県'
;
COMMENT
ON COLUMN wh_mst.address1 IS '住所１'
;
COMMENT
ON COLUMN wh_mst.address2 IS '住所２'
;
COMMENT
ON COLUMN wh_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN wh_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN wh_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN wh_mst.updater IS '更新者名'
;
CREATE TABLE wh_dept_mst
(
    wh_code     VARCHAR(3)                     NOT NULL,
    dept_code   VARCHAR(6)                     NOT NULL,
    start_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE wh_dept_mst
    ADD CONSTRAINT pk_wh_dept_mst PRIMARY KEY (wh_code, dept_code, start_date)
;
COMMENT
ON TABLE wh_dept_mst IS '倉庫部門マスタ'
;
COMMENT
ON COLUMN wh_dept_mst.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN wh_dept_mst.dept_code IS '部門コード'
;
COMMENT
ON COLUMN wh_dept_mst.start_date IS '開始日'
;
COMMENT
ON COLUMN wh_dept_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN wh_dept_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN wh_dept_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN wh_dept_mst.updater IS '更新者名'
;
CREATE TABLE alternate_products
(
    prod_code     VARCHAR(16)                    NOT NULL,
    alt_prod_code VARCHAR(16)                    NOT NULL,
    priority      INTEGER   DEFAULT 1,
    create_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator       VARCHAR(12),
    update_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE alternate_products
    ADD CONSTRAINT pk_alternate_products PRIMARY KEY (prod_code, alt_prod_code)
;
COMMENT
ON TABLE alternate_products IS '代替商品'
;
COMMENT
ON COLUMN alternate_products.prod_code IS '商品コード'
;
COMMENT
ON COLUMN alternate_products.alt_prod_code IS '代替商品コード'
;
COMMENT
ON COLUMN alternate_products.priority IS '優先順位'
;
COMMENT
ON COLUMN alternate_products.create_date IS '作成日時'
;
COMMENT
ON COLUMN alternate_products.creator IS '作成者名'
;
COMMENT
ON COLUMN alternate_products.update_date IS '更新日時'
;
COMMENT
ON COLUMN alternate_products.updater IS '更新者名'
;
CREATE TABLE location_mst
(
    wh_code       VARCHAR(3)                     NOT NULL,
    location_code VARCHAR(4)                     NOT NULL,
    prod_code     VARCHAR(16)                    NOT NULL,
    create_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator       VARCHAR(12),
    update_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE location_mst
    ADD CONSTRAINT pk_location_mst PRIMARY KEY (wh_code, location_code, prod_code)
;
COMMENT
ON TABLE location_mst IS '棚番マスタ'
;
COMMENT
ON COLUMN location_mst.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN location_mst.location_code IS '棚番コード'
;
COMMENT
ON COLUMN location_mst.prod_code IS '商品コード'
;
COMMENT
ON COLUMN location_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN location_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN location_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN location_mst.updater IS '更新者名'
;
CREATE TABLE area_mst
(
    area_code   VARCHAR(10)                    NOT NULL,
    area_name   VARCHAR(20),
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE area_mst
    ADD CONSTRAINT pk_地域マスタ PRIMARY KEY (area_code)
;
COMMENT
ON TABLE area_mst IS '地域マスタ'
;
COMMENT
ON COLUMN area_mst.area_code IS '地域コード'
;
COMMENT
ON COLUMN area_mst.area_name IS '地域名'
;
COMMENT
ON COLUMN area_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN area_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN area_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN area_mst.updater IS '更新者名'
;
CREATE TABLE credit
(
    credit_no       VARCHAR(10)                    NOT NULL,
    credit_date     TIMESTAMP,
    dept_code       VARCHAR(6)                     NOT NULL,
    start_date      TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    comp_code       VARCHAR(8)                     NOT NULL,
    comp_sub_no     INTEGER,
    pay_method_type INTEGER   DEFAULT 1,
    bank_acut_code  VARCHAR(8),
    received_amnt   INTEGER   DEFAULT 0,
    received        INTEGER   DEFAULT 0,
    create_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator         VARCHAR(12),
    update_date     TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater         VARCHAR(12),
    update_plg_date TIMESTAMP DEFAULT CURRENT_DATE,
    update_pgm      VARCHAR(50)
)
;
ALTER TABLE credit
    ADD CONSTRAINT pk_credit PRIMARY KEY (credit_no)
;
ALTER TABLE credit
    ADD CHECK (pay_method_type IN (1, 2))
;
COMMENT
ON TABLE credit IS '入金データ'
;
COMMENT
ON COLUMN credit.credit_no IS '入金番号'
;
COMMENT
ON COLUMN credit.credit_date IS '入金日'
;
COMMENT
ON COLUMN credit.dept_code IS '部門コード'
;
COMMENT
ON COLUMN credit.start_date IS '開始日'
;
COMMENT
ON COLUMN credit.comp_code IS '顧客コード'
;
COMMENT
ON COLUMN credit.comp_sub_no IS '顧客枝番'
;
COMMENT
ON COLUMN credit.pay_method_type IS '支払方法区分,1:振込,2:手形'
;
COMMENT
ON COLUMN credit.bank_acut_code IS '入金口座コード'
;
COMMENT
ON COLUMN credit.received_amnt IS '入金金額'
;
COMMENT
ON COLUMN credit.received IS '消込金額'
;
COMMENT
ON COLUMN credit.create_date IS '作成日時'
;
COMMENT
ON COLUMN credit.creator IS '作成者名'
;
COMMENT
ON COLUMN credit.update_date IS '更新日時'
;
COMMENT
ON COLUMN credit.updater IS '更新者名'
;
COMMENT
ON COLUMN credit.update_plg_date IS 'プログラム更新日時'
;
COMMENT
ON COLUMN credit.update_pgm IS '更新プログラム名'
;
CREATE TABLE bank_acut_mst
(
    bank_acut_code       VARCHAR(8)                     NOT NULL,
    recive_act_name      VARCHAR(30),
    appl_start_date      TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    appl_end_date        TIMESTAMP DEFAULT '2100/12/31',
    start_act_name       VARCHAR(30),
    recive_bank_act_type VARCHAR(1),
    recive_act_no        VARCHAR(12),
    bank_act_type        VARCHAR(1),
    act_name             VARCHAR(20),
    dept_code            VARCHAR(6)                     NOT NULL,
    start_date           TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    a_bank_code          VARCHAR(4),
    a_bank_blnc_code     VARCHAR(3),
    create_date          TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator              VARCHAR(12),
    update_date          TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater              VARCHAR(12),
    update_plg_date      TIMESTAMP DEFAULT CURRENT_DATE,
    update_pgm           VARCHAR(50)
)
;
ALTER TABLE bank_acut_mst
    ADD CONSTRAINT pk_bank_acut_mst PRIMARY KEY (bank_acut_code)
;
COMMENT
ON TABLE bank_acut_mst IS '入金口座マスタ'
;
COMMENT
ON COLUMN bank_acut_mst.bank_acut_code IS '入金口座コード'
;
COMMENT
ON COLUMN bank_acut_mst.recive_act_name IS '入金口座名'
;
COMMENT
ON COLUMN bank_acut_mst.appl_start_date IS '適用開始日'
;
COMMENT
ON COLUMN bank_acut_mst.appl_end_date IS '適用終了日'
;
COMMENT
ON COLUMN bank_acut_mst.start_act_name IS '適用開始後入金口座名'
;
COMMENT
ON COLUMN bank_acut_mst.recive_bank_act_type IS '入金口座区分,B:銀行 P:郵便局'
;
COMMENT
ON COLUMN bank_acut_mst.recive_act_no IS '入金口座番号,銀行:7桁 郵便局:12桁'
;
COMMENT
ON COLUMN bank_acut_mst.bank_act_type IS '銀行口座種別,O:普通 C:当座'
;
COMMENT
ON COLUMN bank_acut_mst.act_name IS '口座名義人'
;
COMMENT
ON COLUMN bank_acut_mst.dept_code IS '部門コード'
;
COMMENT
ON COLUMN bank_acut_mst.start_date IS '部門開始日'
;
COMMENT
ON COLUMN bank_acut_mst.a_bank_code IS '全銀協銀行コード'
;
COMMENT
ON COLUMN bank_acut_mst.a_bank_blnc_code IS '全銀協支店コード'
;
COMMENT
ON COLUMN bank_acut_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN bank_acut_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN bank_acut_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN bank_acut_mst.updater IS '更新者名'
;
COMMENT
ON COLUMN bank_acut_mst.update_plg_date IS 'プログラム更新日時'
;
COMMENT
ON COLUMN bank_acut_mst.update_pgm IS '更新プログラム名'
;
CREATE TABLE sales
(
    sales_no     VARCHAR(10)                    NOT NULL,
    order_no     VARCHAR(10)                    NOT NULL,
    sales_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    sales_type   INTEGER   DEFAULT 1,
    dept_code    VARCHAR(6)                     NOT NULL,
    start_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    comp_code    VARCHAR(8)                     NOT NULL,
    emp_code     VARCHAR(10)                    NOT NULL,
    sales_amnt   INTEGER   DEFAULT 0            NOT NULL,
    cmp_tax      INTEGER   DEFAULT 0            NOT NULL,
    slip_comment VARCHAR(1000),
    updated_no   INTEGER,
    orgnl_no     VARCHAR(10),
    create_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator      VARCHAR(12),
    update_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater      VARCHAR(12)
)
;
ALTER TABLE sales
    ADD CONSTRAINT pk_sales PRIMARY KEY (sales_no)
;
COMMENT
ON TABLE sales IS '売上データ'
;
COMMENT
ON COLUMN sales.sales_no IS '売上番号'
;
COMMENT
ON COLUMN sales.order_no IS '受注番号'
;
COMMENT
ON COLUMN sales.sales_date IS '売上日,出荷日'
;
COMMENT
ON COLUMN sales.sales_type IS '売上区分,1:売上 2:売上返品'
;
COMMENT
ON COLUMN sales.dept_code IS '部門コード'
;
COMMENT
ON COLUMN sales.start_date IS '部門開始日'
;
COMMENT
ON COLUMN sales.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN sales.emp_code IS '社員コード'
;
COMMENT
ON COLUMN sales.sales_amnt IS '売上金額合計'
;
COMMENT
ON COLUMN sales.cmp_tax IS '消費税合計'
;
COMMENT
ON COLUMN sales.slip_comment IS '備考'
;
COMMENT
ON COLUMN sales.updated_no IS '赤黒伝票番号'
;
COMMENT
ON COLUMN sales.orgnl_no IS '元伝票番号'
;
COMMENT
ON COLUMN sales.create_date IS '作成日時'
;
COMMENT
ON COLUMN sales.creator IS '作成者名'
;
COMMENT
ON COLUMN sales.update_date IS '更新日時'
;
COMMENT
ON COLUMN sales.updater IS '更新者名'
;
CREATE TABLE sales_details
(
    sales_no           VARCHAR(10)                    NOT NULL,
    row_no             INTEGER                        NOT NULL,
    prod_code          VARCHAR(16)                    NOT NULL,
    prod_name          VARCHAR(10)                    NOT NULL,
    unitprice          INTEGER   DEFAULT 0            NOT NULL,
    delivered_qty      INTEGER   DEFAULT 0,
    quantity           INTEGER   DEFAULT 1            NOT NULL,
    discount           INTEGER   DEFAULT 0            NOT NULL,
    invoiced_date      TIMESTAMP,
    invoice_no         VARCHAR(10),
    invoice_delay_type INTEGER,
    auto_journal_date  TIMESTAMP,
    create_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator            VARCHAR(12),
    update_date        TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE sales_details
    ADD CONSTRAINT pk_sales_details PRIMARY KEY (sales_no, row_no)
;
COMMENT
ON TABLE sales_details IS '売上データ明細'
;
COMMENT
ON COLUMN sales_details.sales_no IS '売上番号'
;
COMMENT
ON COLUMN sales_details.row_no IS '売上行番号'
;
COMMENT
ON COLUMN sales_details.prod_code IS '商品コード'
;
COMMENT
ON COLUMN sales_details.prod_name IS '商品名'
;
COMMENT
ON COLUMN sales_details.unitprice IS '販売単価'
;
COMMENT
ON COLUMN sales_details.delivered_qty IS '出荷数量'
;
COMMENT
ON COLUMN sales_details.quantity IS '売上数量'
;
COMMENT
ON COLUMN sales_details.discount IS '値引金額'
;
COMMENT
ON COLUMN sales_details.invoiced_date IS '請求日'
;
COMMENT
ON COLUMN sales_details.invoice_no IS '請求番号'
;
COMMENT
ON COLUMN sales_details.invoice_delay_type IS '請求遅延区分'
;
COMMENT
ON COLUMN sales_details.auto_journal_date IS '自動仕訳処理日'
;
COMMENT
ON COLUMN sales_details.create_date IS '作成日時'
;
COMMENT
ON COLUMN sales_details.creator IS '作成者名'
;
COMMENT
ON COLUMN sales_details.update_date IS '更新日時'
;
COMMENT
ON COLUMN sales_details.updater IS '更新者名'
;
CREATE TABLE purchase_orders
(
    po_no        VARCHAR(10)                    NOT NULL,
    po_date      TIMESTAMP,
    order_no     VARCHAR(10)                    NOT NULL,
    sup_code     VARCHAR(8)                     NOT NULL,
    sup_sub_no   INTEGER,
    emp_code     VARCHAR(10)                    NOT NULL,
    due_date     TIMESTAMP,
    wh_code      VARCHAR(3)                     NOT NULL,
    po_amnt      INTEGER,
    cmp_tax      INTEGER   DEFAULT 0            NOT NULL,
    slip_comment VARCHAR(1000),
    create_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator      VARCHAR(12),
    update_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater      VARCHAR(12)
)
;
ALTER TABLE purchase_orders
    ADD CONSTRAINT pk_purchase_orders PRIMARY KEY (po_no)
;
COMMENT
ON TABLE purchase_orders IS '発注データ'
;
COMMENT
ON COLUMN purchase_orders.po_no IS '発注番号'
;
COMMENT
ON COLUMN purchase_orders.po_date IS '発注日'
;
COMMENT
ON COLUMN purchase_orders.order_no IS '受注番号'
;
COMMENT
ON COLUMN purchase_orders.sup_code IS '仕入先コード'
;
COMMENT
ON COLUMN purchase_orders.sup_sub_no IS '仕入先枝番'
;
COMMENT
ON COLUMN purchase_orders.emp_code IS '発注担当者コード'
;
COMMENT
ON COLUMN purchase_orders.due_date IS '指定納期'
;
COMMENT
ON COLUMN purchase_orders.wh_code IS '倉庫コード'
;
COMMENT
ON COLUMN purchase_orders.po_amnt IS '発注金額合計'
;
COMMENT
ON COLUMN purchase_orders.cmp_tax IS '消費税金額'
;
COMMENT
ON COLUMN purchase_orders.slip_comment IS '備考'
;
COMMENT
ON COLUMN purchase_orders.create_date IS '作成日時'
;
COMMENT
ON COLUMN purchase_orders.creator IS '作成者名'
;
COMMENT
ON COLUMN purchase_orders.update_date IS '更新日時'
;
COMMENT
ON COLUMN purchase_orders.updater IS '更新者名'
;
CREATE TABLE po_details
(
    po_no         VARCHAR(10)                    NOT NULL,
    po_row_no     INTEGER                        NOT NULL,
    po_row_dsp_no INTEGER                        NOT NULL,
    order_no      VARCHAR(10)                    NOT NULL,
    so_row_no     INTEGER                        NOT NULL,
    prod_code     VARCHAR(16)                    NOT NULL,
    prod_name     VARCHAR(10)                    NOT NULL,
    po_price      INTEGER   DEFAULT 0,
    po_qt         INTEGER   DEFAULT 1            NOT NULL,
    recived_qt    INTEGER   DEFAULT 1            NOT NULL,
    complete_flg  INTEGER   DEFAULT 0            NOT NULL,
    create_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator       VARCHAR(12),
    update_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE po_details
    ADD CONSTRAINT po_details_pkey PRIMARY KEY (po_row_no, po_no)
;
ALTER TABLE po_details
    ADD CHECK (complete_flg IN (0, 1))
;
COMMENT
ON TABLE po_details IS '発注データ明細'
;
COMMENT
ON COLUMN po_details.po_no IS '発注番号'
;
COMMENT
ON COLUMN po_details.po_row_no IS '発注行番号'
;
COMMENT
ON COLUMN po_details.po_row_dsp_no IS '発注行表示番号'
;
COMMENT
ON COLUMN po_details.order_no IS '受注番号'
;
COMMENT
ON COLUMN po_details.so_row_no IS '受注行番号'
;
COMMENT
ON COLUMN po_details.prod_code IS '商品コード'
;
COMMENT
ON COLUMN po_details.prod_name IS '商品名'
;
COMMENT
ON COLUMN po_details.po_price IS '仕入単価'
;
COMMENT
ON COLUMN po_details.po_qt IS '発注数量'
;
COMMENT
ON COLUMN po_details.recived_qt IS '入荷済数量'
;
COMMENT
ON COLUMN po_details.complete_flg IS '完了フラグ,0:未完了, 1:完了'
;
COMMENT
ON COLUMN po_details.create_date IS '作成日時'
;
COMMENT
ON COLUMN po_details.creator IS '作成者名'
;
COMMENT
ON COLUMN po_details.update_date IS '更新日時'
;
COMMENT
ON COLUMN po_details.updater IS '更新者名'
;
CREATE TABLE bom
(
    prod_code   VARCHAR(16)                    NOT NULL,
    bom_code    VARCHAR(16)                    NOT NULL,
    quantity    INTEGER   DEFAULT 1            NOT NULL,
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE bom
    ADD CONSTRAINT pk_bom PRIMARY KEY (prod_code)
;
COMMENT
ON TABLE bom IS '部品表'
;
COMMENT
ON COLUMN bom.prod_code IS '商品コード'
;
COMMENT
ON COLUMN bom.bom_code IS '部品コード'
;
COMMENT
ON COLUMN bom.quantity IS '部品数量'
;
COMMENT
ON COLUMN bom.create_date IS '作成日時'
;
COMMENT
ON COLUMN bom.creator IS '作成者名'
;
COMMENT
ON COLUMN bom.update_date IS '更新日時'
;
COMMENT
ON COLUMN bom.updater IS '更新者名'
;
CREATE TABLE dept_mst
(
    dept_code   VARCHAR(6)                     NOT NULL,
    start_date  TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    end_date    TIMESTAMP DEFAULT '2100/12/31',
    dep_name    VARCHAR(40),
    dept_layer  INTEGER   DEFAULT 0            NOT NULL,
    dept_psth   VARCHAR(100)                   NOT NULL,
    最下層区分  INTEGER   DEFAULT 0            NOT NULL,
    slit_yn     INTEGER   DEFAULT 1            NOT NULL,
    create_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator     VARCHAR(12),
    update_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE dept_mst
    ADD CONSTRAINT pk_dept_mst PRIMARY KEY (dept_code, start_date)
;
COMMENT
ON TABLE dept_mst IS '部門マスタ'
;
COMMENT
ON COLUMN dept_mst.dept_code IS '部門コード'
;
COMMENT
ON COLUMN dept_mst.start_date IS '開始日'
;
COMMENT
ON COLUMN dept_mst.end_date IS '終了日'
;
COMMENT
ON COLUMN dept_mst.dep_name IS '部門名'
;
COMMENT
ON COLUMN dept_mst.dept_layer IS '組織階層'
;
COMMENT
ON COLUMN dept_mst.dept_psth IS '部門パス'
;
COMMENT
ON COLUMN dept_mst.最下層区分 IS '最下層区分'
;
COMMENT
ON COLUMN dept_mst.slit_yn IS '伝票入力可否,0:不可 1:可能'
;
COMMENT
ON COLUMN dept_mst.create_date IS '作成日時'
;
COMMENT
ON COLUMN dept_mst.creator IS '作成者名'
;
COMMENT
ON COLUMN dept_mst.update_date IS '更新日時'
;
COMMENT
ON COLUMN dept_mst.updater IS '更新者名'
;
CREATE TABLE credit_balance
(
    comp_code     VARCHAR(8)                     NOT NULL,
    order_balance INTEGER   DEFAULT 0,
    rec_balance   INTEGER   DEFAULT 0,
    pay_balance   INTEGER   DEFAULT 0,
    create_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    creator       VARCHAR(12),
    update_date   TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE credit_balance
    ADD CONSTRAINT pk_credit_balance PRIMARY KEY (comp_code)
;
COMMENT
ON TABLE credit_balance IS '与信残高データ'
;
COMMENT
ON COLUMN credit_balance.comp_code IS '取引先コード'
;
COMMENT
ON COLUMN credit_balance.order_balance IS '受注残高'
;
COMMENT
ON COLUMN credit_balance.rec_balance IS '債権残高'
;
COMMENT
ON COLUMN credit_balance.pay_balance IS '債務残高'
;
COMMENT
ON COLUMN credit_balance.create_date IS '作成日時'
;
COMMENT
ON COLUMN credit_balance.creator IS '作成者名'
;
COMMENT
ON COLUMN credit_balance.update_date IS '更新日時'
;
COMMENT
ON COLUMN credit_balance.updater IS '更新者名'
;
ALTER TABLE order_details
    ADD CONSTRAINT FK_ORDERS_ORDER_DETAILS FOREIGN KEY (order_no) REFERENCES orders (order_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pricebycustomer
    ADD CONSTRAINT FK_COMPANYS_MST_PRICEBYCUSTOME FOREIGN KEY (comp_code) REFERENCES companys_mst (comp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE supplier_mst
    ADD CONSTRAINT FK_COMPANYS_MST_SUPPLIER_MST FOREIGN KEY (sup_code) REFERENCES companys_mst (comp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE company_category
    ADD CONSTRAINT FK_CATEGORY_TYPE_COMPANY_CATEG FOREIGN KEY (category_type) REFERENCES category_type (category_type_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE company_category_group
    ADD CONSTRAINT FK_COMPANY_CATEGORY_COMPANY_CA FOREIGN KEY (comp_cate_code, category_type) REFERENCES company_category (comp_cate_code, category_type) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE orders
    ADD CONSTRAINT FK_EMPLOYEE_ORDERS FOREIGN KEY (emp_code) REFERENCES employee (emp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE orders
    ADD CONSTRAINT FK_CUSTOMERS_MST_ORDERS FOREIGN KEY (cust_code, cust_sub_no) REFERENCES customers_mst (cust_code, cust_sub_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE sales_details
    ADD CONSTRAINT FK_SALES_SALES_DETAILS FOREIGN KEY (sales_no) REFERENCES sales (sales_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE customers_mst
    ADD CONSTRAINT FK_COMPANYS_MST_CUSTOMERS_MST FOREIGN KEY (cust_code) REFERENCES companys_mst (comp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE invoice_details
    ADD CONSTRAINT FK_INVOICE_請求データ明細 FOREIGN KEY (invoice_no) REFERENCES invoice (invoice_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE bom
    ADD CONSTRAINT FK_PRODUCTS_BOM FOREIGN KEY (prod_code) REFERENCES products (prod_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE purchase_orders
    ADD CONSTRAINT FK_EMPLOYEE_PURCHASE_ORDERS FOREIGN KEY (emp_code) REFERENCES employee (emp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE po_details
    ADD CONSTRAINT FK_PURCHASE_ORDERS_PO_DETAILS FOREIGN KEY (po_no) REFERENCES purchase_orders (po_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE orders
    ADD CONSTRAINT FK_WH_MST_ORDERS FOREIGN KEY (wh_code) REFERENCES wh_mst (wh_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE stock
    ADD CONSTRAINT FK_WH_MST_STOCK FOREIGN KEY (wh_code) REFERENCES wh_mst (wh_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE wh_dept_mst
    ADD CONSTRAINT FK_WH_MST_WH_DEPT_MST FOREIGN KEY (wh_code) REFERENCES wh_mst (wh_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE wh_dept_mst
    ADD CONSTRAINT FK_DEPT_MST_WH_DEPT_MST FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE location_mst
    ADD CONSTRAINT FK_WH_MST_棚番マスタ FOREIGN KEY (wh_code) REFERENCES wh_mst (wh_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE location_mst
    ADD CONSTRAINT FK_PRODUCTS_棚番マスタ FOREIGN KEY (prod_code) REFERENCES products (prod_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pu
    ADD CONSTRAINT FK_EMPLOYEE_仕入データ FOREIGN KEY (emp_code) REFERENCES employee (emp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pu_details
    ADD CONSTRAINT FK_仕入データ_PU_DETAILS FOREIGN KEY (pu_no) REFERENCES pu (pu_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pu_details
    ADD CONSTRAINT FK_PRODUCTS_PU_DETAILS FOREIGN KEY (prod_code) REFERENCES products (prod_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pu
    ADD CONSTRAINT FK_DEPT_MST_仕入データ FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pu_details
    ADD CONSTRAINT FK_WH_MST_PU_DETAILS FOREIGN KEY (wh_code) REFERENCES wh_mst (wh_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pay
    ADD CONSTRAINT FK_SUPPLIER_MST_PAY FOREIGN KEY (sup_code, sup_sub_no) REFERENCES supplier_mst (sup_code, sup_sub_no) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE pay
    ADD CONSTRAINT FK_DEPT_MST_PAY FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE credit_balance
    ADD CONSTRAINT FK_COMPANYS_MST_CREDIT_BALANC FOREIGN KEY (comp_code) REFERENCES companys_mst (comp_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE credit
    ADD CONSTRAINT FK_DEPT_MST_CREDIT FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE bank_acut_mst
    ADD CONSTRAINT FK_DEPT_MST_入金口座マスタ FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE destinations_mst
    ADD CONSTRAINT FK_地域マスタ_DESTINATIONS_MST FOREIGN KEY (area_code) REFERENCES area_mst (area_code) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE orders
    ADD CONSTRAINT FK_DEPT_MST_ORDERS FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE sales
    ADD CONSTRAINT FK_DEPT_MST_SALES FOREIGN KEY (dept_code, start_date) REFERENCES dept_mst (dept_code, start_date) ON UPDATE NO ACTION ON DELETE NO ACTION
;
-- CREATE OR REPLACE VIEW products_v2
--     (PROD_CODE,PROD_FULLNAME,PROD_NAME,PROD_KANA,PROD_TYPE,SERIAL_NO,UNITPRICE,
--     PO_PRICE,COST,TAX_TYPE,PROD_CATE_NAME,LAYER)
-- AS
-- SELECT
--     A.PROD_CODE PROD_CODE,
--     A.PROD_FULLNAME PROD_FULLNAME,
--     A.PROD_NAME PROD_NAME,
--     A.PROD_KANA PROD_KANA,
--     A.PROD_TYPE PROD_TYPE,
--     A.SERIAL_NO SERIAL_NO,
--     A.UNITPRICE UNITPRICE,
--     A.PO_PRICE PO_PRICE,
--     A.prime_cost COST,
--     A.TAX_TYPE TAX_TYPE,
--     B.PROD_CATE_NAME PROD_CATE_NAME,
--     B.category_layer LAYER
-- FROM PRODUCTS A, PRODUCT_CATEGORY B
-- WHERE A.CATEGORY_CODE = B.CATEGORY_CODE
-- ;
-- COMMENT ON VIEW products_v2 IS '商品ビュー'
-- ;
-- COMMENT ON COLUMN products_v2.PROD_CODE IS '商品コード'
-- ;
-- COMMENT ON COLUMN products_v2.PROD_FULLNAME IS '商品正式名'
-- ;
-- COMMENT ON COLUMN products_v2.PROD_NAME IS '商品名'
-- ;
-- COMMENT ON COLUMN products_v2.PROD_KANA IS '商品名カナ'
-- ;
-- COMMENT ON COLUMN products_v2.PROD_TYPE IS '商品区分,1:商品 2:製品 3:原材料 4:間接材'
-- ;
-- COMMENT ON COLUMN products_v2.SERIAL_NO IS '製品型番'
-- ;
-- COMMENT ON COLUMN products_v2.UNITPRICE IS '販売単価'
-- ;
-- COMMENT ON COLUMN products_v2.PO_PRICE IS '仕入単価'
-- ;
-- COMMENT ON COLUMN products_v2.COST IS '売上原価'
-- ;
-- COMMENT ON COLUMN products_v2.TAX_TYPE IS '税区分,1:外税 2:内税'
-- ;
-- COMMENT ON COLUMN products_v2.PROD_CATE_NAME IS '商品分類名'
-- ;
-- COMMENT ON COLUMN products_v2.LAYER IS '階層'
-- ;
