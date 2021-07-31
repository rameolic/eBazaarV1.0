class ResponseAddReview {
  bool status;
  String message;

  ResponseAddReview({this.status, this.message});

  ResponseAddReview.fromJson(List<dynamic> array) {
    Map<String, dynamic> json = array[0];
    status = json['status'];
    message = json['message'];
  }

  ResponseAddReview.fromErrorJson(Map<String, dynamic> json) {
    status = false;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
