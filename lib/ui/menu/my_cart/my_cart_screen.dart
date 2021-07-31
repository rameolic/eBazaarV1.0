import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_cart_list.dart';
import 'package:thought_factory/core/model/cart_total_items.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/model/shipping_method_model.dart';
import 'package:thought_factory/core/notifier/cart_notifier.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/menu/my_cart/payment_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/custom_expansion_tile.dart';
import 'package:thought_factory/utils/widgetHelper/custom_empty__page.dart';
import 'package:thought_factory/utils/widgetHelper/custom_expendable_widget.dart';

class MyCartScreen extends StatefulWidget {
  static const routeName = '/MyCartScreen';

  @override
  MyCartScreenState createState() => MyCartScreenState();
}

class MyCartScreenState extends State<MyCartScreen> {
  var log = getLogger("MyCartScreen");
  final cornerRadius = 5.0;
  var spinnerErrorCorrection = 1.5;
  var _keyValidationForm = GlobalKey<FormState>();
  var _keyValidationCoupon = GlobalKey<FormState>();
  TextEditingController _textEditConRegion = TextEditingController();
  TextEditingController _textEditConZipCode = TextEditingController();
  final listCartAddOption = [
    AppConstants.CART_ADD_OPTION_1,
    AppConstants.CART_ADD_OPTION_2,
    AppConstants.CART_ADD_OPTION_3,
    AppConstants.CART_ADD_OPTION_MORE,
  ];
  CartNotifier cartNotifier;

  /// Parent Padding
  double parentPaddingLeftRight = 16;
  double parentPaddingTop = 24;
  double twoFiveRadius = 25.0;
  bool estimateIsExpanded = true;

  @override
  Widget build(BuildContext context) {
    bool showAppBar = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider<CartNotifier>(
      create: (context) => CartNotifier(context),
      child: Consumer<CartNotifier>(
        builder: (context, cartNotifier, _) => Scaffold(
          key: cartNotifier.scaffoldKey,
          appBar: (showAppBar != null)
              ? buildAppbar()
              : PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: Container(),
                ),
          body: ModalProgressHUD(
            inAsyncCall: cartNotifier.isLoading,
            child: SingleChildScrollView(
              child: (cartNotifier.lstCartResponse != null &&
                      cartNotifier.lstCartResponse.data != null &&
                      cartNotifier.lstCartResponse.data.length > 0)
                  ? _buildScreenContent(context, cartNotifier)
                  : cartNotifier.isLoading
                      ? Container()
                      : _buildEmptyScreenView(context, showAppBar),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppbar() {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppConstants.DRAWER_ITEM_MY_CART),
        actions: <Widget>[]);
  }

  Widget _buildScreenContent(BuildContext context, CartNotifier cartNotifier) {
    this.cartNotifier = cartNotifier;
    return Container(
      color: colorGrey,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: parentPaddingLeftRight,
                  right: parentPaddingLeftRight,
                  top: parentPaddingTop),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: cartNotifier.lstCartResponse.data.length,
                  itemBuilder: (context, i) {
                    return _buildExpandedDistributorProducts(
                        context,
                        cartNotifier.lstCartResponse.data[i].isExpand,
                        cartNotifier,
                        i); // buildListItemCartList(context, i, cartNotifier);
                  })),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              "Summary",
              style: getStyleSubHeading(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _buildEstimateShippingTaxExpandedTitle(context),
          CustomExpandableContainer(
              context: context,
              childWidget: cartNotifier.countryListResponse != null
                  ? _buildEstimateShippingExpandedBody(context, cartNotifier)
                  : Container(),
              duration: 500,
              expand: estimateIsExpanded),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: _buildDividerLine(true)),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildWidgetApplyCoupon(cartNotifier),
                buildApplyButton(cartNotifier),
                buildDeliveryDetailCard(cartNotifier),
                SizedBox(
                  height: 40,
                ),
                buildButtonProceed(cartNotifier, context),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Card _buildExpandedDistributorProducts(
      BuildContext context, bool isExpand, CartNotifier cartNotifier, int i) {
    return Card(
      color: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: CustomExpansionTile(
        trailing: cartNotifier.lstCartResponse.data[i].isExpand
            ? Icon(
                Icons.keyboard_arrow_down,
                color: colorPrimary,
              )
            : Icon(Icons.keyboard_arrow_right),
        iconColor: colorPrimary,
        headerBackgroundColor: cartNotifier.lstCartResponse.data[i].isExpand
            ? colorDropDownHeaderColor
            : Colors.white,
        initiallyExpanded: isExpand,
        backgroundColor: Colors.white,
        title: Row(children: <Widget>[
//          Text(
//            "Distributor - ",
//            style: getStyleSubHeading(context).copyWith(
//              color: cartNotifier.lstCartResponse.data[i].isExpand
//                  ? colorBlack
//                  : colorBlack,
//            ),
//          ),
          Text(cartNotifier.lstCartResponse.data[i].shopName,
              style: getStyleSubHeading(context).copyWith(
                  color: colorPrimary, fontWeight: AppFont.fontWeightBold))
        ]),
        children: <Widget>[
          (cartNotifier.lstCartResponse.data[i].productList != null &&
                  cartNotifier.lstCartResponse.data[i].productList.length > 0)
              ? Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: cartNotifier
                          .lstCartResponse.data[i].productList.length,
                      itemBuilder: (context, productIndex) =>
                          _buildListItemCart(
                              context, i, productIndex, cartNotifier)))
              : SizedBox(
                  height: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text("No Item"),
                    ),
                  ),
                ),
        ],
        onExpansionChanged: (value) {
          setState(() {
            cartNotifier.lstCartResponse.data[i].isExpand = value;
          });
        },
      ),
    );
  }

  Widget _buildListItemCart(BuildContext context, int distributorIndex,
      int productIndex, CartNotifier cartNotifier) {
    return Container(
      color: colorWhite,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: buildProductImage(AppUrl.baseImageUrl +
                        cartNotifier.lstCartResponse.data[distributorIndex]
                            .productList[productIndex].productImage ??
                    ""),
              ),
              Expanded(
                flex: 3,
                child: _buildProductItem(
                    context,
                    cartNotifier,
                    distributorIndex,
                    productIndex,
                    cartNotifier.lstCartResponse.data[distributorIndex]
                        .productList[productIndex]),
              )
            ],
          ),
          _buildDividerLine(productIndex <
              cartNotifier
                  .lstCartResponse.data[distributorIndex].productList.length)
          //? _buildLineDivider() : _buildDropDown()
        ],
      ),
    );
  }

  Widget _buildDividerLine(bool isBool) {
    if (isBool) {
      return Container(
        height: 0.3,
        width: double.maxFinite,
        color: colorDarkGrey,
      );
    } else {
      return SizedBox(
        height: 4.0,
      );
    }
  }

  Widget buildProductImage(String imageUrl) {
    log.d("image url : $imageUrl");
    return AspectRatio(
      aspectRatio: 1.0 / 1.2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cornerRadius),
                bottomLeft: Radius.circular(cornerRadius)),
            color: Colors.white,
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(imageUrl),
          ))),
    );
  }

  Widget _buildProductItem(BuildContext context, CartNotifier cartNotifier,
      int distributorIndex, int productIndex, ProductList productItem) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: AutoSizeText(
                _buildProductName(
                        productItem.productName, productItem.productOptions) ??
                    "",
                maxLines: 3,
                style: getStyleBody2(context)
                    .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                overflow: TextOverflow.ellipsis,
              )),
              Material(
                color: Colors.white,
                child: InkWell(
                  splashColor: colorPrimary,
                  onTap: () {
                    cartNotifier
                        .callApiRemoveCartItem(productItem.itemId.toString());
                  },
                  child: Icon(
                    Icons.close,
                    color: colorCloseIconImage,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                '${cartNotifier.currencyCode} ' +
                    cartNotifier.convertToDecimal(
                        (productItem.productSplPrice == "" ||
                                productItem.productSplPrice == null
                            ? productItem.productPrice
                            : productItem.productSplPrice),
                        2),
                style: getStyleBody2(context).copyWith(
                  color: colorPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  cartNotifier.convertToDecimal(
                      (productItem.productSplPrice == "" ||
                              productItem.productSplPrice == null
                          ? ""
                          : productItem.productPrice),
                      2),
                  style: getStyleBody1(context)
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "",
              style: getStyleCaption(context).copyWith(
                  color: colorFlashGreen, fontWeight: AppFont.fontWeightMedium),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                '',
                style: getStyleCaption(context).copyWith(
                    color: colorDarkGrey, fontWeight: AppFont.fontWeightMedium),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getStyleCaption(context).copyWith(
                      color: colorPrimary,
                      fontWeight: AppFont.fontWeightMedium),
                ),
              ),
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    height: 25,
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Stack(
                      children: <Widget>[
                        listCartAddOption.contains(cartNotifier
                                .lstCartResponse
                                .data[distributorIndex]
                                .productList[productIndex]
                                .productQty
                                .toString())
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(top: 3, left: 1),
                                child: _buildTextQty(cartNotifier
                                    .lstCartResponse
                                    .data[distributorIndex]
                                    .productList[productIndex]
                                    .productQty
                                    .toString()),
                              ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: listCartAddOption.contains(cartNotifier
                                      .lstCartResponse
                                      .data[distributorIndex]
                                      .productList[productIndex]
                                      .productQty
                                      .toString())
                                  ? cartNotifier
                                      .lstCartResponse
                                      .data[distributorIndex]
                                      .productList[productIndex]
                                      .productQty
                                      .toString()
                                  : null,
                              items: listCartAddOption.map((String quantity) {
                                return DropdownMenuItem(
                                    value: quantity,
                                    child: _buildTextQty(quantity));
                              }).toList(),
                              onChanged: (selectedValue) {
                                //start to add to cart process
                                addQuantityForCartItem(
                                    selectedValue,
                                    cartNotifier
                                        .lstCartResponse
                                        .data[distributorIndex]
                                        .productList[productIndex],
                                    cartNotifier);
                                /* setState(() {
                                cartNotifier.lstCartResponse.data[distributorIndex].productList[productIndex].productQty =
                                    int.parse(selectedValue);
                              });*/
                              }),
                        )
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextQty(quantity) {
    return RichText(
      text: TextSpan(
          text: 'Qty : ',
          style: getStyleCaption(context).copyWith(color: colorQtyHintColor),
          children: <TextSpan>[
            TextSpan(
                text: '$quantity',
                style: getStyleCaption(context).copyWith(
                    color: colorPrimary,
                    fontWeight: AppFont.fontWeightSemiBold))
          ]),
    );
  }

  Widget _buildCountrySpinner(BuildContext context, CartNotifier cartNotifier,
      bool isDropDown, bool changeTitleColor, String inputHint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 7,
        ),
        Container(
            margin: EdgeInsets.only(left: 16.0),
            child: Text(
              'Country',
              style: getStyleCaption(context).copyWith(
                  color:
                      changeTitleColor ? colorFlashDarkGreen : colorDarkGrey),
            )),
        SizedBox(
          height: 7,
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(twoFiveRadius))),
          child: cartNotifier.countryListResponse.listCountryInfo != null &&
                  cartNotifier.countryListResponse.listCountryInfo.length > 0
              ? DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: cartNotifier.selectedCountry,
                      items: cartNotifier.countryListResponse.listCountryInfo
                          .map((item) {
                        return DropdownMenuItem(
                            value: item.fullNameEnglish,
                            child: Container(
                              width: getScreenWidth(context) /
                                  spinnerErrorCorrection,
                              child: Text(
                                '${item.fullNameEnglish}',
                                style: getStyleSubHeading(context).copyWith(
                                    color: colorBlack,
                                    fontWeight: AppFont.fontWeightSemiBold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ));
                      }).toList(),
                      onChanged: (selectedValue) {
                        cartNotifier.selectedCountry = selectedValue;
                      }),
                )
              : Container(),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildWidgetRegionStateSpinner(
      BuildContext context, CartNotifier cartNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 7,
        ),
        Container(
            margin: EdgeInsets.only(left: 16.0),
            child: Text(
              'State / Province',
              style: getStyleCaption(context).copyWith(color: colorDarkGrey),
            )),
        SizedBox(
          height: 7,
        ),
        cartNotifier.listRegion != null && cartNotifier.listRegion.length > 0
            ? Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(twoFiveRadius))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: cartNotifier.selectedRegion,
                      items: cartNotifier.listRegion.map((item) {
                        _textEditConRegion.text = '';
                        return DropdownMenuItem(
                            value: item.name,
                            child: Container(
                              width: getScreenWidth(context) /
                                  spinnerErrorCorrection,
                              child: Text(
                                '${item.name}',
                                style: getStyleSubHeading(context).copyWith(
                                    color: colorBlack,
                                    fontWeight: AppFont.fontWeightSemiBold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ));
                      }).toList(),
                      onChanged: (selectedValue) {
                        cartNotifier.selectedRegion = selectedValue;
                      }),
                ),
              )
            : Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  validator: _validateRegion,
                  controller: _textEditConRegion,
                  maxLines: 1,
                  style: getStyleSubHeading(context).copyWith(
                      color: colorBlack,
                      fontWeight: AppFont.fontWeightSemiBold),
                  decoration: _buildTextDecoration(),
                )),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildWidgetZipPostalCode(CartNotifier cartNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 7,
        ),
        Container(
            margin: EdgeInsets.only(left: 16.0),
            child: Text(
              'Zip / Postal Code',
              style: getStyleCaption(context).copyWith(color: colorDarkGrey),
            )),
        SizedBox(
          height: 7,
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextFormField(
              controller: _textEditConZipCode,
              validator: _validateZipCode,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[0-9]"))
              ],
              style: getStyleSubHeading(context).copyWith(
                  color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
              decoration: _buildTextDecoration(),
              onChanged: (selectedValue) {
                cartNotifier.zipCode = selectedValue;
              }),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildWidgetApplyCoupon(CartNotifier cartNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 7,
        ),
        Container(
            margin: EdgeInsets.only(left: 16.0),
            child: Text(
              'Apply Coupon Code',
              style:
                  getStyleCaption(context).copyWith(color: colorFlashDarkGreen),
            )),
        SizedBox(
          height: 7,
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Form(
            key: _keyValidationCoupon,
            child: TextFormField(
              enabled: cartNotifier.couponCode == null ||
                      cartNotifier.couponCode.trim().length == 0
                  ? true
                  : false,
              maxLines: 1,
              controller: cartNotifier.textEditConCoupon,
              validator: _validateCouponCode,
              style: getStyleSubHeading(context).copyWith(
                  color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
              decoration: _buildTextDecorationForCoupon(cartNotifier),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Container buildApplyButton(CartNotifier cartNotifier) {
    return Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: Center(
        child: SizedBox(
          width: 230,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (cartNotifier.couponCode == null ||
                        cartNotifier.couponCode.trim().length == 0) {
                      _onClickButtonApplyCoupon(cartNotifier);
                    } else {
                      _onClickButtonRemoveCoupon(cartNotifier);
                    }
                  },
                  child: Text(
                    (cartNotifier.couponCode == null ||
                            cartNotifier.couponCode.trim().length == 0)
                        ? "Apply"
                        : 'Remove',
                    style: getStyleButtonText(context),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(twoFiveRadius))),
                  color: colorPrimary,
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButtonProceed(
      CartNotifier cartNotifier, BuildContext context) {
    return Container(
      height: 100,
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                _onClickedButtonProceedToCheckout(cartNotifier, context);
              },
              child: Text("Proceed to Checkout",
                  style: getStyleButtonText(context)),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(twoFiveRadius))),
              color: colorPrimary,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }

  Text _buildPriceLabel(Object amount, String currencyCode) {
    return Text(
      '$currencyCode ' + double.parse(amount.toString()).toStringAsFixed(2),
      style: getStyleBody1(context)
          .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      textAlign: TextAlign.right,
    );
  }

  Text _buildPriceContentLabel(String content) {
    return Text(
      content,
      style: getStyleBody1(context).copyWith(color: colorBlack),
    );
  }

  Widget _buildListShippingMethods(CartNotifier cartNotifier) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 8.0, right: 16.0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: cartNotifier.lstShippingMethod.length,
        itemBuilder: (_, index) {
          return _buildWidgetListTileForShippingMethod(
              cartNotifier.lstShippingMethod[index], index, cartNotifier);
        });
  }

  Row _buildWidgetListTileForShippingMethod(
      ShippingMethodModel item, int indexAsValue, CartNotifier cartNotifier) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Row(
            children: <Widget>[
              Radio(
                activeColor: colorPrimary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: cartNotifier.selectedRadioShippingMethod,
                onChanged: (value) =>
                    _onClickRadioShippingMethod(value, cartNotifier),
                value: indexAsValue,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AutoSizeText(
                    item.methodTitle,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: getStyleBody1(context).copyWith(
                        color: colorBlack, fontWeight: AppFont.fontWeightBold),
                    //  style: getStyleBody1(context).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: _buildPriceLabel(item.amount ?? 0, cartNotifier.currencyCode),
        ),
      ],
    );
  }

  Widget buildDeliveryDetailCard(CartNotifier cartNotifier) {
    return Container(
      margin: EdgeInsets.only(left: 14.0, right: 14.0),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWidgetTitleDeliveryType(cartNotifier),
            _buildWidgetListShippingMethods(cartNotifier),
            _buildWidgetTitleFlatRate(cartNotifier),
            _buildWidgetListCartTotal(cartNotifier),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetListCartTotal(CartNotifier cartNotifier) {
    return (cartNotifier.listTotalSegmentsModel != null &&
            cartNotifier.listTotalSegmentsModel.length > 0)
        ? AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            child: cartNotifier.isLoadingCartTotalData
                ? Container(
                    margin: EdgeInsets.all(8),
                    child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 16),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartNotifier.listTotalSegmentsModel.length,
                    itemBuilder: (context, index) {
                      return _buildCartTotalItem(
                        cartNotifier.listTotalSegmentsModel[index],
                        cartNotifier.currencyCode,
                      );
                    }),
          )
        : Container();
  }

  Widget _buildCartTotalItem(TotalSegmentsModel item, String currencyCode) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      margin: EdgeInsets.only(top: 6, bottom: 6),
      child: Column(
        children: <Widget>[
          (item.area != null && item.area == 'footer')
              ? Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: _buildDividerLine(true))
              : Container(),
          Row(
            children: <Widget>[
              Expanded(flex: 5, child: _buildPriceContentLabel(item.title)),
              Expanded(
                  flex: 5,
                  child: _buildPriceLabel(item.value ?? 0, currencyCode)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetTitleDeliveryType(cartNotifier) {
    return cartNotifier.lstShippingMethod != null &&
            cartNotifier.lstShippingMethod.length > 0
        ? Container(
            padding: const EdgeInsets.all(16),
            child: Text("Delivery Type",
                //  style: getStyleTitle(context).copyWith(color: Colors.black),
                style: getStyleSubHeading(context).copyWith(
                    fontSize: 18.0, fontWeight: AppFont.fontWeightSemiBold)),
          )
        : Container();
  }

  Widget _buildWidgetListShippingMethods(cartNotifier) {
    return cartNotifier.lstShippingMethod != null &&
            cartNotifier.lstShippingMethod.length > 0
        ? _buildListShippingMethods(cartNotifier)
        : Container();
  }

  Widget _buildWidgetTitleFlatRate(CartNotifier cartNotifier) {
    return (cartNotifier.listTotalSegmentsModel != null &&
            cartNotifier.listTotalSegmentsModel.length > 0)
        ? Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16.0, right: 16, bottom: 16),
            child: Text("Flat Rate ",
                style: getStyleSubHeading(context).copyWith(
                    fontSize: 18.0, fontWeight: AppFont.fontWeightSemiBold)),
          )
        : Container();
  }

  Widget _buildEstimateShippingTaxExpandedTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Text(
                      "Estimate Shipping and Tax",
                      style: getStyleSubHeading(context).copyWith(
                          color:
                              estimateIsExpanded ? colorPrimary : colorBlack),
                    )),
                Expanded(
                    flex: 1,
                    child: Icon(
                      estimateIsExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: estimateIsExpanded ? colorPrimary : colorDarkGrey,
                      size: 30.0,
                    ))
              ],
            ),
            onTap: () {
              setState(() {
                estimateIsExpanded = estimateIsExpanded ? false : true;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEstimateShippingExpandedBody(
      BuildContext context, cartNotifier) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Form(
        key: _keyValidationForm,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildCountrySpinner(context, cartNotifier, true, false, ""),
            _buildWidgetRegionStateSpinner(context, cartNotifier),
            _buildWidgetZipPostalCode(cartNotifier),
            _buildButtonEstimate(cartNotifier)
            //  Container(padding: EdgeInsets.only(left: 15.0, right: 15.0) ,height: 1.0, width: double.maxFinite, color: Colors.black54, ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonEstimate(CartNotifier cartNotifier) {
    return Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: Center(
        child: SizedBox(
          width: 230,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    _onClickButtonEstimate(cartNotifier);
                  },
                  child: Text(
                    'Estimate',
                    style: getStyleButtonText(context),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(twoFiveRadius))),
                  color: colorPrimary,
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyScreenView(context, bool showAppBar) {
    return Consumer<StateDrawer>(
        builder: (context, stateDrawer, _) => Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  CustomEmptyScreen(
                    AppImages.IMAGE_CART_EMPTY_INDICATOR,
                    AppConstants.YOUR_SHOPPING_CART_IS_EMPTY,
                    AppConstants.YOU_HAVE_ADD_ITEMS_SAVED_TO_BUY_LATER,
                    AppConstants.SHOP_NOW,
                    context,
                    onPressesButton: () =>
                        _onClickButtonShopNow(context, stateDrawer, showAppBar),
                  )
                ],
              ),
            ));
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }

  InputDecoration _buildTextDecorationForCoupon(CartNotifier cartNotifier) {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: cartNotifier.couponCode == null ||
                cartNotifier.couponCode.trim().length == 0
            ? colorWhite
            : colorVeryLightGrey,
        contentPadding: EdgeInsets.all(16));
  }

  //onClick: button shopNow
  void _onClickButtonShopNow(
      BuildContext context, StateDrawer stateDrawer, bool showAppBar) {
    log.i('Button shopNow is pressed');
    if (showAppBar != null && showAppBar == true) {
      Navigator.of(context).pop();
    } else {
      stateDrawer.selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
    }
  }

  //onClick: button estimate
  void _onClickButtonEstimate(CartNotifier cartNotifier) {
    log.i('Button estimate is pressed');

    String region = _textEditConRegion.text.isNotEmpty
        ? _textEditConRegion.text
        : cartNotifier.selectedRegion;
    String zipCode = _textEditConZipCode.text;

    cartNotifier.callApiEstimateShippingAndTax(region, zipCode);
    //don't remove code add if validation required
    /* if (cartNotifier.isRegionAvailableForSelectedCountry) {
      _textEditConRegion.text = 'test';
      if (_keyValidationForm.currentState.validate()) {
        _textEditConRegion.text = '';
        cartNotifier.callApiEstimateShippingAndTax(region, zipCode);
      }
    } else {
      if (_keyValidationForm.currentState.validate()) {
        cartNotifier.callApiEstimateShippingAndTax(region, zipCode);
      }
    }*/
  }

  //onClick: button radio on shipping method
  void _onClickRadioShippingMethod(int value, CartNotifier cartNotifier) {
    //same value don't call api, else start the changes in view
    if (cartNotifier.selectedRadioShippingMethod != value) {
      cartNotifier.selectedRadioShippingMethod = value;
      String region = _textEditConRegion.text.isNotEmpty
          ? _textEditConRegion.text
          : cartNotifier.selectedRegion;
      String zipCode = _textEditConZipCode.text;
      /*
       * call total Information API with/without shipping method to refresh load totals
       * First time shipping method will not be selected
       * Shipping method example Direct Delivery
       */
      cartNotifier.callApiGetCartTotal();
    }
  }

  //onClick: button apply coupon
  void _onClickButtonApplyCoupon(CartNotifier cartNotifier) {
    if (_keyValidationCoupon.currentState.validate()) {
      cartNotifier.callApiAddCoupon(cartNotifier.textEditConCoupon.text);
    }
  }

  //onClick: button remove coupon
  void _onClickButtonRemoveCoupon(CartNotifier cartNotifier) {
    cartNotifier.callApiRemoveCoupon();
  }

  //onClick: button proceed to checkout
  void _onClickedButtonProceedToCheckout(
      CartNotifier cartNotifier, BuildContext context) {
    if (cartNotifier.selectedRadioShippingMethod == -1) {
//      cartNotifier
//          .showSnackBarMessageWithContext('Please choose delivery type');
      cartNotifier.showSnackBarMessageParamASContext(
          cartNotifier.scaffoldKey.currentContext,
          'Please choose delivery type');
    } else {
      //  Navigator.pop(context,PaymentScreen.routeName);
      Navigator.pushNamed(context, PaymentScreen.routeName,
              arguments: cartNotifier.getPaymentNotifierValue())
          .whenComplete(() {
        final arguments = ModalRoute.of(context).settings.arguments as Map;
        final result = arguments['result'] != null ? arguments['result'] : null;
        log.d("Response :" + result);
      });
    }
  }

  //add quantity for cart item
  void addQuantityForCartItem(String selectedValue, ProductList productItem,
      CartNotifier cartNotifier) {
    try {
      switch (selectedValue) {
        case AppConstants.CART_ADD_OPTION_MORE:
          //show dialogue to get quantity from user
          _showDialogueAddMoreQuantity(cartNotifier, productItem);
          break;
        default:
          //call api for add item // 1, 2 & 3
          _callAddItemAPI(cartNotifier, productItem, selectedValue);
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //dialogue: to get add item count
  void _showDialogueAddMoreQuantity(
      CartNotifier cartNotifier, ProductList productItem) {
    try {
      var _keyValidationForm = GlobalKey<FormState>();
      TextEditingController _textControllerAddMoreQty = TextEditingController();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Enter Quantity',
                style: getAppBarTitleTextStyle(context).copyWith(
                    color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
              ),
              content: Form(
                key: _keyValidationForm,
                child: TextFormField(
                  controller: _textControllerAddMoreQty,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    return _validateTextAddQty(value, productItem);
                  },
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppConstants.CANCEL,
                      style: getStyleSubHeading(context).copyWith(
                          color: colorPrimary,
                          fontWeight: AppFont.fontWeightSemiBold)),
                  onPressed: () {
                    Navigator.pop(context); //for dialogue
                  },
                ),
                FlatButton(
                  child: Text(AppConstants.OK,
                      style: getStyleSubHeading(context).copyWith(
                          color: colorPrimary,
                          fontWeight: AppFont.fontWeightSemiBold)),
                  onPressed: () {
                    if (_keyValidationForm.currentState.validate()) {
                      _callAddItemAPI(cartNotifier, productItem,
                          _textControllerAddMoreQty.text);
                      Navigator.pop(context); //for dialogue
                      //clear local data
                      _keyValidationForm = null;
                      _textControllerAddMoreQty = null;
                    }
                  },
                )
              ],
            );
          });
    } catch (e) {
      log.e(e.toString());
    }
  }

  void _callAddItemAPI(
      CartNotifier cartNotifier, ProductList productItem, String qty) {
    cartNotifier.callAPIAddItemToCart(ItemProduct(
        sku: productItem.productSku,
        productType: productItem.productType,
        itemCartId: productItem.itemId,
        chosenQuantity: int.parse(qty)));
  }

  String _validateTextAddQty(String value, ProductList productItem) {
    return value.trim().length == 0
        ? 'Field can\'t be empty'
        : (int.parse(value) > productItem.productQtyStock)
            ? "Only " +
                productItem.productQtyStock.toString() +
                " Products in stock"
            : null;
  }

  String _validateRegion(String value) {
    return value.trim().length == 0 ? 'Field can\'t be empty' : null;
  }

  String _validateZipCode(String value) {
    return value.trim().length == 0 ? 'Field can\'t be empty' : null;
  }

  String _validateCouponCode(String value) {
    return value.trim().length == 0 ? 'Enter code' : null;
  }

  String _buildProductName(String productName, ProductOptions productOptions) {
    String value = '';
    value = productName ?? "";
    if (productOptions != null &&
        productOptions.value != null &&
        productOptions.value.isNotEmpty) {
      value = "$value \n(${productOptions.label} : ${productOptions.value})";
    }
    return value;
  }
}
