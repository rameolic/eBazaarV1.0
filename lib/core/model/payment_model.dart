import 'package:thought_factory/core/model/payment_methods_model.dart';
import 'package:thought_factory/core/model/shipping_method_model.dart';

import 'cart_total_items.dart';

class PaymentModel {
  List<PaymentMethodsModel> lstPaymentMethods = List();
  List<ShippingMethodModel> lstShippingMethod = List();
  List<TotalSegmentsModel> listTotalSegmentsModel = List();
  int selectedShippingMethod;

  //constructor
  PaymentModel(
      {this.lstPaymentMethods, this.lstShippingMethod, this.listTotalSegmentsModel, this.selectedShippingMethod});
}
