class RemoveCardResponse {
  String message;
  int status;

  RemoveCardResponse({this.message, this.status});


  RemoveCardResponse.fromJson(List<dynamic> responseList) {
    if (responseList != null) {
      Map<String, dynamic> json = responseList[0];
      message = json['message'];
      status = json['status'];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}