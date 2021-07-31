class UpdateProfileResponse {
  String message;
  String trace;
  bool isSuccess = false;

  UpdateProfileResponse({this.message, this.trace, this.isSuccess});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
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
    return 'ChangePasswordResponse{message: $message, trace: $trace, isSuccess: $isSuccess}';
  }
}