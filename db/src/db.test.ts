import { config } from "dotenv";
config({ path: ".env.test" });
import {
  PrismaClient,
  Department,
  Employee,
  ProductCategory,
  Product,
  Bom,
  PriceByCustomer,
  AlternateProduct,
  Company,
  Customer,
  Area,
  Destination,
  Supplier,
  CompanyGroup,
  CompanyCategoryGroup,
  CompanyCategory,
  CategoryType,
  Order,
  OrderDetail,
  Sales,
  SalesDetail,
  Invoice,
  InvoiceDetail,
  BankAccount,
  Credit,
  PurchaseOrder,
  PurchaseOrderDetail,
  Warehouse,
  Location,
  WarehouseDepartment,
  Stock,
  Purchase,
  PurchaseDetail,
  Payment,
  CreditBalance,
} from "@prisma/client";
const prisma = new PrismaClient();

const departments: Department[] = [
  {
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    endDate: new Date("2021-12-31"),
    name: "新規部署",
    layer: 1,
    psth: "D0001",
    lowestType: 1,
    slitYn: 0,
    createDate: new Date("2021-01-01"),
    creator: "admin",
    updateDate: new Date("2021-01-01"),
    updater: "admin",
  },
];

const employees: Employee[] = [
  {
    empCode: "EMP999",
    name: "伊藤 裕子",
    kana: "イトウ ユウコ",
    loginPassword: "password",
    tel: "090-1234-5678",
    fax: "03-1234-5678",
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    occuCode: "",
    approvalCode: "",
    createDate: new Date("2021-01-01"),
    creator: "admin",
    updateDate: new Date("2021-01-01"),
    updater: "admin",
  },
];

const productCategories: ProductCategory[] = [
  {
    categoryCode: "00101001",
    name: "牛肉",
    layer: 0,
    path: "00100000~00101000~00101001",
    lowestType: 1,
    createDate: new Date("2021-01-01"),
    creator: "user",
    updateDate: new Date("2021-01-01"),
    updater: "user",
  },
];

const products: Product[] = [
  {
    prodCode: "1010100X",
    fullname: "商品名",
    name: "商品名",
    kana: "ショウヒンメイ",
    prodType: "1",
    serialNo: "1234567890",
    unitprice: 1000,
    poPrice: 900,
    primeCost: 500,
    taxType: 1,
    categoryCode: "00101001",
    wideUseType: 1,
    stockManageType: 1,
    stockReserveType: 1,
    supCode: "001",
    supSubNo: 1,
    createDate: new Date("2021-01-01"),
    creator: "user",
    updateDate: new Date("2021-01-01"),
    updater: "user",
  },
];

const boms: Bom[] = [
  {
    prodCode: "1010100X",
    bomCode: "1010100X",
    quantity: 0,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const alternateProducts: AlternateProduct[] = [
  {
    prodCode: "1010100X",
    altProdCode: "P0000001",
    priority: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const priceByCustomers: PriceByCustomer[] = [
  {
    prodCode: "1010100X",
    compCode: "C0000001",
    unitprice: 1000,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const companies: Company[] = [
  {
    compCode: "00X",
    name: "顧客名1",
    kana: "クスキメイ1",
    supType: 0,
    zipCode: "000-0000",
    state: "都道府県",
    address1: "住所1",
    address2: "住所2",
    noSalesFlg: 0,
    wideUseType: 0,
    compGroupCode: "001",
    maxCredit: 10000,
    tempCreditUp: 0,
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const customers: Customer[] = [
  {
    custCode: "00X",
    custSubNo: 1,
    custType: 0,
    arCode: "001",
    arSubNo: 1,
    payerCode: "001",
    payerSubNo: 1,
    name: "顧客名1",
    kana: "クスキメイ1",
    empCode: "001",
    custUserName: "顧客担当者名1",
    custUserDepName: "顧客担当者部署名1",
    custZipCode: "000-0000",
    custState: "都道府県",
    custAddress1: "住所1",
    custAddress2: "住所2",
    custTel: "000-0000-0000",
    custFax: "000-0000-0000",
    custEmail: "hoge@hoge.com",
    custArType: 0,
    custCloseDate1: 1,
    custPayMonths1: 0,
    custPayDates1: 1,
    custPayMethod1: 0,
    custPayDates2: 1,
    custPayMethod2: 0,
    custCloseDate2: 1,
    custPayMonths2: 0,
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const areas: Area[] = [
  {
    areaCode: "00X",
    areaName: "エリア名1",
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const destinations: Destination[] = [
  {
    custCode: "00X",
    custSubNo: 1,
    distNo: 1,
    distName: "配送先名1",
    areaCode: "00X",
    zipCode: "000-0000",
    address1: "住所1",
    address2: "住所2",
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const suppliers: Supplier[] = [
  {
    supCode: "00X",
    supSubNo: 1,
    name: "仕入先名1",
    kana: "シスキメイ1",
    supEmpName: "担当者名1",
    supDepName: "部署名1",
    supZipCode: "000-0000",
    supState: "都道府県",
    supAddress1: "住所1",
    supAddress2: "住所2",
    supTel: "000-0000-0000",
    supFax: "000-0000-0000",
    supEmail: "hoge@hoegc.com",
    supCloseDate: 1,
    supPayMonths: 1,
    supPayDates: 1,
    payMethodType: 1,
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const companyGroups: CompanyGroup[] = [
  {
    compGroupCode: "001",
    groupName: "グループ名1",
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const cateoryTypes: CategoryType[] = [
  {
    categoryTypeCode: "01",
    categoryTypeName: "分類名1",
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const companyCategories: CompanyCategory[] = [
  {
    categoryTypeCode: "01",
    compCateCode: "001",
    compCateName: "分類名1",
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const companyCategoryGroups: CompanyCategoryGroup[] = [
  {
    categoryTypeCode: "01",
    compCateCode: "001",
    compCode: "00X",
    createDate: new Date(),
    creator: null,
    updateDate: new Date(),
    updater: null,
  },
];

const orders: Order[] = [
  {
    orderNo: "0000000001",
    orderDate: new Date(),
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    custCode: "00X",
    custSubNo: 1,
    empCode: "EMP999",
    requiredDate: new Date(),
    custorderNo: "0000000001",
    whCode: "001",
    orderAmnt: 1000,
    cmpTax: 10,
    slipComment: "test",
    createDate: new Date(),
    creator: "0001",
    updateDate: new Date(),
    updater: "0001",
  },
];

const orderDetails: OrderDetail[] = [
  {
    orderNo: "0000000001",
    soRowNo: 1,
    prodCode: "0001",
    prodName: "test",
    unitprice: 100,
    quantity: 10,
    cmpTaxRate: 10,
    reserveQty: 0,
    deliveryOrderQty: 0,
    deliveredQty: 0,
    completeFlg: 0,
    discount: 0,
    deliveryDate: new Date(),
    createDate: new Date(),
    creator: "0001",
    updateDate: new Date(),
    updater: "0001",
  },
  {
    orderNo: "0000000001",
    soRowNo: 2,
    prodCode: "0001",
    prodName: "test",
    unitprice: 100,
    quantity: 10,
    cmpTaxRate: 10,
    reserveQty: 0,
    deliveryOrderQty: 0,
    deliveredQty: 0,
    completeFlg: 0,
    discount: 0,
    deliveryDate: new Date(),
    createDate: new Date(),
    creator: "0001",
    updateDate: new Date(),
    updater: "0001",
  },
  {
    orderNo: "0000000001",
    soRowNo: 3,
    prodCode: "0001",
    prodName: "test",
    unitprice: 100,
    quantity: 10,
    cmpTaxRate: 10,
    reserveQty: 0,
    deliveryOrderQty: 0,
    deliveredQty: 0,
    completeFlg: 0,
    discount: 0,
    deliveryDate: new Date(),
    createDate: new Date(),
    creator: "0001",
    updateDate: new Date(),
    updater: "0001",
  },
];

const sales: Sales[] = [
  {
    salesNo: "0000000001",
    orderNo: "0000000001",
    salesDate: new Date(),
    salesType: 1,
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    compCode: "1",
    empCode: "1",
    salesAmnt: 3,
    cmpTax: 100,
    slipComment: "test",
    updatedNo: 1,
    orgnlNo: "1",
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const salesDetails: SalesDetail[] = [
  {
    salesNo: "0000000001",
    rowNo: 1,
    prodCode: "10101001",
    prodName: "test",
    unitprice: 1000,
    deliveredQty: 1,
    quantity: 1,
    discount: 1,
    invoicedDate: new Date(),
    invoiceNo: "1",
    invoiceDelayType: 1,
    autoJournalDate: new Date(),
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    salesNo: "0000000001",
    rowNo: 2,
    prodCode: "10101001",
    prodName: "test",
    unitprice: 1000,
    deliveredQty: 1,
    quantity: 1,
    discount: 1,
    invoicedDate: new Date(),
    invoiceNo: "1",
    invoiceDelayType: 1,
    autoJournalDate: new Date(),
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    salesNo: "0000000001",
    rowNo: 3,
    prodCode: "10101001",
    prodName: "test",
    unitprice: 1000,
    deliveredQty: 1,
    quantity: 1,
    discount: 1,
    invoicedDate: new Date(),
    invoiceNo: "1",
    invoiceDelayType: 1,
    autoJournalDate: new Date(),
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const invoices: Invoice[] = [
  {
    invoiceNo: "0000000001",
    invoicedDate: new Date(),
    compCode: "00X",
    custSubNo: 1,
    lastReceived: 1,
    monthSales: 1,
    monthReceived: 1,
    monthInvoice: 1,
    cmpTax: 1,
    invoiceReceived: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const invoiceDetails: InvoiceDetail[] = [
  {
    invoiceNo: "0000000001",
    salesNo: "0000000001",
    rowNo: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    invoiceNo: "0000000001",
    salesNo: "0000000001",
    rowNo: 2,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    invoiceNo: "0000000001",
    salesNo: "0000000001",
    rowNo: 3,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const bankAccounts: BankAccount[] = [
  {
    bankAcutCode: "00000001",
    reciveActName: "test",
    applStartDate: new Date(),
    applEndDate: new Date(),
    startActName: "test",
    reciveBankActType: "1",
    reciveActNo: "00000001",
    bankActType: "1",
    actName: "test",
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    aBankCode: "0001",
    aBankBlncCode: "001",
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
    updatePlgDate: new Date(),
    updatePgm: "main",
  },
];

const credits: Credit[] = [
  {
    creditNo: "0000000001",
    creditDate: new Date(),
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    custCode: "00X",
    custSubNo: 1,
    payMethodType: 1,
    bankAcutCode: "00000001",
    receivedAmnt: 1000,
    received: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
    updatePlgDate: new Date(),
    updatePgm: "main",
  },
];

const purchaseOrders: PurchaseOrder[] = [
  {
    poNo: "PO0000001",
    poDate: new Date(),
    orderNo: "0000000001",
    supCode: "001",
    supSubNo: 1,
    empCode: "EMP999",
    dueDate: new Date(),
    whCode: "001",
    poAmnt: 1000,
    cmpTax: 100,
    slipComment: "test",
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const purchaseOrderDetails: PurchaseOrderDetail[] = [
  {
    poNo: "PO0000001",
    poRowNo: 1,
    poRowDspNo: 1,
    orderNo: "0000000001",
    soRowNo: 1,
    prodCode: "10101001",
    prodName: "牛ひれ",
    poPrice: 100,
    poQt: 10,
    recivedQt: 10,
    completeFlg: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    poNo: "PO0000001",
    poRowNo: 2,
    poRowDspNo: 2,
    orderNo: "0000000001",
    soRowNo: 1,
    prodCode: "10101001",
    prodName: "牛ひれ",
    poPrice: 100,
    poQt: 10,
    recivedQt: 10,
    completeFlg: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    poNo: "PO0000001",
    poRowNo: 3,
    poRowDspNo: 3,
    orderNo: "0000000001",
    soRowNo: 1,
    prodCode: "10101001",
    prodName: "牛ひれ",
    poPrice: 100,
    poQt: 10,
    recivedQt: 10,
    completeFlg: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const warehouses: Warehouse[] = [
  {
    whCode: "001",
    whName: "本社倉庫",
    whType: "1",
    zipCode: "000-0000",
    state: "東京都",
    address1: "千代田区",
    address2: "千代田1-1-1",
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const locations: Location[] = [
  {
    whCode: "001",
    locationCode: "001",
    prodCode: "1010100X",
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const warehouseDepartments: WarehouseDepartment[] = [
  {
    whCode: "001",
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const stocks: Stock[] = [
  {
    whCode: "001",
    prodCode: "001",
    rotNo: "X03022801",
    stockType: "1",
    qualityType: "1",
    actual: 30,
    valid: 0,
    lastDeliveryDate: new Date(),
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    whCode: "001",
    prodCode: "001",
    rotNo: "X03041502",
    stockType: "1",
    qualityType: "1",
    actual: 100,
    valid: 0,
    lastDeliveryDate: new Date(),
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const purchases: Purchase[] = [
  {
    puNo: "0000000001",
    puDate: new Date(),
    supCode: "00X",
    supSubNo: 1,
    empCode: "EMP999",
    startDate: new Date("2021-01-01"),
    poNo: "PO0000001",
    deptCode: "11101",
    puAmmount: 1000,
    cmpTax: 0,
    slipComment: "test",
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const purchaseDetails: PurchaseDetail[] = [
  {
    puNo: "0000000001",
    puRowNo: 1,
    puRowDspNo: 1,
    poRowNo: 1,
    prodCode: "1010100X",
    whCode: "001",
    prodName: "test",
    poPrice: 1000,
    puQuantity: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    puNo: "0000000001",
    puRowNo: 2,
    puRowDspNo: 2,
    poRowNo: 2,
    prodCode: "1010100X",
    whCode: "001",
    prodName: "test",
    poPrice: 1000,
    puQuantity: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
  {
    puNo: "0000000001",
    puRowNo: 3,
    puRowDspNo: 3,
    poRowNo: 3,
    prodCode: "1010100X",
    whCode: "001",
    prodName: "test",
    poPrice: 1000,
    puQuantity: 1,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

const payments: Payment[] = [
  {
    payNo: "000000001",
    payDate: 1,
    deptCode: "11101",
    startDate: new Date("2021-01-01"),
    supCode: "00X",
    supSubNo: 1,
    payMethodType: 1,
    payAmnt: 1000,
    cmpTax: 100,
    completeFlg: 0,
    createDate: new Date("2021-02-02"),
    creator: "001",
    updateDate: new Date("2021-02-02"),
    updater: "001",
  },
];

const creditBalances: CreditBalance[] = [
  {
    compCode: "00X",
    orderBalance: 0,
    recBalance: 0,
    payBalance: 0,
    createDate: new Date(),
    creator: "admin",
    updateDate: new Date(),
    updater: "admin",
  },
];

describe("Part 1 業務システムの概要とマスタ設計", () => {
  describe("Chapter 1 販売管理システム全体像", () => {});

  describe("Chapter 2 基幹業務システム構築のポイント", () => {});

  describe("Chapter 3 部門／社員／商品マスタ設計", () => {
    describe("部門マスタ", () => {
      beforeAll(async () => {
        await prisma.warehouseDepartment.deleteMany();
        await prisma.department.deleteMany();
      });

      test("部門を登録できる", async () => {
        const expected: Department[] = departments.map((c) => {
          return { ...c };
        });
        await prisma.department.create({
          data: departments[0],
        });

        const result = await prisma.department.findMany();
        expect(result).toEqual(expected);
      });

      test("部門を更新できる", async () => {
        const expected: Department[] = departments.map((c) => {
          return { ...c, name: "更新部署" };
        });
        await prisma.department.update({
          where: {
            deptCode_startDate: {
              deptCode: departments[0].deptCode,
              startDate: departments[0].startDate,
            },
          },
          data: expected[0],
        });

        const result = await prisma.department.findMany();
        expect(result).toEqual(expected);
      });

      test("部門を削除できる", async () => {
        const expected: Department[] = [];
        await prisma.department.delete({
          where: {
            deptCode_startDate: {
              deptCode: departments[0].deptCode,
              startDate: departments[0].startDate,
            },
          },
        });

        const result = await prisma.department.findMany();
        expect(result).toEqual(expected);
      });
    });

    describe("社員マスタ", () => {
      beforeAll(async () => {
        await prisma.employee.deleteMany();
      });

      test("社員を登録できる", async () => {
        const expected: Employee[] = employees.map((c) => {
          return { ...c };
        });
        await prisma.employee.create({
          data: employees[0],
        });

        const result = await prisma.employee.findMany();
        expect(result).toEqual(expected);
      });

      test("社員を更新できる", async () => {
        const expected: Employee[] = employees.map((c) => {
          return { ...c, name: "更新社員" };
        });
        await prisma.employee.update({
          where: { empCode: employees[0].empCode },
          data: expected[0],
        });

        const result = await prisma.employee.findMany();
        expect(result).toEqual(expected);
      });

      test("社員を削除できる", async () => {
        const expected: Employee[] = [];
        await prisma.employee.delete({
          where: { empCode: employees[0].empCode },
        });

        const result = await prisma.employee.findMany();
        expect(result).toEqual(expected);
      });
    });

    describe("商品マスタ", () => {
      beforeAll(async () => {
        await prisma.alternateProduct.deleteMany();
        await prisma.priceByCustomer.deleteMany();
        await prisma.bom.deleteMany();
        await prisma.product.deleteMany();
        await prisma.productCategory.deleteMany();
      });

      test("商品を登録できる", async () => {
        const expected: Product[] = products.map((c) => {
          return {
            ...c,
            alternateProducts: alternateProducts,
            pricebycustomers: priceByCustomers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.productCategory.createMany({ data: productCategories });
          await prisma.product.createMany({ data: products });
          await prisma.alternateProduct.createMany({ data: alternateProducts });
          await prisma.priceByCustomer.createMany({ data: priceByCustomers });
        });

        const result = await prisma.product.findUnique({
          where: { prodCode: products[0].prodCode },
          include: {
            alternateProducts: true,
            pricebycustomers: true,
          },
        });
        expect(result).toEqual(expected[0]);
      });

      test("商品を更新できる", async () => {
        const expected: Product[] = products.map((c) => {
          return { ...c, name: "更新商品" };
        });
        await prisma.product.update({
          where: { prodCode: products[0].prodCode },
          data: expected[0],
        });

        const result = await prisma.product.findUnique({
          where: { prodCode: products[0].prodCode },
        });
        expect(result).toEqual(expected[0]);
      });

      test("商品を削除できる", async () => {
        const expected: Product[] = [];

        await prisma.$transaction(async (prisma) => {
          await prisma.alternateProduct.deleteMany({
            where: { prodCode: products[0].prodCode },
          });
          await prisma.priceByCustomer.deleteMany({
            where: { prodCode: products[0].prodCode },
          });
          await prisma.product.delete({
            where: { prodCode: products[0].prodCode },
          });
        });

        const result = await prisma.product.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 4 取引先（顧客／仕入先）マスタ設計", () => {
    beforeAll(async () => {
      await prisma.destination.deleteMany();
      await prisma.customer.deleteMany();
      await prisma.supplier.deleteMany();
      await prisma.companyCategoryGroup.deleteMany();
      await prisma.company.deleteMany();
      await prisma.companyGroup.deleteMany();
      await prisma.companyCategory.deleteMany();
      await prisma.categoryType.deleteMany();
    });
    describe("取引先マスタ", () => {
      test("取引先を登録できる", async () => {
        const expected: Company[] = companies.map((c) => {
          return {
            ...c,
            customers: customers,
            suppliers: suppliers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.companyGroup.createMany({ data: companyGroups });
          await prisma.company.createMany({ data: companies });
          await prisma.customer.createMany({ data: customers });
          await prisma.supplier.createMany({ data: suppliers });
        });

        const result = await prisma.company.findMany({
          include: {
            customers: true,
            suppliers: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("取引先を更新できる", async () => {
        const updatedCompanies: Company[] = companies.map((c) => {
          return { ...c, name: "更新取引先" };
        });
        const updatedCustomers: Customer[] = customers.map((c) => {
          return { ...c, name: "更新顧客" };
        });
        const updatedSuppliers: Supplier[] = suppliers.map((c) => {
          return { ...c, name: "更新仕入先" };
        });

        const expected: Company[] = updatedCompanies.map((c) => {
          return {
            ...c,
            customers: updatedCustomers,
            suppliers: updatedSuppliers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const com of updatedCompanies) {
            await prisma.company.update({
              where: { compCode: com.compCode },
              data: com,
            });
          }
          for (const cus of updatedCustomers) {
            await prisma.customer.update({
              where: {
                custCode_custSubNo: {
                  custCode: cus.custCode,
                  custSubNo: cus.custSubNo,
                },
              },
              data: cus,
            });
          }
          for (const sup of updatedSuppliers) {
            await prisma.supplier.update({
              where: {
                supCode_supSubNo: {
                  supCode: sup.supCode,
                  supSubNo: sup.supSubNo,
                },
              },
              data: sup,
            });
          }
        });

        const result = await prisma.company.findMany({
          include: {
            customers: true,
            suppliers: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("取引先を削除できる", async () => {
        const expected: Company[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const com of companies) {
            await prisma.companyCategoryGroup.deleteMany({
              where: { compCode: com.compCode },
            });
            await prisma.customer.deleteMany({
              where: { custCode: com.compCode },
            });
            await prisma.supplier.deleteMany({
              where: { supCode: com.compCode },
            });
            await prisma.company.delete({
              where: { compCode: com.compCode },
            });
            await prisma.companyGroup.delete({
              where: { compGroupCode: com.compGroupCode },
            });
          }
        });

        const result = await prisma.company.findMany();
        expect(result).toEqual(expected);
      });
    });

    describe("顧客マスタ", () => {
      test("顧客を登録できる", async () => {
        const expected: Company[] = companies.map((c) => {
          return {
            ...c,
            customers: customers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.company.createMany({ data: companies });
          await prisma.customer.createMany({ data: customers });
        });

        const result = await prisma.company.findMany({
          include: {
            customers: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("顧客を更新できる", async () => {
        const updatedCompanies: Company[] = companies.map((c) => {
          return { ...c, name: "更新取引先" };
        });
        const updatedCustomers: Customer[] = customers.map((c) => {
          return { ...c, name: "更新顧客" };
        });

        const expected: Company[] = updatedCompanies.map((c) => {
          return {
            ...c,
            customers: updatedCustomers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const com of updatedCompanies) {
            await prisma.company.update({
              where: { compCode: com.compCode },
              data: com,
            });
          }
          for (const cus of updatedCustomers) {
            await prisma.customer.update({
              where: {
                custCode_custSubNo: {
                  custCode: cus.custCode,
                  custSubNo: cus.custSubNo,
                },
              },
              data: cus,
            });
          }
        });

        const result = await prisma.company.findMany({
          include: {
            customers: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("顧客を削除できる", async () => {
        const expected: Customer[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const com of companies) {
            await prisma.customer.deleteMany({
              where: { custCode: com.compCode },
            });
            await prisma.company.delete({
              where: { compCode: com.compCode },
            });
          }
        });

        const result = await prisma.customer.findMany();
        expect(result).toEqual(expected);
      });
    });

    describe("取引先グループマスタ", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.companyGroup.createMany({ data: companyGroups });
          await prisma.company.createMany({ data: companies });
        });
      });

      afterAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.company.deleteMany();
          await prisma.companyGroup.deleteMany();
        });
      });

      test("取引先をグループ化できる", async () => {
        const expected = {
          ...companyGroups[0],
          companies: companies,
        };

        const result = {
          ...(await prisma.companyGroup.findUnique({
            where: { compGroupCode: companyGroups[0].compGroupCode },
          })),
          companies: await prisma.company.findMany({
            where: { compGroupCode: companyGroups[0].compGroupCode },
          }),
        };
        expect(result).toEqual(expected);
      });
    });

    describe("取引先分類マスタ", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.company.createMany({ data: companies });
          await prisma.categoryType.createMany({ data: cateoryTypes });
          await prisma.companyCategory.createMany({ data: companyCategories });
          await prisma.companyCategoryGroup.createMany({
            data: companyCategoryGroups,
          });
        });
      });

      afterAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.companyCategoryGroup.deleteMany();
          await prisma.companyCategory.deleteMany();
          await prisma.categoryType.deleteMany();
          await prisma.company.deleteMany();
        });
      });

      test("取引先を種別ごとに分類できる", async () => {
        const expected: CategoryType[] = cateoryTypes.map((c) => {
          return {
            ...c,
            companyCategories: companyCategories,
          };
        });

        const result = await prisma.categoryType.findMany({
          include: {
            companyCategories: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("取引先を所属ごとに分類できる", async () => {
        const expected: CompanyCategory[] = companyCategories.map((c) => {
          return {
            ...c,
            categoryType: cateoryTypes[0],
            companyCategoryGroups: companyCategoryGroups,
          };
        });

        const result = await prisma.companyCategory.findMany({
          include: {
            categoryType: true,
            companyCategoryGroups: true,
          },
        });
        expect(result).toEqual(expected);
      });
    });

    describe("仕入先マスタ", () => {
      test("仕入先を登録できる", async () => {
        const expected: Company[] = companies.map((c) => {
          return {
            ...c,
            suppliers: suppliers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.company.createMany({ data: companies });
          await prisma.supplier.createMany({ data: suppliers });
        });

        const result = await prisma.company.findMany({
          include: {
            suppliers: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("仕入先を更新できる", async () => {
        const updatedCompanies: Company[] = companies.map((c) => {
          return { ...c, name: "更新取引先" };
        });
        const updatedSuppliers: Supplier[] = suppliers.map((c) => {
          return { ...c, name: "更新仕入先" };
        });

        const expected: Company[] = updatedCompanies.map((c) => {
          return {
            ...c,
            suppliers: updatedSuppliers,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const com of updatedCompanies) {
            await prisma.company.update({
              where: { compCode: com.compCode },
              data: com,
            });
          }
          for (const sup of updatedSuppliers) {
            await prisma.supplier.update({
              where: {
                supCode_supSubNo: {
                  supCode: sup.supCode,
                  supSubNo: sup.supSubNo,
                },
              },
              data: sup,
            });
          }
        });

        const result = await prisma.company.findMany({
          include: {
            suppliers: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("仕入先を削除できる", async () => {
        const expected: Supplier[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const com of companies) {
            await prisma.supplier.deleteMany({
              where: { supCode: com.compCode },
            });
            await prisma.company.delete({
              where: { compCode: com.compCode },
            });
          }
        });

        const result = await prisma.supplier.findMany();
        expect(result).toEqual(expected);
      });
    });
  });
});

describe("Part 2 販売システムのDB設計", () => {
  describe("Chapter 5 受注業務のDB設計", () => {
    describe("受注と受注明細", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.employee.deleteMany();
          await prisma.customer.deleteMany();
          await prisma.company.deleteMany();
          await prisma.product.deleteMany();
          await prisma.orderDetail.deleteMany();
          await prisma.order.deleteMany();

          await prisma.employee.createMany({ data: employees });
          await prisma.company.createMany({ data: companies });
          await prisma.customer.createMany({ data: customers });
          await prisma.product.createMany({ data: products });
        });
      });

      test("受注を登録できる", async () => {
        const expected: Order[] = orders.map((o) => {
          return {
            ...o,
            orderDetails: orderDetails.filter((od) => od.orderNo === o.orderNo),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.order.createMany({ data: orders });
          await prisma.orderDetail.createMany({ data: orderDetails });
        });

        const result = await prisma.order.findMany({
          include: {
            orderDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("受注を更新できる", async () => {
        const updatedOrders: Order[] = orders.map((o) => {
          return { ...o, orderAmnt: 1000 };
        });
        const updatedOrderDetails: OrderDetail[] = orderDetails.map((o) => {
          return { ...o, quantity: 10 };
        });

        const expected: Order[] = updatedOrders.map((o) => {
          return {
            ...o,
            orderDetails: updatedOrderDetails.filter(
              (od) => od.orderNo === o.orderNo,
            ),
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const order of updatedOrders) {
            await prisma.order.update({
              where: { orderNo: order.orderNo },
              data: order,
            });
          }
          for (const orderDetail of updatedOrderDetails) {
            await prisma.orderDetail.update({
              where: {
                orderNo_soRowNo: {
                  orderNo: orderDetail.orderNo,
                  soRowNo: orderDetail.soRowNo,
                },
              },
              data: orderDetail,
            });
          }
        });

        const result = await prisma.order.findMany({
          include: {
            orderDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("受注を削除できる", async () => {
        const expected: Order[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const order of orders) {
            await prisma.orderDetail.deleteMany({
              where: { orderNo: order.orderNo },
            });
            await prisma.order.delete({
              where: { orderNo: order.orderNo },
            });
          }
        });

        const result = await prisma.order.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 6 出荷／売上業務のDB設計", () => {
    describe("売上と売上明細", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.employee.deleteMany();
          await prisma.customer.deleteMany();
          await prisma.company.deleteMany();
          await prisma.product.deleteMany();
          await prisma.orderDetail.deleteMany();
          await prisma.order.deleteMany();
          await prisma.invoiceDetail.deleteMany();
          await prisma.invoice.deleteMany();
          await prisma.salesDetail.deleteMany();
          await prisma.sales.deleteMany();

          await prisma.employee.createMany({ data: employees });
          await prisma.company.createMany({ data: companies });
          await prisma.customer.createMany({ data: customers });
          await prisma.product.createMany({ data: products });
          await prisma.order.createMany({ data: orders });
          await prisma.orderDetail.createMany({ data: orderDetails });
        });
      });

      test("売上を登録できる", async () => {
        const expected: Sales[] = sales.map((s) => {
          return {
            ...s,
            salesDetails: salesDetails.filter((sd) => sd.salesNo === s.salesNo),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.sales.createMany({ data: sales });
          await prisma.salesDetail.createMany({ data: salesDetails });
        });

        const result = await prisma.sales.findMany({
          include: {
            salesDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("売上を更新できる", async () => {
        const updatedSales: Sales[] = sales.map((s) => {
          return { ...s, salesAmnt: 1000 };
        });
        const updatedSalesDetails: SalesDetail[] = salesDetails.map((sd) => {
          return { ...sd, quantity: 10 };
        });

        const expected: Sales[] = updatedSales.map((s) => {
          return {
            ...s,
            salesDetails: updatedSalesDetails.filter(
              (sd) => sd.salesNo === s.salesNo,
            ),
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const sales of updatedSales) {
            await prisma.sales.update({
              where: { salesNo: sales.salesNo },
              data: sales,
            });
          }
          for (const salesDetail of updatedSalesDetails) {
            await prisma.salesDetail.update({
              where: {
                salesNo_rowNo: {
                  salesNo: salesDetail.salesNo,
                  rowNo: salesDetail.rowNo,
                },
              },
              data: salesDetail,
            });
          }
        });

        const result = await prisma.sales.findMany({
          include: {
            salesDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("売上を削除できる", async () => {
        const expected: Sales[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const sale of sales) {
            await prisma.salesDetail.deleteMany({
              where: { salesNo: sale.salesNo },
            });
            await prisma.sales.delete({
              where: { salesNo: sale.salesNo },
            });
          }
        });

        const result = await prisma.sales.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 7 請求業務のDB設計", () => {
    describe("売上／請求／回収に関連するマスタ体系", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.area.deleteMany();
          await prisma.destination.deleteMany();
          await prisma.customer.deleteMany();
          await prisma.company.deleteMany();
          await prisma.companyGroup.deleteMany();
          await prisma.product.deleteMany();
          await prisma.orderDetail.deleteMany();
          await prisma.order.deleteMany();
          await prisma.invoiceDetail.deleteMany();
          await prisma.invoice.deleteMany();
          await prisma.salesDetail.deleteMany();
          await prisma.sales.deleteMany();

          await prisma.companyGroup.createMany({ data: companyGroups });
          await prisma.company.createMany({ data: companies });
          await prisma.product.createMany({ data: products });
          await prisma.order.createMany({ data: orders });
          await prisma.orderDetail.createMany({ data: orderDetails });
          await prisma.sales.createMany({ data: sales });
          await prisma.salesDetail.createMany({ data: salesDetails });
        });
      });

      test("出荷先を登録できる", async () => {
        const expected: Customer[] = customers.map((c) => {
          return {
            ...c,
            destinations: destinations.filter((d) => d.custCode === c.custCode),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.customer.createMany({ data: customers });
          await prisma.area.createMany({ data: areas });
          await prisma.destination.createMany({ data: destinations });
        });

        const result = await prisma.customer.findMany({
          include: {
            destinations: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("出荷先を更新できる", async () => {
        const updatedCustomers: Customer[] = customers.map((c) => {
          return { ...c, name: "updated" };
        });
        const updatedDestinations: Destination[] = destinations.map((d) => {
          return { ...d, distName: "updated" };
        });

        const expected: Customer[] = updatedCustomers.map((c) => {
          return {
            ...c,
            destinations: updatedDestinations.filter(
              (d) => d.custCode === c.custCode,
            ),
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const customer of updatedCustomers) {
            await prisma.customer.update({
              where: {
                custCode_custSubNo: {
                  custCode: customer.custCode,
                  custSubNo: customer.custSubNo,
                },
              },
              data: customer,
            });
          }
          for (const destination of updatedDestinations) {
            await prisma.destination.update({
              where: {
                custCode_distNo_custSubNo: {
                  custCode: destination.custCode,
                  distNo: destination.distNo,
                  custSubNo: destination.custSubNo,
                },
              },
              data: destination,
            });
          }
        });

        const result = await prisma.customer.findMany({
          include: {
            destinations: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("出荷先を削除できる", async () => {
        const expected: Destination[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const customer of customers) {
            await prisma.destination.deleteMany({
              where: { custCode: customer.custCode },
            });
            await prisma.customer.delete({
              where: {
                custCode_custSubNo: {
                  custCode: customer.custCode,
                  custSubNo: customer.custSubNo,
                },
              },
            });
            await prisma.area.deleteMany({
              where: { areaCode: customer.arCode },
            });
          }
        });

        const result = await prisma.destination.findMany();
        expect(result).toEqual(expected);
      });
    });

    describe("請求業務の処理", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.customer.deleteMany();
          await prisma.company.deleteMany();
          await prisma.companyGroup.deleteMany();
          await prisma.product.deleteMany();
          await prisma.orderDetail.deleteMany();
          await prisma.order.deleteMany();
          await prisma.invoiceDetail.deleteMany();
          await prisma.invoice.deleteMany();
          await prisma.salesDetail.deleteMany();
          await prisma.sales.deleteMany();

          await prisma.companyGroup.createMany({ data: companyGroups });
          await prisma.company.createMany({ data: companies });
          await prisma.product.createMany({ data: products });
          await prisma.order.createMany({ data: orders });
          await prisma.orderDetail.createMany({ data: orderDetails });
          await prisma.sales.createMany({ data: sales });
          await prisma.salesDetail.createMany({ data: salesDetails });
        });
      });

      test("請求を登録できる", async () => {
        const expected: Invoice[] = invoices.map((i) => {
          return {
            ...i,
            invoiceDetails: invoiceDetails.filter(
              (id) => id.invoiceNo === i.invoiceNo,
            ),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.invoice.createMany({ data: invoices });
          await prisma.invoiceDetail.createMany({ data: invoiceDetails });
        });

        const result = await prisma.invoice.findMany({
          include: {
            invoiceDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("請求を更新できる", async () => {
        const updatedInvoices: Invoice[] = invoices.map((i) => {
          return { ...i, monthSales: 1000 };
        });
        const updatedInvoiceDetails: InvoiceDetail[] = invoiceDetails.map(
          (id) => {
            return { ...id };
          },
        );

        const expected: Invoice[] = updatedInvoices.map((i) => {
          return {
            ...i,
            invoiceDetails: updatedInvoiceDetails.filter(
              (id) => id.invoiceNo === i.invoiceNo,
            ),
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const invoice of updatedInvoices) {
            await prisma.invoice.update({
              where: { invoiceNo: invoice.invoiceNo },
              data: invoice,
            });
          }
          for (const invoiceDetail of updatedInvoiceDetails) {
            await prisma.invoiceDetail.update({
              where: {
                invoiceNo_salesNo_rowNo: {
                  invoiceNo: invoiceDetail.invoiceNo,
                  salesNo: invoiceDetail.salesNo,
                  rowNo: invoiceDetail.rowNo,
                },
              },
              data: invoiceDetail,
            });
          }
        });

        const result = await prisma.invoice.findMany({
          include: {
            invoiceDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("請求を削除できる", async () => {
        const expected: Invoice[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const invoice of invoices) {
            await prisma.invoiceDetail.deleteMany({
              where: { invoiceNo: invoice.invoiceNo },
            });
            await prisma.invoice.delete({
              where: { invoiceNo: invoice.invoiceNo },
            });
          }
        });

        const result = await prisma.invoice.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 8 回収業務のDB設計", () => {
    describe("銀行再編に対応した入金口座マスタ", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.bankAccount.deleteMany();
        });
      });

      test("入金口座を登録できる", async () => {
        const expected: BankAccount[] = bankAccounts.map((b) => {
          return {
            ...b,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.bankAccount.createMany({ data: bankAccounts });
        });

        const result = await prisma.bankAccount.findMany();
        expect(result).toEqual(expected);
      });

      test("入金口座を更新できる", async () => {
        const updatedBankAccounts: BankAccount[] = bankAccounts.map((b) => {
          return { ...b, reciveActName: "updated" };
        });

        const expected: BankAccount[] = updatedBankAccounts.map((b) => {
          return {
            ...b,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const bankAccount of updatedBankAccounts) {
            await prisma.bankAccount.update({
              where: { bankAcutCode: bankAccount.bankAcutCode },
              data: bankAccount,
            });
          }
        });

        const result = await prisma.bankAccount.findMany();
        expect(result).toEqual(expected);
      });

      test("入金口座を削除できる", async () => {
        const expected: BankAccount[] = [];
        await prisma.$transaction(async (prisma) => {
          await prisma.bankAccount.deleteMany({
            where: { bankAcutCode: bankAccounts[0].bankAcutCode },
          });
        });

        const result = await prisma.bankAccount.findMany({
          where: { bankAcutCode: bankAccounts[0].bankAcutCode },
        });
        expect(result).toEqual(expected);
      });
    });

    describe("請求と入金業務の流れ", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.credit.deleteMany();
        });
      });

      test("入金を登録できる", async () => {
        const expected: Credit[] = credits.map((c) => {
          return {
            ...c,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.credit.createMany({ data: credits });
        });

        const result = await prisma.credit.findMany();
        expect(result).toEqual(expected);
      });

      test("入金を更新できる", async () => {
        const updatedCredits: Credit[] = credits.map((c) => {
          return { ...c, receivedAmnt: 1000 };
        });

        const expected: Credit[] = updatedCredits.map((c) => {
          return {
            ...c,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const credit of updatedCredits) {
            await prisma.credit.update({
              where: { creditNo: credit.creditNo },
              data: credit,
            });
          }
        });

        const result = await prisma.credit.findMany();
        expect(result).toEqual(expected);
      });

      test("入金を削除できる", async () => {
        const expected: Credit[] = [];
        await prisma.$transaction(async (prisma) => {
          await prisma.credit.deleteMany({
            where: { creditNo: credits[0].creditNo },
          });
        });

        const result = await prisma.credit.findMany({
          where: { creditNo: credits[0].creditNo },
        });
        expect(result).toEqual(expected);
      });
    });
  });
});

describe("Part 3 仕入／在庫システムのDB設計", () => {
  describe("Chapter 9 発注／仕入業務のDB設計", () => {
    describe("MRP所要量計算", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.bom.deleteMany();
          await prisma.product.deleteMany();
        });
      });

      test("部品表を登録できる", async () => {
        const newProducts: Product[] = [
          {
            ...products[0],
          },
          {
            ...products[0],
            prodCode: "001",
            name: "いちご蒸缶",
            prodType: "2",
          },
          {
            ...products[0],
            prodCode: "002",
            name: "いちご蒸缶セット",
            prodType: "2",
          },
          {
            ...products[0],
            prodCode: "X01",
            name: "生うに",
            prodType: "3",
          },
          {
            ...products[0],
            prodCode: "X02",
            name: "大アワビ",
            prodType: "3",
          },
          {
            ...products[0],
            prodCode: "Z01",
            name: "缶",
            prodType: "4",
          },
        ];

        const newBoms: Bom[] = [
          {
            ...boms[0],
          },
          {
            ...boms[0],
            prodCode: "001",
            bomCode: "X01",
            quantity: 2,
          },
          {
            ...boms[0],
            prodCode: "001",
            bomCode: "X02",
            quantity: 1,
          },
          {
            ...boms[0],
            prodCode: "001",
            bomCode: "Z01",
            quantity: 1,
          },
          {
            ...boms[0],
            prodCode: "002",
            bomCode: "001",
            quantity: 2,
          },
        ];
        const expected: Product[] = newProducts.map((p) => {
          return {
            ...p,
            boms: newBoms.filter((b) => b.prodCode === p.prodCode),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.product.createMany({ data: newProducts });
          await prisma.bom.createMany({ data: newBoms });
        });

        const result = await prisma.product.findMany({
          include: {
            boms: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("部品表を更新できる", async () => {
        const updatedProducts: Product[] = products.map((p) => {
          return { ...p, name: "updated" };
        });
        const updatedBoms: Bom[] = boms.map((b) => {
          return { ...b, quantity: 10 };
        });

        const expected: Product[] = updatedProducts.map((p) => {
          return {
            ...p,
            boms: updatedBoms.filter((b) => b.prodCode === p.prodCode),
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const product of updatedProducts) {
            await prisma.product.update({
              where: { prodCode: product.prodCode },
              data: product,
            });
          }

          for (const bom of updatedBoms) {
            await prisma.bom.update({
              where: {
                prodCode_bomCode: {
                  prodCode: bom.prodCode,
                  bomCode: bom.bomCode,
                },
              },
              data: bom,
            });
          }
        });

        const result = await prisma.product.findMany({
          where: { prodCode: products[0].prodCode },
          include: {
            boms: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("部品表を削除できる", async () => {
        const expected: Bom[] = [];
        await prisma.$transaction(async (prisma) => {
          await prisma.bom.deleteMany({
            where: { prodCode: products[0].prodCode },
          });
          await prisma.product.delete({
            where: { prodCode: products[0].prodCode },
          });
        });

        const result = await prisma.bom.findMany({
          where: { prodCode: products[0].prodCode },
        });
        expect(result).toEqual(expected);
      });
    });

    describe("発注データのテーブル設計", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.employee.deleteMany();
          await prisma.supplier.deleteMany();
          await prisma.bom.deleteMany();
          await prisma.product.deleteMany();
          await prisma.orderDetail.deleteMany();
          await prisma.order.deleteMany();
          await prisma.purchaseOrderDetail.deleteMany();
          await prisma.purchaseOrder.deleteMany();

          await prisma.employee.createMany({ data: employees });
          await prisma.supplier.createMany({ data: suppliers });
          await prisma.product.createMany({ data: products });
          await prisma.order.createMany({ data: orders });
          await prisma.orderDetail.createMany({ data: orderDetails });
        });
      });

      test("発注を登録できる", async () => {
        const expected: PurchaseOrder[] = purchaseOrders.map((po) => {
          return {
            ...po,
            purchaseOrderDetails: purchaseOrderDetails.filter(
              (pod) => pod.poNo === po.poNo,
            ),
          };
        });

        await prisma.$transaction(async (prisma) => {
          await prisma.purchaseOrder.createMany({ data: purchaseOrders });
          await prisma.purchaseOrderDetail.createMany({
            data: purchaseOrderDetails,
          });
        });

        const result = await prisma.purchaseOrder.findMany({
          include: {
            purchaseOrderDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("発注を更新できる", async () => {
        const updatedPurchaseOrders: PurchaseOrder[] = purchaseOrders.map(
          (po) => {
            return { ...po, poAmnt: 1000 };
          },
        );
        const updatedPurchaseOrderDetails: PurchaseOrderDetail[] =
          purchaseOrderDetails.map((pod) => {
            return { ...pod, poQt: 10 };
          });
        const expected: PurchaseOrder[] = updatedPurchaseOrders.map((po) => {
          return {
            ...po,
            purchaseOrderDetails: updatedPurchaseOrderDetails.filter(
              (pod) => pod.poNo === po.poNo,
            ),
          };
        });

        await prisma.$transaction(async (prisma) => {
          for (const purchaseOrder of updatedPurchaseOrders) {
            await prisma.purchaseOrder.update({
              where: { poNo: purchaseOrder.poNo },
              data: purchaseOrder,
            });
          }
          for (const purchaseOrderDetail of updatedPurchaseOrderDetails) {
            await prisma.purchaseOrderDetail.update({
              where: {
                poRowNo_poNo: {
                  poRowNo: purchaseOrderDetail.poRowNo,
                  poNo: purchaseOrderDetail.poNo,
                },
              },
              data: purchaseOrderDetail,
            });
          }
        });

        const result = await prisma.purchaseOrder.findMany({
          include: {
            purchaseOrderDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("発注を削除できる", async () => {
        const expected: PurchaseOrder[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const purchaseOrder of purchaseOrders) {
            await prisma.purchaseOrderDetail.deleteMany({
              where: { poNo: purchaseOrder.poNo },
            });
            await prisma.purchaseOrder.delete({
              where: { poNo: purchaseOrder.poNo },
            });
          }
        });

        const result = await prisma.purchaseOrder.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 10 入庫／倉庫移動業務のDB設計", () => {
    describe("部門間取引", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.location.deleteMany();
          await prisma.stock.deleteMany();
          await prisma.warehouseDepartment.deleteMany();
          await prisma.department.deleteMany();
          await prisma.warehouse.deleteMany();

          await prisma.department.createMany({ data: departments });
        });
      });

      test("在庫データを登録できる", async () => {
        const expected: Warehouse[] = warehouses.map((s) => {
          return {
            ...s,
            warehouseDepartments: warehouseDepartments.filter(
              (whd) => whd.whCode === s.whCode,
            ),
            stocks: stocks.filter((st) => st.whCode === s.whCode),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.warehouse.createMany({ data: warehouses });
          await prisma.warehouseDepartment.createMany({
            data: warehouseDepartments,
          });
          await prisma.stock.createMany({ data: stocks });
        });

        const result = await prisma.warehouse.findMany({
          include: {
            stocks: true,
            warehouseDepartments: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("在庫データを更新できる", async () => {
        const updatedWarehouses: Warehouse[] = warehouses.map((s) => {
          return { ...s, whName: "updated" };
        });
        const updatedWarehouseDepartments: WarehouseDepartment[] =
          warehouseDepartments.map((whd) => {
            return { ...whd };
          });
        const updatedStocks: Stock[] = stocks.map((st) => {
          return { ...st, actual: 10 };
        });

        const expected: Warehouse[] = updatedWarehouses.map((s) => {
          return {
            ...s,
            warehouseDepartments: updatedWarehouseDepartments.filter(
              (whd) => whd.whCode === s.whCode,
            ),
            stocks: updatedStocks.filter((st) => st.whCode === s.whCode),
          };
        });

        await prisma.$transaction(async (prisma) => {
          for (const warehouse of updatedWarehouses) {
            await prisma.warehouse.update({
              where: { whCode: warehouse.whCode },
              data: warehouse,
            });
          }
          for (const warehouseDepartment of updatedWarehouseDepartments) {
            await prisma.warehouseDepartment.update({
              where: {
                whCode_deptCode_startDate: {
                  whCode: warehouseDepartment.whCode,
                  deptCode: warehouseDepartment.deptCode,
                  startDate: warehouseDepartment.startDate,
                },
              },
              data: warehouseDepartment,
            });
          }
          for (const stock of updatedStocks) {
            await prisma.stock.update({
              where: {
                whCode_prodCode_rotNo_stockType_qualityType: {
                  whCode: stock.whCode,
                  prodCode: stock.prodCode,
                  rotNo: stock.rotNo,
                  stockType: stock.stockType,
                  qualityType: stock.qualityType,
                },
              },
              data: stock,
            });
          }
        });

        const result = await prisma.warehouse.findMany({
          include: {
            stocks: true,
            warehouseDepartments: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("在庫データを削除できる", async () => {
        const expected: Warehouse[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const warehouse of warehouses) {
            await prisma.warehouseDepartment.deleteMany({
              where: { whCode: warehouse.whCode },
            });
            await prisma.stock.deleteMany({
              where: { whCode: warehouse.whCode },
            });
            await prisma.warehouse.delete({
              where: { whCode: warehouse.whCode },
            });
          }
        });

        const result = await prisma.warehouse.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 11 在庫管理業のDB設計", () => {
    beforeAll(async () => {
      await prisma.$transaction(async (prisma) => {
        await prisma.location.deleteMany();
        await prisma.stock.deleteMany();
        await prisma.warehouse.deleteMany();
        await prisma.product.deleteMany();

        await prisma.product.createMany({ data: products });
      });
    });

    describe("棚番管理", () => {
      test("棚番を登録できる", async () => {
        const expected: Warehouse[] = warehouses.map((w) => {
          return {
            ...w,
            locations: locations.filter((l) => l.whCode === w.whCode),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.warehouse.createMany({ data: warehouses });
          await prisma.location.createMany({ data: locations });
        });

        const result = await prisma.warehouse.findMany({
          include: {
            locations: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("棚番を更新できる", async () => {
        const updatedWarehouses: Warehouse[] = warehouses.map((w) => {
          return { ...w, whName: "updated" };
        });
        const updatedLocations: Location[] = locations.map((l) => {
          return { ...l };
        });

        const expected: Warehouse[] = updatedWarehouses.map((w) => {
          return {
            ...w,
            locations: updatedLocations.filter((l) => l.whCode === w.whCode),
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const warehouse of updatedWarehouses) {
            await prisma.warehouse.update({
              where: { whCode: warehouse.whCode },
              data: warehouse,
            });
          }
          for (const location of updatedLocations) {
            await prisma.location.update({
              where: {
                whCode_locationCode_prodCode: {
                  whCode: location.whCode,
                  locationCode: location.locationCode,
                  prodCode: location.prodCode,
                },
              },
              data: location,
            });
          }
        });

        const result = await prisma.warehouse.findMany({
          include: {
            locations: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("棚番を削除できる", async () => {
        const expected: Warehouse[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const warehouse of warehouses) {
            await prisma.location.deleteMany({
              where: { whCode: warehouse.whCode },
            });
            await prisma.warehouse.delete({
              where: { whCode: warehouse.whCode },
            });
          }
        });

        const result = await prisma.warehouse.findMany();
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 12  仕入／支払業務のDB設計", () => {
    describe("仕入データのテーブル設計", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.purchaseOrderDetail.deleteMany();
          await prisma.purchaseOrder.deleteMany();
          await prisma.purchaseDetail.deleteMany();
          await prisma.purchase.deleteMany();
          await prisma.product.deleteMany();
          await prisma.supplier.deleteMany();

          await prisma.supplier.createMany({ data: suppliers });
          await prisma.product.createMany({ data: products });
          await prisma.purchaseOrder.createMany({ data: purchaseOrders });
          await prisma.purchaseOrderDetail.createMany({
            data: purchaseOrderDetails,
          });
        });
      });

      test("仕入を登録できる", async () => {
        const expected: Purchase[] = purchases.map((b) => {
          return {
            ...b,
            purchaseDetails: purchaseDetails.filter((bd) => bd.puNo === b.puNo),
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.purchase.createMany({ data: purchases });
          await prisma.purchaseDetail.createMany({ data: purchaseDetails });
        });

        const result = await prisma.purchase.findMany({
          include: {
            purchaseDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("仕入を更新できる", async () => {
        const updatePurchases: Purchase[] = purchases.map((b) => {
          return { ...b, puAmmount: 1000 };
        });
        const updatedBuyingDetails: PurchaseDetail[] = purchaseDetails.map(
          (bd) => {
            return { ...bd, puQuantity: 10 };
          },
        );
        const expected: Purchase[] = updatePurchases.map((b) => {
          return {
            ...b,
            purchaseDetails: updatedBuyingDetails.filter(
              (bd) => bd.puNo === b.puNo,
            ),
          };
        });

        await prisma.$transaction(async (prisma) => {
          for (const purchase of updatePurchases) {
            await prisma.purchase.update({
              where: { puNo: purchase.puNo },
              data: purchase,
            });
          }
          for (const purchaseDetail of updatedBuyingDetails) {
            await prisma.purchaseDetail.update({
              where: {
                puRowNo_puNo: {
                  puRowNo: purchaseDetail.puRowNo,
                  puNo: purchaseDetail.puNo,
                },
              },
              data: purchaseDetail,
            });
          }
        });

        const result = await prisma.purchase.findMany({
          include: {
            purchaseDetails: true,
          },
        });
        expect(result).toEqual(expected);
      });

      test("仕入を削除できる", async () => {
        const expected: Purchase[] = [];
        await prisma.$transaction(async (prisma) => {
          for (const purchase of purchases) {
            await prisma.purchaseDetail.deleteMany({
              where: { puNo: purchase.puNo },
            });
            await prisma.purchase.delete({
              where: { puNo: purchase.puNo },
            });
          }
        });

        const result = await prisma.purchase.findMany();
        expect(result).toEqual(expected);
      });
    });

    describe("支払いデータのテーブル設計", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.department.deleteMany();
          await prisma.supplier.deleteMany();
          await prisma.purchase.deleteMany();
          await prisma.purchaseDetail.deleteMany();
          await prisma.payment.deleteMany();

          await prisma.department.createMany({ data: departments });
          await prisma.supplier.createMany({ data: suppliers });
          await prisma.purchase.createMany({ data: purchases });
          await prisma.purchaseDetail.createMany({ data: purchaseDetails });
        });
      });

      test("支払いを登録できる", async () => {
        const expected: Payment[] = payments.map((p) => {
          return {
            ...p,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.payment.createMany({ data: payments });
        });

        const result = await prisma.payment.findMany();
        expect(result).toEqual(expected);
      });

      test("支払いを更新できる", async () => {
        const updatedPayments: Payment[] = payments.map((p) => {
          return { ...p, payAmnt: 1000 };
        });

        const expected: Payment[] = updatedPayments.map((p) => {
          return {
            ...p,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const payment of updatedPayments) {
            await prisma.payment.update({
              where: { payNo: payment.payNo },
              data: payment,
            });
          }
        });

        const result = await prisma.payment.findMany();
        expect(result).toEqual(expected);
      });

      test("支払いを削除できる", async () => {
        const expected: Payment[] = [];
        await prisma.$transaction(async (prisma) => {
          await prisma.payment.deleteMany({
            where: { payNo: payments[0].payNo },
          });
        });

        const result = await prisma.payment.findMany({
          where: { payNo: payments[0].payNo },
        });
        expect(result).toEqual(expected);
      });
    });
  });

  describe("Chapter 13 業務全般に関連する処理のDB設計", () => {
    describe("与信チェック", () => {
      beforeAll(async () => {
        await prisma.$transaction(async (prisma) => {
          await prisma.supplier.deleteMany();
          await prisma.creditBalance.deleteMany();
        });
      });

      test("与信残高を登録できる", async () => {
        const expected: CreditBalance[] = creditBalances.map((cb) => {
          return {
            ...cb,
          };
        });
        await prisma.$transaction(async (prisma) => {
          await prisma.creditBalance.createMany({ data: creditBalances });
        });

        const result = await prisma.creditBalance.findMany();
        expect(result).toEqual(expected);
      });

      test("与信残高を更新できる", async () => {
        const updatedCreditBalances: CreditBalance[] = creditBalances.map(
          (cb) => {
            return { ...cb, orderBalance: 1000 };
          },
        );

        const expected: CreditBalance[] = updatedCreditBalances.map((cb) => {
          return {
            ...cb,
          };
        });
        await prisma.$transaction(async (prisma) => {
          for (const creditBalance of updatedCreditBalances) {
            await prisma.creditBalance.update({
              where: { compCode: creditBalance.compCode },
              data: creditBalance,
            });
          }
        });

        const result = await prisma.creditBalance.findMany();
        expect(result).toEqual(expected);
      });

      test("与信残高を削除できる", async () => {
        const expected: CreditBalance[] = [];
        await prisma.$transaction(async (prisma) => {
          await prisma.creditBalance.deleteMany({
            where: { compCode: creditBalances[0].compCode },
          });
        });

        const result = await prisma.creditBalance.findMany({
          where: { compCode: creditBalances[0].compCode },
        });
        expect(result).toEqual(expected);
      });
    });
  });
});
