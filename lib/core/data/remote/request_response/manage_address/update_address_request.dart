class UpdateAddressRequest {
  String addressId;
  String firstName;
  String lastName;
  String company;
  String street1;
  String street2;
  String country;
  String region;
  String regionId;
  String city;
  String postcode;
  String telephone;
  String fax;
  String defaultBillling;
  String defaultShipping;

  UpdateAddressRequest(
      {this.addressId,
        this.firstName,
        this.lastName,
        this.company,
        this.street1,
        this.street2,
        this.country,
        this.region,
        this.regionId,
        this.city,
        this.postcode,
        this.telephone,
        this.fax,
        this.defaultBillling,
        this.defaultShipping});

  UpdateAddressRequest.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    street1 = json['street_1'];
    street2 = json['street_2'];
    country = json['country'];
    region = json['region'];
    regionId = json['region_id'];
    city = json['city'];
    postcode = json['postcode'];
    telephone = json['telephone'];
    fax = json['fax'];
    defaultBillling = json['default_billling'];
    defaultShipping = json['default_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['street_1'] = this.street1;
    data['street_2'] = this.street2;
    data['country'] = this.country;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
    data['default_billling'] = this.defaultBillling;
    data['default_shipping'] = this.defaultShipping;
    return data;
  }
}