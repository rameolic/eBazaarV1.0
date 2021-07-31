class RegisterRequest {
  Customer customer;
  String password;

  RegisterRequest({this.customer, this.password});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['password'] = this.password;
    return data;
  }
}

class Customer {
  int groupId;
  String email;
  String firstname;
  String lastname;
  List<CustomAttributes> customAttributes;

  Customer({this.groupId, this.email, this.firstname, this.lastname,  this.customAttributes});

  Customer.fromJson(Map json) {
    groupId = json['group_id'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomAttributes {
  String attributeCode;
  String value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_code'] = this.attributeCode;
    data['value'] = this.value;
    return data;
  }
}
