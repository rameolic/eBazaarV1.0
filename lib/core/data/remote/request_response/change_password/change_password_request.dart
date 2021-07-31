class ChangePasswordRequest {
  String currentPassword;
  String newPassword;

  ChangePasswordRequest({this.currentPassword, this.newPassword});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPassword'] = this.currentPassword;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
