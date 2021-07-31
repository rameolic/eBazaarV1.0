class WishListItemResponse {
  String message;
  String trace;
  String success;

  WishListItemResponse({this.message, this.trace, this.success});

  WishListItemResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['trace'] = this.trace;
    return data;
  }

  @override
  String toString() {
    return 'RemoveWishListItemResponse{message: $message, trace: $trace, success: $success}';
  }


}