class AddOrRemoveProductsToCompareResponse {
  String message;
  String trace;

  List<AddToCompare> addToCompare;

  AddOrRemoveProductsToCompareResponse({this.addToCompare});

  AddOrRemoveProductsToCompareResponse.fromJson(List<dynamic> jsonArray) {
    addToCompare = jsonArray.map((item) => AddToCompare.fromJson(item)).toList();
  }
  AddOrRemoveProductsToCompareResponse.fromJson1(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
  }



}

class AddToCompare {
  String message;
  int status;

  AddToCompare({this.message, this.status});

  AddToCompare.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'AddToCompare{message: $message, status: $status}';
  }


}




/*
String message;
String trace;
int status;

AddOrRemoveProductsToCompareResponse({this.message, this.trace, this.status});

AddOrRemoveProductsToCompareResponse.fromJson(Map<String, dynamic> json) {
message = json['message'];
trace = json['trace'];
status = json['status'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['message'] = this.message;
  data['trace'] = this.trace;
  data['status'] = this.status;
  return data;
}

@override
String toString() {
  return 'AddOrRemoveProductsToCompareResponse{message: $message, trace: $trace, status: $status}';
}
*/
