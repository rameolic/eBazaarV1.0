class OrderResponse {
  List<Items> items;
  String message;
  int status;
  OrderResponse({this.items,this.message,this.status});

  OrderResponse.fromJson(Map<String, dynamic> json) {
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

class Items {
  String baseCurrencyCode;
  String baseDiscountAmount;
  String baseDiscountInvoiced;
  String baseGrandTotal;
  String baseDiscountTaxCompensationAmount;
  String baseDiscountTaxCompensationInvoiced;
  String baseShippingAmount;
  String baseShippingDiscountAmount;
  String baseShippingInclTax;
  String baseShippingInvoiced;
  String baseShippingTaxAmount;
  String baseSubtotal;
  String baseSubtotalInclTax;
  String baseSubtotalInvoiced;
  String baseTaxAmount;
  String baseTaxInvoiced;
  String baseTotalDue;
  String baseTotalInvoiced;
  String baseTotalInvoicedCost;
  String baseTotalPaid;
  String baseToGlobalRate;
  String baseToOrderRate;
  String billingAddressId;
  String createdAt;
  String customerEmail;
  String customerFirstname;
  String customerGroupId;
  String customerId;
  String customerIsGuest;
  String customerLastname;
  String customerNoteNotify;
  String couponCode;
  String discountAmount;
  String discountInvoiced;
  String emailSent;
  String entityId;
  String globalCurrencyCode;
  String grandTotal;
  String discountTaxCompensationAmount;
  String discountTaxCompensationInvoiced;
  String incrementId;
  String isVirtual;
  String orderCurrencyCode;
  String protectCode;
  String quoteId;
  String remoteIp;
  String shippingAmount;
  String shippingDescription;
  String shippingDiscountAmount;
  String shippingDiscountTaxCompensationAmount;
  String shippingInclTax;
  String shippingInvoiced;
  String shippingTaxAmount;
  String state;
  String status;
  String storeCurrencyCode;
  String storeId;
  String storeName;
  String storeToBaseRate;
  String storeToOrderRate;
  String subtotal;
  String subtotalInclTax;
  String subtotalInvoiced;
  String taxAmount;
  String taxInvoiced;
  String totalDue;
  String totalInvoiced;
  String totalItemCount;
  String totalPaid;
  String totalQtyOrdered;
  String updatedAt;
  String weight;
  List<ItemsById> items;
  BillingAddress billingAddress;
  Payment payment;
  List<StatusHistories> statusHistories;
  ExtensionAttributes extensionAttributes;

  Items(
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
        this.couponCode,
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

  Items.fromJson(Map<String, dynamic> json) {
    baseCurrencyCode = json['base_currency_code'].toString();
    baseDiscountAmount = json['base_discount_amount'].toString();
    baseDiscountInvoiced = json['base_discount_invoiced'].toString();
    baseGrandTotal = json['base_grand_total'].toString();
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'].toString();
    baseDiscountTaxCompensationInvoiced =
    json['base_discount_tax_compensation_invoiced'].toString();
    baseShippingAmount = json['base_shipping_amount'].toString();
    baseShippingDiscountAmount = json['base_shipping_discount_amount'].toString();
    baseShippingInclTax = json['base_shipping_incl_tax'].toString();
    baseShippingInvoiced = json['base_shipping_invoiced'].toString();
    baseShippingTaxAmount = json['base_shipping_tax_amount'].toString();
    baseSubtotal = json['base_subtotal'].toString();
    baseSubtotalInclTax = json['base_subtotal_incl_tax'].toString();
    baseSubtotalInvoiced = json['base_subtotal_invoiced'].toString();
    baseTaxAmount = json['base_tax_amount'].toString();
    baseTaxInvoiced = json['base_tax_invoiced'].toString();
    baseTotalDue = json['base_total_due'].toString();
    baseTotalInvoiced = json['base_total_invoiced'].toString();
    baseTotalInvoicedCost = json['base_total_invoiced_cost'].toString();
    baseTotalPaid = json['base_total_paid'].toString();
    baseToGlobalRate = json['base_to_global_rate'].toString();
    baseToOrderRate = json['base_to_order_rate'].toString();
    billingAddressId = json['billing_address_id'].toString();
    createdAt = json['created_at'].toString();
    customerEmail = json['customer_email'].toString();
    customerFirstname = json['customer_firstname'].toString();
    customerGroupId = json['customer_group_id'].toString();
    customerId = json['customer_id'].toString();
    customerIsGuest = json['customer_is_guest'].toString();
    customerLastname = json['customer_lastname'].toString();
    customerNoteNotify = json['customer_note_notify'].toString();
    couponCode = json['coupon_code'] != null ? json['coupon_code']  : "";
    discountAmount = json['discount_amount'].toString();
    discountInvoiced = json['discount_invoiced'].toString();
    emailSent = json['email_sent'].toString();
    entityId = json['entity_id'].toString();
    globalCurrencyCode = json['global_currency_code'].toString();
    grandTotal = json['grand_total'].toString();
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'].toString();
    discountTaxCompensationInvoiced =
    json['discount_tax_compensation_invoiced'].toString();
    incrementId = json['increment_id'].toString();
    isVirtual = json['is_virtual'].toString();
    orderCurrencyCode = json['order_currency_code'].toString();
    protectCode = json['protect_code'].toString();
    quoteId = json['quote_id'].toString();
    remoteIp = json['remote_ip'].toString();
    shippingAmount = json['shipping_amount'].toString();
    shippingDescription = json['shipping_description'].toString();
    shippingDiscountAmount = json['shipping_discount_amount'].toString();
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'].toString();
    shippingInclTax = json['shipping_incl_tax'].toString();
    shippingInvoiced = json['shipping_invoiced'].toString();
    shippingTaxAmount = json['shipping_tax_amount'].toString();
    state = json['state'].toString();
    status = json['status'].toString();
    storeCurrencyCode = json['store_currency_code'].toString();
    storeId = json['store_id'].toString();
    storeName = json['store_name'].toString();
    storeToBaseRate = json['store_to_base_rate'].toString();
    storeToOrderRate = json['store_to_order_rate'].toString();
    subtotal = json['subtotal'].toString();
    subtotalInclTax = json['subtotal_incl_tax'].toString();
    subtotalInvoiced = json['subtotal_invoiced'].toString();
    taxAmount = json['tax_amount'].toString();
    taxInvoiced = json['tax_invoiced'].toString();
    totalDue = json['total_due'].toString();
    totalInvoiced = json['total_invoiced'].toString();
    totalItemCount = json['total_item_count'].toString();
    totalPaid = json['total_paid'].toString();
    totalQtyOrdered = json['total_qty_ordered'].toString();
    updatedAt = json['updated_at'].toString();
    weight = json['weight'].toString();
    if (json['items'] != null) {
      items = new List<ItemsById>();
      json['items'].forEach((v) {
        items.add(new ItemsById.fromJson(v));
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
    data['coupon_code'] = this.couponCode;
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

class ItemsById {
  String amountRefunded;
  String baseAmountRefunded;
  String baseDiscountAmount;
  String baseDiscountInvoiced;
  String baseDiscountTaxCompensationAmount;
  String baseDiscountTaxCompensationInvoiced;
  String baseOriginalPrice;
  String basePrice;
  String basePriceInclTax;
  String baseRowInvoiced;
  String baseRowTotal;
  String baseRowTotalInclTax;
  String baseTaxAmount;
  String baseTaxInvoiced;
  String createdAt;

  String discountAmount;
  String discountInvoiced;
  String discountPercent;
  String freeShipping;
  String discountTaxCompensationAmount;
  String discountTaxCompensationInvoiced;
  String isQtyDecimal;
  String isVirtual;
  String itemId;
  String name;
  String noDiscount;
  String orderId;
  String originalPrice;
  String price;
  String priceInclTax;
  String productId;
  String productType;
  String qtyCanceled;
  String qtyInvoiced;
  String qtyOrdered;
  String qtyRefunded;
  String qtyShipped;
  String quoteItemId;
  String rowInvoiced;
  String rowTotal;
  String rowTotalInclTax;
  String rowWeight;
  String sku;
  String storeId;
  String taxAmount;
  String taxInvoiced;
  String taxPercent;
  String updatedAt;
  String weeeTaxApplied;

  ItemsById(
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
        this.weeeTaxApplied});

  ItemsById.fromJson(Map<String, dynamic> json) {
    amountRefunded = json['amount_refunded'].toString();
    baseAmountRefunded = json['base_amount_refunded'].toString();
    baseDiscountAmount = json['base_discount_amount'].toString();
    baseDiscountInvoiced = json['base_discount_invoiced'].toString();
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'].toString();
    baseDiscountTaxCompensationInvoiced =
    json['base_discount_tax_compensation_invoiced'].toString();
    baseOriginalPrice = json['base_original_price'].toString();
    basePrice = json['base_price'].toString();
    basePriceInclTax = json['base_price_incl_tax'].toString();
    baseRowInvoiced = json['base_row_invoiced'].toString();
    baseRowTotal = json['base_row_total'].toString();
    baseRowTotalInclTax = json['base_row_total_incl_tax'].toString();
    baseTaxAmount = json['base_tax_amount'].toString();
    baseTaxInvoiced = json['base_tax_invoiced'].toString();
    createdAt = json['created_at'].toString();
    discountAmount = json['discount_amount'].toString();
    discountInvoiced = json['discount_invoiced'].toString();
    discountPercent = json['discount_percent'].toString();
    freeShipping = json['free_shipping'].toString();
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'].toString();
    discountTaxCompensationInvoiced =
    json['discount_tax_compensation_invoiced'].toString();
    isQtyDecimal = json['is_qty_decimal'].toString();
    isVirtual = json['is_virtual'].toString();
    itemId = json['item_id'].toString();
    name = json['name'].toString();
    noDiscount = json['no_discount'].toString();
    orderId = json['order_id'].toString();
    originalPrice = json['original_price'].toString();
    price = json['price'].toString();
    priceInclTax = json['price_incl_tax'].toString();
    productId = json['product_id'].toString();
    productType = json['product_type'].toString();
    qtyCanceled = json['qty_canceled'].toString();
    qtyInvoiced = json['qty_invoiced'].toString();
    qtyOrdered = json['qty_ordered'].toString();
    qtyRefunded = json['qty_refunded'].toString();
    qtyShipped = json['qty_shipped'].toString();
    quoteItemId = json['quote_item_id'].toString();
    rowInvoiced = json['row_invoiced'].toString();
    rowTotal = json['row_total'].toString();
    rowTotalInclTax = json['row_total_incl_tax'].toString();
    rowWeight = json['row_weight'].toString();
    sku = json['sku'].toString();
    storeId = json['store_id'].toString();
    taxAmount = json['tax_amount'].toString();
    taxInvoiced = json['tax_invoiced'].toString();
    taxPercent = json['tax_percent'].toString();
    updatedAt = json['updated_at'].toString();
    weeeTaxApplied = json['weee_tax_applied'].toString();
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
    return data;
  }
}

class BillingAddress {
  String addressType;
  String city;
  String company;
  String countryId;
  String email;
  int entityId;
  String firstname;
  String lastname;
  int parentId;
  String postcode;
  List<String> street;
  String telephone;

  BillingAddress(
      {this.addressType,
        this.city,
        this.company,
        this.countryId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.street,
        this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    company = json['company'];
    countryId = json['country_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['email'] = this.email;
    data['entity_id'] = this.entityId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['parent_id'] = this.parentId;
    data['postcode'] = this.postcode;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Payment {
  Null accountStatus;
  List<String> additionalInformation;
  String amountOrdered;
  String amountPaid;
  String baseAmountOrdered;
  String baseAmountPaid;
  String baseShippingAmount;
  String baseShippingCaptured;
  Null ccLast4;
  String entityId;
  String method;
  String parentId;
  String shippingAmount;
  String shippingCaptured;
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
    accountStatus = json['account_status'];
    additionalInformation = json['additional_information'].cast<String>();
    amountOrdered = json['amount_ordered'].toString();
    amountPaid = json['amount_paid'].toString();
    baseAmountOrdered = json['base_amount_ordered'].toString();
    baseAmountPaid = json['base_amount_paid'].toString();
    baseShippingAmount = json['base_shipping_amount'].toString();
    baseShippingCaptured = json['base_shipping_captured'].toString();
    ccLast4 = json['cc_last4'];
    entityId = json['entity_id'].toString();
    method = json['method'].toString();
    parentId = json['parent_id'].toString();
    shippingAmount = json['shipping_amount'].toString();
    shippingCaptured = json['shipping_captured'].toString();
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
//    if (this.extensionAttributes != null) {
//      data['extension_attributes'] =
//          this.extensionAttributes.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

class StatusHistories {
  String comment;
  String createdAt;
  String entityId;
  String entityName;
  String isCustomerNotified;
  String isVisibleOnFront;
  String parentId;
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
    comment = json['comment'].toString();
    createdAt = json['created_at'].toString();
    entityId = json['entity_id'].toString();
    entityName = json['entity_name'].toString();
    isCustomerNotified = json['is_customer_notified'].toString();
    isVisibleOnFront = json['is_visible_on_front'].toString();
    parentId = json['parent_id'].toString();
    status = json['status'].toString();
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
  Shipping shipping;
  List<Items> items;

  ShippingAssignments({this.shipping, this.items});

  ShippingAssignments.fromJson(Map<String, dynamic> json) {
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
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
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Total {
  String baseShippingAmount;
  String baseShippingDiscountAmount;
  String baseShippingInclTax;
  String baseShippingInvoiced;
  String baseShippingTaxAmount;
  String shippingAmount;
  String shippingDiscountAmount;
  String shippingDiscountTaxCompensationAmount;
  String shippingInclTax;
  String shippingInvoiced;
  String shippingTaxAmount;

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
    baseShippingAmount = json['base_shipping_amount'].toString();
    baseShippingDiscountAmount = json['base_shipping_discount_amount'].toString();
    baseShippingInclTax = json['base_shipping_incl_tax'].toString();
    baseShippingInvoiced = json['base_shipping_invoiced'].toString();
    baseShippingTaxAmount = json['base_shipping_tax_amount'].toString();
    shippingAmount = json['shipping_amount'].toString();
    shippingDiscountAmount = json['shipping_discount_amount'].toString();
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'].toString();
    shippingInclTax = json['shipping_incl_tax'].toString();
    shippingInvoiced = json['shipping_invoiced'].toString();
    shippingTaxAmount = json['shipping_tax_amount'].toString();
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