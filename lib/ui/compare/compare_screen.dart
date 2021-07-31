import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/compare_product_list_response.dart';
import 'package:thought_factory/core/model/item_product_detail_model.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/notifier/product_compare_notifier.dart';
import 'package:thought_factory/ui/menu/manage_address/manage_address_screen.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_star_rating.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/dummy_products_list.dart';
import 'package:thought_factory/utils/widgetHelper/custom_modal_bottom_sheet.dart';

class CompareProductScreen extends StatefulWidget {
  static const routeName = '/compare_product_screen';

  @override
  _CompareProductScreenState createState() => _CompareProductScreenState();
}

class _CompareProductScreenState extends State<CompareProductScreen> {
  static final nMaxCompareCount = 2;
  var log = getLogger('CompareProductScreen');

  //var lstCompareProducts = getListProductDetailByCount(nMaxCompareCount);
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    double expandedLayoutHeight =
        (screenWidth / 2) + (screenWidth / 3) - (16 + 16 + 16);

    return ChangeNotifierProvider<ProductCompareNotifier>(
      create: (context) => ProductCompareNotifier(context),
      child: Consumer<ProductCompareNotifier>(
        builder: (BuildContext context, productCompareNotifier, _) =>
            WillPopScope(
          onWillPop: () async {
            var idList = productCompareNotifier.listProductCompared
                .map((value) => value.id)
                .toList();
            Navigator.pop(context, idList);
            return false;
          },
          child: Scaffold(
            appBar: _buildAppbar(context, productCompareNotifier),
            body: ModalProgressHUD(
              inAsyncCall: productCompareNotifier.isLoading,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverAppBar(
                    leading: Icon(null),
                    backgroundColor: colorGrey,
                    pinned: true,
                    expandedHeight: expandedLayoutHeight,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      if (top == 116) {
                        print('Collapse');
                        return Container(
                          height: double.infinity,
                          color: colorGrey,
                          child: (productCompareNotifier.isLoading)
                              ? Container(
                                  child: Center(
                                    child: Text('Loading data...'),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    _buildSmallLayoutProductImage(
                                        context, 0, productCompareNotifier),
                                    _buildSmallLayoutProductImage(
                                        context, 1, productCompareNotifier),
                                  ],
                                ),
                        );
                      } else {
                        print('Expand');
                        return Container(
                          height: double.infinity,
                          color: colorGrey,
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    _buildBigLayoutProductImage(
                                        context, 0, productCompareNotifier),
                                    _buildBigLayoutProductImage(
                                        context, 1, productCompareNotifier)
                                  ]),
                            ),
                          ),
                        );
                      }
                    }),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(60.0),
                      child: Text(''),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return _buildListSubTitleTile(
                        context, 'Specifications', productCompareNotifier);
                  }, childCount: 1))
/*
                            context, productCompareNotifier.listProductCompared[index].name);
                      }, childCount: lstCompareProducts[0].lstCompareTitle.length))
*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(context, ProductCompareNotifier productCompareNotifier) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title:
          Text(AppConstants.COMPARE, style: getAppBarTitleTextStyle(context)),
      /* actions: <Widget>[
          isMaximumProductsAdded(
                  productCompareNotifier.listProductCompared.length)
              ? Container()
              : Container(
                  margin: EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onClickAddSimilarProducts(context);
                    },
                  ))
        ]*/
    );
  }

  Widget _buildSmallLayoutProductImage(
    context,
    int index,
    ProductCompareNotifier productCompareNotifier,
  ) {
    var imageURL = "";
    if (!productCompareNotifier.isLoading &&
        index < productCompareNotifier.listProductCompared.length)
      imageURL = productCompareNotifier.listProductCompared[index].image;
    return Expanded(
      child: (index < productCompareNotifier.listProductCompared.length)
          ? Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 4.0),
                          alignment: Alignment.center,
                          child: Card(
                              child: (imageURL != null && imageURL != "")
                                  ? CachedNetworkImage(
                                      imageUrl: imageURL,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      "assets/logo_thought_factory.png")

                              /*Image.network(
                              "https://cdn.shopify.com/s/files/1/1116/8276/products/StrikeForce_-_Sample_Pack_Fanned_1200x630.png?v=1548724558",
                              fit: BoxFit.fill,
                            ),*/
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 4.0, right: 4.0, bottom: 4.0),
                        child: Align(
                          child: Text(
                            productCompareNotifier
                                .listProductCompared[index].name,
                            style: getStyleSubTitle(context).copyWith(
                                fontWeight: AppFont.fontWeightSemiBold),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 4.0, right: 4.0, bottom: 4.0),
                        child: Align(
                          child: Text(
                            "${productCompareNotifier.currency} ${productCompareNotifier.listProductCompared[index].price}",
                            style: getProductAmtTextStyle(context),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                  isOnlyMinimumProductsAdded(
                          productCompareNotifier.listProductCompared.length)
                      ? Container()
                      : Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0, top: 8.0),
                            width: 24,
                            height: 24,
                            child: FloatingActionButton(
                              heroTag: "${Random().nextDouble()}",
                              onPressed: () {
                                _onClickRemoveProduct(
                                    productCompareNotifier, index);
                              },
                              mini: true,
                              backgroundColor: colorWhite,
                              child: Icon(
                                Icons.clear,
                                size: 16,
                                color: colorDarkGrey,
                              ),
                              elevation: 4.0,
                            ),
                          ),
                        )
                ],
              ),
            )
          : _buildAddButtonView(index, productCompareNotifier),
    );
  }

  Widget _buildBigLayoutProductImage(
    context,
    int index,
    ProductCompareNotifier productCompareNotifier,
  ) {
    var imageURL = "";
    if (!productCompareNotifier.isLoading &&
        index < productCompareNotifier.listProductCompared.length)
      imageURL = productCompareNotifier.listProductCompared[index].image;
    return Expanded(
      child: (index < productCompareNotifier.listProductCompared.length)
          ? Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              color: colorGrey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    color: colorWhite,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: (imageURL != null && imageURL != "")
                                  ? CachedNetworkImage(
                                      imageUrl: imageURL,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      "assets/logo_thought_factory.png"),
                            ) /*Image.network(
                              "https://cdn.shopify.com/s/files/1/1116/8276/products/StrikeForce_-_Sample_Pack_Fanned_1200x630.png?v=1548724558",
                              fit: BoxFit.fill,
                            )*/
                            ,
                            alignment: Alignment.center,
                          ),
                          isOnlyMinimumProductsAdded(productCompareNotifier
                                  .listProductCompared.length)
                              ? Container()
                              : Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 8.0, top: 8.0),
                                    width: 24,
                                    height: 24,
                                    child: FloatingActionButton(
                                      heroTag: "${Random().nextDouble()}",
                                      onPressed: () {
                                        _onClickRemoveProduct(
                                            productCompareNotifier, index);
                                      },
                                      mini: true,
                                      backgroundColor: colorWhite,
                                      child: Icon(
                                        Icons.clear,
                                        size: 16,
                                        color: colorDarkGrey,
                                      ),
                                      elevation: 4.0,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 4.0, right: 4.0, bottom: 8.0),
                    child: Align(
                      child: Text(
                        productCompareNotifier.listProductCompared[index].name,
                        style: getStyleSubTitle(context)
                            .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ), //text: product name
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 2.0),
                    child: Align(
                      child: Wrap(
                        spacing: 5.0,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Text(
                            productCompareNotifier.listProductCompared[index]
                                            .splPrice !=
                                        null &&
                                    productCompareNotifier
                                        .listProductCompared[index]
                                        .splPrice
                                        .isNotEmpty
                                ? "${productCompareNotifier.currency} ${productCompareNotifier.listProductCompared[index].splPrice}"
                                : "",
                            style: getProductAmtTextStyle(context),
                          ),
                          Text(
                            productCompareNotifier
                                            .listProductCompared[index].price !=
                                        null &&
                                    productCompareNotifier
                                        .listProductCompared[index]
                                        .price
                                        .isNotEmpty
                                ? "${productCompareNotifier.currency} ${double.parse(productCompareNotifier.listProductCompared[index].price.toString()).toStringAsFixed(2)}"
                                : "0.0",
                            style: getStyleBody2(context).copyWith(
                                decoration: productCompareNotifier
                                                .listProductCompared[index]
                                                .splPrice !=
                                            null &&
                                        productCompareNotifier
                                            .listProductCompared[index]
                                            .splPrice
                                            .isNotEmpty
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: productCompareNotifier
                                                .listProductCompared[index]
                                                .splPrice !=
                                            null &&
                                        productCompareNotifier
                                            .listProductCompared[index]
                                            .splPrice
                                            .isNotEmpty
                                    ? colorBlack
                                    : colorPrimary),
                          ),
                          Text(
                            //"20% off",
                            "",
                            style: getProductAmtTextStyle(context)
                                .copyWith(color: colorFlashGreen),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ), //text: product price & offers
                  Visibility(
                    visible: (productCompareNotifier
                                .listProductCompared[index].rating.isEmpty ||
                            productCompareNotifier
                                    .listProductCompared[index].rating ==
                                'null')
                        ? false
                        : true,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        color: colorYellow,
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 2.0, bottom: 3.0, right: 6.0, left: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              AppStarRating(
                                color: colorWhite,
                                rating: (productCompareNotifier
                                        .listProductCompared[index]
                                        .rating
                                        .isEmpty)
                                    ? 0
                                    : double.parse(productCompareNotifier
                                            .listProductCompared[index]
                                            .rating) ??
                                        0,
                                starCount: 5,
                                size: 12.0,
                                allowHalfRating: true,
                              ),
                              SizedBox(
                                width: 3.0,
                              ),
                              Text(
                                productCompareNotifier
                                    .listProductCompared[index].rating,
                                style: getStyleCaption(context).copyWith(
                                    color: colorWhite,
                                    fontSize: 9.0,
                                    fontWeight: AppFont.fontWeightSemiBold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
          : _buildAddButtonView(index, productCompareNotifier),
    );
  }

  Widget _buildAddButtonView(
      index, ProductCompareNotifier productCompareNotifier) {
    return Container(
      alignment: Alignment.center,
      child: Builder(
        builder: (BuildContext context) => FlatButton(
          color: colorPrimary,
          onPressed: () =>
              {_onClickAddSimilarProducts(context, productCompareNotifier)},
          child: Text(
            'ADD PRODUCT',
            style: getStyleCaption(context).copyWith(
                fontSize: 8.0,
                color: colorWhite,
                fontWeight: AppFont.fontWeightSemiBold),
          ),
        ),
      ),
    );
  }

  Widget _buildListSubTitleTile(BuildContext context, String lstCompareTitle,
      ProductCompareNotifier productCompareNotifier) {
    return Container(
      color: colorGrey,
      child: _buildSpecifications(productCompareNotifier),

      /*Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: colorWhite,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              lstCompareTitle,
              textAlign: TextAlign.center,
              style: getStyleSubTitle(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
            ),
          ),
          //_buildChildCompareSpecs(lstCompareTitle, productCompareNotifier)
          _buildSpecifications(productCompareNotifier)
        ],
      ),*/
    );
  }

  Widget _buildSpecifications(ProductCompareNotifier productCompareNotifier) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return _itemSpecification(index, productCompareNotifier);
        },
        itemCount: 3);
  }

  Widget _itemSpecification(
      int index, ProductCompareNotifier productCompareNotifier) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: colorWhite,
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                _specificationTitle(index),
                textAlign: TextAlign.center,
                style: getStyleSubTitle(context)
                    .copyWith(fontWeight: AppFont.fontWeightSemiBold),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: (index == 0)
                          ? Html(
                              data: _getSpecification(
                                  index, productCompareNotifier, 0),
                              defaultTextStyle: getStyleCaption(context)
                                  .copyWith(color: colorBlack),
                            )
                          : Text(
                              _getSpecification(
                                  index, productCompareNotifier, 0),
                              textAlign: TextAlign.center,
                              style: getStyleCaption(context)
                                  .copyWith(color: colorBlack),
                            ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  child: VerticalDivider(
                    indent: 0.0,
                    endIndent: 0.0,
                    color: Colors.red,
                    thickness: 3.0,
                  ),
                  width: 20.0,
                )
                /*width: 1.0,
                  color: colorDarkGrey,
                  padding: EdgeInsets.only(
                      top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                )*/
                ,
                Expanded(
                  child: Container(
                    child: (index == 0)
                        ? Html(
                            data: _getSpecification(
                                index, productCompareNotifier, 1),
                            defaultTextStyle: getStyleCaption(context)
                                .copyWith(color: colorBlack),
                          )
                        : Text(
                            _getSpecification(index, productCompareNotifier, 1),
                            textAlign: TextAlign.center,
                            style: getStyleCaption(context)
                                .copyWith(color: colorBlack),
                          ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  String _specificationTitle(int index) {
    switch (index) {
      case 0:
        return 'Description';
      case 1:
        return 'SKU';
      case 2:
        return 'Unit of Measurement';
      case 3:
        return 'SKU';
      default:
        return 'Specification';
    }
  }

  String _getSpecification(int index,
      ProductCompareNotifier productCompareNotifier, int productCount) {
    if (index == 0) {
      if (productCount == 0) {
        return (productCompareNotifier.listProductCompared.length > 0)
            ? productCompareNotifier.listProductCompared[0].shortDescription ??
                'N/A'
            : 'N/A';
      } else {
        return (productCompareNotifier.listProductCompared.length > 1)
            ? productCompareNotifier.listProductCompared[1].shortDescription ??
                'N/A'
            : 'N/A';
      }
    } else if (index == 1) {
      if (productCount == 0) {
        return (productCompareNotifier.listProductCompared.length > 0)
            ? productCompareNotifier.listProductCompared[0].sku ?? 'N/A'
            : 'N/A';
      } else {
        return (productCompareNotifier.listProductCompared.length > 1)
            ? productCompareNotifier.listProductCompared[1].sku ?? 'N/A'
            : 'N/A';
      }
    } else if (index == 2) {
      if (productCount == 0) {
        return (productCompareNotifier.listProductCompared.length > 0)
            ? productCompareNotifier.listProductCompared[0].unit ?? 'N/A'
            : 'N/A';
      } else {
        return (productCompareNotifier.listProductCompared.length > 1)
            ? productCompareNotifier.listProductCompared[1].unit ?? 'N/A'
            : 'N/A';
      }
    } else {
      return '';
    }
  }

  Widget _buildChildCompareSpecs(
      String lstCompareTitle, ProductCompareNotifier productCompareNotifier) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      (productCompareNotifier.listProductCompared.length > 0)
                          ? productCompareNotifier
                                  .listProductCompared[0].shortDescription ??
                              'N/A'
                          : 'N/A',
                      textAlign: TextAlign.center,
                      style:
                          getStyleCaption(context).copyWith(color: colorBlack),
                    ),
                  ),
                ),
                Container(
                  width: 1.0,
                  color: colorDarkGrey,
                  padding: EdgeInsets.only(
                      top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      (productCompareNotifier.listProductCompared.length > 1)
                          ? productCompareNotifier
                                  .listProductCompared[1].shortDescription ??
                              'N/A'
                          : 'N/A',
                      textAlign: TextAlign.center,
                      style:
                          getStyleCaption(context).copyWith(color: colorBlack),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));

    /* Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: lstCompareProducts
            .asMap()
            .map((index, item) {
              return MapEntry(
                  index,
                  Expanded(
                    child: Container(
                      child: Text(
                        (lstCompareProducts[index].id < 0)
                            ? 'N/A'
                            : lstCompareProducts[index].mapCompareContent[lstCompareTitle],
                        textAlign: TextAlign.center,
                        style: getStyleCaption(context).copyWith(color: colorBlack),
                      ),
                    ),
                  ));
            })
            .values
            .toList(),
      ),
    );*/
  }

/*Widget _buildChildCompareSpecs(String lstCompareTitle, ProductCompareNotifier productCompareNotifier) {
    if (lstCompareProducts.length == 2) {
      return Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    (lstCompareProducts[0].id < 0)
                        ? 'N/A'
                        : lstCompareProducts[0]
                            .mapCompareContent[lstCompareTitle],
                    textAlign: TextAlign.center,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
              ),
              Container(height: 150, width: 1.0, color: colorDarkGrey),
              Expanded(
                child: Container(
                  child: Text(
                    (lstCompareProducts[1].id < 0)
                        ? 'N/A'
                        : lstCompareProducts[1]
                            .mapCompareContent[lstCompareTitle],
                    textAlign: TextAlign.center,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
              )
            ],
          ));
    } else if (lstCompareProducts.length == 3) {
      return Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    (lstCompareProducts[0].id < 0)
                        ? 'N/A'
                        : lstCompareProducts[0]
                            .mapCompareContent[lstCompareTitle],
                    textAlign: TextAlign.center,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
              ),
              Container(
                  height: 100, child: VerticalDivider(color: colorDarkGrey)),
              Expanded(
                child: Container(
                  child: Text(
                    (lstCompareProducts[1].id < 0)
                        ? 'N/A'
                        : lstCompareProducts[1]
                            .mapCompareContent[lstCompareTitle],
                    textAlign: TextAlign.center,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
              ),
              Container(
                  height: 100, child: VerticalDivider(color: colorDarkGrey)),
              Expanded(
                child: Container(
                  child: Text(
                    (lstCompareProducts[2].id < 0)
                        ? 'N/A'
                        : lstCompareProducts[2]
                            .mapCompareContent[lstCompareTitle],
                    textAlign: TextAlign.center,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
              ),
            ],
          ));
    } else {
      return Container();
    }

     Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: lstCompareProducts
            .asMap()
            .map((index, item) {
              return MapEntry(
                  index,
                  Expanded(
                    child: Container(
                      child: Text(
                        (lstCompareProducts[index].id < 0)
                            ? 'N/A'
                            : lstCompareProducts[index].mapCompareContent[lstCompareTitle],
                        textAlign: TextAlign.center,
                        style: getStyleCaption(context).copyWith(color: colorBlack),
                      ),
                    ),
                  ));
            })
            .values
            .toList(),
      ),
    );
  }*/

  void _onClickRemoveProduct(
      ProductCompareNotifier productCompareNotifier, int index) {
    productCompareNotifier.callAPIRemoveProduct(index);
  }

  void _onClickAddSimilarProducts(
      context, ProductCompareNotifier productCompareNotifier) async {
    if (productCompareNotifier.listProductCompared.length > 0) {
      await productCompareNotifier.callApiRelatedProductList(
          productCompareNotifier.listProductCompared.first.id);
      if (productCompareNotifier.lstRelatedProduct.isNotEmpty) {
        showModalBottomSheetType(
            context, getScreenHeight(context), productCompareNotifier);
      } else {
        log.d('No Simillar products found');
        productCompareNotifier.showSnackBarContextDuration(
            context, "No Simillar products found", 2);
        // productCompareNotifier.showToast("No Simillar products found");
      }
    }
  }

  void showModalBottomSheetType(
      context, screenHeight, ProductCompareNotifier productCompareNotifier) {
    showCustomModalBottomSheet<void>(
        context: context,
        theme: new ThemeData(
          canvasColor: Colors.transparent,
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Container(
                color: colorWhite,
                height: screenHeight / 1.2,
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                        child: Container(
                      margin: EdgeInsets.only(top: 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child:
                                _buildSelectProductList(productCompareNotifier),
                          )
                        ],
                      ),
                    )
                        //_buildSelectProductList(),
                        ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      color: colorPrimary,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            'Similar Products',
                            style: getStyleSubHeading(context).copyWith(
                                color: colorWhite,
                                fontWeight: AppFont.fontWeightBold),
                          )),
                          Icon(
                            Icons.clear,
                            color: colorWhite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool isOnlyMinimumProductsAdded(int length) {
    return (length == 1);
  }

  bool isMaximumProductsAdded(int length) {
    return (2 == length);
  }

  Widget _buildSelectProductList(
      ProductCompareNotifier productCompareNotifier) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 8.0),
        itemCount: productCompareNotifier.lstRelatedProduct.length,
        itemBuilder: (_, index) {
          return _buildSelectProductItem(
              productCompareNotifier.lstRelatedProduct[index],
              index,
              productCompareNotifier);
        });
  }

  Widget _buildSelectProductItem(ItemProduct lstRelatedProduct, int index,
      ProductCompareNotifier productCompareNotifier) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      child: GestureDetector(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(

                          //borderRadius: BorderRadius.only(
                          //    topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))
                          ),
                      margin: EdgeInsets.only(right: 16.0),
                      padding: EdgeInsets.all(14.0),
                      child: (lstRelatedProduct.imageUrl != null &&
                              lstRelatedProduct.imageUrl != "")
                          ? Image.network(
                              lstRelatedProduct.imageUrl,
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.fitHeight,
                            )
                          : Image.asset(
                              AppImages.IMAGE_LOGO_THOUGHT_FACTORY,
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          lstRelatedProduct.name,
                          maxLines: 2,
                          style: getWLProductNameTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${productCompareNotifier.currency} ${lstRelatedProduct.price}",
                              style: getWLProductAmtTextStyle(context),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "${productCompareNotifier.currency} ${lstRelatedProduct.price}",
                              style: getWLProductStrikeAmtTextStyle(context),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        /*Container(
                          padding: EdgeInsets.only(top: 0.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '20% off',
                            style: getWLProductOfferAmtTextStyle(context),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),*/
                        Container(
                          padding: EdgeInsets.only(
                              left: 4, right: 4, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              color: colorYellow),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: colorWhite,
                                size: 12,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "4.5",
                                style: getWLProductOfferAmtTextStyle(context)
                                    .copyWith(color: colorWhite),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              (productCompareNotifier.lstRelatedProduct.length - 1) != index
                  ? Divider(
                      height: 1.0,
                      color: colorDarkGrey,
                    )
                  : Container(
                      height: 0,
                    )
            ],
          ),
        ),
        onTap: () => onTappedSelectedProductItem(
            lstRelatedProduct.id, productCompareNotifier),
      ),
    );
  }

  onTappedSelectedProductItem(
      int productID, ProductCompareNotifier productCompareNotifier) {
    if (productID > 0) {
      productCompareNotifier.addProductCompare(productID.toString());
      // Navigator.pop(context);
    }
  }
}
