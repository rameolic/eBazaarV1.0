class GetOrderByIdResponse {
  String baseCurrencyCode;
  Object baseDiscountAmount;
  Object baseDiscountInvoiced;
  Object baseGrandTotal;
  Object baseDiscountTaxCompensationAmount;
  Object baseDiscountTaxCompensationInvoiced;
  Object baseShippingAmount;
  Object baseShippingDiscountAmount;
  Object baseShippingInclTax;
  Object baseShippingInvoiced;
  Object baseShippingTaxAmount;
  Object baseSubtotal;
  Object baseSubtotalInclTax;
  Object baseSubtotalInvoiced;
  Object baseTaxAmount;
  Object baseTaxInvoiced;
  Object baseTotalDue;
  Object baseTotalInvoiced;
  Object baseTotalInvoicedCost;
  Object baseTotalPaid;
  Object baseToGlobalRate;
  Object baseToOrderRate;
  Object billingAddressId;
  String createdAt;
  String customerEmail;
  String customerFirstname;
  int customerGroupId;
  int customerId;
  int customerIsGuest;
  String customerLastname;
  int customerNoteNotify;
  Object discountAmount;
  Object discountInvoiced;
  int emailSent;
  int entityId;
  String globalCurrencyCode;
  Object grandTotal;
  Object discountTaxCompensationAmount;
  Object discountTaxCompensationInvoiced;
  String incrementId;
  int isVirtual;
  String orderCurrencyCode;
  String protectCode;
  int quoteId;
  String remoteIp;
  Object shippingAmount;
  String shippingDescription;
  Object shippingDiscountAmount;
  Object shippingDiscountTaxCompensationAmount;
  Object shippingInclTax;
  Object shippingInvoiced;
  Object shippingTaxAmount;
  String state;
  String status;
  String storeCurrencyCode;
  int storeId;
  String storeName;
  int storeToBaseRate;
  int storeToOrderRate;
  Object subtotal;
  Object subtotalInclTax;
  Object subtotalInvoiced;
  Object taxAmount;
  Object taxInvoiced;
  Object totalDue;
  Object totalInvoiced;
  Object totalItemCount;
  Object totalPaid;
  Object totalQtyOrdered;
  String updatedAt;
  int weight;
  List<Items> items;
  BillingAddress billingAddress;
  Payment payment;
  List<StatusHistories> statusHistories;
  ExtensionAttributes extensionAttributes;

  GetOrderByIdResponse(
      {this.baseCurrencyCode,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseGrandTotal,
        this.baseDiscountTaxCompensationAmount,
        this.baseDiscountTaxCompensationInvoiced,
        this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingInclTax,
        this.baseShippingInvoiced,
        this.baseShippingTaxAmount,
        this.baseSubtotal,
        this.baseSubtotalInclTax,
        this.baseSubtotalInvoiced,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.baseTotalDue,
        this.baseTotalInvoiced,
        this.baseTotalInvoicedCost,
        this.baseTotalPaid,
        this.baseToGlobalRate,
        this.baseToOrderRate,
        this.billingAddressId,
        this.createdAt,
        this.customerEmail,
        this.customerFirstname,
        this.customerGroupId,
        this.customerId,
        this.customerIsGuest,
        this.customerLastname,
        this.customerNoteNotify,
        this.discountAmount,
        this.discountInvoiced,
        this.emailSent,
        this.entityId,
        this.globalCurrencyCode,
        this.grandTotal,
        this.discountTaxCompensationAmount,
        this.discountTaxCompensationInvoiced,
        this.incrementId,
        this.isVirtual,
        this.orderCurrencyCode,
        this.protectCode,
        this.quoteId,
        this.remoteIp,
        this.shippingAmount,
        this.shippingDescription,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingInvoiced,
        this.shippingTaxAmount,
        this.state,
        this.status,
        this.storeCurrencyCode,
        this.storeId,
        this.storeName,
        this.storeToBaseRate,
        this.storeToOrderRate,
        this.subtotal,
        this.subtotalInclTax,
        this.subtotalInvoiced,
        this.taxAmount,
        this.taxInvoiced,
        this.totalDue,
        this.totalInvoiced,
        this.totalItemCount,
        this.totalPaid,
        this.totalQtyOrdered,
        this.updatedAt,
        this.weight,
        this.items,
        this.billingAddress,
        this.payment,
        this.statusHistories,
        this.extensionAttributes});

  GetOrderByIdResponse.fromJson(Map<String, dynamic> json) {
    baseCurrencyCode = json['base_currency_code'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseGrandTotal = json['base_grand_total'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseDiscountTaxCompensationInvoiced =
    json['base_discount_tax_compensation_invoiced'];
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingInvoiced = json['base_shipping_invoiced'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    baseSubtotal = json['base_subtotal'];
    baseSubtotalInclTax = json['base_subtotal_incl_tax'];
    baseSubtotalInvoiced = json['base_subtotal_invoiced'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    baseTotalDue = json['base_total_due'];
    baseTotalInvoiced = json['base_total_invoiced'];
    baseTotalInvoicedCost = json['base_total_invoiced_cost'];
    baseTotalPaid = json['base_total_paid'];
    baseToGlobalRate = json['base_to_global_rate'];
    baseToOrderRate = json['base_to_order_rate'];
    billingAddressId = json['billing_address_id'];
    createdAt = json['created_at'];
    customerEmail = json['customer_email'];
    customerFirstname = json['customer_firstname'];
    customerGroupId = json['customer_group_id'];
    customerId = json['customer_id'];
    customerIsGuest = json['customer_is_guest'];
    customerLastname = json['customer_lastname'];
    customerNoteNotify = json['customer_note_notify'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    emailSent = json['email_sent'];
    entityId = json['entity_id'];
    globalCurrencyCode = json['global_currency_code'];
    grandTotal = json['grand_total'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    discountTaxCompensationInvoiced =
    json['discount_tax_compensation_invoiced'];
    incrementId = json['increment_id'];
    isVirtual = json['is_virtual'];
    orderCurrencyCode = json['order_currency_code'];
    protectCode = json['protect_code'];
    quoteId = json['quote_id'];
    remoteIp = json['remote_ip'];
    shippingAmount = json['shipping_amount'];
    shippingDescription = json['shipping_description'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingInvoiced = json['shipping_invoiced'];
    shippingTaxAmount = json['shipping_tax_amount'];
    state = json['state'];
    status = json['status'];
    storeCurrencyCode = json['store_currency_code'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeToBaseRate = json['store_to_base_rate'];
    storeToOrderRate = json['store_to_order_rate'];
    subtotal = json['subtotal'];
    subtotalInclTax = json['subtotal_incl_tax'];
    subtotalInvoiced = json['subtotal_invoiced'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    totalDue = json['total_due'];
    totalInvoiced = json['total_invoiced'];
    totalItemCount = json['total_item_count'];
    totalPaid = json['total_paid'];
    totalQtyOrdered = json['total_qty_ordered'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    if (json['status_histories'] != null) {
      statusHistories = new List<StatusHistories>();
      json['status_histories'].forEach((v) {
        statusHistories.add(new StatusHistories.fromJson(v));
      });
    }
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_discount_invoiced'] = this.baseDiscountInvoiced;
    data['base_grand_total'] = this.baseGrandTotal;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_discount_tax_compensation_invoiced'] =
        this.baseDiscountTaxCompensationInvoiced;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_shipping_invoiced'] = this.baseShippingInvoiced;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['base_subtotal'] = this.baseSubtotal;
    data['base_subtotal_incl_tax'] = this.baseSubtotalInclTax;
    data['base_subtotal_invoiced'] = this.baseSubtotalInvoiced;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_tax_invoiced'] = this.baseTaxInvoiced;
    data['base_total_due'] = this.baseTotalDue;
    data['base_total_invoiced'] = this.baseTotalInvoiced;
    data['base_total_invoiced_cost'] = this.baseTotalInvoicedCost;
    data['base_total_paid'] = this.baseTotalPaid;
    data['base_to_global_rate'] = this.baseToGlobalRate;
    data['base_to_order_rate'] = this.baseToOrderRate;
    data['billing_address_id'] = this.billingAddressId;
    data['created_at'] = this.createdAt;
    data['customer_email'] = this.customerEmail;
    data['customer_firstname'] = this.customerFirstname;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_id'] = this.customerId;
    data['customer_is_guest'] = this.customerIsGuest;
    data['customer_lastname'] = this.customerLastname;
    data['customer_note_notify'] = this.customerNoteNotify;
    data['discount_amount'] = this.discountAmount;
    data['discount_invoiced'] = this.discountInvoiced;
    data['email_sent'] = this.emailSent;
    data['entity_id'] = this.entityId;
    data['global_currency_code'] = this.globalCurrencyCode;
    data['grand_total'] = this.grandTotal;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['discount_tax_compensation_invoiced'] =
        this.discountTaxCompensationInvoiced;
    data['increment_id'] = this.incrementId;
    data['is_virtual'] = this.isVirtual;
    data['order_currency_code'] = this.orderCurrencyCode;
    data['protect_code'] = this.protectCode;
    data['quote_id'] = this.quoteId;
    data['remote_ip'] = this.remoteIp;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_description'] = this.shippingDescription;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        this.shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['shipping_invoiced'] = this.shippingInvoiced;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    data['state'] = this.state;
    data['status'] = this.status;
    data['store_currency_code'] = this.storeCurrencyCode;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_to_base_rate'] = this.storeToBaseRate;
    data['store_to_order_rate'] = this.storeToOrderRate;
    data['subtotal'] = this.subtotal;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['subtotal_invoiced'] = this.subtotalInvoiced;
    data['tax_amount'] = this.taxAmount;
    data['tax_invoiced'] = this.taxInvoiced;
    data['total_due'] = this.totalDue;
    data['total_invoiced'] = this.totalInvoiced;
    data['total_item_count'] = this.totalItemCount;
    data['total_paid'] = this.totalPaid;
    data['total_qty_ordered'] = this.totalQtyOrdered;
    data['updated_at'] = this.updatedAt;
    data['weight'] = this.weight;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    if (this.statusHistories != null) {
      data['status_histories'] =
          this.statusHistories.map((v) => v.toJson()).toList();
    }
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    return data;
  }
}

class Items {
  Object amountRefunded;
  Object baseAmountRefunded;
  Object baseDiscountAmount;
  Object baseDiscountInvoiced;
  Object baseDiscountTaxCompensationAmount;
  Object baseDiscountTaxCompensationInvoiced;
  Object baseOriginalPrice;
  Object basePrice;
  Object basePriceInclTax;
  Object baseRowInvoiced;
  Object baseRowTotal;
  Object baseRowTotalInclTax;
  Object baseTaxAmount;
  Object baseTaxInvoiced;
  String createdAt;
  Object discountAmount;
  Object discountInvoiced;
  Object discountPercent;
  int freeShipping;
  Object discountTaxCompensationAmount;
  Object discountTaxCompensationInvoiced;
  int isQtyDecimal;
  int isVirtual;
  int itemId;
  String name;
  int noDiscount;
  int orderId;
  Object originalPrice;
  Object price;
  Object priceInclTax;
  int productId;
  String productType;
  int qtyCanceled;
  int qtyInvoiced;
  int qtyOrdered;
  int qtyRefunded;
  int qtyShipped;
  int quoteItemId;
  Object rowInvoiced;
  Object rowTotal;
  Object rowTotalInclTax;
  int rowWeight;
  String sku;
  int storeId;
  Object taxAmount;
  Object taxInvoiced;
  int taxPercent;
  String updatedAt;
  Object weeeTaxApplied;
  int weight;

  Items(
      {this.amountRefunded,
        this.baseAmountRefunded,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseDiscountTaxCompensationAmount,
        this.baseDiscountTaxCompensationInvoiced,
        this.baseOriginalPrice,
        this.basePrice,
        this.basePriceInclTax,
        this.baseRowInvoiced,
        this.baseRowTotal,
        this.baseRowTotalInclTax,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.createdAt,
        this.discountAmount,
        this.discountInvoiced,
        this.discountPercent,
        this.freeShipping,
        this.discountTaxCompensationAmount,
        this.discountTaxCompensationInvoiced,
        this.isQtyDecimal,
        this.isVirtual,
        this.itemId,
        this.name,
        this.noDiscount,
        this.orderId,
        this.originalPrice,
        this.price,
        this.priceInclTax,
        this.productId,
        this.productType,
        this.qtyCanceled,
        this.qtyInvoiced,
        this.qtyOrdered,
        this.qtyRefunded,
        this.qtyShipped,
        this.quoteItemId,
        this.rowInvoiced,
        this.rowTotal,
        this.rowTotalInclTax,
        this.rowWeight,
        this.sku,
        this.storeId,
        this.taxAmount,
        this.taxInvoiced,
        this.taxPercent,
        this.updatedAt,
        this.weeeTaxApplied,
        this.weight});

  Items.fromJson(Map<String, dynamic> json) {
    amountRefunded = json['amount_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseDiscountTaxCompensationInvoiced =
    json['base_discount_tax_compensation_invoiced'];
    baseOriginalPrice = json['base_original_price'];
    basePrice = json['base_price'];
    basePriceInclTax = json['base_price_incl_tax'];
    baseRowInvoiced = json['base_row_invoiced'];
    baseRowTotal = json['base_row_total'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    createdAt = json['created_at'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    discountPercent = json['discount_percent'];
    freeShipping = json['free_shipping'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    discountTaxCompensationInvoiced =
    json['discount_tax_compensation_invoiced'];
    isQtyDecimal = json['is_qty_decimal'];
    isVirtual = json['is_virtual'];
    itemId = json['item_id'];
    name = json['name'];
    noDiscount = json['no_discount'];
    orderId = json['order_id'];
    originalPrice = json['original_price'];
    price = json['price'];
    priceInclTax = json['price_incl_tax'];
    productId = json['product_id'];
    productType = json['product_type'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyOrdered = json['qty_ordered'];
    qtyRefunded = json['qty_refunded'];
    qtyShipped = json['qty_shipped'];
    quoteItemId = json['quote_item_id'];
    rowInvoiced = json['row_invoiced'];
    rowTotal = json['row_total'];
    rowTotalInclTax = json['row_total_incl_tax'];
    rowWeight = json['row_weight'];
    sku = json['sku'];
    storeId = json['store_id'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    taxPercent = json['tax_percent'];
    updatedAt = json['updated_at'];
    weeeTaxApplied = json['weee_tax_applied'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_refunded'] = this.amountRefunded;
    data['base_amount_refunded'] = this.baseAmountRefunded;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_discount_invoiced'] = this.baseDiscountInvoiced;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_discount_tax_compensation_invoiced'] =
        this.baseDiscountTaxCompensationInvoiced;
    data['base_original_price'] = this.baseOriginalPrice;
    data['base_price'] = this.basePrice;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['base_row_invoiced'] = this.baseRowInvoiced;
    data['base_row_total'] = this.baseRowTotal;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_tax_invoiced'] = this.baseTaxInvoiced;
    data['created_at'] = this.createdAt;
    data['discount_amount'] = this.discountAmount;
    data['discount_invoiced'] = this.discountInvoiced;
    data['discount_percent'] = this.discountPercent;
    data['free_shipping'] = this.freeShipping;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['discount_tax_compensation_invoiced'] =
        this.discountTaxCompensationInvoiced;
    data['is_qty_decimal'] = this.isQtyDecimal;
    data['is_virtual'] = this.isVirtual;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['no_discount'] = this.noDiscount;
    data['order_id'] = this.orderId;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    data['price_incl_tax'] = this.priceInclTax;
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['qty_canceled'] = this.qtyCanceled;
    data['qty_invoiced'] = this.qtyInvoiced;
    data['qty_ordered'] = this.qtyOrdered;
    data['qty_refunded'] = this.qtyRefunded;
    data['qty_shipped'] = this.qtyShipped;
    data['quote_item_id'] = this.quoteItemId;
    data['row_invoiced'] = this.rowInvoiced;
    data['row_total'] = this.rowTotal;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['row_weight'] = this.rowWeight;
    data['sku'] = this.sku;
    data['store_id'] = this.storeId;
    data['tax_amount'] = this.taxAmount;
    data['tax_invoiced'] = this.taxInvoiced;
    data['tax_percent'] = this.taxPercent;
    data['updated_at'] = this.updatedAt;
    data['weee_tax_applied'] = this.weeeTaxApplied;
    data['weight'] = this.weight;
    return data;
  }
}

class BillingAddress {
  String addressType;
  String city;
  String company;
  String countryId;
  int customerAddressId;
  String email;
  int entityId;
  String firstname;
  String lastname;
  int parentId;
  String postcode;
  String region;
  String regionCode;
  List<String> street;
  String telephone;

  BillingAddress(
      {this.addressType,
        this.city,
        this.company,
        this.countryId,
        this.customerAddressId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.region,
        this.regionCode,
        this.street,
        this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    company = json['company'];
    countryId = json['country_id'];
    customerAddressId = json['customer_address_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    region = json['region'];
    regionCode = json['region_code'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['customer_address_id'] = this.customerAddressId;
    data['email'] = this.email;
    data['entity_id'] = this.entityId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['parent_id'] = this.parentId;
    data['postcode'] = this.postcode;
    data['region'] = this.region;
    data['region_code'] = this.regionCode;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Payment {
  String accountStatus;
  List<String> additionalInformation;
  Object amountOrdered;
  Object amountPaid;
  Object baseAmountOrdered;
  Object baseAmountPaid;
  Object baseShippingAmount;
  Object baseShippingCaptured;
  String ccLast4;
  int entityId;
  String method;
  int parentId;
  Object shippingAmount;
  int shippingCaptured;
  List<Null> extensionAttributes;

  Payment(
      {this.accountStatus,
        this.additionalInformation,
        this.amountOrdered,
        this.amountPaid,
        this.baseAmountOrdered,
        this.baseAmountPaid,
        this.baseShippingAmount,
        this.baseShippingCaptured,
        this.ccLast4,
        this.entityId,
        this.method,
        this.parentId,
        this.shippingAmount,
        this.shippingCaptured,
        this.extensionAttributes});

  Payment.fromJson(Map<String, dynamic> json) {
    accountStatus = json['account_status'] != null ? json['account_status'].toString() : "";
    additionalInformation = json['additional_information'].cast<String>();
    amountOrdered = json['amount_ordered'];
    amountPaid = json['amount_paid'];
    baseAmountOrdered = json['base_amount_ordered'];
    baseAmountPaid = json['base_amount_paid'];
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingCaptured = json['base_shipping_captured'];
    ccLast4 = json['cc_last4'];
    entityId = json['entity_id'];
    method = json['method'];
    parentId = json['parent_id'];
    shippingAmount = json['shipping_amount'];
    shippingCaptured = json['shipping_captured'];
    if (json['extension_attributes'] != null) {
      extensionAttributes = new List<Null>();
      json['extension_attributes'].forEach((v) {
       // extensionAttributes.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_status'] = this.accountStatus;
    data['additional_information'] = this.additionalInformation;
    data['amount_ordered'] = this.amountOrdered;
    data['amount_paid'] = this.amountPaid;
    data['base_amount_ordered'] = this.baseAmountOrdered;
    data['base_amount_paid'] = this.baseAmountPaid;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_captured'] = this.baseShippingCaptured;
    data['cc_last4'] = this.ccLast4;
    data['entity_id'] = this.entityId;
    data['method'] = this.method;
    data['parent_id'] = this.parentId;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_captured'] = this.shippingCaptured;
    return data;
  }
}

class StatusHistories {
  String comment;
  String createdAt;
  int entityId;
  String entityName;
  int isCustomerNotified;
  int isVisibleOnFront;
  int parentId;
  String status;

  StatusHistories(
      {this.comment,
        this.createdAt,
        this.entityId,
        this.entityName,
        this.isCustomerNotified,
        this.isVisibleOnFront,
        this.parentId,
        this.status});

  StatusHistories.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    createdAt = json['created_at'];
    entityId = json['entity_id'];
    entityName = json['entity_name'];
    isCustomerNotified = json['is_customer_notified'];
    isVisibleOnFront = json['is_visible_on_front'];
    parentId = json['parent_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['entity_id'] = this.entityId;
    data['entity_name'] = this.entityName;
    data['is_customer_notified'] = this.isCustomerNotified;
    data['is_visible_on_front'] = this.isVisibleOnFront;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    return data;
  }
}

class ExtensionAttributes {
  List<ShippingAssignments> shippingAssignments;

  ExtensionAttributes({this.shippingAssignments});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['shipping_assignments'] != null) {
      shippingAssignments = new List<ShippingAssignments>();
      json['shipping_assignments'].forEach((v) {
        shippingAssignments.add(new ShippingAssignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingAssignments != null) {
      data['shipping_assignments'] =
          this.shippingAssignments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingAssignments {
  List<Items> items;
  Shipping shipping;
  ShippingAssignments({this.items});

  ShippingAssignments.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Shipping {
  Address address;
  String method;
  Total total;

  Shipping({this.address, this.method, this.total});

  Shipping.fromJson(Map<String, dynamic> json) {
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    method = json['method'];
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['method'] = this.method;
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    return data;
  }
}
class Address {
  String addressType;
  String city;
  String company;
  String countryId;
  int customerAddressId;
  String email;
  int entityId;
  String firstname;
  String lastname;
  int parentId;
  String postcode;
  String region;
  String regionCode;
  List<String> street;
  String telephone;

  Address(
      {this.addressType,
        this.city,
        this.company,
        this.countryId,
        this.customerAddressId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.region,
        this.regionCode,
        this.street,
        this.telephone});

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    company = json['company'];
    countryId = json['country_id'];
    customerAddressId = json['customer_address_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    region = json['region'];
    regionCode = json['region_code'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['customer_address_id'] = this.customerAddressId;
    data['email'] = this.email;
    data['entity_id'] = this.entityId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['parent_id'] = this.parentId;
    data['postcode'] = this.postcode;
    data['region'] = this.region;
    data['region_code'] = this.regionCode;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Total {
  int baseShippingAmount;
  int baseShippingDiscountAmount;
  int baseShippingInclTax;
  int baseShippingInvoiced;
  int baseShippingTaxAmount;
  int shippingAmount;
  int shippingDiscountAmount;
  int shippingDiscountTaxCompensationAmount;
  int shippingInclTax;
  int shippingInvoiced;
  int shippingTaxAmount;

  Total(
      {this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingInclTax,
        this.baseShippingInvoiced,
        this.baseShippingTaxAmount,
        this.shippingAmount,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingInvoiced,
        this.shippingTaxAmount});

  Total.fromJson(Map<String, dynamic> json) {
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingInvoiced = json['base_shipping_invoiced'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    shippingAmount = json['shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingInvoiced = json['shipping_invoiced'];
    shippingTaxAmount = json['shipping_tax_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_shipping_invoiced'] = this.baseShippingInvoiced;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        this.shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['shipping_invoiced'] = this.shippingInvoiced;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    return data;
  }
}


