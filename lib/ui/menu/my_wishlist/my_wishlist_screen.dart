import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/notifier/wish_list_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_text_style.dart';

import 'CustomDialog.dart';

class MyWishListScreen extends StatefulWidget {
  @override
  _MyWishListScreenState createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {
  final cornerRadius = 5.0;
  final listQty = ['1', '2', '3', '4'];
  final listDummyImage = [
    AppImages.IMAGE_DUMMY_WOMEN_CLOTH,
    AppImages.IMAGE_DUMMY_WATCH,
    AppImages.IMAGE_DUMMY_REFRIGERATOR,
    AppImages.IMAGE_DUMMY_T_SHIRT,
    AppImages.IMAGE_DUMMY_REFRIGERATOR,
    AppImages.IMAGE_DUMMY_KETTLE
  ];
  String selectedQty = "";

  @override
  void initState() {
    super.initState();
    selectedQty = this.listQty[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WishListNotifier>(
      create: (context) => WishListNotifier(context),
      child: Consumer<WishListNotifier>(
        builder: (context, wishListNotifier, _) => ModalProgressHUD(
          inAsyncCall: wishListNotifier.isLoading,
          child: Stack(
            children: <Widget>[
              Container(
                  color: colorGrey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: (isWishListAvailable(wishListNotifier))
                            ? buildListWishList(wishListNotifier)
                            : Container(
                                child: Center(child: Text("No Data")),
                              ),
                      ),
                      (isWishListAvailable(wishListNotifier))
                          ? buildButtonShareWishList(context, wishListNotifier)
                          : Container(),
                      (isWishListAvailable(wishListNotifier))
                          ? Container() //buildButtonAddAllToCart(context)
                          : Container(),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  bool isWishListAvailable(WishListNotifier wishListNotifier) {
    if ((wishListNotifier.wishListResponse != null) &&
        (wishListNotifier.wishListResponse.wishList != null) &&
        (wishListNotifier.wishListResponse.wishList.length > 0)) {
      return true;
    } else {
      return false;
    }
  }

  ListView buildListWishList(WishListNotifier wishListNotifier) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      itemBuilder: (context, index) {
        return buildListItemWishList(context, index, wishListNotifier);
      },
      itemCount: wishListNotifier.wishListResponse.wishList.length,
    );
  }

  Widget buildListItemWishList(
      context, index, WishListNotifier wishListNotifier) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Card(
        color: colorGrey,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: buildProductImage(index, wishListNotifier),
            ),
            Expanded(
              flex: 3,
              child: buildProductInfo(context, wishListNotifier, index),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(index, WishListNotifier wishListNotifier) {
    return AspectRatio(
      aspectRatio: 1.0 / 1.2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cornerRadius),
                bottomLeft: Radius.circular(cornerRadius)),
            color: colorGrey,
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.network(AppUrl.baseImageUrl +
                wishListNotifier
                    .wishListResponse.wishList[index].product.thumbnail),
          ))),
    );
  }

  Widget buildProductInfo(context, WishListNotifier wishListNotifier, index) {
    //final formatCurrency = new NumberFormat("#,##0.00", "en_US");
    return Container(
      color: colorWhite,
      padding: EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                wishListNotifier.wishListResponse.wishList[index].product.name,
                maxLines: 1,
                style: getWLProductNameTextStyle(context),
                overflow: TextOverflow.ellipsis,
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    wishListNotifier.callApiAddWishListItem(
                        wishListNotifier
                            .wishListResponse.wishList[index].product.sku,
                        wishListNotifier.wishListResponse.wishList[index].qty);
                  },
                  child: Icon(
                    AppCustomIcon.icon_cart,
                    size: 18,
                    color: colorPrimary,
                  ),
                ),
              ),
              Material(
                color: colorWhite,
                child: InkWell(
                  splashColor: colorPrimary,
                  onTap: () {
                    wishListNotifier.callApiRemoveWishListItem(wishListNotifier
                        .wishListResponse.wishList[index].wishlistItemId);
                  },
                  child: Icon(
                    Icons.clear,
                    color: colorDarkGrey,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                  '${wishListNotifier.currencySymbol} ${wishListNotifier.convertToDecimal((wishListNotifier.wishListResponse.wishList[index].product.minPrice != null || wishListNotifier.wishListResponse.wishList[index].product.minPrice.isNotEmpty) ? wishListNotifier.wishListResponse.wishList[index].product.minPrice : wishListNotifier.wishListResponse.wishList[index].product.price, 2)}',
                  style: getWLProductAmtTextStyle(context)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${wishListNotifier.currencySymbol} ${wishListNotifier.convertToDecimal((wishListNotifier.wishListResponse.wishList[index].product.minPrice == null || wishListNotifier.wishListResponse.wishList[index].product.minPrice == "") ? "" : wishListNotifier.wishListResponse.wishList[index].product.price, 2)}',
                  style: getWLProductStrikeAmtTextStyle(context),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              '${wishListNotifier.currencySymbol} ${wishListNotifier.convertToDecimal(getDiscountPercentage(double.parse(wishListNotifier.wishListResponse.wishList[index].product.price), double.parse(wishListNotifier.wishListResponse.wishList[index].product.minPrice)).toString(), 2)} Off',
              style: getWLProductOfferAmtTextStyle(context),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                '',
                style: getStyleCaption(context).copyWith(color: colorDarkGrey),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getStyleCaption(context).copyWith(
                      color: colorPrimary,
                      fontWeight: AppFont.fontWeightSemiBold),
                ),
              ),
              Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  height: 30,
                  padding: EdgeInsets.only(left: 8.0, right: 4.0),
                  /*child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          value: selectedQty,
                          items: listQty.map((String nQty) {
                            return DropdownMenuItem(
                                value: nQty,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Qty : ',
                                      style: getWLQtyLabelTextStyle(context),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '$nQty',
                                            style: getWLQtyTextStyle(context))
                                      ]),
                                ));
                          }).toList(),
                          onChanged: (selectedValue) {
                            setState(() {
                              this.selectedQty = selectedValue;
                            });
                          }),
                    )*/
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Qty : ',
                          style: getWLQtyLabelTextStyle(context),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "${wishListNotifier.wishListResponse.wishList[index].qty}",
                                style: getWLQtyTextStyle(context))
                          ]),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildButtonShareWishList(
      BuildContext context, WishListNotifier wishListNotifier) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0, top: 20.0),
      width: double.infinity,
      child: RaisedButton(
        color: colorOrange,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          'Share Wishlist',
          style: getStyleSubHeading(context).copyWith(
              fontWeight: AppFont.fontWeightMedium, color: colorWhite),
        ),
        onPressed: () {
          _showDialog(context, wishListNotifier);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget buildButtonAddAllToCart(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 20.0),
      width: double.infinity,
      child: RaisedButton(
        color: colorAccent,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          'Add all to cart',
          style: getStyleSubHeading(context).copyWith(
              fontWeight: AppFont.fontWeightMedium, color: colorWhite),
        ),
        onPressed: () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  void _showDialog(
      BuildContext context, WishListNotifier wishListNotifier) async {
    String customerId = await AppSharedPreference().getCustomerId();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialog(
        wishListNotifier: wishListNotifier,
        customerId: customerId,
      ),
    );
  }

  double getDiscountPercentage(
      double productMarkedPrice, double productSalePrice) {
    double discount = (productMarkedPrice != null ? productMarkedPrice : 0) -
        (productSalePrice != null ? productSalePrice : 0);
    double disPercentage = (discount / productMarkedPrice) * 100;
    return disPercentage;
  }
}
