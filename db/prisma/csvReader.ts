import {
  Department,
  Employee,
  Product,
  Bom,
  PriceByCustomer,
  ProductCategory,
  AlternateProduct,
  Company,
  Customer,
  Destination,
  Area,
  Consumer,
  Supplier,
  CompanyGroup,
  CategoryType,
  CompanyCategory,
  CompanyCategoryGroup,
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
  WarehouseDepartment,
  Warehouse,
  Location,
  Stock,
  Purchase,
  PurchaseDetail,
  Payment,
  CreditBalance,
} from "@prisma/client";
import * as fs from 'fs';
import * as path from 'path';
import {fileURLToPath} from 'url';

const __filename = fileURLToPath(import.meta.url);

// 👇️ "/home/john/Desktop/javascript"
const __dirname = path.dirname(__filename);
console.log('directory-name 👉️', __dirname);

// 👇️ "/home/borislav/Desktop/javascript/dist/index.html"
console.log(path.join(__dirname, '/dist', 'index.html'));

const encodeing = "utf-8";
const filePath = (fileName: string) => path.join(`${__dirname}/data`, fileName);
export const departments: Department[] = fs
  .readFileSync(filePath("department.csv"), encodeing)
  .trim()
  .split("\n")
  .slice(1)
  .map((line) => {
    const [
      deptCode,
      startDate,
      endDate,
      name,
      layer,
      psth,
      lowestType,
      slitYn,
      createDate,
      creator,
      updateDate,
      updater,
    ] = line.split(",");
    return {
      deptCode,
      startDate: new Date(startDate),
      endDate: new Date(endDate),
      name,
      layer: parseInt(layer, 10),
      psth,
      lowestType: parseInt(lowestType, 10),
      slitYn: Number(slitYn),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const employees: Employee[] = fs
  .readFileSync(filePath("employee.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      empCode,
      name,
      kana,
      loginPassword,
      tel,
      fax,
      deptCode,
      startDate,
      occuCode,
      approvalCode,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      empCode,
      name,
      kana,
      loginPassword,
      tel,
      fax,
      deptCode,
      startDate: new Date(startDate),
      occuCode,
      approvalCode,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const products: Product[] = fs
  .readFileSync(filePath("product.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      prodCode,
      fullname,
      name,
      kana,
      prodType,
      serialNo,
      unitprice,
      poPrice,
      primeCost,
      taxType,
      categoryCode,
      wideUseType,
      stockManageType,
      stockReserveType,
      supCode,
      supSubNo,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      prodCode,
      fullname,
      name,
      kana,
      prodType,
      serialNo,
      unitprice: Number(unitprice),
      poPrice: Number(poPrice),
      primeCost: Number(primeCost),
      taxType: Number(taxType),
      categoryCode,
      wideUseType: Number(wideUseType),
      stockManageType: Number(stockManageType),
      stockReserveType: Number(stockReserveType),
      supCode,
      supSubNo: Number(supSubNo),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const boms: Bom[] = fs
  .readFileSync(filePath("bom.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      prodCode,
      bomCode,
      quantity,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      prodCode,
      bomCode,
      quantity: Number(quantity),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const productCategories: ProductCategory[] = fs
  .readFileSync(filePath("productCategory.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      categoryCode,
      name,
      layer,
      path,
      lowestType,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      categoryCode,
      name,
      layer: Number(layer),
      path,
      lowestType: Number(lowestType),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const priceByCustomers: PriceByCustomer[] = fs
  .readFileSync(filePath("priceByCustomer.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      prodCode,
      compCode,
      unitprice,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      prodCode,
      compCode,
      unitprice: Number(unitprice),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const alterNateProducts: AlternateProduct[] = fs
  .readFileSync(filePath("alternateProduct.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      prodCode,
      altProdCode,
      priority,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      prodCode,
      altProdCode,
      priority: Number(priority),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const companys: Company[] = fs
  .readFileSync(filePath("company.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      compCode,
      name,
      kana,
      supType,
      zipCode,
      state,
      address1,
      address2,
      noSalesFlg,
      wideUseType,
      compGroupCode,
      maxCredit,
      tempCreditUp,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      compCode,
      name,
      kana,
      supType: Number(supType),
      zipCode,
      state,
      address1,
      address2,
      noSalesFlg: Number(noSalesFlg),
      wideUseType: Number(wideUseType),
      compGroupCode,
      maxCredit: Number(maxCredit),
      tempCreditUp: Number(tempCreditUp),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const customers: Customer[] = fs
  .readFileSync(filePath("customer.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      custCode,
      custSubNo,
      custType,
      arCode,
      arSubNo,
      payerCode,
      payerSubNo,
      name,
      kana,
      empCode,
      custUserName,
      custUserDepName,
      custZipCode,
      custState,
      custAddress1,
      custAddress2,
      custTel,
      custFax,
      custEmail,
      custArType,
      custCloseDate1,
      custPayMonths1,
      custPayDates1,
      custPayMethod1,
      custCloseDate2,
      custPayMonths2,
      custPayDates2,
      custPayMethod2,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      custCode,
      custSubNo: Number(custSubNo),
      custType: Number(custType),
      arCode,
      arSubNo: Number(arSubNo),
      payerCode: payerCode,
      payerSubNo: Number(payerSubNo),
      name,
      kana,
      empCode,
      custUserName,
      custUserDepName,
      custZipCode,
      custState,
      custAddress1,
      custAddress2,
      custTel,
      custFax,
      custEmail,
      custArType: Number(custArType),
      custCloseDate1: Number(custCloseDate1),
      custPayMonths1: Number(custPayMonths1),
      custPayDates1: Number(custPayDates1),
      custPayMethod1: Number(custPayMethod1),
      custCloseDate2: Number(custCloseDate2),
      custPayMonths2: Number(custPayMonths2),
      custPayDates2: Number(custPayDates2),
      custPayMethod2: Number(custPayMethod2),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const areas: Area[] = fs
  .readFileSync(filePath("area.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      areaCode,
      areaName,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      areaCode,
      areaName,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const destinations: Destination[] = fs
  .readFileSync(filePath("destination.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      custCode,
      custSubNo,
      distNo,
      distName,
      areaCode,
      zipCode,
      address1,
      address2,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      custCode,
      custSubNo: Number(custSubNo),
      distNo: Number(distNo),
      distName,
      areaCode,
      zipCode,
      address1,
      address2,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const consumers: Consumer[] = fs
  .readFileSync(filePath("consumer.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      consumerCode,
      lastName,
      firstName,
      lastNameKana,
      firstNameKana,
      loginId,
      email,
      pwd,
      birthDate,
      sex,
      loginDatetime,
      restPoint,
      withdrawalDate,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      consumerCode,
      lastName,
      firstName,
      lastNameKana,
      firstNameKana,
      loginId,
      email,
      pwd,
      birthDate: new Date(birthDate),
      sex: Number(sex),
      loginDatetime: new Date(loginDatetime),
      restPoint: Number(restPoint),
      withdrawalDate: new Date(withdrawalDate),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const suppliers: Supplier[] = fs
  .readFileSync(filePath("supplier.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      supCode,
      supSubNo,
      name,
      kana,
      supEmpName,
      supDepName,
      supZipCode,
      supState,
      supAddress1,
      supAddress2,
      supTel,
      supFax,
      supEmail,
      supCloseDate,
      supPayMonths,
      supPayDates,
      payMethodType,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      supCode,
      supSubNo: Number(supSubNo),
      name,
      kana,
      supEmpName,
      supDepName,
      supZipCode,
      supState,
      supAddress1,
      supAddress2,
      supTel,
      supFax,
      supEmail,
      supCloseDate: Number(supCloseDate),
      supPayMonths: Number(supPayMonths),
      supPayDates: Number(supPayDates),
      payMethodType: Number(payMethodType),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const companyGroups: CompanyGroup[] = fs
  .readFileSync(filePath("companyGroup.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      compGroupCode,
      groupName,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      compGroupCode,
      groupName,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const categoryTypes: CategoryType[] = fs
  .readFileSync(filePath("categoryType.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      categoryTypeCode,
      categoryTypeName,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      categoryTypeCode,
      categoryTypeName,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const companyCategories: CompanyCategory[] = fs
  .readFileSync(filePath("companyCategory.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      categoryTypeCode,
      compCateCode,
      compCateName,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      categoryTypeCode,
      compCateCode,
      compCateName,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const companyCategoryGroups: CompanyCategoryGroup[] = fs
  .readFileSync(filePath("companyCategoryGroup.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      categoryTypeCode,
      compCateCode,
      compCode,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      categoryTypeCode,
      compCateCode,
      compCode,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const orders: Order[] = fs
  .readFileSync(filePath("order.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      orderNo,
      orderDate,
      deptCode,
      startDate,
      custCode,
      custSubNo,
      empCode,
      requiredDate,
      custorderNo,
      whCode,
      orderAmnt,
      cmpTax,
      slipComment,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      orderNo,
      orderDate: new Date(orderDate),
      deptCode,
      startDate: new Date(startDate),
      custCode,
      custSubNo: Number(custSubNo),
      empCode,
      requiredDate: new Date(requiredDate),
      custorderNo,
      whCode,
      orderAmnt: Number(orderAmnt),
      cmpTax: Number(cmpTax),
      slipComment,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const orderDetails: OrderDetail[] = fs
  .readFileSync(filePath("orderDetail.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      orderNo,
      soRowNo,
      prodCode,
      prodName,
      unitprice,
      quantity,
      cmpTaxRate,
      reserveQty,
      deliveryOrderQty,
      deliveredQty,
      completeFlg,
      discount,
      deliveryDate,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      orderNo,
      soRowNo: Number(soRowNo),
      prodCode,
      prodName,
      unitprice: Number(unitprice),
      quantity: Number(quantity),
      cmpTaxRate: Number(cmpTaxRate),
      reserveQty: Number(reserveQty),
      deliveryOrderQty: Number(deliveryOrderQty),
      deliveredQty: Number(deliveredQty),
      completeFlg: Number(completeFlg),
      discount: Number(discount),
      deliveryDate: new Date(deliveryDate),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const sales: Sales[] = fs
  .readFileSync(filePath("sales.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      salesNo,
      orderNo,
      salesDate,
      salesType,
      deptCode,
      startDate,
      compCode,
      empCode,
      salesAmnt,
      cmpTax,
      slipComment,
      updatedNo,
      orgnlNo,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      salesNo,
      orderNo,
      salesDate: new Date(salesDate),
      salesType: Number(salesType),
      deptCode,
      startDate: new Date(startDate),
      compCode,
      empCode,
      salesAmnt: Number(salesAmnt),
      cmpTax: Number(cmpTax),
      slipComment,
      updatedNo: Number(updatedNo),
      orgnlNo,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const salesDetails: SalesDetail[] = fs
  .readFileSync(filePath("salesDetail.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      salesNo,
      rowNo,
      prodCode,
      prodName,
      unitprice,
      deliveredQty,
      quantity,
      discount,
      invoicedDate,
      invoiceNo,
      invoiceDelayType,
      autoJournalDate,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      salesNo,
      rowNo: Number(rowNo),
      prodCode,
      prodName,
      unitprice: Number(unitprice),
      deliveredQty: Number(deliveredQty),
      quantity: Number(quantity),
      discount: Number(discount),
      invoicedDate: new Date(invoicedDate),
      invoiceNo,
      invoiceDelayType: Number(invoiceDelayType),
      autoJournalDate: new Date(autoJournalDate),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const invoices: Invoice[] = fs
  .readFileSync(filePath("invoice.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      invoiceNo,
      invoicedDate,
      compCode,
      custSubNo,
      lastReceived,
      monthSales,
      monthReceived,
      monthInvoice,
      cmpTax,
      invoiceReceived,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      invoiceNo,
      invoicedDate: new Date(invoicedDate),
      compCode,
      custSubNo: Number(custSubNo),
      lastReceived: Number(lastReceived),
      monthSales: Number(monthSales),
      monthReceived: Number(monthReceived),
      monthInvoice: Number(monthInvoice),
      cmpTax: Number(cmpTax),
      invoiceReceived: Number(invoiceReceived),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const invoiceDetails: InvoiceDetail[] = fs
  .readFileSync(filePath("invoiceDetail.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      invoiceNo,
      salesNo,
      rowNo,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      invoiceNo,
      salesNo,
      rowNo: Number(rowNo),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const bankAccounts: BankAccount[] = fs
  .readFileSync(filePath("bankAccount.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      bankAcutCode,
      reciveActName,
      applStartDate,
      applEndDate,
      startActName,
      reciveBankActType,
      reciveActNo,
      bankActType,
      actName,
      deptCode,
      startDate,
      aBankCode,
      aBankBlncCode,
      createDate,
      creator,
      updateDate,
      updater,
      updatePlgDate,
      updatePgm
    ] = line.split(",");
    return {
      bankAcutCode,
      reciveActName,
      applStartDate: new Date(applStartDate),
      applEndDate: new Date(applEndDate),
      startActName,
      reciveBankActType,
      reciveActNo,
      bankActType,
      actName,
      deptCode,
      startDate: new Date(startDate),
      aBankCode,
      aBankBlncCode,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
      updatePlgDate: new Date(updatePlgDate),
      updatePgm
    };
  });

export const credits: Credit[] = fs
  .readFileSync(filePath("credit.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      creditNo,
      creditDate,
      deptCode,
      startDate,
      custCode,
      custSubNo,
      payMethodType,
      bankAcutCode,
      receivedAmnt,
      received,
      createDate,
      creator,
      updateDate,
      updater,
      updatePlgDate,
      updatePgm
    ] = line.split(",");
    return {
      creditNo,
      creditDate: new Date(creditDate),
      deptCode,
      startDate: new Date(startDate),
      custCode,
      custSubNo: Number(custSubNo),
      payMethodType: Number(payMethodType),
      bankAcutCode,
      receivedAmnt: Number(receivedAmnt),
      received: Number(received),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
      updatePlgDate: new Date(updatePlgDate),
      updatePgm
    };
  });

export const purchaseOrders: PurchaseOrder[] = fs
  .readFileSync(filePath("purchaseOrder.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      poNo,
      poDate,
      orderNo,
      supCode,
      supSubNo,
      empCode,
      dueDate,
      whCode,
      poAmnt,
      cmpTax,
      slipComment,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      poNo,
      poDate: new Date(poDate),
      orderNo,
      supCode,
      supSubNo: Number(supSubNo),
      empCode,
      dueDate: new Date(dueDate),
      whCode,
      poAmnt: Number(poAmnt),
      cmpTax: Number(cmpTax),
      slipComment,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const purchaseOrderDetails: PurchaseOrderDetail[] = fs
  .readFileSync(filePath("purchaseOrderDetail.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      poNo,
      poRowNo,
      poRowDspNo,
      orderNo,
      soRowNo,
      prodCode,
      prodName,
      poPrice,
      poQt,
      recivedQt,
      completeFlg,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      poNo,
      poRowNo: Number(poRowNo),
      poRowDspNo: Number(poRowDspNo),
      orderNo,
      soRowNo: Number(soRowNo),
      prodCode,
      prodName,
      poPrice: Number(poPrice),
      poQt: Number(poQt),
      recivedQt: Number(recivedQt),
      completeFlg: Number(completeFlg),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const warehouseDepartments: WarehouseDepartment[] = fs
  .readFileSync(filePath("warehouseDepartment.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      whCode,
      deptCode,
      startDate,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      whCode,
      deptCode,
      startDate: new Date(startDate),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const warehouses: Warehouse[] = fs
  .readFileSync(filePath("warehouse.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      whCode,
      whName,
      whType,
      zipCode,
      state,
      address1,
      address2,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      whCode,
      whName,
      whType,
      zipCode,
      state,
      address1,
      address2,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const locations: Location[] = fs
  .readFileSync(filePath("location.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      whCode,
      locationCode,
      prodCode,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      whCode,
      locationCode,
      prodCode,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const stocks: Stock[] = fs
  .readFileSync(filePath("stock.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      whCode,
      prodCode,
      rotNo,
      stockType,
      qualityType,
      actual,
      valid,
      lastDeliveryDate,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      whCode,
      prodCode,
      rotNo,
      stockType,
      qualityType,
      actual: Number(actual),
      valid: Number(valid),
      lastDeliveryDate: new Date(lastDeliveryDate),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater
    };
  });

export const purchases: Purchase[] = fs
  .readFileSync(filePath("purchase.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      puNo,
      puDate,
      supCode,
      supSubNo,
      empCode,
      startDate,
      poNo,
      deptCode,
      puAmmount,
      cmpTax,
      slipComment,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      puNo,
      puDate: new Date(puDate),
      supCode,
      supSubNo: Number(supSubNo),
      empCode,
      startDate: new Date(startDate),
      poNo,
      deptCode,
      puAmmount: Number(puAmmount),
      cmpTax: Number(cmpTax),
      slipComment,
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const purchaseDetails: PurchaseDetail[] = fs
  .readFileSync(filePath("purchaseDetail.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      puNo,
      puRowNo,
      puRowDspNo,
      poRowNo,
      prodCode,
      whCode,
      prodName,
      poPrice,
      puQuantity,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      puNo,
      puRowNo: Number(puRowNo),
      puRowDspNo: Number(puRowDspNo),
      poRowNo: Number(poRowNo),
      prodCode,
      whCode,
      prodName,
      poPrice: Number(poPrice),
      puQuantity: Number(puQuantity),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const payments: Payment[] = fs
  .readFileSync(filePath("payment.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      payNo,
      payDate,
      deptCode,
      startDate,
      supCode,
      supSubNo,
      payMethodType,
      payAmnt,
      cmpTax,
      completeFlg,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      payNo,
      payDate: Number(payDate),
      deptCode,
      startDate: new Date(startDate),
      supCode,
      supSubNo: Number(supSubNo),
      payMethodType: Number(payMethodType),
      payAmnt: Number(payAmnt),
      cmpTax: Number(cmpTax),
      completeFlg: Number(completeFlg),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });

export const creditBalances: CreditBalance[] = fs
  .readFileSync(filePath("creditBalance.csv"), encodeing)
  .trim() // 末尾の改行を削除
  .split("\n") // 行単位で分割
  .slice(1) // ヘッダー行を除外
  .map((line) => {
    const [
      compCode,
      orderBalance,
      recBalance,
      payBalance,
      createDate,
      creator,
      updateDate,
      updater
    ] = line.split(",");
    return {
      compCode,
      orderBalance: Number(orderBalance),
      recBalance: Number(recBalance),
      payBalance: Number(payBalance),
      createDate: new Date(createDate),
      creator,
      updateDate: new Date(updateDate),
      updater,
    };
  });
