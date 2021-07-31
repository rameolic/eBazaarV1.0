class ProfileImageResponse {
  List<ProfileImage> profileImage;
  String message;
  int status;
  ProfileImageResponse({this.profileImage,this.message, this.status});
  ProfileImageResponse.fromJson(List<dynamic> jsonArray) {
    profileImage = jsonArray.map((item) => ProfileImage.fromJson(item)).toList();
  }
}
class ProfileImage {
  String data;
  String message;
  int status;

  ProfileImage({this.data, this.message, this.status});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }

}