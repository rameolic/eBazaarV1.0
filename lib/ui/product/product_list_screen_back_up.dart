import 'package:flutter/material.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/ui/product/product_detail_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/dummy_products_list.dart';
import 'package:thought_factory/utils/widgetHelper/widget_product_item.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = '/product_list_screen';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final lstProducts = getListProducts();

  @override
  Widget build(BuildContext context) {
    final String stTitle = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _buildAppbar(stTitle),
      body: Stack(
        children: <Widget>[_buildSearchBar(), _buildGridProducts()],
      ),
    );
  }

  AppBar _buildAppbar(stTitle) {
    return AppBar(elevation: 0.0, centerTitle: true, title: Text(stTitle ?? ""), actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Stack(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(AppCustomIcon.icon_cart),
              iconSize: 18,
              tooltip: 'Open shopping cart',
            ),
            Positioned(
              top: 5,
              left: 25,
              height: 17.0,
              width: 17.0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Text(
                  '0',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: colorBlack,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

  Widget _buildSearchBar() {
    return Container(
      color: colorGrey,
      child: Column(
        children: <Widget>[
          Container(
            color: colorPrimary,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
              padding: EdgeInsets.only(left: 16.0),
              width: double.infinity,
              alignment: Alignment.center,
              height: 38.0,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
              child: TextFormField(
                style: getStyleCaption(context).copyWith(fontStyle: FontStyle.italic),
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
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: RaisedButton.icon(
                  onPressed: () {},
                  label: Text('Compare'),
                  icon: Icon(Icons.swap_horiz),
                  color: colorWhite,
                )),
                Expanded(
                    child: RaisedButton.icon(
                  onPressed: () {},
                  label: Text('Filter'),
                  icon: Icon(Icons.filter_list),
                  color: colorWhite,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget jbfasbf() {
    return RawMaterialButton(
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
    );
  }

  Container _buildGridProducts() {
    return Container(
        color: colorGrey,
        margin: EdgeInsets.only(top: 135),
        child: GridView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
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

  void onTapProductDetail(ItemProduct value, BuildContext context) {
    print('clicked: product Detail');

    Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: value);
    // (or) another way
    /*Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(), settings: RouteSettings(arguments: value)),
    );*/
  }
}
