class TermsConditionResponse {
  int id;
  String identifier;
  String title;
  String message;
  int statusCode;
  String content;
  String creationTime;
  String updateTime;
  bool active;

  TermsConditionResponse(
      {this.id,
        this.identifier,
        this.title,
        this.message,
        this.content,
        this.statusCode,
        this.creationTime,
        this.updateTime,
        this.active});

  TermsConditionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    title = json['title'];
    content = json['content'];
    creationTime = json['creation_time'];
    updateTime = json['update_time'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['identifier'] = this.identifier;
    data['title'] = this.title;
    data['content'] = this.content;
    data['creation_time'] = this.creationTime;
    data['update_time'] = this.updateTime;
    data['active'] = this.active;
    return data;
  }
}