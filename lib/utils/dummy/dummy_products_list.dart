import 'package:thought_factory/core/model/item_product_detail_model.dart';
import 'package:thought_factory/core/model/item_product_model.dart';

import '../app_images.dart';

List<String> lstCompareTitle = [
  'HighLights',
  'Process & Memory Feature',
  'Display & Audio Feature',
  /*'Dimension',
  'Additional Feature'*/
];

List<ItemProductDetail> getListProductDetailByCount(int count) {
  return List<ItemProductDetail>.generate(
      count,
      (index) => ItemProductDetail(
              id: index,
              name: 'Product_ $index',
              price: 20.0,
              maxQuantity: 10,
              description: 'Product_ $index description',
              lstCompareTitle: lstCompareTitle,
              mapCompareContent: {
                lstCompareTitle[0]:
                    'Core i5 Intel processor\n\nSSD: NA\n\n8 GB DDR3 RAM\n\nHDD: 1TB\n\nDos OS\n\n1 year warrenty',
                lstCompareTitle[1]:
                    'Core i5 Intel processor\n\nSSD: NA\n\n8 GB DDR3 RAM\n\nHDD: 1TB\n\nDos OS\n\n1 year warrenty',
                lstCompareTitle[2]:
                    'Core i5 Intel processor\n\nSSD: NA\n\n8 GB DDR3 RAM\n\nHDD: 1TB\n\nDos OS\n\n1 year warrenty'
              }));
}

List<ItemProduct> getDummyListProducts(int count) {
  int idGen = 100;
  return List<ItemProduct>.generate(
      count,
      (index) => ItemProduct(
          id: idGen++,
          name: 'Lenin Red 54899',
          price: 50.0,
          maxQuantity: 10,
          description: 'The Product is excellent, cheap, best worth.'));
}

final listDummyImage = [
  AppImages.IMAGE_DUMMY_WOMEN_CLOTH,
  AppImages.IMAGE_DUMMY_WATCH,
  AppImages.IMAGE_DUMMY_REFRIGERATOR,
  AppImages.IMAGE_DUMMY_T_SHIRT,
  AppImages.IMAGE_DUMMY_REFRIGERATOR,
  AppImages.IMAGE_DUMMY_KETTLE
];

List<ItemProduct> getDummyInvoiceProducts(int count) {
  int idGen = 100;
  return List<ItemProduct>.generate(
      count,
      (index) => ItemProduct(
          id: idGen++,
          name: 'Lenin Red 54899',
          price: 50.0,
          maxQuantity: 10,
          imageUrl: listDummyImage[index],
          description: 'The Product is excellent, cheap, best worth.'));
}

List<ItemProduct> getDummyListProductsForPopular(int count) {
  int idGen = 100;
  return List<ItemProduct>.generate(
      count,
      (index) => ItemProduct(
          id: idGen++,
          name: index == 1 ? 'Default Watch' : 'Kitchen Decor',
          imageUrl: index == 1 ? AppImages.IMAGE_DUMMY_WATCH : AppImages.IMAGE_DUMMY_KETTLE,
          price: 50.0,
          maxQuantity: 10,
          description: 'The Product is excellent, cheap, best worth.'));
}

List<ItemProduct> getDummyListProductsForClothing(int count) {
  int idGen = 100;
  return List<ItemProduct>.generate(
      count,
      (index) => ItemProduct(
          id: idGen++,
          name: index == 1 ? 'Lenin Orange' : 'Default red',
          imageUrl: index == 1 ? AppImages.IMAGE_DUMMY_T_SHIRT : AppImages.IMAGE_DUMMY_WOMEN_CLOTH,
          price: 50.0,
          maxQuantity: 10,
          description: 'The Product is excellent, cheap, best worth.'));
}

List<ItemProduct> getDummyListProductsForElectronics(int count) {
  int idGen = 100;
  return List<ItemProduct>.generate(
      count,
      (index) => ItemProduct(
          id: idGen++,
          name: index == 1 ? 'Refridgerator' : 'Dell Laptop',
          imageUrl: index == 1 ? AppImages.IMAGE_DUMMY_REFRIGERATOR : AppImages.IMAGE_DUMMY_LAPTOP,
          price: 50.0,
          maxQuantity: 10,
          description: 'The Product is excellent, cheap, best worth.'));
}

List<ItemProduct> getDummyListProductsForHealthAndBeauty(int count) {
  int idGen = 100;
  return List<ItemProduct>.generate(
      count,
      (index) => ItemProduct(
          id: idGen++,
          name: index == 1 ? 'DM - Skincare' : 'Perfume',
          imageUrl: index == 1 ? AppImages.IMAGE_DUMMY_FACE_CREAM : AppImages.IMAGE_DUMMY_PERFUME,
          price: 50.0,
          maxQuantity: 10,
          description: 'The Product is excellent, cheap, best worth.'));
}

List<ItemProduct> getListProducts() {
  int idGen = 100;
  List<ItemProduct> lstProducts = [
    ItemProduct(id: idGen++, name: 'Solid watch', price: 20.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Crystal watch', price: 40.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Leather Watch', price: 30.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Plastic Watch', price: 15.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Light Watch', price: 5.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Rugged Watch', price: 30.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Gorilla Watch', price: 15.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'Avenger Watch', price: 20.0, maxQuantity: 10, description: 'Well made product'),
    ItemProduct(id: idGen++, name: 'WaterProof Watch', price: 50.0, maxQuantity: 10, description: 'Well made product'),
  ];
  return lstProducts;
}

List<ItemProduct> getListProductsForGrocery() {
  int idGen = 100;
  List<ItemProduct> lstProducts = [
    ItemProduct(
        id: idGen++,
        name: 'Solid watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Crystal watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 40.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Leather Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Plastic Watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Light Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 5.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Rugged Watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Gorilla Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Avenger Watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'WaterProof Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 50.0,
        maxQuantity: 10,
        description: 'Well made product'),
  ];
  return lstProducts;
}

List<ItemProduct> getListProductsForBeauty() {
  int idGen = 100;
  List<ItemProduct> lstProducts = [
    ItemProduct(
        id: idGen++,
        name: 'Solid watch',
        imageUrl: AppImages.IMAGE_DUMMY_FACE_CREAM,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Crystal watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 40.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Leather Watch',
        imageUrl: AppImages.IMAGE_DUMMY_FACE_CREAM,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Plastic Watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Light Watch',
        imageUrl: AppImages.IMAGE_DUMMY_FACE_CREAM,
        price: 5.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Rugged Watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Gorilla Watch',
        imageUrl: AppImages.IMAGE_DUMMY_FACE_CREAM,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Avenger Watch',
        imageUrl: AppImages.IMAGE_DUMMY_PERFUME,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'WaterProof Watch',
        imageUrl: AppImages.IMAGE_DUMMY_FACE_CREAM,
        price: 50.0,
        maxQuantity: 10,
        description: 'Well made product'),
  ];
  return lstProducts;
}

List<ItemProduct> getListProductsForHomeAppliances() {
  int idGen = 100;
  List<ItemProduct> lstProducts = [
    ItemProduct(
        id: idGen++,
        name: 'Solid watch',
        imageUrl: AppImages.IMAGE_DUMMY_REFRIGERATOR,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Crystal watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 40.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Leather Watch',
        imageUrl: AppImages.IMAGE_DUMMY_REFRIGERATOR,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Plastic Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Light Watch',
        imageUrl: AppImages.IMAGE_DUMMY_REFRIGERATOR,
        price: 5.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Rugged Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Gorilla Watch',
        imageUrl: AppImages.IMAGE_DUMMY_REFRIGERATOR,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Avenger Watch',
        imageUrl: AppImages.IMAGE_DUMMY_KETTLE,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'WaterProof Watch',
        imageUrl: AppImages.IMAGE_DUMMY_REFRIGERATOR,
        price: 50.0,
        maxQuantity: 10,
        description: 'Well made product'),
  ];
  return lstProducts;
}

List<ItemProduct> getListProductsForFashion() {
  int idGen = 100;
  List<ItemProduct> lstProducts = [
    ItemProduct(
        id: idGen++,
        name: 'Solid watch',
        imageUrl: AppImages.IMAGE_DUMMY_WOMEN_CLOTH,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Crystal watch',
        imageUrl: AppImages.IMAGE_DUMMY_T_SHIRT,
        price: 40.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Leather Watch',
        imageUrl: AppImages.IMAGE_CATEGORY_SHOE,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Plastic Watch',
        imageUrl: AppImages.IMAGE_DUMMY_SHOE_ADDIDAS,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Light Watch',
        imageUrl: AppImages.IMAGE_DUMMY_WOMEN_CLOTH,
        price: 5.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Rugged Watch',
        imageUrl: AppImages.IMAGE_DUMMY_T_SHIRT,
        price: 30.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Gorilla Watch',
        imageUrl: AppImages.IMAGE_CATEGORY_SHOE,
        price: 15.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'Avenger Watch',
        imageUrl: AppImages.IMAGE_DUMMY_SHOE_ADDIDAS,
        price: 20.0,
        maxQuantity: 10,
        description: 'Well made product'),
    ItemProduct(
        id: idGen++,
        name: 'WaterProof Watch',
        imageUrl: AppImages.IMAGE_DUMMY_WOMEN_CLOTH,
        price: 50.0,
        maxQuantity: 10,
        description: 'Well made product'),
  ];
  return lstProducts;
}

List<String> getListDummyDistributor() {
  return [
    AppImages.IMAGE_DISTRIBUTOR_1,
    AppImages.IMAGE_DISTRIBUTOR_2,
    AppImages.IMAGE_DISTRIBUTOR_3,
    AppImages.IMAGE_DISTRIBUTOR_4,
    AppImages.IMAGE_DISTRIBUTOR_5,
    AppImages.IMAGE_DISTRIBUTOR_6,
    AppImages.IMAGE_DISTRIBUTOR_7,
    AppImages.IMAGE_DISTRIBUTOR_8,
    AppImages.IMAGE_DISTRIBUTOR_9,
    AppImages.IMAGE_DISTRIBUTOR_10,
    AppImages.IMAGE_DISTRIBUTOR_11,
    AppImages.IMAGE_DISTRIBUTOR_1,
    AppImages.IMAGE_DISTRIBUTOR_2,
    AppImages.IMAGE_DISTRIBUTOR_3,
    AppImages.IMAGE_DISTRIBUTOR_4,
    AppImages.IMAGE_DISTRIBUTOR_5,
    AppImages.IMAGE_DISTRIBUTOR_6,
    AppImages.IMAGE_DISTRIBUTOR_7,
    AppImages.IMAGE_DISTRIBUTOR_8,
    AppImages.IMAGE_DISTRIBUTOR_9,
    AppImages.IMAGE_DISTRIBUTOR_10,
    AppImages.IMAGE_DISTRIBUTOR_3,
    AppImages.IMAGE_DISTRIBUTOR_4,
    AppImages.IMAGE_DISTRIBUTOR_5,
    AppImages.IMAGE_DISTRIBUTOR_6,
    AppImages.IMAGE_DISTRIBUTOR_7,
    AppImages.IMAGE_DISTRIBUTOR_8
  ];
}
