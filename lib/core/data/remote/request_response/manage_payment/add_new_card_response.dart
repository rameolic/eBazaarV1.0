class AddNewCardResponse {
  String message;
  int status;
  String cardMessage;
  AddNewCardResponse({this.message, this.status,this.cardMessage});

//  AddNewCardResponse.fromJson(Map<String, dynamic> json) {
//    message = json['message'];
//    status = json['status'];
//  }

  AddNewCardResponse.fromJson(List<dynamic> responseList) {
    if (responseList != null) {
      Map<String, dynamic> json = responseList[0];
      if (json['data'] != null) {
        cardMessage =json['data']['card'];
      }
      message = json['message'];
      status = json['status'];
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['card'] = this.cardMessage;
    return data;
  }
}