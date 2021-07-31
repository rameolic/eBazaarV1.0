import 'package:flutter/material.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/ui/product/product_detail_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/dummy_products_list.dart';
import 'package:thought_factory/utils/widgetHelper/widget_product_item.dart';

class BeautyAndPersonalCareScreen extends StatefulWidget {
  @override
  _BeautyAndPersonalCareScreenState createState() => _BeautyAndPersonalCareScreenState();
}

class _BeautyAndPersonalCareScreenState extends State<BeautyAndPersonalCareScreen> {
  final lstProducts = getListProductsForBeauty();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[_buildSearchBar(context), _buildGridProducts()],
    );
  }

  Widget _buildSearchBar(context) {
    return Container(
      height: 80,
      color: colorPrimary,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    alignment: Alignment.center,
                    height: 38.0,
                    padding: EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
                    child: TextFormField(
                      style: getAppSearchTextStyle(context),
                      decoration: InputDecoration(
                        hintText: "Search products",
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          color: colorBlack,
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                RawMaterialButton(
                  splashColor: colorPrimary,
                  constraints: BoxConstraints(maxWidth: 38.0),
                  onPressed: () {},
                  child: Icon(
                    Icons.filter_list,
                    color: colorBlack,
                    size: 24.0,
                  ),
                  shape: CircleBorder(),
                  fillColor: colorWhite,
                  padding: EdgeInsets.all(7.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildGridProducts() {
    return Container(
        color: colorGrey,
        margin: EdgeInsets.only(top: 65),
        child: GridView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4.8),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
              child: WidgetProductItem(
                itemProduct: lstProducts[index],
                onPressedProduct: (value) => Navigator.pushNamed(context, ProductDetailScreen.routeName),
                onPressedAdd: () => onTapAddProduct(lstProducts[index]),
                onPressedRemove: (value) => onTapRemoveProduct(value),
                onPressedIconHeart: (value) => onTapIconHeart(value),
              ),
            );
          },
          itemCount: lstProducts.length,
        ));
  }

  void onTapAddProduct(ItemProduct itemProduct) {
    print('clicked: add');
    if (itemProduct.chosenQuantity != itemProduct.maxQuantity) {
      itemProduct.chosenQuantity++;
    } else {
      print('max quantity reached');
    }
  }

  void onTapRemoveProduct(ItemProduct itemProduct) {
    print('clicked: remove');
    if (itemProduct.chosenQuantity != 0) {
      itemProduct.chosenQuantity--;
    } else {
      print('min quantity reached, cant reduce futher');
    }
  }

  void onTapIconHeart(ItemProduct itemProduct) {
    itemProduct.isFavourite = (!itemProduct.isFavourite);
  }

  void onTapProduct(ItemProduct itemProduct) {}
}
