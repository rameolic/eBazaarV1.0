class DistributorModel {
  int _id;
  String _name;
  String _imageUrl;
  String _description;

  //constructor
  DistributorModel({int id, String name, String imageUrl, String description}) {
    this._id = id;
    this._name = name;
    this._imageUrl = imageUrl;
    this._description = description;
  }

  //getter setter
  int get id => this._id;

  set id(int value) => this._id = value;

  String get name => this._name;

  set name(String value) => this._name = value;

  String get imageUrl => this._imageUrl;

  set imageUrl(String value) => this._imageUrl = value;

  String get description => this._description;

  set description(String value) => this._description = value;
}
