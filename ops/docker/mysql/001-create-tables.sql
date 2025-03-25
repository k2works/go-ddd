CREATE TABLE consumer
(
    consumer_code   VARCHAR(16)                        NOT NULL,
    last_name       VARCHAR(20)                        NOT NULL,
    first_name      VARCHAR(20)                        NOT NULL,
    last_name_kana  VARCHAR(40)                        NOT NULL,
    first_name_kana VARCHAR(40)                        NOT NULL,
    login_id        VARCHAR(256)                       NOT NULL,
    email           VARCHAR(256)                       NOT NULL,
    pwd             VARCHAR(16)                        NOT NULL,
    birth_date      DATETIME                           NOT NULL,
    sex             INT(1) NOT NULL,
    login_datetime  DATETIME,
    rest_point      INT(8),
    withdrawal_date DATETIME,
    create_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator         VARCHAR(12),
    update_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE consumer
    ADD CONSTRAINT PRIMARY KEY (consumer_code)
;
ALTER TABLE consumer COMMENT = '個人客,顧客'
;
ALTER TABLE consumer MODIFY consumer_code VARCHAR (16) NOT NULL COMMENT '個人客コード'
;
ALTER TABLE consumer MODIFY last_name VARCHAR (20) NOT NULL COMMENT '姓'
;
ALTER TABLE consumer MODIFY first_name VARCHAR (20) NOT NULL COMMENT '名'
;
ALTER TABLE consumer MODIFY last_name_kana VARCHAR (40) NOT NULL COMMENT '姓カナ'
;
ALTER TABLE consumer MODIFY first_name_kana VARCHAR (40) NOT NULL COMMENT '名カナ'
;
ALTER TABLE consumer MODIFY login_id VARCHAR (256) NOT NULL COMMENT 'ログインid'
;
ALTER TABLE consumer MODIFY email VARCHAR (256) NOT NULL COMMENT 'メールアドレス'
;
ALTER TABLE consumer MODIFY pwd VARCHAR (16) NOT NULL COMMENT 'パスワード'
;
ALTER TABLE consumer MODIFY birth_date DATETIME NOT NULL COMMENT '生年月日'
;
ALTER TABLE consumer MODIFY sex INT (1) NOT NULL COMMENT '性別'
;
ALTER TABLE consumer MODIFY login_datetime DATETIME COMMENT 'ログイン日時'
;
ALTER TABLE consumer MODIFY rest_point INT (8) COMMENT 'ポイント残高'
;
ALTER TABLE consumer MODIFY withdrawal_date DATETIME COMMENT '退会日'
;
ALTER TABLE consumer MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE consumer MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE consumer MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE consumer MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
#
CREATE INDEX CUSTOMER_IX4
    # ON CUSTOMER ("LAST_NAME"||"FIRST_NAME", "LAST_NAME_KANA"||"FIRST_NAME_KANA")
    # TABLESPACE TS_CUSTOMER_I01
    # /
;
CREATE TABLE customers_mst
(
    cust_code          VARCHAR(8)                         NOT NULL,
    cust_sub_no        INT(2) NOT NULL,
    cust_type          INT(1) DEFAULT 0,
    ar_code            VARCHAR(8)                         NOT NULL,
    ar_sub_no          INT(2),
    payer_code         VARCHAR(8)                         NOT NULL,
    payer_sub_no       INT(2),
    cust_name          VARCHAR(40)                        NOT NULL,
    cust_kana          VARCHAR(40),
    emp_code           VARCHAR(10)                        NOT NULL,
    cust_user_name     VARCHAR(20),
    cust_user_dep_name VARCHAR(40),
    cust_zip_code      CHAR(8),
    cust_state         VARCHAR(4),
    cust_address1      VARCHAR(40),
    cust_address2      VARCHAR(40),
    cust_tel           VARCHAR(13),
    cust_fax           VARCHAR(13),
    cust_email         VARCHAR(100),
    cust_ar_flag       INT(1),
    cust_close_date1   INT(2) NOT NULL,
    cust_pay_months1   INT(1) DEFAULT 1,
    cust_pay_dates1    INT(1),
    cust_pay_method1   INT(1) DEFAULT 1,
    cust_close_date2   INT(2) NOT NULL,
    cust_pay_months2   INT(1) DEFAULT 1,
    cust_pay_dates2    INT(1),
    cust_pay_method2   INT(1) DEFAULT 1,
    create_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator            VARCHAR(12),
    update_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE customers_mst
    ADD CONSTRAINT PRIMARY KEY (cust_code, cust_sub_no)
;
ALTER TABLE customers_mst COMMENT = '顧客マスタ'
;
ALTER TABLE customers_mst MODIFY cust_code VARCHAR (8) NOT NULL COMMENT '顧客コード'
;
ALTER TABLE customers_mst MODIFY cust_sub_no INT (2) NOT NULL COMMENT '顧客枝番'
;
ALTER TABLE customers_mst MODIFY cust_type INT (1) DEFAULT 0 COMMENT '顧客区分'
;
ALTER TABLE customers_mst MODIFY ar_code VARCHAR (8) NOT NULL COMMENT '請求先コード'
;
ALTER TABLE customers_mst MODIFY ar_sub_no INT (2) COMMENT '請求先枝番'
;
ALTER TABLE customers_mst MODIFY payer_code VARCHAR (8) NOT NULL COMMENT '回収先コード'
;
ALTER TABLE customers_mst MODIFY payer_sub_no INT (2) COMMENT '回収先枝番'
;
ALTER TABLE customers_mst MODIFY cust_name VARCHAR (40) NOT NULL COMMENT '顧客名'
;
ALTER TABLE customers_mst MODIFY cust_kana VARCHAR (40) COMMENT '顧客名カナ'
;
ALTER TABLE customers_mst MODIFY emp_code VARCHAR (10) NOT NULL COMMENT '自社担当者コード'
;
ALTER TABLE customers_mst MODIFY cust_user_name VARCHAR (20) COMMENT '顧客担当者名'
;
ALTER TABLE customers_mst MODIFY cust_user_dep_name VARCHAR (40) COMMENT '顧客部門名'
;
ALTER TABLE customers_mst MODIFY cust_zip_code CHAR (8) COMMENT '顧客郵便番号'
;
ALTER TABLE customers_mst MODIFY cust_state VARCHAR (4) COMMENT '顧客都道府県'
;
ALTER TABLE customers_mst MODIFY cust_address1 VARCHAR (40) COMMENT '顧客住所１'
;
ALTER TABLE customers_mst MODIFY cust_address2 VARCHAR (40) COMMENT '顧客住所２'
;
ALTER TABLE customers_mst MODIFY cust_tel VARCHAR (13) COMMENT '顧客電話番号'
;
ALTER TABLE customers_mst MODIFY cust_fax VARCHAR (13) COMMENT '顧客fax番号'
;
ALTER TABLE customers_mst MODIFY cust_email VARCHAR (100) COMMENT '顧客メールアドレス'
;
ALTER TABLE customers_mst MODIFY cust_ar_flag INT (1) COMMENT '顧客請求区分,1:都度請求,2:締請求'
;
ALTER TABLE customers_mst MODIFY cust_close_date1 INT (2) NOT NULL COMMENT '顧客締日１,15:15日締め'
;
ALTER TABLE customers_mst MODIFY cust_pay_months1 INT (1) DEFAULT 1 COMMENT '顧客支払月１,0:当月,1:翌月,2:翌々月'
;
ALTER TABLE customers_mst MODIFY cust_pay_dates1 INT (1) COMMENT '顧客支払日１,10:10日払い,99：末日'
;
ALTER TABLE customers_mst MODIFY cust_pay_method1 INT (1) DEFAULT 1 COMMENT '顧客支払方法１,1:振込,2:手形'
;
ALTER TABLE customers_mst MODIFY cust_close_date2 INT (2) NOT NULL COMMENT '顧客締日２,99:末締め'
;
ALTER TABLE customers_mst MODIFY cust_pay_months2 INT (1) DEFAULT 1 COMMENT '顧客支払月２,0:当月,1:翌月,2:翌々月'
;
ALTER TABLE customers_mst MODIFY cust_pay_dates2 INT (1) COMMENT '顧客支払日２,10:10日払い,99：末日'
;
ALTER TABLE customers_mst MODIFY cust_pay_method2 INT (1) DEFAULT 1 COMMENT '顧客支払方法２,1:振込,2:手形'
;
ALTER TABLE customers_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE customers_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE customers_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE customers_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE pricebycustomer
(
    prod_code   VARCHAR(16)                        NOT NULL,
    comp_code   VARCHAR(8)                         NOT NULL,
    unitprice   INT(8) DEFAULT 0 NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE pricebycustomer
    ADD CONSTRAINT PRIMARY KEY (prod_code, comp_code)
;
ALTER TABLE pricebycustomer COMMENT = '顧客別販売単価'
;
ALTER TABLE pricebycustomer MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE pricebycustomer MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE pricebycustomer MODIFY unitprice INT (8) NOT NULL DEFAULT 0 COMMENT '販売単価'
;
ALTER TABLE pricebycustomer MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE pricebycustomer MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE pricebycustomer MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE pricebycustomer MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE stock
(
    wh_code            VARCHAR(3)                           NOT NULL,
    prod_code          VARCHAR(16)                          NOT NULL,
    rot_no             VARCHAR(20)                          NOT NULL,
    stock_type         VARCHAR(1) DEFAULT '1'               NOT NULL,
    quality_type       VARCHAR(1) DEFAULT 'G'               NOT NULL,
    actual             INT(4) DEFAULT 1 NOT NULL,
    valid              INT(4) DEFAULT 1 NOT NULL,
    last_delivery_date DATETIME,
    create_date        DATETIME   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator            VARCHAR(12),
    update_date        DATETIME   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE stock
    ADD CONSTRAINT PRIMARY KEY (wh_code, prod_code, rot_no, stock_type, quality_type)
;
ALTER TABLE stock COMMENT = '在庫データ'
;
ALTER TABLE stock MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE stock MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE stock MODIFY rot_no VARCHAR (20) NOT NULL COMMENT 'ロット番号'
;
ALTER TABLE stock MODIFY stock_type VARCHAR (1) NOT NULL DEFAULT '1' COMMENT '在庫区分,1:自社在庫 2:預り在庫'
;
ALTER TABLE stock MODIFY quality_type VARCHAR (1) NOT NULL DEFAULT 'G' COMMENT '良品区分,G:良品 F:不良品 U:未検品'
;
ALTER TABLE stock MODIFY actual INT (4) NOT NULL DEFAULT 1 COMMENT '実在庫数'
;
ALTER TABLE stock MODIFY valid INT (4) NOT NULL DEFAULT 1 COMMENT '有効在庫数'
;
ALTER TABLE stock MODIFY last_delivery_date DATETIME COMMENT '最終出荷日'
;
ALTER TABLE stock MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE stock MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE stock MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE stock MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE pu
(
    pu_no        VARCHAR(10)                        NOT NULL,
    pu_date      DATETIME DEFAULT CURRENT_TIMESTAMP,
    sup_code     VARCHAR(8)                         NOT NULL,
    sup_sub_no   INT(2),
    emp_code     VARCHAR(10)                        NOT NULL,
    start_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    po_no        VARCHAR(10),
    dept_code    VARCHAR(6)                         NOT NULL,
    pu_ammount   INT(10),
    cmp_tax      INT(10) DEFAULT 0 NOT NULL,
    slip_comment VARCHAR(1000),
    create_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator      VARCHAR(12),
    update_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      VARCHAR(12)
)
;
ALTER TABLE pu
    ADD CONSTRAINT PRIMARY KEY (pu_no)
;
ALTER TABLE pu COMMENT = '仕入データ'
;
ALTER TABLE pu MODIFY pu_no VARCHAR (10) NOT NULL COMMENT '仕入番号'
;
ALTER TABLE pu MODIFY pu_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '仕入日'
;
ALTER TABLE pu MODIFY sup_code VARCHAR (8) NOT NULL COMMENT '仕入先コード'
;
ALTER TABLE pu MODIFY sup_sub_no INT (2) COMMENT '仕入先枝番'
;
ALTER TABLE pu MODIFY emp_code VARCHAR (10) NOT NULL COMMENT '仕入担当者コード'
;
ALTER TABLE pu MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '開始日'
;
ALTER TABLE pu MODIFY po_no VARCHAR (10) COMMENT '発注番号'
;
ALTER TABLE pu MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE pu MODIFY pu_ammount INT (10) COMMENT '仕入金額合計'
;
ALTER TABLE pu MODIFY cmp_tax INT (10) NOT NULL DEFAULT 0 COMMENT '消費税金額'
;
ALTER TABLE pu MODIFY slip_comment VARCHAR (1000) COMMENT '備考'
;
ALTER TABLE pu MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE pu MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE pu MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE pu MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE pu_details
(
    pu_no         VARCHAR(10)                        NOT NULL,
    pu_row_no     INT(3) NOT NULL,
    pu_row_dsp_no INT(3) NOT NULL,
    po_row_no     INT(3) NOT NULL,
    prod_code     VARCHAR(16)                        NOT NULL,
    wh_code       VARCHAR(3)                         NOT NULL,
    prod_name     VARCHAR(10)                        NOT NULL,
    po_price      INT(8) DEFAULT 0,
    pu_quantity   INT(4) DEFAULT 1 NOT NULL,
    create_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator       VARCHAR(12),
    update_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE pu_details
    ADD CONSTRAINT PRIMARY KEY (pu_row_no, pu_no)
;
ALTER TABLE pu_details COMMENT = '仕入データ明細'
;
ALTER TABLE pu_details MODIFY pu_no VARCHAR (10) NOT NULL COMMENT '仕入番号'
;
ALTER TABLE pu_details MODIFY pu_row_no INT (3) NOT NULL COMMENT '仕入行番号'
;
ALTER TABLE pu_details MODIFY pu_row_dsp_no INT (3) NOT NULL COMMENT '仕入行表示番号'
;
ALTER TABLE pu_details MODIFY po_row_no INT (3) NOT NULL COMMENT '発注行番号'
;
ALTER TABLE pu_details MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE pu_details MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE pu_details MODIFY prod_name VARCHAR (10) NOT NULL COMMENT '商品名'
;
ALTER TABLE pu_details MODIFY po_price INT (8) DEFAULT 0 COMMENT '仕入単価'
;
ALTER TABLE pu_details MODIFY pu_quantity INT (4) NOT NULL DEFAULT 1 COMMENT '仕入数量'
;
ALTER TABLE pu_details MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE pu_details MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE pu_details MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE pu_details MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE supplier_mst
(
    sup_code        VARCHAR(8)                         NOT NULL,
    sup_sub_no      INT(2) NOT NULL,
    sup_name        VARCHAR(40)                        NOT NULL,
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
    sup_close_date  INT(2) NOT NULL,
    sup_pay_months  INT(1) DEFAULT 1,
    sup_pay_dates   INT(1),
    pay_method_type INT(1) DEFAULT 1,
    create_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator         VARCHAR(12),
    update_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE supplier_mst
    ADD CONSTRAINT PRIMARY KEY (sup_code, sup_sub_no)
;
ALTER TABLE supplier_mst COMMENT = '仕入先マスタ'
;
ALTER TABLE supplier_mst MODIFY sup_code VARCHAR (8) NOT NULL COMMENT '仕入先コード'
;
ALTER TABLE supplier_mst MODIFY sup_sub_no INT (2) NOT NULL COMMENT '仕入先枝番'
;
ALTER TABLE supplier_mst MODIFY sup_name VARCHAR (40) NOT NULL COMMENT '仕入先名'
;
ALTER TABLE supplier_mst MODIFY sup_kana VARCHAR (40) COMMENT '仕入先名カナ'
;
ALTER TABLE supplier_mst MODIFY sup_emp_name VARCHAR (20) COMMENT '仕入先担当者名'
;
ALTER TABLE supplier_mst MODIFY sup_dep_name VARCHAR (40) COMMENT '仕入先部門名'
;
ALTER TABLE supplier_mst MODIFY sup_zip_code CHAR (8) COMMENT '仕入先郵便番号'
;
ALTER TABLE supplier_mst MODIFY sup_state VARCHAR (4) COMMENT '仕入先都道府県'
;
ALTER TABLE supplier_mst MODIFY sup_address1 VARCHAR (40) COMMENT '仕入先住所１'
;
ALTER TABLE supplier_mst MODIFY sup_address2 VARCHAR (40) COMMENT '仕入先住所２'
;
ALTER TABLE supplier_mst MODIFY sup_tel VARCHAR (13) COMMENT '仕入先電話番号'
;
ALTER TABLE supplier_mst MODIFY sup_fax VARCHAR (13) COMMENT '仕入先fax番号'
;
ALTER TABLE supplier_mst MODIFY sup_email VARCHAR (100) COMMENT '仕入先メールアドレス'
;
ALTER TABLE supplier_mst MODIFY sup_close_date INT (2) NOT NULL COMMENT '仕入先締日,15:15日締め'
;
ALTER TABLE supplier_mst MODIFY sup_pay_months INT (1) DEFAULT 1 COMMENT '仕入先支払月,0:当月,1:翌月,2:翌々月'
;
ALTER TABLE supplier_mst MODIFY sup_pay_dates INT (1) COMMENT '仕入先支払日,10:10日払い,99：末日'
;
ALTER TABLE supplier_mst MODIFY pay_method_type INT (1) DEFAULT 1 COMMENT '支払方法区分,1:振込,2:手形'
;
ALTER TABLE supplier_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE supplier_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE supplier_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE supplier_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE pay
(
    pay_no          VARCHAR(10)                        NOT NULL,
    pay_date        INT(1),
    dept_code       VARCHAR(6)                         NOT NULL,
    start_date      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sup_code        VARCHAR(8)                         NOT NULL,
    sup_sub_no      INT(2),
    pay_method_type INT(1) DEFAULT 1,
    pay_amnt        INT(13),
    cmp_tax         INT(10) DEFAULT 0 NOT NULL,
    complete_flg    INT(1) DEFAULT 0 NOT NULL,
    create_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator         VARCHAR(12),
    update_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE pay
    ADD CONSTRAINT PRIMARY KEY (pay_no)
;
ALTER TABLE pay COMMENT = '支払データ'
;
ALTER TABLE pay MODIFY pay_no VARCHAR (10) NOT NULL COMMENT '支払番号'
;
ALTER TABLE pay MODIFY pay_date INT (1) COMMENT '支払日,10:10日払い,99：末日'
;
ALTER TABLE pay MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE pay MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '部門開始日'
;
ALTER TABLE pay MODIFY sup_code VARCHAR (8) NOT NULL COMMENT '仕入先コード'
;
ALTER TABLE pay MODIFY sup_sub_no INT (2) COMMENT '仕入先枝番'
;
ALTER TABLE pay MODIFY pay_method_type INT (1) DEFAULT 1 COMMENT '支払方法区分,1:振込,2:手形'
;
ALTER TABLE pay MODIFY pay_amnt INT (13) COMMENT '支払金額'
;
ALTER TABLE pay MODIFY cmp_tax INT (10) NOT NULL DEFAULT 0 COMMENT '消費税金額'
;
ALTER TABLE pay MODIFY complete_flg INT (1) NOT NULL DEFAULT 0 COMMENT '支払完了フラグ,0:未完了, 1:完了'
;
ALTER TABLE pay MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE pay MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE pay MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE pay MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE auto_number
(
    slip_type    VARCHAR(2) NOT NULL,
    yearmonth    DATETIME   NOT NULL,
    last_silp_no INT(4) DEFAULT 0 NOT NULL
)
;
ALTER TABLE auto_number
    ADD PRIMARY KEY (slip_type, yearmonth)
;
ALTER TABLE auto_number COMMENT = '自動採番マスタ'
;
ALTER TABLE auto_number MODIFY slip_type VARCHAR (2) NOT NULL COMMENT '伝票種別コード'
;
ALTER TABLE auto_number MODIFY yearmonth DATETIME NOT NULL COMMENT '年月'
;
ALTER TABLE auto_number MODIFY last_silp_no INT (4) NOT NULL DEFAULT 0 COMMENT '最終伝票番号'
;
CREATE TABLE employee
(
    emp_code       VARCHAR(10)                        NOT NULL,
    emp_name       VARCHAR(20),
    emp_kana       VARCHAR(40),
    login_password VARCHAR(8),
    tel            VARCHAR(13),
    fax            VARCHAR(13),
    dept_code      VARCHAR(6)                         NOT NULL,
    start_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    occu_code      VARCHAR(2)                         NOT NULL,
    approval_code  VARCHAR(2)                         NOT NULL,
    create_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator        VARCHAR(12),
    update_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE employee
    ADD CONSTRAINT PRIMARY KEY (emp_code)
;
ALTER TABLE employee COMMENT = '社員マスタ'
;
ALTER TABLE employee MODIFY emp_code VARCHAR (10) NOT NULL COMMENT '社員コード'
;
ALTER TABLE employee MODIFY emp_name VARCHAR (20) COMMENT '社員名'
;
ALTER TABLE employee MODIFY emp_kana VARCHAR (40) COMMENT '社員名カナ'
;
ALTER TABLE employee MODIFY login_password VARCHAR (8) COMMENT 'パスワード'
;
ALTER TABLE employee MODIFY tel VARCHAR (13) COMMENT '電話番号'
;
ALTER TABLE employee MODIFY fax VARCHAR (13) COMMENT 'fax番号'
;
ALTER TABLE employee MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE employee MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '開始日'
;
ALTER TABLE employee MODIFY occu_code VARCHAR (2) NOT NULL COMMENT '職種コード'
;
ALTER TABLE employee MODIFY approval_code VARCHAR (2) NOT NULL COMMENT '承認権限コード'
;
ALTER TABLE employee MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE employee MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE employee MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE employee MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE company_group_mst
(
    comp_group_code VARCHAR(4)                         NOT NULL,
    group_name      VARCHAR(40),
    create_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator         VARCHAR(12),
    update_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE company_group_mst
    ADD CONSTRAINT PRIMARY KEY (comp_group_code)
;
ALTER TABLE company_group_mst COMMENT = '取引先グループマスタ'
;
ALTER TABLE company_group_mst MODIFY comp_group_code VARCHAR (4) NOT NULL COMMENT '取引先グループコード'
;
ALTER TABLE company_group_mst MODIFY group_name VARCHAR (40) COMMENT '取引先グループ名'
;
ALTER TABLE company_group_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE company_group_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE company_group_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE company_group_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE companys_mst
(
    comp_code       VARCHAR(8)                         NOT NULL,
    comp_name       VARCHAR(40)                        NOT NULL,
    comp_kana       VARCHAR(40),
    sup_type        INT(1) DEFAULT 0,
    zip_code        CHAR(8),
    state           VARCHAR(4),
    address1        VARCHAR(40),
    address2        VARCHAR(40),
    no_sales_flg    INT(1) DEFAULT 0,
    wide_use_type   INT(1),
    comp_group_code VARCHAR(4)                         NOT NULL,
    max_credit      INT(10),
    temp_credit_up  INT(10) DEFAULT 0,
    create_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator         VARCHAR(12),
    update_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         VARCHAR(12)
)
;
ALTER TABLE companys_mst
    ADD CONSTRAINT PRIMARY KEY (comp_code)
;
ALTER TABLE companys_mst COMMENT = '取引先マスタ'
;
ALTER TABLE companys_mst MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE companys_mst MODIFY comp_name VARCHAR (40) NOT NULL COMMENT '取引先名'
;
ALTER TABLE companys_mst MODIFY comp_kana VARCHAR (40) COMMENT '取引先名カナ'
;
ALTER TABLE companys_mst MODIFY sup_type INT (1) DEFAULT 0 COMMENT '仕入先区分'
;
ALTER TABLE companys_mst MODIFY zip_code CHAR (8) COMMENT '郵便番号'
;
ALTER TABLE companys_mst MODIFY state VARCHAR (4) COMMENT '都道府県'
;
ALTER TABLE companys_mst MODIFY address1 VARCHAR (40) COMMENT '住所１'
;
ALTER TABLE companys_mst MODIFY address2 VARCHAR (40) COMMENT '住所２'
;
ALTER TABLE companys_mst MODIFY no_sales_flg INT (1) DEFAULT 0 COMMENT '取引禁止フラグ'
;
ALTER TABLE companys_mst MODIFY wide_use_type INT (1) COMMENT '雑区分'
;
ALTER TABLE companys_mst MODIFY comp_group_code VARCHAR (4) NOT NULL COMMENT '取引先グループコード'
;
ALTER TABLE companys_mst MODIFY max_credit INT (10) COMMENT '与信限度額'
;
ALTER TABLE companys_mst MODIFY temp_credit_up INT (10) DEFAULT 0 COMMENT '与信一時増加枠'
;
ALTER TABLE companys_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE companys_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE companys_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE companys_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE company_category
(
    category_type  VARCHAR(2)                         NOT NULL,
    comp_cate_code VARCHAR(8)                         NOT NULL,
    comp_cate_name VARCHAR(30),
    create_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator        VARCHAR(12),
    update_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE company_category
    ADD CONSTRAINT PRIMARY KEY (comp_cate_code, category_type)
;
ALTER TABLE company_category COMMENT = '取引先分類マスタ'
;
ALTER TABLE company_category MODIFY category_type VARCHAR (2) NOT NULL COMMENT '取引先分類種別コード'
;
ALTER TABLE company_category MODIFY comp_cate_code VARCHAR (8) NOT NULL COMMENT '取引先分類コード'
;
ALTER TABLE company_category MODIFY comp_cate_name VARCHAR (30) COMMENT '取引先分類名'
;
ALTER TABLE company_category MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE company_category MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE company_category MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE company_category MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE category_type
(
    category_type_code VARCHAR(2)                         NOT NULL,
    cate_type_name     VARCHAR(20),
    create_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator            VARCHAR(12),
    update_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE category_type
    ADD CONSTRAINT PRIMARY KEY (category_type_code)
;
ALTER TABLE category_type COMMENT = '取引先分類種別マスタ'
;
ALTER TABLE category_type MODIFY category_type_code VARCHAR (2) NOT NULL COMMENT '取引先分類種別コード'
;
ALTER TABLE category_type MODIFY cate_type_name VARCHAR (20) COMMENT '取引先分類種別名'
;
ALTER TABLE category_type MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE category_type MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE category_type MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE category_type MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE company_category_group
(
    category_type  VARCHAR(2)                         NOT NULL,
    comp_cate_code VARCHAR(8)                         NOT NULL,
    comp_code      VARCHAR(8)                         NOT NULL,
    create_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator        VARCHAR(12),
    update_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE company_category_group
    ADD CONSTRAINT PRIMARY KEY (category_type, comp_code, comp_cate_code)
;
ALTER TABLE company_category_group COMMENT = '取引先分類所属マスタ'
;
ALTER TABLE company_category_group MODIFY category_type VARCHAR (2) NOT NULL COMMENT '取引先分類種別コード'
;
ALTER TABLE company_category_group MODIFY comp_cate_code VARCHAR (8) NOT NULL COMMENT '取引先分類コード'
;
ALTER TABLE company_category_group MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE company_category_group MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE company_category_group MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE company_category_group MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE company_category_group MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE orders
(
    order_no      VARCHAR(10)                        NOT NULL,
    order_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dept_code     VARCHAR(6)                         NOT NULL,
    start_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cust_code     VARCHAR(8)                         NOT NULL,
    cust_sub_no   INT(2),
    emp_code      VARCHAR(10)                        NOT NULL,
    required_date DATETIME,
    custorder_no  VARCHAR(20),
    wh_code       VARCHAR(3)                         NOT NULL,
    order_amnt    INT(10) DEFAULT 0 NOT NULL,
    cmp_tax       INT(10) DEFAULT 0 NOT NULL,
    slip_comment  VARCHAR(1000),
    create_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator       VARCHAR(12),
    update_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE orders
    ADD CONSTRAINT PRIMARY KEY (order_no)
;
ALTER TABLE orders COMMENT = '受注データ'
;
ALTER TABLE orders MODIFY order_no VARCHAR (10) NOT NULL COMMENT '受注番号'
;
ALTER TABLE orders MODIFY order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '受注日'
;
ALTER TABLE orders MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE orders MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '部門開始日'
;
ALTER TABLE orders MODIFY cust_code VARCHAR (8) NOT NULL COMMENT '顧客コード'
;
ALTER TABLE orders MODIFY cust_sub_no INT (2) COMMENT '顧客枝番'
;
ALTER TABLE orders MODIFY emp_code VARCHAR (10) NOT NULL COMMENT '社員コード'
;
ALTER TABLE orders MODIFY required_date DATETIME COMMENT '希望納期'
;
ALTER TABLE orders MODIFY custorder_no VARCHAR (20) COMMENT '客先注文番号'
;
ALTER TABLE orders MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE orders MODIFY order_amnt INT (10) NOT NULL DEFAULT 0 COMMENT '受注金額合計'
;
ALTER TABLE orders MODIFY cmp_tax INT (10) NOT NULL DEFAULT 0 COMMENT '消費税金額'
;
ALTER TABLE orders MODIFY slip_comment VARCHAR (1000) COMMENT '備考'
;
ALTER TABLE orders MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE orders MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE orders MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE orders MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE order_details
(
    order_no           VARCHAR(10)                        NOT NULL,
    so_row_no          INT(3) NOT NULL,
    prod_code          VARCHAR(16)                        NOT NULL,
    prod_name          VARCHAR(10)                        NOT NULL,
    unitprice          INT(8) DEFAULT 0 NOT NULL,
    quantity           INT(4) DEFAULT 1 NOT NULL,
    cmp_tax_rate       INT(3),
    reserve_qty        INT(4) DEFAULT 0,
    delivery_order_qty INT(4) DEFAULT 0,
    delivered_qty      INT(4) DEFAULT 0,
    complete_flg       INT(1) DEFAULT 0 NOT NULL,
    discount           INT(4) DEFAULT 0 NOT NULL,
    delivery_date      DATETIME,
    create_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator            VARCHAR(12),
    update_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE order_details
    ADD CONSTRAINT PRIMARY KEY (order_no, so_row_no)
;
ALTER TABLE order_details COMMENT = '受注データ明細'
;
ALTER TABLE order_details MODIFY order_no VARCHAR (10) NOT NULL COMMENT '受注番号'
;
ALTER TABLE order_details MODIFY so_row_no INT (3) NOT NULL COMMENT '受注行番号'
;
ALTER TABLE order_details MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE order_details MODIFY prod_name VARCHAR (10) NOT NULL COMMENT '商品名'
;
ALTER TABLE order_details MODIFY unitprice INT (8) NOT NULL DEFAULT 0 COMMENT '販売単価'
;
ALTER TABLE order_details MODIFY quantity INT (4) NOT NULL DEFAULT 1 COMMENT '受注数量'
;
ALTER TABLE order_details MODIFY cmp_tax_rate INT (3) COMMENT '消費税率'
;
ALTER TABLE order_details MODIFY reserve_qty INT (4) DEFAULT 0 COMMENT '引当数量'
;
ALTER TABLE order_details MODIFY delivery_order_qty INT (4) DEFAULT 0 COMMENT '出荷指示数量'
;
ALTER TABLE order_details MODIFY delivered_qty INT (4) DEFAULT 0 COMMENT '出荷済数量'
;
ALTER TABLE order_details MODIFY complete_flg INT (1) NOT NULL DEFAULT 0 COMMENT '完了フラグ,0:未完了, 1:完了'
;
ALTER TABLE order_details MODIFY discount INT (4) NOT NULL DEFAULT 0 COMMENT '値引金額'
;
ALTER TABLE order_details MODIFY delivery_date DATETIME COMMENT '納期'
;
ALTER TABLE order_details MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE order_details MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE order_details MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE order_details MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE destinations_mst
(
    comp_code   VARCHAR(8)                         NOT NULL,
    comp_sub_no INT(2) NOT NULL,
    dist_no     INT(2) NOT NULL,
    dist_name   VARCHAR(40)                        NOT NULL,
    area_code   VARCHAR(10)                        NOT NULL,
    zip_code    CHAR(8),
    address1    VARCHAR(40),
    address2    VARCHAR(40),
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE destinations_mst
    ADD CONSTRAINT PRIMARY KEY (comp_code, dist_no, comp_sub_no)
;
ALTER TABLE destinations_mst COMMENT = '出荷先マスタ'
;
ALTER TABLE destinations_mst MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE destinations_mst MODIFY comp_sub_no INT (2) NOT NULL COMMENT '顧客枝番'
;
ALTER TABLE destinations_mst MODIFY dist_no INT (2) NOT NULL COMMENT '出荷先番号'
;
ALTER TABLE destinations_mst MODIFY dist_name VARCHAR (40) NOT NULL COMMENT '出荷先名'
;
ALTER TABLE destinations_mst MODIFY area_code VARCHAR (10) NOT NULL COMMENT '地域コード'
;
ALTER TABLE destinations_mst MODIFY zip_code CHAR (8) COMMENT '出荷先郵便番号'
;
ALTER TABLE destinations_mst MODIFY address1 VARCHAR (40) COMMENT '出荷先住所１'
;
ALTER TABLE destinations_mst MODIFY address2 VARCHAR (40) COMMENT '出荷先住所２'
;
ALTER TABLE destinations_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE destinations_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE destinations_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE destinations_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE products
(
    prod_code          VARCHAR(16)                        NOT NULL,
    prod_fullname      VARCHAR(40)                        NOT NULL,
    prod_name          VARCHAR(10)                        NOT NULL,
    prod_kana          VARCHAR(20)                        NOT NULL,
    prod_type          VARCHAR(1),
    serial_no          VARCHAR(40),
    unitprice          INT(8) DEFAULT 0 NOT NULL,
    po_price           INT(8) DEFAULT 0,
    prime_cost         INT(8) DEFAULT 0 NOT NULL,
    tax_type           INT(1) DEFAULT 1 NOT NULL,
    category_code      VARCHAR(8),
    wide_use_type      INT(1),
    stock_manage_type  INT(1) DEFAULT 1,
    stock_reserve_type INT(1),
    sup_code           VARCHAR(8)                         NOT NULL,
    sup_sub_no         INT(2),
    create_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator            VARCHAR(12),
    update_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE products
    ADD CONSTRAINT PRIMARY KEY (prod_code)
;
ALTER TABLE products COMMENT = '商品マスタ'
;
ALTER TABLE products MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE products MODIFY prod_fullname VARCHAR (40) NOT NULL COMMENT '商品正式名'
;
ALTER TABLE products MODIFY prod_name VARCHAR (10) NOT NULL COMMENT '商品名'
;
ALTER TABLE products MODIFY prod_kana VARCHAR (20) NOT NULL COMMENT '商品名カナ'
;
ALTER TABLE products MODIFY prod_type VARCHAR (1) COMMENT '商品区分,1:商品 2:製品 3:原材料 4:間接材'
;
ALTER TABLE products MODIFY serial_no VARCHAR (40) COMMENT '製品型番'
;
ALTER TABLE products MODIFY unitprice INT (8) NOT NULL DEFAULT 0 COMMENT '販売単価'
;
ALTER TABLE products MODIFY po_price INT (8) DEFAULT 0 COMMENT '仕入単価'
;
ALTER TABLE products MODIFY prime_cost INT (8) NOT NULL DEFAULT 0 COMMENT '売上原価'
;
ALTER TABLE products MODIFY tax_type INT (1) NOT NULL DEFAULT 1 COMMENT '税区分,1:外税 2:内税'
;
ALTER TABLE products MODIFY category_code VARCHAR (8) COMMENT '商品分類コード'
;
ALTER TABLE products MODIFY wide_use_type INT (1) COMMENT '雑区分'
;
ALTER TABLE products MODIFY stock_manage_type INT (1) DEFAULT 1 COMMENT '在庫管理対象区分,0:対象外 1:在庫管理対象'
;
ALTER TABLE products MODIFY stock_reserve_type INT (1) COMMENT '在庫引当区分,0:対象外 1:即時 2:まとめ 3:手配品'
;
ALTER TABLE products MODIFY sup_code VARCHAR (8) NOT NULL COMMENT '仕入先コード'
;
ALTER TABLE products MODIFY sup_sub_no INT (2) COMMENT '仕入先枝番'
;
ALTER TABLE products MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE products MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE products MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE products MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE product_category
(
    category_code  VARCHAR(8)                         NOT NULL,
    prod_cate_name VARCHAR(30),
    category_layer INT(2) DEFAULT 0 NOT NULL,
    category_path  VARCHAR(100),
    lowest_flug    INT(1) DEFAULT 0,
    create_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator        VARCHAR(12),
    update_date    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        VARCHAR(12)
)
;
ALTER TABLE product_category
    ADD CONSTRAINT PRIMARY KEY (category_code)
;
ALTER TABLE product_category COMMENT = '商品分類マスタ'
;
ALTER TABLE product_category MODIFY category_code VARCHAR (8) NOT NULL COMMENT '商品分類コード'
;
ALTER TABLE product_category MODIFY prod_cate_name VARCHAR (30) COMMENT '商品分類名'
;
ALTER TABLE product_category MODIFY category_layer INT (2) NOT NULL DEFAULT 0 COMMENT '商品分類階層'
;
ALTER TABLE product_category MODIFY category_path VARCHAR (100) COMMENT '商品分類パス'
;
ALTER TABLE product_category MODIFY lowest_flug INT (1) DEFAULT 0 COMMENT '最下層区分'
;
ALTER TABLE product_category MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE product_category MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE product_category MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE product_category MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE invoice
(
    invoice_no       VARCHAR(10)                        NOT NULL,
    invoiced_date    DATETIME,
    comp_code        VARCHAR(8)                         NOT NULL,
    cust_sub_no      INT(2),
    last_received    INT(13),
    month_sales      INT(13),
    month_received   INT(13),
    month_invoice    INT(13),
    cmp_tax          INT(10) DEFAULT 0 NOT NULL,
    invoice_received INT(13) DEFAULT 0,
    create_date      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator          VARCHAR(12),
    update_date      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater          VARCHAR(12)
)
;
ALTER TABLE invoice
    ADD CONSTRAINT PRIMARY KEY (invoice_no)
;
ALTER TABLE invoice COMMENT = '請求データ'
;
ALTER TABLE invoice MODIFY invoice_no VARCHAR (10) NOT NULL COMMENT '請求番号'
;
ALTER TABLE invoice MODIFY invoiced_date DATETIME COMMENT '請求日'
;
ALTER TABLE invoice MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE invoice MODIFY cust_sub_no INT (2) COMMENT '顧客枝番'
;
ALTER TABLE invoice MODIFY last_received INT (13) COMMENT '前回入金額'
;
ALTER TABLE invoice MODIFY month_sales INT (13) COMMENT '当月売上額'
;
ALTER TABLE invoice MODIFY month_received INT (13) COMMENT '当月入金額'
;
ALTER TABLE invoice MODIFY month_invoice INT (13) COMMENT '当月請求額'
;
ALTER TABLE invoice MODIFY cmp_tax INT (10) NOT NULL DEFAULT 0 COMMENT '消費税金額'
;
ALTER TABLE invoice MODIFY invoice_received INT (13) DEFAULT 0 COMMENT '請求消込金額'
;
ALTER TABLE invoice MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE invoice MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE invoice MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE invoice MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE invoice_details
(
    invoice_no  VARCHAR(10)                        NOT NULL,
    sales_no    VARCHAR(10)                        NOT NULL,
    row_no      INT(3) NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE invoice_details
    ADD CONSTRAINT PRIMARY KEY (invoice_no, sales_no, row_no)
;
ALTER TABLE invoice_details COMMENT = '請求データ明細'
;
ALTER TABLE invoice_details MODIFY invoice_no VARCHAR (10) NOT NULL COMMENT '請求番号'
;
ALTER TABLE invoice_details MODIFY sales_no VARCHAR (10) NOT NULL COMMENT '売上番号'
;
ALTER TABLE invoice_details MODIFY row_no INT (3) NOT NULL COMMENT '売上行番号'
;
ALTER TABLE invoice_details MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE invoice_details MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE invoice_details MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE invoice_details MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE wh_mst
(
    wh_code     VARCHAR(3)                           NOT NULL,
    wh_name     VARCHAR(20),
    wh_type     VARCHAR(1) DEFAULT 'N',
    zip_code    CHAR(8),
    state       VARCHAR(4),
    address1    VARCHAR(40),
    address2    VARCHAR(40),
    create_date DATETIME   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE wh_mst
    ADD CONSTRAINT PRIMARY KEY (wh_code)
;
ALTER TABLE wh_mst COMMENT = '倉庫マスタ'
;
ALTER TABLE wh_mst MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE wh_mst MODIFY wh_name VARCHAR (20) COMMENT '倉庫名'
;
ALTER TABLE wh_mst MODIFY wh_type VARCHAR (1) DEFAULT 'N' COMMENT '倉庫区分,N:通常倉庫 C:得意先 S:仕入先 D:部門倉庫 P:製品倉庫 M:原材料倉庫'
;
ALTER TABLE wh_mst MODIFY zip_code CHAR (8) COMMENT '郵便番号'
;
ALTER TABLE wh_mst MODIFY state VARCHAR (4) COMMENT '都道府県'
;
ALTER TABLE wh_mst MODIFY address1 VARCHAR (40) COMMENT '住所１'
;
ALTER TABLE wh_mst MODIFY address2 VARCHAR (40) COMMENT '住所２'
;
ALTER TABLE wh_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE wh_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE wh_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE wh_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE wh_dept_mst
(
    wh_code     VARCHAR(3)                         NOT NULL,
    dept_code   VARCHAR(6)                         NOT NULL,
    start_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE wh_dept_mst
    ADD CONSTRAINT PRIMARY KEY (wh_code, dept_code, start_date)
;
ALTER TABLE wh_dept_mst COMMENT = '倉庫部門マスタ'
;
ALTER TABLE wh_dept_mst MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE wh_dept_mst MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE wh_dept_mst MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '開始日'
;
ALTER TABLE wh_dept_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE wh_dept_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE wh_dept_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE wh_dept_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE alternate_products
(
    prod_code     VARCHAR(16)                        NOT NULL,
    alt_prod_code VARCHAR(16)                        NOT NULL,
    priority      INT(2) DEFAULT 1,
    create_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator       VARCHAR(12),
    update_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE alternate_products
    ADD CONSTRAINT PRIMARY KEY (prod_code, alt_prod_code)
;
ALTER TABLE alternate_products COMMENT = '代替商品'
;
ALTER TABLE alternate_products MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE alternate_products MODIFY alt_prod_code VARCHAR (16) NOT NULL COMMENT '代替商品コード'
;
ALTER TABLE alternate_products MODIFY priority INT (2) DEFAULT 1 COMMENT '優先順位'
;
ALTER TABLE alternate_products MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE alternate_products MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE alternate_products MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE alternate_products MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE location_mst
(
    wh_code       VARCHAR(3)                         NOT NULL,
    location_code VARCHAR(4)                         NOT NULL,
    prod_code     VARCHAR(16)                        NOT NULL,
    create_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator       VARCHAR(12),
    update_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE location_mst
    ADD CONSTRAINT PRIMARY KEY (wh_code, location_code, prod_code)
;
ALTER TABLE location_mst COMMENT = '棚番マスタ'
;
ALTER TABLE location_mst MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE location_mst MODIFY location_code VARCHAR (4) NOT NULL COMMENT '棚番コード'
;
ALTER TABLE location_mst MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE location_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE location_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE location_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE location_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE area_mst
(
    area_code   VARCHAR(10)                        NOT NULL,
    area_name   VARCHAR(20),
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE area_mst
    ADD CONSTRAINT PRIMARY KEY (area_code)
;
ALTER TABLE area_mst COMMENT = '地域マスタ'
;
ALTER TABLE area_mst MODIFY area_code VARCHAR (10) NOT NULL COMMENT '地域コード'
;
ALTER TABLE area_mst MODIFY area_name VARCHAR (20) COMMENT '地域名'
;
ALTER TABLE area_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE area_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE area_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE area_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE credit
(
    credit_no       VARCHAR(10)                        NOT NULL,
    credit_date     DATETIME,
    dept_code       VARCHAR(6)                         NOT NULL,
    start_date      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    comp_code       VARCHAR(8)                         NOT NULL,
    comp_sub_no     INT(2),
    pay_method_type INT(1) DEFAULT 1,
    bank_acut_code  VARCHAR(8),
    received_amnt   INT(13) DEFAULT 0,
    received        INT(13) DEFAULT 0,
    create_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator         VARCHAR(12),
    update_date     DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         VARCHAR(12),
    update_plg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_pgm      VARCHAR(50)
)
;
ALTER TABLE credit
    ADD CONSTRAINT PRIMARY KEY (credit_no)
;
ALTER TABLE credit COMMENT = '入金データ'
;
ALTER TABLE credit MODIFY credit_no VARCHAR (10) NOT NULL COMMENT '入金番号'
;
ALTER TABLE credit MODIFY credit_date DATETIME COMMENT '入金日'
;
ALTER TABLE credit MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE credit MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '開始日'
;
ALTER TABLE credit MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '顧客コード'
;
ALTER TABLE credit MODIFY comp_sub_no INT (2) COMMENT '顧客枝番'
;
ALTER TABLE credit MODIFY pay_method_type INT (1) DEFAULT 1 COMMENT '支払方法区分,1:振込,2:手形'
;
ALTER TABLE credit MODIFY bank_acut_code VARCHAR (8) COMMENT '入金口座コード'
;
ALTER TABLE credit MODIFY received_amnt INT (13) DEFAULT 0 COMMENT '入金金額'
;
ALTER TABLE credit MODIFY received INT (13) DEFAULT 0 COMMENT '消込金額'
;
ALTER TABLE credit MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE credit MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE credit MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE credit MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
ALTER TABLE credit MODIFY update_plg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'プログラム更新日時'
;
ALTER TABLE credit MODIFY update_pgm VARCHAR (50) COMMENT '更新プログラム名'
;
CREATE TABLE bank_acut_mst
(
    bank_acut_code       VARCHAR(8)                         NOT NULL,
    recive_act_name      VARCHAR(30),
    appl_start_date      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    appl_end_date        DATETIME DEFAULT '2100/12/31',
    start_act_name       VARCHAR(30),
    recive_bank_act_type VARCHAR(1),
    recive_act_no        VARCHAR(12),
    bank_act_type        VARCHAR(1),
    act_name             VARCHAR(20),
    dept_code            VARCHAR(6)                         NOT NULL,
    start_date           DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    a_bank_code          VARCHAR(4),
    a_bank_blnc_code     VARCHAR(3),
    create_date          DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator              VARCHAR(12),
    update_date          DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater              VARCHAR(12),
    update_plg_date      DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_pgm           VARCHAR(50)
)
;
ALTER TABLE bank_acut_mst
    ADD CONSTRAINT PRIMARY KEY (bank_acut_code)
;
ALTER TABLE bank_acut_mst COMMENT = '入金口座マスタ'
;
ALTER TABLE bank_acut_mst MODIFY bank_acut_code VARCHAR (8) NOT NULL COMMENT '入金口座コード'
;
ALTER TABLE bank_acut_mst MODIFY recive_act_name VARCHAR (30) COMMENT '入金口座名'
;
ALTER TABLE bank_acut_mst MODIFY appl_start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '適用開始日'
;
ALTER TABLE bank_acut_mst MODIFY appl_end_date DATETIME DEFAULT '2100/12/31' COMMENT '適用終了日'
;
ALTER TABLE bank_acut_mst MODIFY start_act_name VARCHAR (30) COMMENT '適用開始後入金口座名'
;
ALTER TABLE bank_acut_mst MODIFY recive_bank_act_type VARCHAR (1) COMMENT '入金口座区分,B:銀行 P:郵便局'
;
ALTER TABLE bank_acut_mst MODIFY recive_act_no VARCHAR (12) COMMENT '入金口座番号,銀行:7桁 郵便局:12桁'
;
ALTER TABLE bank_acut_mst MODIFY bank_act_type VARCHAR (1) COMMENT '銀行口座種別,O:普通 C:当座'
;
ALTER TABLE bank_acut_mst MODIFY act_name VARCHAR (20) COMMENT '口座名義人'
;
ALTER TABLE bank_acut_mst MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE bank_acut_mst MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '部門開始日'
;
ALTER TABLE bank_acut_mst MODIFY a_bank_code VARCHAR (4) COMMENT '全銀協銀行コード'
;
ALTER TABLE bank_acut_mst MODIFY a_bank_blnc_code VARCHAR (3) COMMENT '全銀協支店コード'
;
ALTER TABLE bank_acut_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE bank_acut_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE bank_acut_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE bank_acut_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
ALTER TABLE bank_acut_mst MODIFY update_plg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'プログラム更新日時'
;
ALTER TABLE bank_acut_mst MODIFY update_pgm VARCHAR (50) COMMENT '更新プログラム名'
;
CREATE TABLE sales
(
    sales_no     VARCHAR(10)                        NOT NULL,
    order_no     VARCHAR(10)                        NOT NULL,
    sales_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sales_type   INT(1) DEFAULT 1,
    dept_code    VARCHAR(6)                         NOT NULL,
    start_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    comp_code    VARCHAR(8)                         NOT NULL,
    emp_code     VARCHAR(10)                        NOT NULL,
    sales_amnt   INT(13) DEFAULT 0 NOT NULL,
    cmp_tax      INT(10) DEFAULT 0 NOT NULL,
    slip_comment VARCHAR(1000),
    updated_no   INT(10),
    orgnl_no     VARCHAR(10),
    create_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator      VARCHAR(12),
    update_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      VARCHAR(12)
)
;
ALTER TABLE sales
    ADD CONSTRAINT PRIMARY KEY (sales_no)
;
ALTER TABLE sales COMMENT = '売上データ'
;
ALTER TABLE sales MODIFY sales_no VARCHAR (10) NOT NULL COMMENT '売上番号'
;
ALTER TABLE sales MODIFY order_no VARCHAR (10) NOT NULL COMMENT '受注番号'
;
ALTER TABLE sales MODIFY sales_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '売上日,出荷日'
;
ALTER TABLE sales MODIFY sales_type INT (1) DEFAULT 1 COMMENT '売上区分,1:売上 2:売上返品'
;
ALTER TABLE sales MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE sales MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '部門開始日'
;
ALTER TABLE sales MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE sales MODIFY emp_code VARCHAR (10) NOT NULL COMMENT '社員コード'
;
ALTER TABLE sales MODIFY sales_amnt INT (13) NOT NULL DEFAULT 0 COMMENT '売上金額合計'
;
ALTER TABLE sales MODIFY cmp_tax INT (10) NOT NULL DEFAULT 0 COMMENT '消費税合計'
;
ALTER TABLE sales MODIFY slip_comment VARCHAR (1000) COMMENT '備考'
;
ALTER TABLE sales MODIFY updated_no INT (10) COMMENT '赤黒伝票番号'
;
ALTER TABLE sales MODIFY orgnl_no VARCHAR (10) COMMENT '元伝票番号'
;
ALTER TABLE sales MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE sales MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE sales MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE sales MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE sales_details
(
    sales_no           VARCHAR(10)                        NOT NULL,
    row_no             INT(3) NOT NULL,
    prod_code          VARCHAR(16)                        NOT NULL,
    prod_name          VARCHAR(10)                        NOT NULL,
    unitprice          INT(8) DEFAULT 0 NOT NULL,
    delivered_qty      INT(4) DEFAULT 0,
    quantity           INT(4) DEFAULT 1 NOT NULL,
    discount           INT(4) DEFAULT 0 NOT NULL,
    invoiced_date      DATETIME,
    invoice_no         VARCHAR(10),
    invoice_delay_type INT(1),
    auto_journal_date  DATETIME,
    create_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator            VARCHAR(12),
    update_date        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater            VARCHAR(12)
)
;
ALTER TABLE sales_details
    ADD CONSTRAINT PRIMARY KEY (sales_no, row_no)
;
ALTER TABLE sales_details COMMENT = '売上データ明細'
;
ALTER TABLE sales_details MODIFY sales_no VARCHAR (10) NOT NULL COMMENT '売上番号'
;
ALTER TABLE sales_details MODIFY row_no INT (3) NOT NULL COMMENT '売上行番号'
;
ALTER TABLE sales_details MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE sales_details MODIFY prod_name VARCHAR (10) NOT NULL COMMENT '商品名'
;
ALTER TABLE sales_details MODIFY unitprice INT (8) NOT NULL DEFAULT 0 COMMENT '販売単価'
;
ALTER TABLE sales_details MODIFY delivered_qty INT (4) DEFAULT 0 COMMENT '出荷数量'
;
ALTER TABLE sales_details MODIFY quantity INT (4) NOT NULL DEFAULT 1 COMMENT '売上数量'
;
ALTER TABLE sales_details MODIFY discount INT (4) NOT NULL DEFAULT 0 COMMENT '値引金額'
;
ALTER TABLE sales_details MODIFY invoiced_date DATETIME COMMENT '請求日'
;
ALTER TABLE sales_details MODIFY invoice_no VARCHAR (10) COMMENT '請求番号'
;
ALTER TABLE sales_details MODIFY invoice_delay_type INT (1) COMMENT '請求遅延区分'
;
ALTER TABLE sales_details MODIFY auto_journal_date DATETIME COMMENT '自動仕訳処理日'
;
ALTER TABLE sales_details MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE sales_details MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE sales_details MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE sales_details MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE purchase_orders
(
    po_no        VARCHAR(10)                        NOT NULL,
    po_date      DATETIME,
    order_no     VARCHAR(10)                        NOT NULL,
    sup_code     VARCHAR(8)                         NOT NULL,
    sup_sub_no   INT(2),
    emp_code     VARCHAR(10)                        NOT NULL,
    due_date     DATETIME,
    wh_code      VARCHAR(3)                         NOT NULL,
    po_amnt      INT(10),
    cmp_tax      INT(10) DEFAULT 0 NOT NULL,
    slip_comment VARCHAR(1000),
    create_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator      VARCHAR(12),
    update_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      VARCHAR(12)
)
;
ALTER TABLE purchase_orders
    ADD CONSTRAINT PRIMARY KEY (po_no)
;
ALTER TABLE purchase_orders COMMENT = '発注データ'
;
ALTER TABLE purchase_orders MODIFY po_no VARCHAR (10) NOT NULL COMMENT '発注番号'
;
ALTER TABLE purchase_orders MODIFY po_date DATETIME COMMENT '発注日'
;
ALTER TABLE purchase_orders MODIFY order_no VARCHAR (10) NOT NULL COMMENT '受注番号'
;
ALTER TABLE purchase_orders MODIFY sup_code VARCHAR (8) NOT NULL COMMENT '仕入先コード'
;
ALTER TABLE purchase_orders MODIFY sup_sub_no INT (2) COMMENT '仕入先枝番'
;
ALTER TABLE purchase_orders MODIFY emp_code VARCHAR (10) NOT NULL COMMENT '発注担当者コード'
;
ALTER TABLE purchase_orders MODIFY due_date DATETIME COMMENT '指定納期'
;
ALTER TABLE purchase_orders MODIFY wh_code VARCHAR (3) NOT NULL COMMENT '倉庫コード'
;
ALTER TABLE purchase_orders MODIFY po_amnt INT (10) COMMENT '発注金額合計'
;
ALTER TABLE purchase_orders MODIFY cmp_tax INT (10) NOT NULL DEFAULT 0 COMMENT '消費税金額'
;
ALTER TABLE purchase_orders MODIFY slip_comment VARCHAR (1000) COMMENT '備考'
;
ALTER TABLE purchase_orders MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE purchase_orders MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE purchase_orders MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE purchase_orders MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE po_details
(
    po_no         VARCHAR(10)                        NOT NULL,
    po_row_no     INT(3) NOT NULL,
    po_row_dsp_no INT(3) NOT NULL,
    order_no      VARCHAR(10)                        NOT NULL,
    so_row_no     INT(3) NOT NULL,
    prod_code     VARCHAR(16)                        NOT NULL,
    prod_name     VARCHAR(10)                        NOT NULL,
    po_price      INT(8) DEFAULT 0,
    po_qt         INT(4) DEFAULT 1 NOT NULL,
    recived_qt    INT(4) DEFAULT 1 NOT NULL,
    complete_flg  INT(1) DEFAULT 0 NOT NULL,
    create_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator       VARCHAR(12),
    update_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE po_details
    ADD CONSTRAINT PRIMARY KEY (po_row_no, po_no)
;
ALTER TABLE po_details COMMENT = '発注データ明細'
;
ALTER TABLE po_details MODIFY po_no VARCHAR (10) NOT NULL COMMENT '発注番号'
;
ALTER TABLE po_details MODIFY po_row_no INT (3) NOT NULL COMMENT '発注行番号'
;
ALTER TABLE po_details MODIFY po_row_dsp_no INT (3) NOT NULL COMMENT '発注行表示番号'
;
ALTER TABLE po_details MODIFY order_no VARCHAR (10) NOT NULL COMMENT '受注番号'
;
ALTER TABLE po_details MODIFY so_row_no INT (3) NOT NULL COMMENT '受注行番号'
;
ALTER TABLE po_details MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE po_details MODIFY prod_name VARCHAR (10) NOT NULL COMMENT '商品名'
;
ALTER TABLE po_details MODIFY po_price INT (8) DEFAULT 0 COMMENT '仕入単価'
;
ALTER TABLE po_details MODIFY po_qt INT (4) NOT NULL DEFAULT 1 COMMENT '発注数量'
;
ALTER TABLE po_details MODIFY recived_qt INT (4) NOT NULL DEFAULT 1 COMMENT '入荷済数量'
;
ALTER TABLE po_details MODIFY complete_flg INT (1) NOT NULL DEFAULT 0 COMMENT '完了フラグ,0:未完了, 1:完了'
;
ALTER TABLE po_details MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE po_details MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE po_details MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE po_details MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE bom
(
    prod_code   VARCHAR(16)                        NOT NULL,
    bom_code    VARCHAR(16)                        NOT NULL,
    quantity    INT(4) DEFAULT 1 NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE bom
    ADD CONSTRAINT PRIMARY KEY (prod_code)
;
ALTER TABLE bom COMMENT = '部品表'
;
ALTER TABLE bom MODIFY prod_code VARCHAR (16) NOT NULL COMMENT '商品コード'
;
ALTER TABLE bom MODIFY bom_code VARCHAR (16) NOT NULL COMMENT '部品コード'
;
ALTER TABLE bom MODIFY quantity INT (4) NOT NULL DEFAULT 1 COMMENT '部品数量'
;
ALTER TABLE bom MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE bom MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE bom MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE bom MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE dept_mst
(
    dept_code   VARCHAR(6)                         NOT NULL,
    start_date  DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end_date    DATETIME DEFAULT '2100/12/31',
    dep_name    VARCHAR(40),
    dept_layer  INT(2) DEFAULT 0 NOT NULL,
    dept_psth   VARCHAR(100)                       NOT NULL,
    最下層区分  INT(1) DEFAULT 0 NOT NULL,
    slit_yn     INT(1) DEFAULT 1 NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator     VARCHAR(12),
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     VARCHAR(12)
)
;
ALTER TABLE dept_mst
    ADD CONSTRAINT PRIMARY KEY (dept_code, start_date)
;
ALTER TABLE dept_mst COMMENT = '部門マスタ'
;
ALTER TABLE dept_mst MODIFY dept_code VARCHAR (6) NOT NULL COMMENT '部門コード'
;
ALTER TABLE dept_mst MODIFY start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '開始日'
;
ALTER TABLE dept_mst MODIFY end_date DATETIME DEFAULT '2100/12/31' COMMENT '終了日'
;
ALTER TABLE dept_mst MODIFY dep_name VARCHAR (40) COMMENT '部門名'
;
ALTER TABLE dept_mst MODIFY dept_layer INT (2) NOT NULL DEFAULT 0 COMMENT '組織階層'
;
ALTER TABLE dept_mst MODIFY dept_psth VARCHAR (100) NOT NULL COMMENT '部門パス'
;
ALTER TABLE dept_mst MODIFY 最下層区分 INT (1) NOT NULL DEFAULT 0 COMMENT '最下層区分'
;
ALTER TABLE dept_mst MODIFY slit_yn INT (1) NOT NULL DEFAULT 1 COMMENT '伝票入力可否,0:不可 1:可能'
;
ALTER TABLE dept_mst MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE dept_mst MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE dept_mst MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE dept_mst MODIFY updater VARCHAR (12) COMMENT '更新者名'
;
CREATE TABLE credit_balance
(
    comp_code     VARCHAR(8)                         NOT NULL,
    order_balance INT(13) DEFAULT 0,
    rec_balance   INT(13) DEFAULT 0,
    pay_balance   INT(13) DEFAULT 0,
    create_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator       VARCHAR(12),
    update_date   DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       VARCHAR(12)
)
;
ALTER TABLE credit_balance
    ADD CONSTRAINT PRIMARY KEY (comp_code)
;
ALTER TABLE credit_balance COMMENT = '与信残高データ'
;
ALTER TABLE credit_balance MODIFY comp_code VARCHAR (8) NOT NULL COMMENT '取引先コード'
;
ALTER TABLE credit_balance MODIFY order_balance INT (13) DEFAULT 0 COMMENT '受注残高'
;
ALTER TABLE credit_balance MODIFY rec_balance INT (13) DEFAULT 0 COMMENT '債権残高'
;
ALTER TABLE credit_balance MODIFY pay_balance INT (13) DEFAULT 0 COMMENT '債務残高'
;
ALTER TABLE credit_balance MODIFY create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時'
;
ALTER TABLE credit_balance MODIFY creator VARCHAR (12) COMMENT '作成者名'
;
ALTER TABLE credit_balance MODIFY update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時'
;
ALTER TABLE credit_balance MODIFY updater VARCHAR (12) COMMENT '更新者名'
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
CREATE
OR REPLACE VIEW products_v2
    (PROD_CODE,PROD_FULLNAME,PROD_NAME,PROD_KANA,PROD_TYPE,SERIAL_NO,UNITPRICE,
    PO_PRICE,COST,TAX_TYPE,PROD_CATE_NAME,LAYER)
AS
SELECT A.PROD_CODE      PROD_CODE,
       A.PROD_FULLNAME  PROD_FULLNAME,
       A.PROD_NAME      PROD_NAME,
       A.PROD_KANA      PROD_KANA,
       A.PROD_TYPE      PROD_TYPE,
       A.SERIAL_NO      SERIAL_NO,
       A.UNITPRICE      UNITPRICE,
       A.PO_PRICE       PO_PRICE,
       A.prime_cost     COST,
       A.TAX_TYPE       TAX_TYPE,
       B.PROD_CATE_NAME PROD_CATE_NAME,
       B.category_layer LAYER
FROM PRODUCTS A,
     PRODUCT_CATEGORY B
WHERE A.CATEGORY_CODE = B.CATEGORY_CODE
;
