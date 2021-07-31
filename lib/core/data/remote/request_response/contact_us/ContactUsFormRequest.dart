class ContactUsFormRequest {
  String subject;
  String name;
  String email;
  String telephone;
  String message;

  ContactUsFormRequest(
      {this.subject, this.name, this.email, this.telephone, this.message});

  ContactUsFormRequest.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['name'] = this.name;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['message'] = this.message;
    return data;
  }
}