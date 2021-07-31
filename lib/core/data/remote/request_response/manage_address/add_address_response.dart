

class AddAddressResponse {
  List<UpdateAddress> updateAddress;
  String message;
  int status;
  AddAddressResponse({this.updateAddress,this.message, this.status});
  AddAddressResponse.fromJson(List<dynamic> jsonArray) {
    updateAddress = jsonArray.map((item) => UpdateAddress.fromJson(item)).toList();
  }
}

class UpdateAddress {
  List<Data> data;
  int status;

  UpdateAddress({this.data, this.status});

  UpdateAddress.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) { data.add(new Data.fromJson(v)); });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String entityId;
  Null incrementId;
  String parentId;
  String createdAt;
  String updatedAt;
  String isActive;
  String city;
  String company;
  String countryId;
  String fax;
  String firstname;
  String lastname;
  Null middlename;
  String postcode;
  Null prefix;
  String region;
  String regionId;
  String street;
  Null suffix;
  String telephone;
  Null vatId;
  Null vatIsValid;
  Null vatRequestDate;
  Null vatRequestId;
  Null vatRequestSuccess;
  String customerId;
  String isDefaultBilling;
  String isDefaultShipping;
  String saveInAddressBook;

  Data({this.entityId, this.incrementId, this.parentId, this.createdAt, this.updatedAt, this.isActive, this.city, this.company, this.countryId, this.fax, this.firstname, this.lastname, this.middlename, this.postcode, this.prefix, this.region, this.regionId, this.street, this.suffix, this.telephone, this.vatId, this.vatIsValid, this.vatRequestDate, this.vatRequestId, this.vatRequestSuccess,  this.customerId, this.isDefaultBilling, this.isDefaultShipping, this.saveInAddressBook});

  Data.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    incrementId = json['increment_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    city = json['city'];
    company = json['company'];
    countryId = json['country_id'];
    fax = json['fax'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    middlename = json['middlename'];
    postcode = json['postcode'];
    prefix = json['prefix'];
    region = json['region'];
    regionId = json['region_id'];
    street = json['street'];
    suffix = json['suffix'];
    telephone = json['telephone'];
    vatId = json['vat_id'];
    vatIsValid = json['vat_is_valid'];
    vatRequestDate = json['vat_request_date'];
    vatRequestId = json['vat_request_id'];
    vatRequestSuccess = json['vat_request_success'];
    customerId = json['customer_id'];
    isDefaultBilling = json['is_default_billing'];
    isDefaultShipping = json['is_default_shipping'];
    saveInAddressBook = json['save_in_address_book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['increment_id'] = this.incrementId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['fax'] = this.fax;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['middlename'] = this.middlename;
    data['postcode'] = this.postcode;
    data['prefix'] = this.prefix;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['street'] = this.street;
    data['suffix'] = this.suffix;
    data['telephone'] = this.telephone;
    data['vat_id'] = this.vatId;
    data['vat_is_valid'] = this.vatIsValid;
    data['vat_request_date'] = this.vatRequestDate;
    data['vat_request_id'] = this.vatRequestId;
    data['vat_request_success'] = this.vatRequestSuccess;
    data['customer_id'] = this.customerId;
    data['is_default_billing'] = this.isDefaultBilling;
    data['is_default_shipping'] = this.isDefaultShipping;
    data['save_in_address_book'] = this.saveInAddressBook;
    return data;
  }
}
Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}