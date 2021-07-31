class RegisterResponse {
  String message;
  String trace;
  int id;
  int groupId;
  String createdAt;
  String updatedAt;
  String createdIn;
  String email;
  String firstname;
  String lastname;
  int storeId;
  int websiteId;
  List<Null> addresses;
  int disableAutoGroupChange;

  RegisterResponse(
      {this.message,
      this.trace,
      this.id,
      this.groupId,
      this.createdAt,
      this.updatedAt,
      this.createdIn,
      this.email,
      this.firstname,
      this.lastname,
      this.storeId,
      this.websiteId,
      this.addresses,
      this.disableAutoGroupChange});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
    id = json['id'];
    groupId = json['group_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    storeId = json['store_id'];
    websiteId = json['website_id'];
    disableAutoGroupChange = json['disable_auto_group_change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['trace'] = this.trace;
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_in'] = this.createdIn;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['store_id'] = this.storeId;
    data['website_id'] = this.websiteId;
    data['disable_auto_group_change'] = this.disableAutoGroupChange;
    return data;
  }
}
