import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/product_list_notifier.dart';
import 'package:thought_factory/ui/compare/compare_screen.dart';
import 'package:thought_factory/ui/menu/my_cart/my_cart_screen.dart';
import 'package:thought_factory/ui/product/product_detail_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/widget_product_item.dart';

import '../../router.dart';

// ignore: must_be_immutable
class ProductListScreen extends StatefulWidget {
  static const routeName = '/product_list_screen';
  final log = getLogger('ProductListScreen');
  InfoHomeTap infoHomeTap1;

  ProductListScreen({this.infoHomeTap1});

  @override
  _ProductListScreenState createState() =>
      _ProductListScreenState(infoHomeTap1);
}

class _ProductListScreenState extends State<ProductListScreen> {
  //final lstProducts = getListProductsForFashion();
  InfoHomeTap infoHomeTap;

  _ProductListScreenState(InfoHomeTap infoHomeTap) {
    this.infoHomeTap = infoHomeTap;
  }

  //_ProductListScreenState(this.infoHomeTap);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (infoHomeTap == null) {
      print("inforhometap1 -----------> $infoHomeTap");
      infoHomeTap = ModalRoute.of(context).settings.arguments;
    }

    return ChangeNotifierProvider<ProductListNotifier>(
      create: (context) => ProductListNotifier(infoHomeTap, context),
      child: Consumer<ProductListNotifier>(
        builder: (context, productNotifier, _) => Scaffold(
          key: _scaffoldKey,
          appBar: _buildAppbar(infoHomeTap, productNotifier),
          bottomNavigationBar: Builder(
              builder: (BuildContext context) =>
                  _buildBottomBar(productNotifier, context)),
          body: ModalProgressHUD(
            inAsyncCall: productNotifier.isLoading,
            child: Builder(
              builder: (BuildContext context) =>
                  _buildScreenContent(productNotifier, infoHomeTap),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreenContent(
      ProductListNotifier productListNotifier, InfoHomeTap infoHomeTap) {
    if (productListNotifier.lstProducts == null ||
        productListNotifier.lstProducts.length == 0) {
      return Container(
        child: Center(
          child: productListNotifier.isLoading == true
              ? Text("Please wait..")
              : Text('No data found'),
        ),
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(productListNotifier, infoHomeTap),
          _buildSliverGridProducts(productListNotifier),
        ],
      );
    }
  }

  AppBar _buildAppbar(
      InfoHomeTap infoHomeTap, ProductListNotifier productNotifier) {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(infoHomeTap.toolBarName ?? ""),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 18,
          tooltip: 'Open shopping cart',
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(MyCartScreen.routeName, arguments: true)
                        .whenComplete(() {
                      productNotifier.refreshProductList(infoHomeTap);
                    });
                  },
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
                      child: Consumer<CommonNotifier>(
                        builder: (context, commonNotifier, _) => Text(
                          commonNotifier.cartCount ?? '0',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: colorBlack,
                          ),
                        ),
                      )),
                )
              ],
            ),
          )
        ]);
  }

  Widget _buildSliverAppBar(
      ProductListNotifier productListNotifier, InfoHomeTap infoHomeTap) {
    return SliverAppBar(
      leading: Icon(null),
      expandedHeight:
          infoHomeTap.type != AppConstants.FIELD_POPULAR_PRODUCT ? 138 : 60,
      floating: true,
      flexibleSpace: Container(
        color: colorGrey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: colorPrimary,
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 38.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: TextFormField(
                    controller: productListNotifier.searchProductEditText,
                    style: getStyleCaption(context)
                        .copyWith(fontStyle: FontStyle.italic),
                    decoration: InputDecoration(
                      hintText: "Search products",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          onClickSearchButton(productListNotifier);
                        },
                        color: colorBlack,
                        icon: Icon(Icons.search),
                      ),
                      prefixIcon: Visibility(
                        visible: productListNotifier.btnCancelVisible,
                        child: IconButton(
                          onPressed: () {
                            log.i('Clicked : Button clear ');
                            productListNotifier.refreshProductList(infoHomeTap);
                            productListNotifier.searchProductEditText.text = "";
                          },
                          color: colorBlack,
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              infoHomeTap.type != AppConstants.FIELD_POPULAR_PRODUCT
                  ? Container(
                      margin: EdgeInsets.only(top: 14.0, bottom: 14.0),
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: RaisedButton.icon(
                            onPressed: () =>
                                productListNotifier.clearCompareProductsList(),
                            label: Text(
                              AppConstants.COMPARE,
                              style: getStyleBody1(context).copyWith(
                                  fontWeight: AppFont.fontWeightSemiBold,
                                  color: productListNotifier.isCompareModeOn
                                      ? colorPrimary
                                      : colorBlack),
                            ),
                            icon: Icon(
                              Icons.swap_horiz,
                              color: productListNotifier.isCompareModeOn
                                  ? colorPrimary
                                  : colorBlack,
                            ),
                            color: colorWhite,
                            splashColor: colorPrimary,
                          )),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                              child: RaisedButton.icon(
                            onPressed: () {
                              _onTapFilterOption(context, productListNotifier);
                            },
                            label: Text(
                              AppConstants.FILTER,
                              style: getStyleBody1(context).copyWith(
                                  fontWeight: AppFont.fontWeightSemiBold),
                            ),
                            icon: Icon(Icons.filter_list),
                            color: colorWhite,
                            splashColor: colorPrimary,
                          ))
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverGridProducts(ProductListNotifier productListNotifier) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 8, right: 8),
      sliver: SliverGrid(
        key: UniqueKey(),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 0, left: 4.0, right: 4.0),
              child: WidgetProductItem(
                itemProduct: productListNotifier.lstProducts[index],
                onPressedProduct: (value) =>
                    _onTapProductDetail(value, context, productListNotifier),
                onPressedAdd: () => _onTapAddProduct(
                    productListNotifier.lstProducts[index],
                    productListNotifier),
                onPressedRemove: (value) =>
                    _onTapRemoveProduct(value, productListNotifier),
                onPressedIconHeart: (value) =>
                    _onTapIconHeart(value, productListNotifier),
                onPressedItemCompareButton: (value) => _onTapItemCompareButton(
                    value, productListNotifier, productListNotifier, context),
                isCompareModeOn: productListNotifier.isCompareModeOn,
              ),
            );
          },
          childCount: productListNotifier.lstProducts.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 4.9),
      ),
    );
  }

  Widget _buildBottomBar(
      ProductListNotifier productListNotifier, BuildContext context) {
    return productListNotifier.isCompareModeOn
        ? Container(
            padding: EdgeInsets.all(16),
            color: colorWhite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildBottomCompareProductItem(productListNotifier),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: colorAccent,
                    textColor: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      'Compare',
                      style: getStyleButtonText(context),
                    ),
                    onPressed: () {
                      if (productListNotifier.productID.length == 2) {
                        Navigator.pushNamed(
                                context, CompareProductScreen.routeName)
                            .then((val) {
                          log.d('$val');
                          productListNotifier.onCompareProductChanged(val);
                        });
                      } else
                        productListNotifier.showSnackBarContextDuration(
                            context, 'Select atleast 2 items to compare', 2);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
              ],
            ),
          )
        : SizedBox();
  }

  Widget _buildBottomCompareProductItem(
      ProductListNotifier productListNotifier) {
    return !productListNotifier.isCompareModeOn
        ? Container()
        : Container(
            child: (productListNotifier.lstCompareProduct == null ||
                    productListNotifier.lstCompareProduct.length == 0)
                ? Container()
                : Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        child: _buildProductItem(
                            productListNotifier.lstCompareProduct[0]),
                      )),
                      Expanded(
                        child: Container(
                          child: _buildProductItem(
                              productListNotifier.lstCompareProduct[1]),
                        ),
                      )
                    ],
                  ),
          );
  }

  Widget _buildProductItem(ItemProduct lstCompareProduct) {
    return Container(
        child: Stack(
      children: <Widget>[
        FloatingActionButton(
          elevation: 2.0,
          onPressed: () {},
          mini: true,
          backgroundColor: colorWhite,
          child: Icon(
            Icons.favorite,
            size: 18,
          ),
        )
      ],
    ));
  }

  void _onTapAddProduct(
      ItemProduct itemProduct, ProductListNotifier productNotifier) {
    print('clicked: add');
    print("itemproc --------------> $itemProduct");

    //if product has custom option do this
    if (itemProduct.isCustomProduct) {
      print("customProduct exist");
      _navigateToProductDetail(itemProduct, productNotifier);
      return;
    }

    if (itemProduct.minQuantity != null && itemProduct.minQuantity > 1) {
      print("minQuantity exist");
      _navigateToProductDetail(itemProduct, productNotifier);
      return;
    } else {
      itemProduct.minQuantity = 0;
    }

    //no custom option do this
    bool isAvailable = false;
    Provider.of<CommonNotifier>(context)
        .callApiChangeCartItemQuantity(itemProduct);

    //call api: add item to cart
    if (itemProduct.chosenQuantity != itemProduct.maxQuantity) {
      CommonNotifier commonNotifier = CommonNotifier();
      commonNotifier.callApiGetCartList();
      log.i(
          "cartlistresponse ---------------> $commonNotifier  ${commonNotifier.cartListResponse}");
      if (commonNotifier.cartListResponse != null &&
          commonNotifier.cartListResponse.data != null &&
          commonNotifier.cartListResponse.data.length > 0) {
        for (int i = 0; i < commonNotifier.cartListResponse.data.length; i++) {
          for (int j = 0;
              j < commonNotifier.cartListResponse.data[i].productList.length;
              j++) {
            if (itemProduct.itemCartId != null &&
                itemProduct.itemCartId ==
                    commonNotifier
                        .cartListResponse.data[i].productList[j].itemId) {
              isAvailable = true;
              break;
            }
          }
        }

        if (isAvailable) {
          print('coming -------> $itemProduct');
          productNotifier.callApiChangeCartItemQuantity(
              itemProduct, itemProduct.chosenQuantity + 1);
        } else {
          print('coming else -------> $itemProduct');
          productNotifier.callApiFirstTimeAddToCart(itemProduct, _scaffoldKey);
        }
      } else {
        print('isAvailable -------> null');
        productNotifier.callApiFirstTimeAddToCart(itemProduct, _scaffoldKey);
      }
      if (itemProduct.isCustomProduct == false) {
      } else {
        print("custom Product exist in ELSE loop");
        _navigateToProductDetail(itemProduct, productNotifier);
      }
    } else {
      print('max quantity reached');
    }
  }

  void _onTapRemoveProduct(
      ItemProduct itemProduct, ProductListNotifier productNotifier) {
    print('clicked: remove');
    if (itemProduct.chosenQuantity == 1) {
      productNotifier.callApiRemoveCartItem(itemProduct);
    } else if (itemProduct.chosenQuantity != 0) {
      productNotifier.callApiChangeCartItemQuantity(
          itemProduct, itemProduct.chosenQuantity - 1);
    } else {
      productNotifier.showSnackBarMessageWithContext('Cant reduce futher');
      print('min quantity reached, cant reduce futher');
    }
  }

  void _onTapIconHeart(
      ItemProduct itemProduct, ProductListNotifier productNotifier) async {
    itemProduct.isFavourite = (!itemProduct.isFavourite);
    if (itemProduct.isFavourite) {
      print('1 ------------> product list screen ');
      productNotifier.callApiAddToWishList(itemProduct);
    } else {
      print('2 ------------> product list screen ');
      await productNotifier.callApiGetWishList();
      if (productNotifier.wishListResponse != null &&
          productNotifier.wishListResponse.wishList != null) {
        for (int i = 0;
            i < productNotifier.wishListResponse.wishList.length;
            i++) {
          if (itemProduct.id ==
              int.parse(
                  productNotifier.wishListResponse.wishList[i].productId)) {
            productNotifier.callApiRemoveFromWishList(
                itemProduct,
                productNotifier.wishListResponse.wishList[i].wishlistItemId
                    .toString());
          }
        }
      }
    }
  }

  void _onTapItemCompareButton(
      ItemProduct itemProduct,
      ProductListNotifier productListNotifier,
      ProductListNotifier productNotifier,
      BuildContext context) async {
    widget.log.i('Printing successfully');
    print("true ------> ${itemProduct.isAddedToCompare}");
    if (!itemProduct.isAddedToCompare) {
      //Remove Product from Compare  apiAddToCompare
      await productNotifier.apiRemoveFromCompare(itemProduct.id.toString());
      if (productNotifier.addOrRemoveProductsToCompareResponse != null &&
          productNotifier.addOrRemoveProductsToCompareResponse.addToCompare !=
              null) {
        if (productNotifier.addOrRemoveProductsToCompareResponse.addToCompare[0]
                    .status ==
                1 ||
            productNotifier.addOrRemoveProductsToCompareResponse.addToCompare[0]
                    .status ==
                0) {
          if (productListNotifier.productID.contains(itemProduct.id.toString()))
            productListNotifier.productID.remove(itemProduct.id.toString());
          itemProduct.isAddedToCompare = (!itemProduct.isAddedToCompare);
        }
/*        productNotifier.showSnackBarMessageParamASContext(
            context,
            productNotifier
                .addOrRemoveProductsToCompareResponse.addToCompare[0].message);*/
      }
    } else if (itemProduct.isAddedToCompare &&
        productListNotifier.productID.length < 2) {
      //Add Product from Compare
      await productNotifier.apiAddToCompare(itemProduct.id.toString());
      if (productNotifier.addOrRemoveProductsToCompareResponse != null &&
          productNotifier.addOrRemoveProductsToCompareResponse.addToCompare !=
              null) {
        if (productNotifier.addOrRemoveProductsToCompareResponse.addToCompare[0]
                    .status ==
                1 ||
            productNotifier.addOrRemoveProductsToCompareResponse.addToCompare[0]
                    .status ==
                0) {
          productListNotifier.productID.add(itemProduct.id.toString());
          itemProduct.isAddedToCompare = (!itemProduct.isAddedToCompare);
        }
        /*    productNotifier.showSnackBarMessageParamASContext(
            context,
            productNotifier
                .addOrRemoveProductsToCompareResponse.addToCompare[0].message);*/
      }
    } else {
      productNotifier.showSnackBarContextDuration(
          context, 'Max. of 2 Products allowed', 2);
    }
  }

  void _onTapFilterOption(
      BuildContext context, ProductListNotifier productListNotifier) async {
    print('clicked: Filter');
    String categoryId = infoHomeTap.id.toString();
    productListNotifier.callAPIFilterFormDetail(categoryId);
  }

  void _onTapProductDetail(ItemProduct value, BuildContext context,
      ProductListNotifier productListNotifier) {
    print('clicked: product Detail');

    _navigateToProductDetail(value, productListNotifier);
    // (or) another way
    /*Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(), settings: RouteSettings(arguments: value)),
    );*/
  }

  void onClickSearchButton(ProductListNotifier productListNotifier) {
    log.i('Clicked : Button Search ');
    if (productListNotifier.searchProductEditText.text.length > 0) {
      if (infoHomeTap.type == AppConstants.FIELD_SELLER_ID) {
        productListNotifier.apiGetProductBySearchNameDistributorWise(
            infoHomeTap.id.toString(),
            productListNotifier.searchProductEditText.text.trim());
      } else {
        productListNotifier.apiGetProductBySearchName(
            productListNotifier.searchProductEditText.text);
      }
    } else {
      productListNotifier
          .showSnackBarMessageWithContext("Please enter Product name");
    }
  }

  void _navigateToProductDetail(
      ItemProduct itemProduct, ProductListNotifier productNotifier) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: itemProduct)
        .whenComplete(() {
      productNotifier.refreshProductList(infoHomeTap);
    });
  }
}
