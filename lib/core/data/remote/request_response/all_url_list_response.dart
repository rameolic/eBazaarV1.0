

class AllUrlListResponse {
  List<AllUrlListResponseData> items;
  String message;
  int status;
  AllUrlListResponse({this.items,this.message,this.status});
  AllUrlListResponse.fromJson(List<dynamic> jsonArray) {
    items = jsonArray.map((item) => AllUrlListResponseData.fromJson(item)).toList();
  }
}


class AllUrlListResponseData {
  Data data;
  String message;
  int status;

  AllUrlListResponseData({this.data, this.message, this.status});

  AllUrlListResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String base;
  String media;
  String category;
  String product;
  String distProfile;
  String distCompanyLogo;
  String distCompanyBanner;
  String customerLogo;
  String forgotPassword;
  int privacyPolicId;
  int termsConditionId;

  Data(
      {this.base,
        this.media,
        this.category,
        this.product,
        this.distProfile,
        this.distCompanyLogo,
        this.distCompanyBanner,
        this.customerLogo,
        this.forgotPassword,
        this.privacyPolicId,
        this.termsConditionId});

  Data.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    media = json['media'];
    category = json['category'];
    product = json['product'];
    distProfile = json['dist_profile'];
    distCompanyLogo = json['dist_company_logo'];
    distCompanyBanner = json['dist_company_banner'];
    customerLogo = json['customer_logo'];
    forgotPassword = json['forgot_password'];
    privacyPolicId = json['privacy_polic_id'];
    termsConditionId = json['terms_condition_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    data['media'] = this.media;
    data['category'] = this.category;
    data['product'] = this.product;
    data['dist_profile'] = this.distProfile;
    data['dist_company_logo'] = this.distCompanyLogo;
    data['dist_company_banner'] = this.distCompanyBanner;
    data['customer_logo'] = this.customerLogo;
    data['forgot_password'] = this.forgotPassword;
    data['privacy_polic_id'] = this.privacyPolicId;
    data['terms_condition_id'] = this.termsConditionId;
    return data;
  }
}