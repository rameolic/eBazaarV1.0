class CompareProductListResponse {
  List<CompareProductList> compareProductList;

  CompareProductListResponse({this.compareProductList});

  CompareProductListResponse.fromJson(List<dynamic> jsonArray) {
    compareProductList = jsonArray.map((item) => CompareProductList.fromJson(item)).toList();
  }
}

class CompareProductList {
  List<CompareProductItem> data;
  String message;
  int status;

  CompareProductList({this.data, this.message, this.status});

  CompareProductList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CompareProductItem>();
      json['data'].forEach((v) {
        data.add(new CompareProductItem.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
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

  @override
  String toString() {
    return 'CompareProductList{data: $data, message: $message, status: $status}';
  }

}

class CompareProductItem {
  String id;
  String name;
  String price;
  String splPrice;
  String image;
  String manufacturer;
  String sku;
  String shortDescription;
  String unit;
  String rating;


  CompareProductItem(
      {this.id,
        this.name,
        this.price,
        this.splPrice,
        this.image,
        this.manufacturer,
        this.sku,
        this.unit,
        this.rating
      });

  CompareProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    splPrice = json['spl_price'];
    image = json['image'];
    manufacturer = json['manufacturer'];
    sku = json['sku'];
    shortDescription = json['mobile_app_short_description'];
    unit = json['unit_of_measurement'];
    rating = json['ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['spl_price'] = this.splPrice;
    data['image'] = this.image;
    data['manufacturer'] = this.manufacturer;
    data['sku'] = this.sku;
    data['mobile_app_short_description'] = this.shortDescription;
    data['unit_of_measurement'] = this.unit;
    data['ratings'] = this.rating;
    return data;
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $name, price: $price, splPrice: $splPrice, image: $image, manufacturer: $manufacturer, sku: $sku, mobile_app_short_description: $shortDescription, unit_of_measurement: $unit, ratings: $rating}';
  }


}
