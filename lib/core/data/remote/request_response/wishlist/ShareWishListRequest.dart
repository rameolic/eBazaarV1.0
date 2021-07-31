class ShareWishListRequest {
  String message;
  String emails;
  String customerId;

  ShareWishListRequest({this.message, this.emails, this.customerId});

  ShareWishListRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    emails = json['emails'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['emails'] = this.emails;
    data['customer_id'] = this.customerId;
    return data;
  }

  @override
  String toString() {
    return 'ShareWishListRequest{message: $message, emails: $emails, customerId: $customerId}';
  }


}
