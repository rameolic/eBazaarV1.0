import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_to_cart_custom/add_to_cart_custom_request.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_reviews_list.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/product_detail_notifier.dart';
import 'package:thought_factory/ui/menu/my_cart/my_cart_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_star_rating.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/custom_dots_indicator.dart';
import 'package:thought_factory/utils/widgetHelper/widget_product_item.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product_detail_screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var log = getLogger('product_detail_screen');
  TextStyle subTitle = TextStyle();
  double reviewerImageHeight = 60.0;
  int maxLimit = 20;
  PageController pageController;

  TextEditingController searchProductsEditText = TextEditingController();
  bool btnCancelVisible = false;
  ProductDetailNotifier productDetailNotifier;
  List<ItemProduct> searchResultList = List();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  searchController() async {
    print("Second text field: ${searchProductsEditText.text}");
    if (searchProductsEditText.text.length > 0) {
      setState(() {
        btnCancelVisible = true;
      });

      if (searchProductsEditText.text.length > 2) {
        productDetailNotifier
            .apiGetProductBySearchName(searchProductsEditText.text.trim());

        setState(() {});
      }
    } else {
      setState(() {
        btnCancelVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    subTitle = getStyleSubHeading(context)
        .copyWith(color: colorBlack, fontWeight: AppFont.fontWeightSemiBold);
    final ItemProduct itemProduct = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<ProductDetailNotifier>(
        create: (context) =>
            ProductDetailNotifier(context, itemProduct.sku, itemProduct.id),
        child: Consumer<ProductDetailNotifier>(
          builder: (BuildContext context, productDetailNotifier, _) => Scaffold(
            key: productDetailNotifier.scaffoldKey,
            backgroundColor: colorGrey,
            appBar: buildAppbar(),
            body: ModalProgressHUD(
                inAsyncCall: productDetailNotifier.isLoading,
                child: _buildProductDetailScreen(
                    context, productDetailNotifier, itemProduct)),
          ),
        ));
  }

  Widget buildAppbar() {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppConstants.PRODUCT_DETAILS),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(MyCartScreen.routeName, arguments: true);
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
                        style: getStyleOverLine(context),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]);
  }

  Container _buildProductDetailScreen(BuildContext context,
      ProductDetailNotifier productDetailNotifier, ItemProduct itemProduct) {
    this.productDetailNotifier = productDetailNotifier;
    searchProductsEditText.addListener(searchController);

    return Container(
      child: Column(
        children: <Widget>[
          _buildSearchBar(context, productDetailNotifier),
          Flexible(
            fit: FlexFit.tight,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildProductDetailContentArea(
                          productDetailNotifier, itemProduct),
                      (productDetailNotifier.lstRelatedProduct != null &&
                              productDetailNotifier.lstRelatedProduct.length >
                                  0)
                          ? _buildRelatedProductsContentArea(
                              productDetailNotifier, context)
                          : Container()
                    ],
                  ),
                ),
                Visibility(
                    visible: btnCancelVisible,
                    // productDetailNotifier.btnCancelVisible,
                    child: Container(
                      child: _buildScreenContent(context, productDetailNotifier,
                          productDetailNotifier.lstProducts),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildProductDetailContentArea(
      ProductDetailNotifier productDetailNotifier, ItemProduct itemProduct) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: PageView.builder(
                                controller: pageController,
                                physics: BouncingScrollPhysics(),
                                itemCount: productDetailNotifier
                                            .responseProductDetail
                                            .lstProductUrl ==
                                        null
                                    ? 0
                                    : productDetailNotifier
                                        .responseProductDetail
                                        .lstProductUrl
                                        .length,
                                itemBuilder: (context, index) {
                                  productDetailNotifier.currentSliderIndex =
                                      index ?? 0;
                                  return Container(
                                    child: Image.network(
                                      productDetailNotifier
                                          .responseProductDetail
                                          .lstProductUrl[index]
                                          .url,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Positioned.fill(
                            right: 8.0,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                child: FloatingActionButton(
                                  elevation: 2.0,
                                  onPressed: () => _onClickedIconHeart(
                                      productDetailNotifier, itemProduct),
                                  mini: true,
                                  backgroundColor: colorWhite,
                                  child: itemProduct.isFavourite
                                      ? _buildIconHeart(colorPrimary)
                                      : _buildIconHeart(colorDarkGrey),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child:
                        productDetailNotifier.responseProductDetail != null &&
                                productDetailNotifier
                                        .responseProductDetail.lstProductUrl !=
                                    null &&
                                productDetailNotifier.responseProductDetail
                                        .lstProductUrl.length >
                                    0
                            ? CustomDotsIndicator(
                                color: colorPrimary,
                                controller: pageController,
                                itemCount: productDetailNotifier
                                    .responseProductDetail.lstProductUrl.length,
                                onPageSelected: (int page) {
                                  pageController.animateToPage(
                                    page,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                indexValue: pageController.initialPage,
                              )
                            : Container(),
                  ),
                ],
              ),
            ),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                side: BorderSide(
                  color: colorWhite,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    fit: FlexFit.tight,
                    child: AutoSizeText(
                      productDetailNotifier.responseProductDetail.productName ??
                          '',
                      style: getStyleSubHeading(context).copyWith(
                          color: colorBlack,
                          fontWeight: AppFont.fontWeightSemiBold),
                      maxLines: 2,
                    )),
                productDetailNotifier.responseProductDetail.avgRatingPercent !=
                        null
                    ? Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8.0, top: 4.0, bottom: 4.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: colorWhite,
                              size: 14.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              productDetailNotifier
                                  .responseProductDetail.avgRatingPercent
                                  .toString(),
                              style: getStyleCaption(context).copyWith(
                                  color: colorWhite,
                                  fontWeight: AppFont.fontWeightSemiBold),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: colorYellow,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
            child: Row(
              children: <Widget>[
                productDetailNotifier.responseProductDetail.productSalePrice !=
                            null &&
                        productDetailNotifier.optionValue == null
                    ? Text(
                        productDetailNotifier.currencyCode +
                                " " +
                                productDetailNotifier
                                    .responseProductDetail.productSalePrice
                                    .toStringAsFixed(2) ??
                            '',
                        style: getStyleBody2(context).copyWith(
                          color: colorPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : productDetailNotifier.optionValue != null
                        ? Text(
                            productDetailNotifier.currencyCode +
                                " " +
                                (productDetailNotifier.responseProductDetail
                                            .productSalePrice +
                                        double.parse(
                                            productDetailNotifier.optionValue))
                                    .toStringAsFixed(2),
                            style: getStyleBody2(context).copyWith(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: productDetailNotifier
                                  .responseProductDetail.productMarkedPrice !=
                              null &&
                          productDetailNotifier
                                  .responseProductDetail.productMarkedPrice >
                              0
                      ? Text(
                          productDetailNotifier
                              .responseProductDetail.productMarkedPrice
                              .toStringAsFixed(2),
                          style: getStyleBody1(context)
                              .copyWith(decoration: TextDecoration.lineThrough),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: productDetailNotifier
                                  .responseProductDetail.productMarkedPrice !=
                              null &&
                          productDetailNotifier
                                  .responseProductDetail.productMarkedPrice >
                              0
                      ? Text(
                          productDetailNotifier
                                  .responseProductDetail.discountPercent
                                  .toStringAsFixed(0) +
                              '% off',
                          style: getStyleBody1(context).copyWith(
                              color: colorFlashGreen,
                              fontWeight: AppFont.fontWeightMedium),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          _buildSubTitle('Quantity'),
          Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
              child: _buildAddRemoveProductQuantity(
                  context, maxLimit, productDetailNotifier, itemProduct)),
          (productDetailNotifier.responseProductDetail != null &&
                  productDetailNotifier
                          .responseProductDetail.isOptionsAvailable !=
                      null &&
                  productDetailNotifier
                      .responseProductDetail.isOptionsAvailable)
              ? _buildSubTitle('Size')
              : Container(),
          (productDetailNotifier.responseProductDetail != null &&
                  productDetailNotifier
                          .responseProductDetail.isOptionsAvailable !=
                      null &&
                  productDetailNotifier
                      .responseProductDetail.isOptionsAvailable)
              ? SizedBox(
                  height: 50,
                  child: ListView.builder(
                    key: Key(productDetailNotifier.keyListViewRandom),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: productDetailNotifier.responseProductDetail
                                .isOptionsValuesAvailable !=
                            null
                        ? productDetailNotifier
                            .responseProductDetail.optionsValues.length
                        : 0,
                    itemBuilder: (context, i) {
                      return InkWell(
                          onTap: () {
                            for (int j = 0;
                                j <
                                    productDetailNotifier.responseProductDetail
                                        .lstOptionsSelected.length;
                                j++) {
                              productDetailNotifier.responseProductDetail
                                  .lstOptionsSelected[j] = false;
                            }
                            productDetailNotifier.responseProductDetail
                                .lstOptionsSelected[i] = true;

                            productDetailNotifier.keyListViewRandom =
                                randomString();
                            print(
                                "kdkkdk ${productDetailNotifier.responseProductDetail.optionsValues[i].optionTypeId}");
                            productDetailNotifier.optionTypeId =
                                productDetailNotifier.responseProductDetail
                                    .optionsValues[i].optionTypeId;

                            productDetailNotifier.optionValue =
                                productDetailNotifier.responseProductDetail
                                    .optionsValues[i].price
                                    .toStringAsFixed(2);
                            productDetailNotifier
                                .responseProductDetail.lstOptionsSelected
                                .forEach((value) {
                              log.d(value.toString());
                            });
                          },
                          child: _buildSizeTypesTile(
                              context,
                              productDetailNotifier
                                  .responseProductDetail.lstOptionsSelected[i],
                              productDetailNotifier
                                  .responseProductDetail.optionsValues[i].title,
                              productDetailNotifier,
                              i));
                    },
                  ),
                )
              : Container(),
          Container(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.whatshot,
                color: colorPrimary,
                size: 15.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Shop Secure  |  Free return',
                style: getStyleCaption(context).copyWith(color: colorBlack),
              )
            ],
          ),
          productDetailNotifier.responseProductDetail.description != null &&
                  productDetailNotifier
                          .responseProductDetail.description.length >
                      0
              ? _buildSubTitle('Description')
              : Container(),
          productDetailNotifier.responseProductDetail.description != null &&
                  productDetailNotifier
                          .responseProductDetail.description.length >
                      0
              ? _buildDescriptionLine(false,
                  productDetailNotifier.responseProductDetail.description)
              : Container(),
          // Button : Add to Cart
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            width: double.infinity,
            child: RaisedButton(
              color: colorAccent,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                AppConstants.ADD_TO_CART,
                style: getStyleButtonText(context),
              ),
              onPressed: () async {
                _onAddToCart(productDetailNotifier, itemProduct);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
          // Button : Compare, Share
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
//              Flexible(
//                  fit: FlexFit.tight,
//                  flex: 1,
//                  child: InkWell(
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: Row(
//                        mainAxisSize: MainAxisSize.min,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Icon(
//                            Icons.compare_arrows,
//                            color: colorBlack,
//                            size: 20.0,
//                          ),
//                          SizedBox(
//                            width: 8.0,
//                          ),
//                          Text(
//                            'Compare',
//                            style: getFormStyleText(context)
//                                .copyWith(color: colorBlack),
//                          )
//                        ],
//                      ),
//                    ),
//                  )),
//
              productDetailNotifier.responseProductDetail.isUrlFound
                  ? Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _onClickButtonShare(productDetailNotifier);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: colorBlack,
                                size: 20.0,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Share',
                                style: getFormStyleText(context)
                                    .copyWith(color: colorBlack),
                              )
                            ],
                          ),
                        ),
                      ))
                  : Container()
            ],
          ),
          productDetailNotifier.responseProductDetail.reviewsList != null &&
                  productDetailNotifier
                          .responseProductDetail.reviewsList.length >
                      0
              ? _buildReviewArea(productDetailNotifier)
              : Container(),
          _buildRateThisProductArea(productDetailNotifier),
        ],
      ),
    );
  }

  Widget _buildDescriptionLine(bool canShowDot, String content) {
    return Row(
      children: <Widget>[
        Visibility(
          visible: false,
          child: Flexible(
            fit: FlexFit.loose,
            child: Text(
              "\u25CF",
              style: TextStyle(color: colorDarkGrey, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Html(
            data: content,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewArea(ProductDetailNotifier productDetailNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSubTitle('Reviews'),
        //_buildReviewCommentTile(context, 0, 2)
        _buildReviewList(productDetailNotifier)
      ],
    );
  }

  Widget _buildReviewList(ProductDetailNotifier productDetailNotifier) {
    int length = productDetailNotifier.responseProductDetail.reviewsList.length;
    return ListView.separated(
      itemCount: length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return _buildReviewCommentTile(index, length,
            productDetailNotifier.responseProductDetail.reviewsList[index]);
      },
      separatorBuilder: (context, index) => Container(
          margin: EdgeInsets.only(top: 16.0),
          child: Divider(
            height: 1.0,
            color: colorDarkGrey,
          )),
    );
  }

  Widget _buildReviewCommentTile(int index, int totalLength, Reviews review) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CachedNetworkImage(
                  imageUrl: "",
                  imageBuilder: (context, imageProvider) => Container(
                        width: reviewerImageHeight,
                        height: reviewerImageHeight,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              alignment: Alignment.center,
                              image: imageProvider,
                              fit: BoxFit.cover),
                          //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            color: colorDividerGrey,
                            width: 1.0,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => _buildPlaceHolder(),
                  errorWidget: (context, url, error) => _buildPlaceHolder()),
              SizedBox(
                width: 16.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Text(
                    review.nickname ?? '',
                    style: getStyleSubHeading(context).copyWith(
                        height: 1.5, fontWeight: AppFont.fontWeightSemiBold),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
                  AppStarRating(
                    starCount: 5,
                    size: 16,
                    color: colorYellow,
                    rating: (review.ratingVotes != null &&
                            review.ratingVotes.length > 0)
                        ? double.parse(review.ratingVotes[0].value)
                        : 0,
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          review.detail ?? "",
          style: getStyleCaption(context).copyWith(color: colorBlack),
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget _buildRateThisProductArea(
      ProductDetailNotifier productDetailNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //productDetailNotifier.listRatingsResponse != null &&
        productDetailNotifier.responseProductDetail != null &&
                productDetailNotifier.responseProductDetail.listRatingList !=
                    null &&
                productDetailNotifier
                        .responseProductDetail.listRatingList.length >
                    0
            ? _buildSubTitle('Rate this Product')
            : Container(),
        productDetailNotifier.listRatingsResponse != null &&
                productDetailNotifier.listRatingsResponse.length > 0
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          height: 16.0,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: productDetailNotifier
                              .responseProductDetail.listRatingList.length,
                          itemBuilder: (context, i) {
                            return _buildTextLabel(productDetailNotifier
                                .responseProductDetail
                                .listRatingList[i]
                                .ratingCode);
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          //Icon(Icons.brightness_1, color: Colors.orange, size: 14.0,),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: productDetailNotifier
                                .addReviewToProductRequest.ratingData.length,
                            itemBuilder: (context, i) {
                              return Container(
                                alignment: Alignment.centerRight,
                                child: AppStarRating(
                                  starCount: 5,
                                  size: 24,
                                  color: colorYellow,
                                  rating: double.parse(productDetailNotifier
                                      .addReviewToProductRequest
                                      .ratingData[i]
                                      .ratingValue),
                                  onRatingChanged: ((value) {
                                    setState(() {
                                      productDetailNotifier
                                          .addReviewToProductRequest
                                          .ratingData[i]
                                          .ratingValue = value.toString();
                                    });
                                  }),
                                  spacing: 5,
                                  allowHalfRating: true,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          maxLines: 1,
          style: getStyleBody1(context).copyWith(
              color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
          textAlign: TextAlign.center,
          controller: productDetailNotifier.reviewCommentTextController,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorDarkGrey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary)),
              hintText: 'Description',
              hintStyle:
                  getStyleSubHeading(context).copyWith(color: colorDarkGrey)),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 32.0, bottom: 16.0),
            child: RaisedButton(
              color: colorAccent,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 64.0, right: 64.0),
              child: Text(
                AppConstants.SUBMIT,
                style: getStyleButtonText(context),
              ),
              onPressed: () async {
                _onClickButtonSubmitRating(productDetailNotifier);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildRelatedProductsContentArea(
      ProductDetailNotifier productDetailNotifier, BuildContext context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Related Products',
            style: subTitle,
          ),
          SizedBox(
            height: 12.0,
          ),
          GridView.builder(
              itemCount: productDetailNotifier.lstRelatedProduct.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 4.8),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
                  child: WidgetProductItem(
                    itemProduct: productDetailNotifier.lstRelatedProduct[index],
                    onPressedProduct: (value) => Navigator.pushNamed(
                        context, ProductDetailScreen.routeName),
                    onPressedAdd: () => _onClickAddProduct(
                        productDetailNotifier.lstRelatedProduct[index]),
                    onPressedRemove: (value) => _onClickRemoveProduct(value),
                    onPressedIconHeart: (value) => _onClickedIconHeart(
                        productDetailNotifier,
                        productDetailNotifier.lstRelatedProduct[index]),
                  ),
                );
              })
        ],
      ),
    );
  }

  Container _buildSubTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Text(
        title,
        style: subTitle,
      ),
    );
  }

  Widget _buildTextLabel(String content) {
    return Text(
      content,
      style: getStyleSubHeading(context),
    );
  }

  Container _buildPlaceHolder() {
    return Container(
      width: reviewerImageHeight,
      height: reviewerImageHeight,
      child: Center(
        child: Icon(
          AppCustomIcon.icon_user,
          color: colorDarkGrey,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //image: DecorationImage(alignment: Alignment.center, image: , fit: BoxFit.scaleDown),
        //borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: colorLightGrey,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildSizeTypesTile(BuildContext context, bool isClicked, String sign,
      ProductDetailNotifier productDetailNotifier, int i) {
    log.d(isClicked.toString());
    return Card(
      child: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0, bottom: 8.0),
        child: Text(
          sign,
          style: getStyleBody1(context).copyWith(
              color: isClicked ? colorWhite : colorPrimary,
              fontWeight: productDetailNotifier
                      .responseProductDetail.lstOptionsSelected[i]
                  ? AppFont.fontWeightBold
                  : AppFont.fontWeightSemiBold),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: productDetailNotifier
                    .responseProductDetail.lstOptionsSelected[i]
                ? colorPrimary
                : colorWhite),
      ),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          side: BorderSide(
              color: productDetailNotifier
                      .responseProductDetail.lstOptionsSelected[i]
                  ? colorPrimary
                  : colorWhite)),
    );
  }

  Widget _buildAddRemoveProductQuantity(BuildContext context, int maxLimit,
      ProductDetailNotifier productDetailNotifier, ItemProduct itemProduct) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 35,
              height: 35,
              child: GestureDetector(
                onTap: () {
                  //itemProduct.chosenQuantity=3;
                  setState(() {
                    productDetailNotifier.qty != 0
                        ? productDetailNotifier.qty -= 1
                        : productDetailNotifier.qty = 0;
                    log.d("Qty value :" + productDetailNotifier.qty.toString());
                  });
                }
//                  log.d(stateProductDetail.productQuantityList.toString());
//                  log.d(stateProductDetail.productQuantityList[
//                  stateProductDetail.sizeFieldIndexCurrentPosition]
//                      .toString());
//                  if (stateProductDetail.productQuantityList[
//                  stateProductDetail.sizeFieldIndexCurrentPosition] >
//                      0) {
//                    stateProductDetail.productQuantityList[stateProductDetail
//                        .sizeFieldIndexCurrentPosition] = stateProductDetail
//                        .productQuantityList[
//                    stateProductDetail.sizeFieldIndexCurrentPosition] -
//                        1;
//                  }
//                }
                //stateProductDetail.productQuantity[stateProductDetail.sizeFieldIndexCurrentValue] > 0 ?
                //stateProductDetail.productQuantity[stateProductDetail.sizeFieldIndexCurrentValue] = stateProductDetail.productQuantity[stateProductDetail.sizeFieldIndexCurrentValue] - 1 : stateProductDetail.productQuantity[stateProductDetail.sizeFieldIndexCurrentValue] = 0
                ,
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 1.0,
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: colorPrimary,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      side: BorderSide(color: colorWhite)),
                ),
              )),
          Container(
            height: 35,
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: AbsorbPointer(
              //to avoid touch on the button with not like disable effect
              absorbing: true,
              child: RaisedButton(
                color: colorWhite,
                textColor: colorPrimary,
                elevation: 1.0,
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: AutoSizeText(
                  productDetailNotifier.qty.toString() ?? "0",
//                  stateProductDetail.productQuantityList[
//                  stateProductDetail.sizeFieldIndexCurrentPosition]
//                      .toString(),
                  style: getProductQtyTextStyle(context),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
          ),
          Container(
              width: 35,
              height: 35,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    productDetailNotifier.qty < maxLimit
                        ? productDetailNotifier.qty =
                            productDetailNotifier.qty + 1
                        : productDetailNotifier.qty = maxLimit;
                    log.d("Qty value :" + productDetailNotifier.qty.toString());
                  });

//                  log.d(stateProductDetail.productQuantityList.toString());
//                  log.d(stateProductDetail.productQuantityList[
//                  stateProductDetail.sizeFieldIndexCurrentPosition]
//                      .toString());
//                  if (stateProductDetail.productQuantityList[
//                  stateProductDetail.sizeFieldIndexCurrentPosition] <
//                      maxLimit) {
//                    stateProductDetail.productQuantityList[stateProductDetail
//                        .sizeFieldIndexCurrentPosition] = stateProductDetail
//                        .productQuantityList[
//                    stateProductDetail.sizeFieldIndexCurrentPosition] +
//                        1;
//                  }
                },
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 1.0,
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: colorPrimary,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      side: BorderSide(color: colorWhite)),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
      BuildContext context, ProductDetailNotifier productDetailNotifier) {
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
          //padding: EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
          child: TextFormField(
            controller: searchProductsEditText,
            // productDetailNotifier.searchProductsEditText,
            style: getAppSearchTextStyle(context),
            decoration: InputDecoration(
              hintText: "Search products",
              alignLabelWithHint: true,
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {},
                color: colorBlack,
                icon: Icon(Icons.search),
              ),
              prefixIcon: Visibility(
                visible: btnCancelVisible,
                //productDetailNotifier.btnCancelVisible,
                child: IconButton(
                  onPressed: () {
                    log.i('Clicked : Button clear ');
                    searchProductsEditText.text = "";
                    productDetailNotifier.lstProducts.clear();
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

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget _buildIconHeart(Color colorHeart) {
    return Icon(
      Icons.favorite,
      size: 18,
      color: colorHeart,
    );
  }

  Widget _buildScreenContent(BuildContext context,
      ProductDetailNotifier productDetailNotifier, lstProducts) {
    return _buildSliverGridProducts(
        context, productDetailNotifier, lstProducts);
  }

  Widget _buildSliverGridProducts(
      BuildContext context,
      ProductDetailNotifier productDetailNotifier,
      List<ItemProduct> lstProducts) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
        child: Container(
          width: double.infinity,
          color: Colors.black12,
          height: 900,
          child: (lstProducts != null && lstProducts.length > 0)
              ? ListView.builder(
                  padding: EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                  itemCount: lstProducts.length,
                  itemBuilder: (_, index) {
                    return buildListItemProduct(
                        index: index,
                        productItem: lstProducts[index],
                        productDetailNotifier: productDetailNotifier,
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
      ProductDetailNotifier productDetailNotifier,
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
              mainAxisSize: MainAxisSize.min,
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
                                    padding: const EdgeInsets.all(8.0),
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        productItem.name != null && productItem.name.isNotEmpty
                            ? productItem.name
                            : "",
                        style: getStyleSubHeading(context).copyWith(
                            height: 1.5,
                            fontWeight: AppFont.fontWeightSemiBold),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
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
        onTap: () =>
            _onTapProductDetail(productItem, context, productDetailNotifier),
      ),
    );
  }

  Container _buildSearchImagePlaceHolder(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      child: Center(child: Image.asset(AppImages.IMAGE_LOGO_THOUGHT_FACTORY)),
    );
  }

  void _onTapProductDetail(ItemProduct itemProduct, BuildContext context,
      ProductDetailNotifier productDetailNotifier) {
    print('clicked: product Detail');
    searchProductsEditText.text =
        ""; //productDetailNotifier.searchProductsEditText.text = "";
    productDetailNotifier.lstProducts.clear();
    FocusScope.of(context).requestFocus(new FocusNode());
    productDetailNotifier.initialApisToCall(
        itemProduct.id.toString(), itemProduct.sku);
    // (or) another way
    /*Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(), settings: RouteSettings(arguments: value)),
    );*/
  }

  _onClickAddProduct(lstProduct) {}

  _onClickRemoveProduct(value) {}

  _onClickedIconHeart(
      ProductDetailNotifier productDetailNotifier, itemProduct) async {
    //  ProductDetailNotifier productDetailNotifier = Provider.of<ProductDetailNotifier>(context);
    itemProduct.isFavourite = (!itemProduct.isFavourite);
    if (itemProduct.isFavourite) {
      print('1');
      productDetailNotifier.callApiAddToWishList(itemProduct);
    } else {
      await productDetailNotifier.callApiGetWishList();
      if (productDetailNotifier.wishListResponse != null &&
          productDetailNotifier.wishListResponse.wishList != null) {
        for (int i = 0;
            i < productDetailNotifier.wishListResponse.wishList.length;
            i++) {
          if (itemProduct.id ==
              int.parse(productDetailNotifier
                  .wishListResponse.wishList[i].productId)) {
            productDetailNotifier.callApiRemoveFromWishList(
                itemProduct,
                productDetailNotifier
                    .wishListResponse.wishList[i].wishlistItemId
                    .toString());
          }
        }
      }
    }
  }

  _onClickButtonSubmitRating(ProductDetailNotifier productDetailNotifier) {
    productDetailNotifier.addReviewToProductRequest.title =
        productDetailNotifier.reviewCommentTextController.text;
    productDetailNotifier.addReviewToProductRequest.detail =
        productDetailNotifier.reviewCommentTextController.text;
    // call Api
    productDetailNotifier
        .callApiAddReview(productDetailNotifier.addReviewToProductRequest);
  }

  _onClickButtonShare(ProductDetailNotifier productDetailNotifier) {
    log.d('onClickButtonShare');
    Share.share(AppUrl.baseUrl +
        "/" +
        productDetailNotifier.responseProductDetail.shareProductUrl +
        ".html");
  }

  String randomString() {
    var random = Random.secure();
    var value = random.nextInt(1000000000);
    return value.toString();
  }

  AddToCartCustomRequest buildRequest() {
    return AddToCartCustomRequest();
  }

  void _onAddToCart(ProductDetailNotifier productDetailNotifier,
      ItemProduct itemProduct) async {
    if (productDetailNotifier.qty > 0) {
      if (productDetailNotifier.responseProductDetail.isOptionsAvailable ??
          false) {
        if (productDetailNotifier.optionTypeId != -1) {
          CustomOptions customOptions = CustomOptions(
              optionId: productDetailNotifier.responseProductDetail.option_id,
              optionValue: productDetailNotifier.optionTypeId.toString());

          List<CustomOptions> customOptionsList = new List<CustomOptions>();
          customOptionsList.add(customOptions);
          ExtensionAttributes extensionAttributes =
              ExtensionAttributes(customOptions: customOptionsList);
          ProductOption productOption =
              ProductOption(extensionAttributes: extensionAttributes);
          AddToCartCustomRequest addToCartRequest = AddToCartCustomRequest(
              cartItem: CartItem(
                  sku: productDetailNotifier.responseProductDetail.sku,
                  qty: productDetailNotifier.qty,
                  quoteId: (CommonNotifier().quoteId),
                  productOption: productOption));
          // itemProduct.chosenQuantity=1;
          log.d(
              "Custom Option Submit : " + addToCartRequest.toJson().toString());
          var result = await productDetailNotifier.callApiAddToCartCustomData(
              (CommonNotifier().quoteId), addToCartRequest);
          if (result) {
            productDetailNotifier.qty = 0;
          }
        } else {
          productDetailNotifier.showMessage("Please select options");
//          productDetailNotifier
//              .showSnackBarMessageWithContext("Please select options");
        }
      } else {
        AddToCartCustomRequest addToCartRequest = AddToCartCustomRequest(
            cartItem: CartItem(
                sku: productDetailNotifier.responseProductDetail.sku,
                qty: productDetailNotifier.qty,
                quoteId: (CommonNotifier().quoteId),
                productOption: null));
        //  itemProduct.chosenQuantity=1;
        var result = await productDetailNotifier.callApiAddToCartCustomData(
            (CommonNotifier().quoteId), addToCartRequest);
        if (result) {
          productDetailNotifier.qty = 0;
        }
      }
    } else {
      productDetailNotifier.showMessage("Please select quantity");
//      productDetailNotifier
//          .showSnackBarMessageWithContext("Please select qantity");
    }
  }
}
