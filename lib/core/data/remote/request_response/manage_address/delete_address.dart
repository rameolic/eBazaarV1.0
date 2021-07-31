
class DeleteAddress {
  List<Delete_Address_response> items;
  String message;
  int status;
  DeleteAddress({this.items,this.message,this.status});
  DeleteAddress.fromJson(List<dynamic> jsonArray) {
    items = jsonArray.map((item) => Delete_Address_response.fromJson(item)).toList();
  }
}
class Delete_Address_response {
  String message;
  int status;

  Delete_Address_response({this.message, this.status});

  Delete_Address_response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}