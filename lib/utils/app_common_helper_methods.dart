import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart';

int getMinQuantity(List<CustomAttributes> customAttributes) {
  if(customAttributes != null && customAttributes.length > 0) {
    int minQuantity = 1;
    for(int i = 0; i < customAttributes.length; i++) {
      if(customAttributes[i].attributeCode == "min_quantity") {
        minQuantity = int.parse(customAttributes[i].value);
        break;
      }
    }
    return minQuantity;
  } else  {
    return 1;
  }
}