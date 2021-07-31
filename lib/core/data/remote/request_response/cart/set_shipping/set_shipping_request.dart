class SetShippingMethodRequest {
  String cartId;
  AddressInformation addressInformation;

  SetShippingMethodRequest({this.cartId, this.addressInformation});

  SetShippingMethodRequest.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    addressInformation =
        json['addressInformation'] != null ? new AddressInformation.fromJson(json['addressInformation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    if (this.addressInformation != null) {
      data['addressInformation'] = this.addressInformation.toJson();
    }
    return data;
  }
}

class AddressInformation {
  SetShippingAddress shippingAddress;
  SetShippingAddress billingAddress;
  String shippingMethodCode;
  String shippingCarrierCode;

  AddressInformation({this.shippingAddress, this.billingAddress, this.shippingMethodCode, this.shippingCarrierCode});

  AddressInformation.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null ? new SetShippingAddress.fromJson(json['shippingAddress']) : null;
    billingAddress = json['billingAddress'] != null ? new SetShippingAddress.fromJson(json['billingAddress']) : null;
    shippingMethodCode = json['shipping_method_code'];
    shippingCarrierCode = json['shipping_carrier_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress.toJson();
    }
    if (this.billingAddress != null) {
      data['billingAddress'] = this.billingAddress.toJson();
    }
    data['shipping_method_code'] = this.shippingMethodCode;
    data['shipping_carrier_code'] = this.shippingCarrierCode;
    return data;
  }
}

class SetShippingAddress {
  int customerAddressId;
  int customerId;
  String regionCode;
  String region;
  int regionId;
  String countryId;
  List<String> street;
  String company;
  String telephone;
  String postcode;
  String city;
  String firstname;
  String lastname;

  SetShippingAddress(
      {this.customerAddressId,
       this.customerId,
       this.region,
       this.regionCode,
      this.regionId,
      this.countryId,
      this.street,
      this.company,
      this.telephone,
      this.postcode,
      this.city,
      this.firstname,
      this.lastname});

  SetShippingAddress.fromJson(Map<String, dynamic> json) {
    customerAddressId = json['customerAddressId'];
    customerId = json['customerId'];
    regionCode = json['regionCode'];
    region = json['region'];
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    company = json['company'];
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerAddressId'] = this.customerAddressId;
    data['regionCode'] = this.regionCode;
    data['customerId'] = this.customerId;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['company'] = this.company;
    data['telephone'] = this.telephone;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
