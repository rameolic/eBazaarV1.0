class TotalInfoRequest {
  AddressInfo addressInformation;

  TotalInfoRequest({this.addressInformation});

  TotalInfoRequest.fromJson(Map<String, dynamic> json) {
    addressInformation = json['addressInformation'] != null
        ? new AddressInfo.fromJson(json['addressInformation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressInformation != null) {
      data['addressInformation'] = this.addressInformation.toJson();
    }
    return data;
  }
}

class AddressInfo {
  AddressDetails address;
  String shippingMethodCode;
  String shippingCarrierCode;

  AddressInfo(
      {this.address, this.shippingMethodCode, this.shippingCarrierCode});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new AddressDetails.fromJson(json['address']) : null;
    shippingMethodCode = json['shipping_method_code'];
    shippingCarrierCode = json['shipping_carrier_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['shipping_method_code'] = this.shippingMethodCode;
    data['shipping_carrier_code'] = this.shippingCarrierCode;
    return data;
  }
}

class AddressDetails {
  String countryId;
  String region;
  String regionId;
  String postcode;

  AddressDetails({this.countryId, this.region, this.regionId, this.postcode});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    region = json['region'];
    regionId = json['regionId'];
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['region'] = this.region;
    data['regionId'] = this.regionId;
    data['postcode'] = this.postcode;
    return data;
  }
}