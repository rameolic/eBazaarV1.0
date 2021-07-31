

//class ContactAddressResponse {
//  List<ContactUsAddressResponse> wishList;
//  String message;
//  int status;
//  ContactAddressResponse({this.wishList,this.message, this.status});
//  ContactAddressResponse.fromJson(List<dynamic> jsonArray) {
//    wishList = jsonArray.map((item) => ContactUsAddressResponse.fromJson(item)).toList();
//  }
//}
//
//class ContactUsAddressResponse {
//  Data data;
//  String message;
//  int status;
//  ContactUsAddressResponse({this.data, this.message, this.status});
//  ContactUsAddressResponse.fromJson(Map<String, dynamic> json) {
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//    message = json['message'];
//    status = json['status'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    data['message'] = this.message;
//    data['status'] = this.status;
//    return data;
//  }
//}
//
//class Data {
//  String name="";
//  String phone="";
//  String email1="";
//  String email2="";
//  String streetLine1;
//  String streetLine2;
//  String city="";
//  String regionId="";
//  String regionName="";
//  String countryId="";
//  String countryName="";
//  String postcode="";
//  String hours="";
//
//  Data(
//      {this.name,
//        this.phone,
//        this.email1,
//        this.email2,
//        this.streetLine1,
//        this.streetLine2,
//        this.city,
//        this.regionId,
//        this.regionName,
//        this.countryId,
//        this.countryName,
//        this.postcode,
//        this.hours});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    name = json['name'];
//    phone = json['phone'];
//    email1 = json['email1'];
//    email2 = json['email2'];
//    streetLine1 = json['street_line1'];
//    streetLine2 = json['street_line2'];
//    city = json['city'];
//    regionId = json['region_id'];
//    regionName = json['region_name'];
//    countryId = json['country_id'];
//    countryName = json['country_name'];
//    postcode = json['postcode'];
//    hours = json['hours'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['name'] = this.name;
//    data['phone'] = this.phone;
//    data['email1'] = this.email1;
//    data['email2'] = this.email2;
//    data['street_line1'] = this.streetLine1;
//    data['street_line2'] = this.streetLine2;
//    data['city'] = this.city;
//    data['region_id'] = this.regionId;
//    data['region_name'] = this.regionName;
//    data['country_id'] = this.countryId;
//    data['country_name'] = this.countryName;
//    data['postcode'] = this.postcode;
//    data['hours'] = this.hours;
//    return data;
//  }
//}

/*class ContactAddressResponse1 {
  List<ContactAddressResponse1> contactAddResponse1;
  ContactAddressResponse1({this.contactAddResponse1});
  ContactAddressResponse1.fromJson(List<dynamic> jsonArray) {
    //contactAddResponse1 = jsonArray.map((item) => ContactAddressResponse.fromJson(item)).toList();
    contactAddResponse1 = new ContactAddressResponse.fromJson(json['wishlist']);
  }
}*/
class ContactAddressResponse {
  Wishlist wishlist;

  ContactAddressResponse({this.wishlist});

  ContactAddressResponse.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'] != null
        ? new Wishlist.fromJson(json['wishlist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist.toJson();
    }
    return data;
  }
}

class Wishlist {
  Data data;
  String message;
  int status;

  Wishlist({this.data, this.message, this.status});

  Wishlist.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String name;
  String phone;
  String email1;
  String email2;
  String streetLine1;
  String streetLine2;
  String city;
  String regionId;
  String regionName;
  String countryId;
  String countryName;
  String postcode;
  String hours;

  Data(
      {this.name,
        this.phone,
        this.email1,
        this.email2,
        this.streetLine1,
        this.streetLine2,
        this.city,
        this.regionId,
        this.regionName,
        this.countryId,
        this.countryName,
        this.postcode,
        this.hours});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email1 = json['email1'];
    email2 = json['email2'];
    streetLine1 = json['street_line1'];
    streetLine2 = json['street_line2'];
    city = json['city'];
    regionId = json['region_id'];
    regionName = json['region_name'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    postcode = json['postcode'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email1'] = this.email1;
    data['email2'] = this.email2;
    data['street_line1'] = this.streetLine1;
    data['street_line2'] = this.streetLine2;
    data['city'] = this.city;
    data['region_id'] = this.regionId;
    data['region_name'] = this.regionName;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['postcode'] = this.postcode;
    data['hours'] = this.hours;
    return data;
  }
}