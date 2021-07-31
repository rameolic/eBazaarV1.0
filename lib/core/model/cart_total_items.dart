class TotalSegmentsModel {
  String code;
  String title;
  Object value;
  ExtensionAttributes extensionAttributes;
  String area;

  TotalSegmentsModel({this.code, this.title, this.value, this.extensionAttributes, this.area});

  TotalSegmentsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    value = json['value'];
    extensionAttributes =
        json['extension_attributes'] != null ? new ExtensionAttributes.fromJson(json['extension_attributes']) : null;
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['value'] = this.value;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    data['area'] = this.area;
    return data;
  }
}

class ExtensionAttributes {
  List<Null> taxGrandtotalDetails;

  ExtensionAttributes({this.taxGrandtotalDetails});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['tax_grandtotal_details'] != null) {
      taxGrandtotalDetails = new List<Null>();
      json['tax_grandtotal_details'].forEach((v) {
        // taxGrandtotalDetails.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taxGrandtotalDetails != null) {
      //data['tax_grandtotal_details'] = this.taxGrandtotalDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
