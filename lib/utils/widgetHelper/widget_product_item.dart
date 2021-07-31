import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/utils/app_colors.dart';

import '../app_constants.dart';
import '../app_font.dart';
import '../app_screen_dimen.dart';
import '../app_text_style.dart';

class WidgetProductItem extends StatelessWidget {
  final ItemProduct itemProduct;
  final VoidCallback onPressedAdd;
  final ValueSetter<ItemProduct> onPressedRemove;
  final ValueSetter<ItemProduct> onPressedProduct;
  final ValueSetter<ItemProduct> onPressedIconHeart;
  final ValueSetter<ItemProduct> onPressedItemCompareButton;
  final bool isCompareModeOn;

  WidgetProductItem(
      {@required this.itemProduct,
      @required this.onPressedAdd,
      @required this.onPressedRemove,
      this.onPressedItemCompareButton,
      this.onPressedProduct,
      this.onPressedIconHeart,
      this.isCompareModeOn = false});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ItemProduct>(
      create: (_) => itemProduct,
      child: Card(
        elevation: 1.0,
        color: colorGrey,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: () => onPressedProduct(itemProduct),
                splashColor: colorPrimary,
                child: Card(
                  elevation: 0.0,
                  color: colorWhite,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: AspectRatio(
                      aspectRatio: 1 / 0.95,
                      child: Container(
                        width: (getScreenWidth(context) / 2) - 32,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
//                              child: Image.asset(itemProduct.imageUrl),
                                child: (itemProduct.imageUrl != null &&
                                        itemProduct.imageUrl != "")
                                    ? CachedNetworkImage(
                                        imageUrl: itemProduct.imageUrl)
                                    : Image.asset(
                                        "assets/logo_thought_factory.png"),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                child: FloatingActionButton(
                                  heroTag: "${Random().nextDouble()}",
                                  elevation: 2.0,
                                  onPressed: () =>
                                      onPressedIconHeart(itemProduct),
                                  mini: true,
                                  backgroundColor: colorWhite,
                                  child: Consumer<ItemProduct>(
                                    builder: (context, value, _) =>
                                        value.isFavourite
                                            ? _buildIconHeart(colorPrimary)
                                            : _buildIconHeart(colorDarkGrey),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, left: 4.0, right: 4.0, bottom: 0.0),
                child: Align(
                  child:
//                  Text(
//                    itemProduct.name,
//                    style: getProductNameTextStyle(context),
//                    maxLines: 2,
//                  ),
                      AutoSizeText(
                    itemProduct.name,
                    maxLines: 2,
                    style: getProductNameTextStyle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ), //text: product name
              Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 2.0),
                child: Align(
                  child: (itemProduct.specialPrice == null ||
                          itemProduct.specialPrice == 0.0)
                      ? Text(
                          "AED ${double.parse(itemProduct.price.toString()).toStringAsFixed(2) ?? ""} ",
                          style: getProductAmtTextStyle(context),
                        )
                      : Row(
                          children: <Widget>[
                            Text(
                              "AED ${double.parse(itemProduct.specialPrice.toString()).toStringAsFixed(2) ?? ""} ",
                              style: getProductAmtTextStyle(context),
                            ),
                            Text(
                              '${double.parse(itemProduct.price.toString()).toStringAsFixed(2) ?? ""}',
                              style: getStyleCaption(context).copyWith(
                                  decoration: TextDecoration.lineThrough),
                            )
                          ],
                        ),
                  alignment: Alignment.centerLeft,
                ),
              ), //text: product price in dollar
              Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
                  child: isCompareModeOn
                      ? _buildCompareModeOption(
                          itemProduct, context, onPressedItemCompareButton)
                      : _buildAddRemoveQuantityOption(
                          itemProduct, onPressedRemove, onPressedAdd))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCompareModeOption(
    itemProduct, context, onPressedItemCompareButton) {
  return Consumer<ItemProduct>(
    builder: (context, value, _) => Container(
      width: double.infinity,
      child: RaisedButton(
        color: !value.isAddedToCompare ? colorPrimary : colorWhite,
        elevation: 1,
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(
          !value.isAddedToCompare ? AppConstants.ADDED : AppConstants.COMPARE,
          style: getStyleBody1(context).copyWith(
              color: !value.isAddedToCompare ? colorWhite : colorPrimary,
              fontWeight: AppFont.fontWeightSemiBold),
        ),
        onPressed: () => onPressedItemCompareButton(
            value) /*() {
          value.isAddedToCompare = (!itemProduct.isAddedToCompare);
        }*/
        ,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    ),
  );
}

Widget _buildAddRemoveQuantityOption(
    ItemProduct itemProduct, onPressedRemove, onPressedAdd) {
  return Row(
    children: <Widget>[
      Expanded(
        child: RawMaterialButton(
          onPressed: () => onPressedRemove(itemProduct),
          child: Icon(
            Icons.remove,
            color: colorPrimary,
            size: 16.0,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: colorWhite,
          padding: EdgeInsets.all(6.0),
          splashColor: colorPrimary,
        ),
      ), //button: decrease product count
      Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.only(left: 8.0, right: 8.0),
          child: AbsorbPointer(
            //to avoid touch on the button with not like disable effect
            absorbing: true,
            child: RaisedButton(
              color: colorWhite,
              textColor: colorPrimary,
              elevation: 1.0,
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Consumer<ItemProduct>(
                builder: (context, value, _) => Text(
                  '${itemProduct.chosenQuantity}',
                  style: getProductQtyTextStyle(context),
                ),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        ),
      ), //text: product count
      Expanded(
        child: RawMaterialButton(
            onPressed: onPressedAdd,
            child: Icon(
              Icons.add,
              color: colorPrimary,
              size: 16.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: colorWhite,
            padding: EdgeInsets.all(6.0),
            splashColor: colorPrimary),
      ) //button: increase product count
    ],
  );
}

Widget _buildIconHeart(colorHeart) {
  return Icon(
    Icons.favorite,
    size: 18,
    color: colorHeart,
  );
}
