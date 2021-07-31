class FilterItemModel {
  String code;
  String name;
  String display;
  String id;
  bool isSelected = false;
  double minPrice;
  double maxPrice;

  FilterItemModel({this.code, this.name, this.display, this.id, this.isSelected, this.minPrice, this.maxPrice});

}