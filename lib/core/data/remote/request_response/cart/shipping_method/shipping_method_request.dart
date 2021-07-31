class ShippingMethodRequest {
  int cardId;
  Address address;

  ShippingMethodRequest({this.cardId, this.address});

  ShippingMethodRequest.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardId'] = this.cardId;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String region;
  String regionId;
  String regionCode;
  String countryId;
  List<String> street;
  String postcode;
  String city;
  String firstname;
  String lastname;
  int customerId;
  String email;
  String telephone;
  int sameAsBilling;

  Address(
      {this.region,
      this.regionId,
      this.regionCode,
      this.countryId,
      this.street,
      this.postcode,
      this.city,
      this.firstname,
      this.lastname,
      this.customerId,
      this.email,
      this.telephone,
      this.sameAsBilling});

  Address.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    regionId = json['region_id'];
    regionCode = json['region_code'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    customerId = json['customer_id'];
    email = json['email'];
    telephone = json['telephone'];
    sameAsBilling = json['same_as_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['region_code'] = this.regionCode;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['customer_id'] = this.customerId;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['same_as_billing'] = this.sameAsBilling;
    return data;
  }
}
