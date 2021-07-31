import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/sub_category/response_sub_category_list.dart';
import 'package:thought_factory/core/model/category_model.dart';
import 'package:thought_factory/core/model/cateogry_showoff_data.dart';
import 'package:thought_factory/core/model/distributor_model.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/home_notifier.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/product/product_detail_screen.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_network_check.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/widget_product_item.dart';

class HomeScreen extends StatefulWidget {
  final log = getLogger('HomeScreen');
  StateDrawer stateDrawer;

  HomeScreen(this.stateDrawer, context);

  @override
  _HomeScreenState createState() => _HomeScreenState(stateDrawer);
}

class _HomeScreenState extends State<HomeScreen> {
  final log = getLogger('HomeScreen');
  List<Widget> listHomeWidgets = List();
  List<Widget> listPopularProducts = List();
  List<Widget> listTopDistributors = List();
  List<Widget> listCategoryBasedWidgets = List();
  StateDrawer stateDrawer;
  BuildContext ctx;

  _HomeScreenState(this.stateDrawer);

  @override
  void initState() {
    super.initState();
    print("calling state");
    Future.delayed(Duration.zero, () {
      HomeNotifier homeNotifier =
          Provider.of<HomeNotifier>(context, listen: false);
      homeNotifier.context = context;
      homeNotifier.stateDrawer = stateDrawer;
      initialSetup(homeNotifier);
    });

    stateDrawer.onValueChange.addListener(() {
      log.d("SomeThing happened in menu");
      log.d(stateDrawer.onValueChange.value.toString());
      _categoryfun(CategoryModel(
          id: stateDrawer.onValueChange.value.id,
          name: stateDrawer.onValueChange.value.toolBarName));
    });
  }

  void initialSetup(HomeNotifier homeNotifier) async {
    await CommonNotifier().callApiBasicInfoResponse();
    await CommonNotifier().callApiGetCartList();
    await CommonNotifier().callApiGetWishList();
    _localApiHits(homeNotifier);
    homeNotifier.apiGetTopDistributorsList();
    //CommonNotifier().callApiGetWishList();
    if (CommonNotifier().privacyPolicy == "" ||
        CommonNotifier().termsandCondition == "") {
      CommonNotifier().callListUrlResponse();
    }
    viewSetup(homeNotifier);
  }

  viewSetup(HomeNotifier homeNotifier) {
    listHomeWidgets.clear();
    if (listTopDistributors != null && listTopDistributors.length > 0) {
      listTopDistributors.clear();
    }
    if (listPopularProducts != null && listPopularProducts.length > 0) {
      listPopularProducts.clear();
    }
    listHomeWidgets.add(_buildTitle(context, 'Categories'));
    listHomeWidgets.add(_buildCategoryList(context));
    listPopularProducts.add(_buildProductType(context, 'Popular Products'));
    listTopDistributors.add(_buildTitle(context, 'Top Distributors'));
    listTopDistributors.add(_buildTopDistributorsList(context));
    homeNotifier.isCategoryListArrived.addListener(() {
      widget.log.i('new show off category list arrived');
      CategoryShowOffData itemCategory = homeNotifier.categoryShowOffData;
      setState(() {
        listCategoryBasedWidgets.add(_buildRealProductType(
            context, itemCategory, itemCategory.listItemProduct));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(
      builder: (context, homeNotifier, _) => Stack(
        children: <Widget>[
          _buildSearchBar(context, homeNotifier),
          Container(
              margin: EdgeInsets.only(top: 65),
              //added this CustomScrollView smooth scroll experience
              child: Stack(
                children: <Widget>[
                  RefreshIndicator(
                      child: ModalProgressHUD(
                        inAsyncCall: homeNotifier.isLoading,
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        key: ValueKey(20),
                                        children: listHomeWidgets,
                                      ),
                                      Column(
                                        children: listPopularProducts,
                                      ),
                                      Column(
                                        children: listTopDistributors,
                                      ),
                                      Column(
                                        children: listCategoryBasedWidgets,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onRefresh: _refreshHomeScreen),
                  Visibility(
                      visible: homeNotifier.btnCancelVisible,
                      child: _buildScreenContent(
                          homeNotifier, homeNotifier.lstProducts))
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, HomeNotifier homeNotifier) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          color: colorPrimary,
          height: 70,
        ),
        Container(
          margin: EdgeInsets.only(right: 16.0, left: 16.0),
          alignment: Alignment.topCenter,
          height: 42.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
          child: TextFormField(
            onTap: (){
              if( homeNotifier.searchProductEditText.text.isNotEmpty && homeNotifier.searchProductEditText.text.length > 2){
                print("SearchProductname " +homeNotifier.searchProductEditText.text);
                homeNotifier.apiGetProductBySearchName(
                    homeNotifier.searchProductEditText.text);
              }
            },
            controller: homeNotifier.searchProductEditText,
            onChanged: (value){
              if( homeNotifier.searchProductEditText.text.isNotEmpty && homeNotifier.searchProductEditText.text.length > 2){
                print("SearchProductname " +homeNotifier.searchProductEditText.text);
                homeNotifier.apiGetProductBySearchName(
                    homeNotifier.searchProductEditText.text);
              }
            },
            style: getAppSearchTextStyle(context),
            decoration: InputDecoration(
              hintText: "Search products",
              alignLabelWithHint: true,
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  print("pressed search");
                  homeNotifier.apiGetProductBySearchName(
                      homeNotifier.searchProductEditText.text);
                },
                color: colorBlack,
                icon: Icon(Icons.search),
              ),
              prefixIcon: Visibility(
                visible: homeNotifier.btnCancelVisible,
                child: IconButton(
                  onPressed: () {
                    log.i('Clicked : Button clear ');
                    homeNotifier.searchProductEditText.text = "";
                    homeNotifier.lstProducts.clear();
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  color: colorBlack,
                  icon: Icon(Icons.close),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Container(
      color: colorGrey,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, left: 16.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: getStyleSubHeading(context)
                  .copyWith(fontWeight: AppFont.fontWeightBold),
            )),
      ),
    );
  }

  Widget _buildCategoryList(context) {
    return Container(
      color: colorGrey,
      height: 135,
      child: Consumer<HomeNotifier>(
        builder: (context, homeNotifier, _) => AnimatedSwitcher(
          /*  transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(child: child, scale: animation),*/
          duration: Duration(seconds: 1),
          child: homeNotifier.isCategoryApiFetching
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: homeNotifier.lstCategory.length,
                  itemBuilder: (_, index) {
                    return _buildListTileCategory(
                        context, homeNotifier.lstCategory[index]);
                  },
                  padding: EdgeInsets.only(right: 16.0),
                  scrollDirection: Axis.horizontal,
//                    children: homeNotifier.lstCategory.map((itemCategory) {
//                      return _buildListTileCategory(context, itemCategory);
//                    }).toList(),
                ),
        ),
      ),
    );
  }

  Widget _buildListTileCategory(context, CategoryModel itemCategory) {
    this.ctx = context;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
      child: Container(
          alignment: Alignment.center,
          width: 70,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: colorPrimary,
              onTap: () {
                print('clicked: category ${itemCategory.name}');
                _categoryfun(itemCategory);
              },
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 1.5,
                    color: colorWhite,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      width: 70,
                      height: 70,
                      child: (itemCategory.imageUrl != null &&
                              itemCategory.imageUrl.isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl: itemCategory.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      image: imageProvider,
                                      fit: BoxFit.scaleDown),
                                  //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  _buildPlaceHolder(context),
                              errorWidget: (context, url, error) =>
                                  _buildErrorPlaceHolder(context),
                            )
                          : Image.asset(AppImages.IMAGE_LOGO_THOUGHT_FACTORY),
                      //Image.asset(AppImages.IMAGE_CATEGORY_CLOTHING),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      itemCategory.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: getStyleCaption(context).copyWith(
                          color: colorBlack,
                          fontSize: 10.0,
                          fontWeight: AppFont.fontWeightMedium),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildProductType(BuildContext context, String stProductType,
      {Color bgColor = colorWhite}) {
    return Consumer<HomeNotifier>(
      builder: (context, homeNotifier, _) => ModalProgressHUD(
        inAsyncCall: homeNotifier.isLoading,
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: bgColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        stProductType,
                        style: getStyleSubHeading(context)
                            .copyWith(fontWeight: AppFont.fontWeightBold),
                      ),
                    )),
                    Material(
                      child: InkWell(
                        splashColor: colorPrimary,
                        onTap: () {
                          _onClickViewAllProducts(
                              context,
                              InfoHomeTap(
                                  id: -1,
                                  toolBarName: "Popular Products",
                                  type: AppConstants.FIELD_POPULAR_PRODUCT));
                        },
                        child: Text(
                          'View all',
                          style: getProductViewAllTextStyle(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                key: UniqueKey(),
                children: <Widget>[
                  (isPopularProductsAvailable(homeNotifier)
                      ? getItemNew(context, homeNotifier.lstPopularProducts[0])
                      : Container()),
                  SizedBox(width: 16.0),
                  (isPopularProductsAvailable(homeNotifier)
                      ? homeNotifier.popularProductsResponse.data.length > 1
                          ? getItemNew(
                              context, homeNotifier.lstPopularProducts[1])
                          : showEmptyContainer()
                      : Container())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ItemProduct extractPopularProducts(HomeNotifier homeNotifier, int index) {
    /*var data = homeNotifier.popularProductsResponse.data[index];
    print("rrrrrrrrrrrrrr -------------> ${homeNotifier.lstPopularProducts.length}");
    return ItemProduct(
        id: int.parse(data.productId),
        name: data.productName,
        imageUrl: data.productImage[0],
        sku: data.productSku,
        chosenQuantity: homeNotifier.popularProductsCount,
        price: double.parse(data.productPrice),
        maxQuantity: data.productQty,
        productType: data.productType);*/
    return homeNotifier.lstPopularProducts[index];
  }

  bool isPopularProductsAvailable(HomeNotifier homeNotifier) {
    if (homeNotifier.popularProductsResponse != null &&
        homeNotifier.popularProductsResponse.data != null &&
        homeNotifier.popularProductsResponse.data.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildRealProductType(
      BuildContext context, CategoryShowOffData itemCategory, var lstProducts,
      {Color bgColor = colorWhite}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: bgColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    itemCategory.name,
                    style: getStyleSubHeading(context)
                        .copyWith(fontWeight: AppFont.fontWeightBold),
                  ),
                )),
                Material(
                  child: InkWell(
                    splashColor: colorPrimary,
                    onTap: () {
                      _onClickViewAllProducts(
                          context,
                          InfoHomeTap(
                              id: itemCategory.id,
                              toolBarName: itemCategory.name));
                    },
                    child: Text(
                      'View all',
                      style: getProductViewAllTextStyle(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              getItemNew(context, lstProducts[0]),
              SizedBox(width: 16.0),
              lstProducts.length > 1
                  ? getItemNew(context, lstProducts[1])
                  : showEmptyContainer()
            ],
          )
        ],
      ),
    );
  }

  //show this empty container when product is only one
  Widget showEmptyContainer() {
    return Expanded(child: Container());
  }

  Widget getItem(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1.0,
        color: colorGrey,
        child: Container(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0.0,
                color: colorWhite,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      width: (getScreenWidth(context) / 2) - 32,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 30,
                              height: 30,
                              child: FloatingActionButton(
                                heroTag: "${Random().nextDouble()}",
                                onPressed: () {},
                                mini: true,
                                backgroundColor: colorWhite,
                                child: Icon(
                                  Icons.favorite,
                                  size: 18,
                                  color: colorPrimary,
                                ),
                                elevation: 2.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 4.0, right: 4.0, bottom: 8.0),
                child: Align(
                  child: Text(
                    'Default watch',
                    style: getProductNameTextStyle(context),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ), //text: product name
              Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
                child: Align(
                  child: Text(
                    "AED 25.75",
                    style: getProductAmtTextStyle(context),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ), //text: product price in dollar
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {},
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
                            child: Text(
                              '2',
                              style: getProductQtyTextStyle(context),
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
                          onPressed: () {},
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getItemNew(BuildContext context, ItemProduct itemProduct) {
    return Expanded(
      child: WidgetProductItem(
        itemProduct: itemProduct,
        onPressedAdd: () => _onClickAddProduct(itemProduct),
        onPressedRemove: (value) => _onClickRemoveProduct(value),
        onPressedIconHeart: (value) => _onClickIconHeart(value),
        onPressedProduct: (value) => Navigator.pushNamed(
            context, ProductDetailScreen.routeName,
            arguments: itemProduct),
      ),
    );
  }

  Widget _buildTopDistributorsList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      color: colorGrey,
      height: 118,
      child: Consumer<HomeNotifier>(
        builder: (context, homeNotifier, _) => AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: homeNotifier.isTopDistributorApiFetching
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: homeNotifier.lstDistributor.length,
                    itemBuilder: (_, index) {
                      return _buildListTileTopDistributors(
                          context, homeNotifier.lstDistributor[index]);
                    },
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    scrollDirection: Axis
                        .horizontal) /*ListView(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  scrollDirection: Axis.horizontal,
                  children: _listDistributorModel.map((itemCategory) {
                    return _buildListTileTopDistributors(context, itemCategory);
                  }).toList(),
                ),*/
            ),
      ),
    );
  }

  Widget _buildListTileTopDistributors(
      BuildContext context, DistributorModel itemCategory) {
    var width = (getScreenWidth(context) / 3.5);
    var height = (getScreenWidth(context) / 5.5);
    return Container(
      alignment: Alignment.topCenter,
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: colorPrimary,
          onTap: () {
            _onClickViewAllProducts(
              context,
              InfoHomeTap(
                  id: itemCategory.id,
                  toolBarName: itemCategory.name ?? "Distributor",
                  //'Distributor Name',
                  type: AppConstants.FIELD_SELLER_ID),
            );
          },
          child: Card(
            elevation: 1.0,
            child: Container(
              padding: EdgeInsets.all(16),
              width: width,
              height: height,
              child: (itemCategory.imageUrl != null &&
                      itemCategory.imageUrl.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: itemCategory.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          //shape: BoxShape.circle,
                          image: DecorationImage(
                              alignment: Alignment.center,
                              image: imageProvider,
                              fit: BoxFit.scaleDown),
                          //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                      placeholder: (context, url) => _buildPlaceHolder(context),
                      errorWidget: (context, url, error) =>
                          _buildErrorPlaceHolder(context),
                    )
                  : Image.asset(AppImages.IMAGE_LOGO_THOUGHT_FACTORY),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildPlaceHolder(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Center(child: Image.asset(AppImages.IMAGE_LOGO_THOUGHT_FACTORY)),
    );
  }

  Container _buildSearchImagePlaceHolder(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      child: Center(child: Image.asset(AppImages.IMAGE_LOGO_THOUGHT_FACTORY)),
    );
  }

  Container _buildErrorPlaceHolder(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Center(child: Image.asset(AppImages.IMAGE_LOGO_THOUGHT_FACTORY)),
    );
  }

  void _onClickViewAllProducts(
      BuildContext context, InfoHomeTap infoHomeTap) async {
    HomeNotifier homeNotifier =
        Provider.of<HomeNotifier>(context, listen: false);
    widget.log
        .i('onClickViewAllProducts, params category Id: ${infoHomeTap.id}');

    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      Navigator.pushNamed(context, ProductListScreen.routeName,
              arguments: infoHomeTap)
          .whenComplete(() {
        //updatePopularProducts(homeNotifier);
        listCategoryBasedWidgets.clear();
        _localApiHits(homeNotifier);
      });
    } else {
      Provider.of<HomeNotifier>(context, listen: false)
          .showSnackBarMessageWithContext(
              AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  Future updateTopDistributor(HomeNotifier homeNotifier) async {
    await CommonNotifier().callApiGetCartList();
    await CommonNotifier().callApiGetWishList();
    homeNotifier.apiGetTopDistributorsList();
    viewSetup(homeNotifier);
  }

  Future updatePopularProducts(HomeNotifier homeNotifier) async {
    await CommonNotifier().callApiGetCartList();
    await CommonNotifier().callApiGetWishList();
    await homeNotifier.apiGetPopularProducts();
    homeNotifier.apiGetCustomCategoryList();
    homeNotifier.apiGetTopDistributorsList();
    viewSetup(homeNotifier);
  }

  void _onClickAddProduct(ItemProduct itemProduct) {
    print('clicked: add');
    HomeNotifier homeNotifier =
        Provider.of<HomeNotifier>(context, listen: false);
    //if product has custom option do this
    if (itemProduct.isCustomProduct != null && itemProduct.isCustomProduct) {
      print("customProduct exist");
      _navigateToProductDetail(itemProduct, homeNotifier);
      return;
    }

    if (itemProduct.minQuantity != null && itemProduct.minQuantity > 1) {
      print("minQuantity exist");
      _navigateToProductDetail(itemProduct, homeNotifier);
      return;
    }

    if (itemProduct.productType != null &&
        itemProduct.productType != AppConstants.PRODUCT_TYPE_SIMPLE) {
      print("Product Type is Not Simple");
      _navigateToProductDetail(itemProduct, homeNotifier);
      return;
    }

    //no custom option do this
    bool isAvailable = false;

    if (itemProduct.isCustomProduct != null && itemProduct.isCustomProduct) {
      Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: itemProduct);
    } else {
      if (itemProduct.chosenQuantity != itemProduct.maxQuantity) {
        CommonNotifier commonNotifier = CommonNotifier();
        commonNotifier.callApiGetCartList();
        if (commonNotifier.cartListResponse != null &&
            commonNotifier.cartListResponse.data != null &&
            commonNotifier.cartListResponse.data.length > 0) {
          for (int i = 0;
              i < commonNotifier.cartListResponse.data.length;
              i++) {
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
            homeNotifier.callApiChangeCartItemQuantity(
                itemProduct, itemProduct.chosenQuantity + 1);
          } else {
            homeNotifier.callApiFirstTimeAddToCart(itemProduct);
          }
        } else {
          homeNotifier.callApiFirstTimeAddToCart(itemProduct);
        }
        if (itemProduct.isCustomProduct == false) {
        } else {
          print("custom Product exist in ELSE loop");
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: itemProduct);
        }
      } else {
        print('max quantity reached');
      }
    }
  }

  void _onClickRemoveProduct(ItemProduct itemProduct) {
    print('clicked: remove');
    if (itemProduct.chosenQuantity == 1) {
      Provider.of<HomeNotifier>(context, listen: false)
          .callApiRemoveCartItem(itemProduct);
    } else if (itemProduct.chosenQuantity != 0) {
      Provider.of<HomeNotifier>(context, listen: false)
          .callApiChangeCartItemQuantity(
              itemProduct, itemProduct.chosenQuantity - 1);
    } else {
      Provider.of<HomeNotifier>(context, listen: false)
          .showSnackBarMessageWithContext('Cant reduce futher');
      widget.log.i('min quantity reached');
    }
  }

  void _onClickIconHeart(ItemProduct itemProduct) async {
    HomeNotifier homeNotifier =
        Provider.of<HomeNotifier>(context, listen: false);
    itemProduct.isFavourite = (!itemProduct.isFavourite);
    if (itemProduct.isFavourite) {
      print('1');
      homeNotifier.callApiAddToWishList(itemProduct);
    } else {
      await homeNotifier.callApiGetWishList();
      if (homeNotifier.wishListResponse != null &&
          homeNotifier.wishListResponse.wishList != null) {
        for (int i = 0;
            i < homeNotifier.wishListResponse.wishList.length;
            i++) {
          if (itemProduct.id ==
              int.parse(homeNotifier.wishListResponse.wishList[i].productId)) {
            homeNotifier.callApiRemoveFromWishList(
                itemProduct,
                homeNotifier.wishListResponse.wishList[i].wishlistItemId
                    .toString());
          }
        }
      }
    }
  }

  void updateCategory(HomeNotifier homeNotifier) async {
    // homeNotifier.categoryShowOffData = null;
    // listHomeWidgets.clear();
    //homeNotifier.categoryShowOffData.listItemProduct.clear();
    /*
    viewSetup(homeNotifier);*/
    await CommonNotifier().callApiGetCartList();
    await CommonNotifier().callApiGetWishList();
    await homeNotifier.apiGetPopularProducts();
    //homeNotifier.apiGetCustomCategoryList();
    //homeNotifier.apiGetTopDistributorsList();
  }

  Widget _buildScreenContent(HomeNotifier homeNotifier, lstProducts) {
    return _buildSliverGridProducts(homeNotifier, lstProducts);
  }

  Widget _buildSliverGridProducts(
      HomeNotifier homeNotifier, List<ItemProduct> lstProducts) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
        child: Container(
          width: double.infinity,
          color: Colors.black12,
          height: 900,
          child: (lstProducts != null && lstProducts.length > 0)
              ? ListView.builder(
                  key: homeNotifier.randomKey,
                  padding: EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                  itemCount: lstProducts.length,
                  itemBuilder: (_, index) {
                    return buildListItemProduct(
                        index: index,
                        productItem: lstProducts[index],
                        homeNotifier: homeNotifier,
                        context: context);
                  },
                  shrinkWrap: true,
                )
              : Center(
                  child: Text('No data found'),
                ),
        ),
      ),
    );
  }

  Widget buildListItemProduct(
      {int index,
      ItemProduct productItem,
      HomeNotifier homeNotifier,
      BuildContext context}) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          child: Container(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 16.0,
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      child: CachedNetworkImage(
                          imageUrl: productItem.imageUrl != null &&
                                  productItem.imageUrl.isNotEmpty
                              ? productItem.imageUrl
                              : "",
                          imageBuilder: (context, imageProvider) => SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colorYoutubeGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            alignment: Alignment.center,
                                            image: imageProvider,
                                            fit: BoxFit.scaleDown),
                                        //borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                                        border: Border.all(
//                                          color: Colors.transparent,
//                                          width: 1.0,
//                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          placeholder: (context, url) =>
                              _buildSearchImagePlaceHolder(context),
                          errorWidget: (context, url, error) =>
                              _buildSearchImagePlaceHolder(context)),
                    )),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 1,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          productItem.name != null &&
                                  productItem.name.isNotEmpty
                              ? productItem.name
                              : "",
                          style: getStyleSubHeading(context).copyWith(
                              height: 1.5,
                              fontWeight: AppFont.fontWeightSemiBold),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        productItem.sku != null && productItem.sku.isNotEmpty
                            ? productItem.sku
                            : "",
                        style: getStyleCaption(context).copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => _onTapProductDetail(productItem, context),
      ),
    );
  }

  void _onTapProductDetail(ItemProduct value, BuildContext context) {
    print('clicked: product Detail');

    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: value);
    // (or) another way
    /*Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(), settings: RouteSettings(arguments: value)),
    );*/
  }

  void _onClickCategoryItem(ChildrenData subCategoryList, int parentCategoryId,
      String parentCategoryName, BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: InkWell(
              onTap: () {
                _onClickViewAllProducts(
                    ctx,
                    InfoHomeTap(
                        id: parentCategoryId, toolBarName: parentCategoryName));
              },
              child: Text(
                parentCategoryName,
                style: getAppBarTitleTextStyle(context)
                    .copyWith(color: colorOrange),
              ),
            ),
            content: setupAlertDialogContainer(
                subCategoryList, parentCategoryId, parentCategoryName),
          );
        });
  }

  Widget setupAlertDialogContainer(ChildrenData subCategoryList,
      int parentCategoryId, String parentCategoryName) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subCategoryList.childrenData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: InkWell(
            onTap: () {
              _onClickViewAllProducts(
                  ctx,
                  InfoHomeTap(
                      id: subCategoryList.childrenData[index].id,
                      toolBarName: subCategoryList.childrenData[index].name));
            },
            child: Text(
              subCategoryList.childrenData[index].name,
              style: getStyleButtonText(context).copyWith(color: colorBlack),
            ),
          ));
        },
      ),
    );
  }

  void _onTapAddProduct(ItemProduct itemProduct, HomeNotifier homeNotifier) {
    print('clicked: add');
    print("itemproc --------------> $itemProduct");

    if (itemProduct.isCustomProduct) {
      Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: itemProduct);
      return;
    }

    bool isAvailable = false;
    Provider.of<CommonNotifier>(context, listen: false)
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
          homeNotifier.callApiChangeCartItemQuantity(
              itemProduct, itemProduct.chosenQuantity + 1);
        } else {
          print('coming else -------> $itemProduct');
          homeNotifier.callApiFirstTimeAddToCart(itemProduct);
        }
      } else {
        print('isAvailable -------> null');
        homeNotifier.callApiFirstTimeAddToCart(itemProduct);
      }
      if (itemProduct.isCustomProduct == false) {
      } else {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: itemProduct);
      }
    } else {
      print('max quantity reached');
    }
  }

  void _onTapRemoveProduct(ItemProduct itemProduct, HomeNotifier homeNotifier) {
    print('clicked: remove');
    if (itemProduct.chosenQuantity == 1) {
      homeNotifier.callApiRemoveCartItem(itemProduct);
    } else if (itemProduct.chosenQuantity != 0) {
      homeNotifier.callApiChangeCartItemQuantity(
          itemProduct, itemProduct.chosenQuantity - 1);
    } else {
      homeNotifier.showSnackBarMessageWithContext('Cant reduce futher');
      print('min quantity reached, cant reduce futher');
    }
  }

  void _onTapIconHeart(
      ItemProduct itemProduct, HomeNotifier homeNotifier) async {
    itemProduct.isFavourite = (!itemProduct.isFavourite);
    if (itemProduct.isFavourite) {
      print('1 ------------> product list screen ');
      homeNotifier.callApiAddToWishList(itemProduct);
    } else {
      print('2 ------------> product list screen ');
      await homeNotifier.callApiGetWishList();
      if (homeNotifier.wishListResponse != null &&
          homeNotifier.wishListResponse.wishList != null) {
        for (int i = 0;
            i < homeNotifier.wishListResponse.wishList.length;
            i++) {
          if (itemProduct.id ==
              int.parse(homeNotifier.wishListResponse.wishList[i].productId)) {
            homeNotifier.callApiRemoveFromWishList(
                itemProduct,
                homeNotifier.wishListResponse.wishList[i].wishlistItemId
                    .toString());
          }
        }
      }
    }
  }

  void _localApiHits(HomeNotifier homeNotifier) async {
    await homeNotifier.apiGetPopularProducts();
    homeNotifier.apiGetCustomCategoryList();
  }

  void _navigateToProductDetail(
      ItemProduct itemProduct, HomeNotifier homeNotifier) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: itemProduct)
        .whenComplete(() {
      //  homeNotifier.refreshProductList(infoHomeTap);
    });
  }

  Future<void> _refreshHomeScreen() async {
    print("calling state");
    bool isNetworkAvail = await NetworkCheck().check();
    Future.delayed(Duration.zero, () {
      HomeNotifier homeNotifier =
          Provider.of<HomeNotifier>(context, listen: false);
      homeNotifier.context = context;
      homeNotifier.stateDrawer = stateDrawer;
      if (isNetworkAvail) {
        listCategoryBasedWidgets.clear();
        _localApiHits(homeNotifier);
      } else {
        Provider.of<HomeNotifier>(context, listen: false)
            .showSnackBarMessageWithContext(
                AppConstants.ERROR_INTERNET_CONNECTION);
      }
    });
  }

  void _categoryfun(CategoryModel itemCategory) {
    if (CommonNotifier().subCategoryListResponse != null &&
        CommonNotifier().subCategoryListResponse.childrenData != null &&
        CommonNotifier().subCategoryListResponse.childrenData.length > 0) {
      for (int i = 0;
          i < CommonNotifier().subCategoryListResponse.childrenData.length;
          i++) {
        if (CommonNotifier().subCategoryListResponse.childrenData[i].id ==
            itemCategory.id) {
          if (CommonNotifier()
                      .subCategoryListResponse
                      .childrenData[i]
                      .childrenData !=
                  null &&
              CommonNotifier()
                      .subCategoryListResponse
                      .childrenData[i]
                      .childrenData
                      .length >
                  0) {
            _onClickCategoryItem(
                CommonNotifier().subCategoryListResponse.childrenData[i],
                itemCategory.id,
                itemCategory.name,
                ctx);
          } else {
            _onClickViewAllProducts(
                ctx,
                InfoHomeTap(
                    id: itemCategory.id, toolBarName: itemCategory.name));
          }
          break;
        }
      }
    } else {
      _onClickViewAllProducts(ctx,
          InfoHomeTap(id: itemCategory.id, toolBarName: itemCategory.name));
    }
  }
}
