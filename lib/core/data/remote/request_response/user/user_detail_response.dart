class UserDetailResponse {
  int id;
  int groupId;
  String defaultBilling;
  String defaultShipping;
  String createdAt;
  String updatedAt;
  String createdIn;
  String email;
  String firstname;
  String lastname;
  int storeId;
  int websiteId;
  List<Addresses> addresses;
  int disableAutoGroupChange;
  String message;
  Parameters parameters;
  String trace;

  UserDetailResponse(
      {this.id,
      this.groupId,
      this.defaultBilling,
      this.defaultShipping,
      this.createdAt,
      this.updatedAt,
      this.createdIn,
      this.email,
      this.firstname,
      this.lastname,
      this.storeId,
      this.websiteId,
      this.addresses,
      this.disableAutoGroupChange,
      this.message,
      this.parameters,
      this.trace});

  UserDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    defaultBilling = json['default_billing'];
    defaultShipping = json['default_shipping'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    storeId = json['store_id'];
    websiteId = json['website_id'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    disableAutoGroupChange = json['disable_auto_group_change'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['default_billing'] = this.defaultBilling;
    data['default_shipping'] = this.defaultShipping;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_in'] = this.createdIn;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['store_id'] = this.storeId;
    data['website_id'] = this.websiteId;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['disable_auto_group_change'] = this.disableAutoGroupChange;
    data['message'] = this.message;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.toJson();
    }
    data['trace'] = this.trace;
    return data;
  }

  @override
  String toString() {
    return 'UserDetailResponse{id: $id, groupId: $groupId, defaultBilling: $defaultBilling, defaultShipping: $defaultShipping, createdAt: $createdAt, updatedAt: $updatedAt, createdIn: $createdIn, email: $email, firstname: $firstname, lastname: $lastname, storeId: $storeId, websiteId: $websiteId, addresses: $addresses, disableAutoGroupChange: $disableAutoGroupChange, message: $message, parameters: $parameters, trace: $trace}';
  }
}

class Addresses {
  int id;
  int customerId;
  Region region;
  int regionId;
  String countryId;
  List<String> street;
  String company;
  String fax;
  String telephone;
  String postcode;
  String city;
  String firstname;
  String lastname;
  bool defaultShipping;
  bool defaultBilling;
  int manageAddress;

  Addresses(
      {this.id,
      this.customerId,
      this.region,
      this.regionId,
      this.countryId,
      this.street,
      this.company,
        this. manageAddress,
      this.telephone,
      this.postcode,
      this.city,
      this.fax,
      this.firstname,
      this.lastname,
      this.defaultShipping,
      this.defaultBilling});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    company = json['company'];
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    fax = json["fax"];
    defaultShipping = json['default_shipping'];
    defaultBilling = json['default_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    data['region_id'] = this.regionId;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['company'] = this.company;
    data['telephone'] = this.telephone;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['fax']=this.fax;
    data['default_shipping'] = this.defaultShipping;
    data['default_billing'] = this.defaultBilling;
    return data;
  }

  @override
  String toString() {
    return 'Addresses{id: $id, fax: $fax, customerId: $customerId, region: $region, regionId: $regionId, countryId: $countryId, street: $street, company: $company, telephone: $telephone, postcode: $postcode, city: $city, firstname: $firstname, lastname: $lastname, defaultShipping: $defaultShipping, defaultBilling: $defaultBilling}';
  }
}

class Region {
  String regionCode;
  String region;
  int regionId;

  Region({this.regionCode, this.region, this.regionId});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_code'] = this.regionCode;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    return data;
  }

  @override
  String toString() {
    return 'Region{regionCode: $regionCode, region: $region, regionId: $regionId}';
  }
}

class Parameters {
  String resources;

  Parameters({this.resources});

  Parameters.fromJson(Map<String, dynamic> json) {
    resources = json['resources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resources'] = this.resources;
    return data;
  }

  @override
  String toString() {
    return 'Parameters{resources: $resources}';
  }
}
