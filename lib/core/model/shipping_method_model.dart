import 'package:flutter/foundation.dart';

class ShippingMethodModel with ChangeNotifier {
  String methodTitle;
  String carrierCode;
  String methodCode;
  Object amount;

  //constructor
  ShippingMethodModel({this.methodTitle, this.amount, this.carrierCode, this.methodCode});
}
