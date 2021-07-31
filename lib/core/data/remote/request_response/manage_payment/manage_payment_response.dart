import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
class ManagePaymentListResponse {

  List<NewCard> data;
  String message;
  int status;

  ManagePaymentListResponse({this.data, this.message, this.status});

  ManagePaymentListResponse.fromJson(List<dynamic> response) {
    if (response != null) {
      Map<String, dynamic> json = response[0];
      if (json['data'] != null) {
        data = new List<NewCard>();
        json['data'].forEach((v) {
          data.add(new NewCard.fromJson(v));
        });
      }
      message = json['message'];
      status = json['status'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }

}

