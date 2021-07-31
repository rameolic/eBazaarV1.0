import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/model/cart_total_items.dart';
import 'package:thought_factory/core/model/payment_methods_model.dart';
import 'package:thought_factory/core/model/payment_model.dart';
import 'package:thought_factory/core/model/shipping_method_model.dart';
import 'package:thought_factory/core/notifier/payment_notifier.dart';
import 'package:thought_factory/ui/menu/manage_address/manage_address_screen.dart';
import 'package:thought_factory/ui/order/order_confirmation_screen.dart';
import 'package:thought_factory/ui/payment/payment_card_screen1.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';
import 'package:thought_factory/utils/widgetHelper/custom_expendable_widget.dart';

import '../../../router.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment_screen';

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  int selectedG1Radio = 2;
  int selectedG2Radio = 1;
  bool thirdPartyRadioIsExpanded = true;

  int _radioOtherOption = -1;
  bool _expandOtherOptionChildNetBank = false;
  bool _expandOtherOptionChildCreditDebit = false;
  bool _expandOtherOptionChildCashOnDelivery = false;

  double boxCornerRadius = 10.0;
  double adjustContainerLeftRightMargin = 5.0;

  double paddingLeft = 8.0;
  double paddingRight = 8.0;

  List savedCardList = List();
  Map currentlySelected = Map();

  var textFieldStyleOfOtherOptions;

  var fieldFontWeight = AppFont.fontWeightSemiBold;

  var cardNumberController = TextEditingController(text: '');
  var cardHolderNameController = TextEditingController();
  var cvvController = TextEditingController();

  final FocusNode _focusNodeCardHolderName = FocusNode();
  final FocusNode _focusNodeCvv = FocusNode();
  String grandTotal = "";

  @override
  void initState() {
    super.initState();
    saveModelData();
  }

  saveModelData() {
    savedCardList.addAll(['Emirates NBD Bank', 'Abu Dhabi Commercial Bank']);
  }

  @override
  Widget build(BuildContext context) {
    final PaymentModel paymentModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: colorGrey,
      appBar: buildAppBar(),
      body: ChangeNotifierProvider<PaymentNotifier>(
        create: (context) => PaymentNotifier(context, paymentModel),
        child: Consumer<PaymentNotifier>(
          builder: (context, paymentNotifier, _) => ModalProgressHUD(
              inAsyncCall: paymentNotifier.isLoading,
              child: _buildBody(paymentNotifier)),
        ),
      ),
    );
  }

  //build widget: appbar
  Widget buildAppBar() {
    return AppBar(
      elevation: 3.0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          )),
      title: Text(
        AppConstants.REVIEW_AND_PAYMENTs,
        style: getAppBarTitleTextStyle(context),
      ),
    );
  }

  // page Content Area
  Widget _buildBody(PaymentNotifier paymentNotifier) {
    return Container(
      color: colorGrey,
      child: Stack(
        children: <Widget>[
          buildPageContent(paymentNotifier),
        ],
      ),
    );
  }

  // Page Content
  Widget buildPageContent(PaymentNotifier paymentNotifier) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(top: 26.0, bottom: 16.0, left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            //buildSavedCardsSession(context),
            _buildLabel(
                context,
                AppConstants.CONTACT_DETAILS,
                getStyleSubHeading(context)
                    .copyWith(fontWeight: AppFont.fontWeightSemiBold)),
            _buildContactDetailInfo(paymentNotifier),
            _buildButtonChangeOrAddAddress(context, paymentNotifier),
            buildOtherOptionsSession(paymentNotifier),
            buildDeliveryDetailCard(paymentNotifier),
            buildButtonPayNow(paymentNotifier),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(context, String stLabelText, TextStyle textStyle) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        stLabelText,
        style: textStyle,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildContactDetailInfo(PaymentNotifier paymentNotifier) {
    return paymentNotifier.shippingAddressAvailable
        ? Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                    text: '${paymentNotifier.shippingAddress.firstname}\n',
                    style: getStyleBody1(context)
                        .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                    children: <TextSpan>[
                      TextSpan(text: '\n'),
                      TextSpan(
                          text:
                              '${(paymentNotifier.shippingAddress.street != null && paymentNotifier.shippingAddress.street.length > 0) ? paymentNotifier.shippingAddress.street[0] : ''}, ${paymentNotifier.shippingAddress.city ?? ''}. ${paymentNotifier.shippingAddress.postcode ?? ''},\n\n${paymentNotifier.shippingAddress.telephone ?? ''}',
                          style: getStyleBody1(context)
                              .copyWith(fontWeight: AppFont.fontWeightMedium))
                    ]),
              ),
            ),
          )
        : Container();
  }

  Widget _buildButtonChangeOrAddAddress(
      context, PaymentNotifier paymentNotifier) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 16.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ManageAddressScreen())).then((onValue) {
            // if (onValue != null && onValue == "onValue") {
            paymentNotifier.callApiGetUserProfileDetail();
            // }
          });
        },
        child: Text(
          "Change or Add Address",
          style: getStyleButtonText(context),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        color: colorPrimary,
        padding: EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }

  Widget buildDeliveryDetailCard(PaymentNotifier cartNotifier) {
    return Container(
      margin: EdgeInsets.only(top: 8),
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

  Widget _buildWidgetTitleDeliveryType(PaymentNotifier paymentNotifier) {
    return paymentNotifier.lstShippingMethod != null &&
            paymentNotifier.lstShippingMethod.length > 0
        ? Container(
            padding: const EdgeInsets.all(16),
            child: Text("Delivery Type",
                //  style: getStyleTitle(context).copyWith(color: Colors.black),
                style: getStyleSubHeading(context).copyWith(
                    fontSize: 18.0, fontWeight: AppFont.fontWeightSemiBold)),
          )
        : Container();
  }

  Widget _buildWidgetListShippingMethods(PaymentNotifier paymentNotifier) {
    return paymentNotifier.lstShippingMethod != null &&
            paymentNotifier.lstShippingMethod.length > 0
        ? _buildListShippingMethods(paymentNotifier)
        : Container();
  }

  Widget _buildListShippingMethods(PaymentNotifier paymentNotifier) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 8.0, right: 16.0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: paymentNotifier.lstShippingMethod.length,
        itemBuilder: (_, index) {
          return _buildWidgetListTileForShippingMethod(
              paymentNotifier.lstShippingMethod[index], index, paymentNotifier);
        });
  }

  Row _buildWidgetListTileForShippingMethod(ShippingMethodModel item,
      int indexAsValue, PaymentNotifier paymentNotifier) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Row(
            children: <Widget>[
              Radio(
                activeColor: colorPrimary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: paymentNotifier.selectedRadioShippingMethod,
                onChanged: (value) => {},
                value: indexAsValue,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    item.methodTitle,
                    overflow: TextOverflow.fade,
                    //  style: getStyleBody1(context).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: _buildPriceLabel(item.amount ?? 0, paymentNotifier),
        ),
      ],
    );
  }

  Widget _buildWidgetTitleFlatRate(PaymentNotifier paymentNotifier) {
    return (paymentNotifier.listTotalSegmentsModel != null &&
            paymentNotifier.listTotalSegmentsModel.length > 0)
        ? Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16.0, right: 16, bottom: 16),
            child: Text("Flat Rate ",
                style: getStyleSubHeading(context).copyWith(
                    fontSize: 18.0, fontWeight: AppFont.fontWeightSemiBold)),
          )
        : Container();
  }

  Widget _buildWidgetListCartTotal(PaymentNotifier paymentNotifier) {
    return (paymentNotifier.listTotalSegmentsModel != null &&
            paymentNotifier.listTotalSegmentsModel.length > 0)
        ? ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: paymentNotifier.listTotalSegmentsModel.length,
            itemBuilder: (context, index) {
              return _buildCartTotalItem(
                  paymentNotifier.listTotalSegmentsModel[index],
                  paymentNotifier);
            })
        : Container();
  }

  Widget _buildCartTotalItem(
      TotalSegmentsModel item, PaymentNotifier paymentNotifier) {
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
                  child: _buildPriceLabel(item.value, paymentNotifier)),
            ],
          ),
        ],
      ),
    );
  }

/* Saved Card Card Area */
  Column buildSavedCardsSession(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildSubHeading(' Saved Cards'),
        _buildVerticalSpace(12),
        _buildSavedCardsRadioCard(context),
      ],
    );
  }

/* Other Options Card Area */
  Column buildOtherOptionsSession(PaymentNotifier paymentNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildVerticalSpace(12),
        _buildSubHeading(' Payment Options'),
        _buildVerticalSpace(12),
        _buildExpandableRadioCard(paymentNotifier),
      ],
    );
  }

// Bottom NavigationBar Area
  Widget buildButtonPayNow(PaymentNotifier paymentNotifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0, bottom: 32),
          width: double.infinity,
          child: RaisedButton(
            color: colorAccent,
            textColor: Colors.white,
            elevation: 3.0,
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              paymentNotifier.selectedRadioPaymentMethod != -1 ? paymentNotifier.lstPaymentMethods[paymentNotifier.selectedRadioPaymentMethod].code == "cashondelivery"
                  ? AppConstants.PLACE_ORDER
                  : AppConstants.PAY_NOW : AppConstants.PAY_NOW,
              style: getStyleButtonText(context),
            ),
            onPressed: () {
              _onClickButtonPayNow(paymentNotifier);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ],
    );
  }

/* Other Options */
  Container _buildExpandableRadioCard(PaymentNotifier paymentNotifier) {
    return paymentNotifier.lstPaymentMethods != null &&
            paymentNotifier.lstPaymentMethods.length > 0
        ? Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: paymentNotifier.lstPaymentMethods.length,
                itemBuilder: (context, index) {
                  return _buildWidgetItemListPayment(paymentNotifier,
                      paymentNotifier.lstPaymentMethods[index], index);
                }))
        : Container();
  }

  Widget _buildWidgetItemListPayment(PaymentNotifier paymentNotifier,
      PaymentMethodsModel item, int indexAsValue) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 8),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                activeColor: colorPrimary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: paymentNotifier.selectedRadioPaymentMethod,
                onChanged: (value) =>
                    _onClickRadioPaymentMethod(value, paymentNotifier),
                value: indexAsValue,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    item.title ?? '',
                    overflow: TextOverflow.fade,
                    style: getStyleBody2(context).copyWith(
                        color: Colors.black,
                        fontWeight: AppFont.fontWeightSemiBold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //onClick: button radio on payment method
  void _onClickRadioPaymentMethod(int value, PaymentNotifier paymentNotifier) {
    //same value don't call api, else start the changes in view
    if (paymentNotifier.selectedRadioPaymentMethod != value) {
      paymentNotifier.selectedRadioPaymentMethod = value;
    }
  }

  Container _buildOtherOptionRadioButton(String content, int indicatorValue,
      int groupValue, BuildContext context) {
    bool flag = false;

    if (indicatorValue == 0 && _expandOtherOptionChildNetBank == true) {
      flag = true;
    } else if (indicatorValue == 1 &&
        _expandOtherOptionChildCreditDebit == true) {
      flag = true;
    } else if (indicatorValue == 2 &&
        _expandOtherOptionChildCashOnDelivery == true) {
      flag = true;
    }

    return Container(
      margin: EdgeInsets.only(
          left: adjustContainerLeftRightMargin,
          right: adjustContainerLeftRightMargin),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(boxCornerRadius))),
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Row(
                  children: <Widget>[
                    Radio(
                      activeColor: colorPrimary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      groupValue: groupValue,
                      onChanged: _onOtherOptionSelectionChanged,
                      value: indicatorValue,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          content,
                          overflow: TextOverflow.fade,
                          style: getStyleBody2(context).copyWith(
                              color: Colors.black,
                              fontWeight: AppFont.fontWeightSemiBold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '',
                  style: getStyleBody1(context).copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          CustomExpandableContainer(
              context: context,
              childWidget: childSelectorForExpandContainer(indicatorValue),
              duration: 500,
              expand: flag)
        ],
      ),
    );
  }

  void _onOtherOptionSelectionChanged(int value) {
    setState(() {
      _radioOtherOption = value;

      switch (_radioOtherOption) {
        case 0:
          _expandOtherOptionChildNetBank = true;
          _expandOtherOptionChildCreditDebit = false;
          _expandOtherOptionChildCashOnDelivery = false;
          break;
        case 1:
          _expandOtherOptionChildNetBank = false;
          _expandOtherOptionChildCreditDebit = true;
          _expandOtherOptionChildCashOnDelivery = false;
          break;
        case 2:
          _expandOtherOptionChildNetBank = false;
          _expandOtherOptionChildCreditDebit = false;
          _expandOtherOptionChildCashOnDelivery = true;
      }
    });
  }

  Widget childSelectorForExpandContainer(int currentItem) {
    switch (currentItem) {
      case 0:
        return _buildNetBanking();
        break;
      case 1:
        return _buildCreditDebitCard();
        break;
      case 2:
        return _buildCashOnDelivery();
        break;
      default:
        return Container();
    }
  }

  Container _buildNetBanking() {
    return Container(
      child: Text(
        "This is NetBanking",
        style: getStyleBody1(context),
      ),
    );
  }

  Container _buildCreditDebitCard() {
    textFieldStyleOfOtherOptions = getStyleSubHeading(context).copyWith(
        fontSize: 18,
        color: Colors.black,
        fontWeight: AppFont.fontWeightSemiBold);

    var _textFieldStyle =
        getStyleSubHeading(context).copyWith(fontWeight: fieldFontWeight);

    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildHorizontalSpace(30),
              _buildImageLabel('assets/american_express.png'),
              _buildHorizontalSpace(8),
              _buildImageLabel('assets/discover.png'),
              _buildHorizontalSpace(8),
              _buildImageLabel('assets/master_card.png'),
              _buildHorizontalSpace(8),
              _buildImageLabel('assets/visa.png'),
            ],
          ),
          _buildVerticalSpace(12),
          Divider(
            height: 1,
          ),
          _buildVerticalSpace(8),
          buildSmallCaption(AppConstants.CARD_NUMBER + " ", context),
          Container(
            margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
            //padding: EdgeInsets.only(left: paddingLeft,right: paddingRight, top: paddingTop, bottom: paddingBottom),
            child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: cardNumberController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                style: _textFieldStyle,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_focusNodeCardHolderName);
                },
                //validator: (value) => validateEmptyCheck(value, "${AppConstants.NEW_PASSWORD} can\'t be empty"),
                validator: (value) => validateEmptyCheck(
                    value, AppConstants.CARD_NUMBER + " Can't be empty"),
                decoration: _buildTextDecoration()),
          ),
//          Container(
//            margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
//            alignment: Alignment.center,
//            padding: EdgeInsets.only(
//                left: paddingLeft,
//                right: paddingRight,
//                top: textFieldTopBottomPadding,
//                bottom: textFieldTopBottomPadding),
//            child: Row(
//              children: <Widget>[
//                Flexible(
//                  flex: 90,
//                  child: TextField(
//                    cursorColor: colorPrimary,
//                    style: textFieldStyleOfOtherOptions,
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10, bottom: 10),
//                    ),
//                    onChanged: (value) {},
//                  ),
//                ),
//              ],
//            ),
//            decoration: BoxDecoration(color: colorGrey, borderRadius: BorderRadius.all(Radius.circular(50.0))),
//          ),

          _buildVerticalSpace(8),

          //Card Holder Name
          buildSmallCaption(AppConstants.CARD_HOLDER_NAME + " ", context),
          Container(
            margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
            //padding: EdgeInsets.only(left: paddingLeft,right: paddingRight, top: paddingTop, bottom: paddingBottom),
            child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: cardHolderNameController,
                maxLines: 1,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: _textFieldStyle,
                focusNode: _focusNodeCardHolderName,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_focusNodeCvv);
                },
                //validator: (value) => validateEmptyCheck(value, "${AppConstants.NEW_PASSWORD} can\'t be empty"),
                validator: (value) => validateEmptyCheck(
                    value, AppConstants.CARD_HOLDER_NAME + " Can't be empty"),
                decoration: _buildTextDecoration()),
          ),
//          Container(
//            margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
//            alignment: Alignment.center,
//            padding: EdgeInsets.only(
//                left: paddingLeft,
//                right: paddingRight,
//                top: textFieldTopBottomPadding,
//                bottom: textFieldTopBottomPadding),
//            child: Row(
//              children: <Widget>[
//                Flexible(
//                  flex: 90,
//                  child: TextField(
//                    cursorColor: colorPrimary,
//                    style: textFieldStyleOfOtherOptions,
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10, bottom: 10),
//                    ),
//                    onChanged: (value) {},
//                  ),
//                ),
//              ],
//            ),
//            decoration: BoxDecoration(color: colorGrey, borderRadius: BorderRadius.all(Radius.circular(50.0))),
//          ),
          _buildVerticalSpace(8),
          Row(
            children: <Widget>[
              Flexible(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      buildSmallCaption('Expiry Month ', context),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
                        padding: EdgeInsets.only(
                            left: paddingLeft,
                            right: paddingRight,
                            top: 0.0,
                            bottom: 0.0),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              style: textFieldStyleOfOtherOptions,
                              value: 1,
                              items: <DropdownMenuItem<int>>[
                                DropdownMenuItem(
                                  child: new Text('06'),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: new Text('07'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: new Text('08'),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: new Text('09'),
                                  value: 2,
                                ),
                              ],
                              onChanged: (dynamic value) {
                                //  stateEditProfile.countryNumber = value;
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: colorGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                      ),
                    ],
                  )),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      buildSmallCaption('Expiry Year ', context),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
                        padding: EdgeInsets.only(
                            left: paddingLeft,
                            right: paddingRight,
                            top: 0.0,
                            bottom: 0.0),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              style: textFieldStyleOfOtherOptions,
                              value: 1,
                              items: <DropdownMenuItem<int>>[
                                DropdownMenuItem(
                                  child: new Text('2019'),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: new Text('2020'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: new Text('2021'),
                                  value: 2,
                                ),
                              ],
                              onChanged: (dynamic value) {
                                //  stateEditProfile.countryNumber = value;
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: colorGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                      ),
                    ],
                  )),
            ],
          ),

          //CVV
          buildSmallCaption(AppConstants.CVV + " ", context),
          Container(
            margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
            //padding: EdgeInsets.only(left: paddingLeft,right: paddingRight, top: paddingTop, bottom: paddingBottom),
            child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: cvvController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: _textFieldStyle,
                focusNode: _focusNodeCvv,
                //validator: (value) => validateEmptyCheck(value, "${AppConstants.NEW_PASSWORD} can\'t be empty"),
                validator: (value) => validateEmptyCheck(
                    value, AppConstants.CVV + " Can't be empty"),
                decoration: _buildTextDecoration()),
          ),
//          Container(
//            margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
//            alignment: Alignment.center,
//            padding: EdgeInsets.only(
//                left: paddingLeft + 5.0,
//                right: paddingRight,
//                top: textFieldTopBottomPadding,
//                bottom: textFieldTopBottomPadding),
//            child: Row(
//              children: <Widget>[
//                Flexible(
//                  flex: 90,
//                  child: TextField(
//                    cursorColor: colorPrimary,
//                    style: textFieldStyleOfOtherOptions,
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10, bottom: 10),
//                    ),
//                    onChanged: (value) {},
//                  ),
//                ),
//              ],
//            ),
//            decoration: BoxDecoration(color: colorGrey, borderRadius: BorderRadius.all(Radius.circular(50.0))),
//          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.lock_outline,
                size: 16,
                color: colorFlashGreen,
              ),
              SizedBox(width: 8.0),
              Text('CVV number will not be saved',
                  style: getStyleCaption(context).copyWith(color: colorBlack))
            ],
          ),
          _buildVerticalSpace(10),
        ],
      ),
    );
  }

  Container _buildCashOnDelivery() {
    return Container(
      child: Text(
        "This is CashOnDelivery",
        style: getStyleBody1(context),
      ),
    );
  }

//Delivery Type Card Area
  /*Card buildDeliveryDetailCardSession(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSubHeading('Delivery Type'),
            _buildRadioButton("Distributor Delivery", 1, selectedG1Radio),
            _buildRadioButton("Third Party Delivery", 2, selectedG1Radio),
            CustomExpandableContainer(
                context: context,
                childWidget: _buildThirdPartyShippingExpenderBody(context),
                duration: 500,
                expand: thirdPartyRadioIsExpanded),
            SizedBox(
              height: 10,
            ),
            _buildSubHeading('Flat Rate'),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: <Widget>[
                Expanded(flex: 5, child: _buildPriceContentLabel('Sub Total')),
                Expanded(flex: 5, child: _buildPriceLabel(250)),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: <Widget>[
                Expanded(flex: 5, child: _buildPriceContentLabel('Shipping')),
                Expanded(flex: 5, child: _buildPriceLabel(10)),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: <Widget>[
                Expanded(flex: 5, child: _buildPriceContentLabel('Tax')),
                Expanded(flex: 5, child: _buildPriceLabel(5)),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            _buildDividerLine(true),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 5, child: _buildPriceContentLabel('Order Total')),
                Expanded(flex: 5, child: _buildPriceLabel(256)),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }*/

  /* Row _buildRadioButton(String content, int indicatorValue, int groupValue) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Row(
            children: <Widget>[
              Radio(
                activeColor: colorPrimary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: groupValue,
                onChanged: onClickDeliveryTypeRadio,
                value: indicatorValue,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    content,
                    overflow: TextOverflow.fade,
                    //style: getStyleBody1(context).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: indicatorValue == 0
              ? _buildPriceLabel(10)
              : Text(
                  '',
                  style: getStyleBody1(context).copyWith(color: Colors.black),
                ),
        ),
      ],
    );
  }*/

  void onClickDeliveryTypeRadio(int value) {
    setState(() {
      selectedG1Radio = value;

      switch (selectedG1Radio) {
        case 1:
          thirdPartyRadioIsExpanded = false;
          break;
        case 2:
          thirdPartyRadioIsExpanded = true;
          break;
      }
    });
  }

  void onClickThirdPartyDlyChildRadio(int value) {
    setState(() {
      selectedG2Radio = value;
    });
  }

  /* Widget _buildThirdPartyShippingExpenderBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25.0),
      child: Column(
        children: <Widget>[
          _buildThirdPartyRadioButton2("Direct Delivery", 1, selectedG2Radio),
          _buildThirdPartyRadioButton2(
              "Consolidate Delivery", 2, selectedG2Radio),
        ],
      ),
    );
  }*/

  /* Row _buildThirdPartyRadioButton2(
      String content, int indicatorValue, int groupValue) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Row(
            children: <Widget>[
              Radio(
                activeColor: colorPrimary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: groupValue,
                onChanged: onClickThirdPartyDlyChildRadio,
                value: indicatorValue,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    content + " ",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    //style: getStyleBody1(context).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: _buildPriceLabel(10),
        ),
      ],
    );
  }

  void _onShippingType2Changed(int value) {
    setState(() {
      selectedG2Radio = value;

      switch (selectedG1Radio) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }*/

  Text _buildPriceLabel(Object amount, PaymentNotifier paymentNotifier) {
    print("Amount :==>" + double.parse(amount.toString()).toStringAsFixed(2));
    grandTotal = double.parse(amount.toString()).toStringAsFixed(2);
    return Text(
      '${paymentNotifier.currencyCode} ${paymentNotifier.convertToDecimal(amount.toString(), 2)}',
      style: getStyleBody1(context).copyWith(
          color: Colors.black, fontWeight: AppFont.fontWeightSemiBold),
      textAlign: TextAlign.right,
    );
  }

  Text _buildPriceContentLabel(String content) {
    return Text(
      content,
      style: getStyleBody1(context).copyWith(color: colorBlack),
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

// Functionality Related Method (Non Widget Methods)
  void onBackPress() {
    Navigator.of(context).pop();
  }

  void _onClickButtonPayNow(PaymentNotifier paymentNotifier) {
    if (!paymentNotifier.shippingAddressAvailable) {
      paymentNotifier
          .showSnackBarMessageWithContext('Please set Shipping Address');
    } else if (!paymentNotifier.billingAddressAvailable) {
      paymentNotifier
          .showSnackBarMessageWithContext('Please set Billing Address');
    } else if (paymentNotifier.selectedRadioPaymentMethod == -1) {
      paymentNotifier
          .showSnackBarMessageWithContext('Please choose payment option');
    } else {
      String paymentMethod = paymentNotifier
          .lstPaymentMethods[paymentNotifier.selectedRadioPaymentMethod].code;
      String shippingCode = paymentNotifier
          .lstShippingMethod[paymentNotifier.selectedRadioShippingMethod]
          .methodCode;
      String carrierCode = paymentNotifier
          .lstShippingMethod[paymentNotifier.selectedRadioShippingMethod]
          .carrierCode;
      paymentNotifier
          .callApiPayment(paymentMethod, shippingCode, carrierCode)
          .then((value) {
        log.i("cartResponseId Value : -------------> $value");

        if (value != null) {
          if (value.cartResponseId != null && value.cartResponseId.isNotEmpty) {
            print("payment mowa: ${paymentNotifier.lstPaymentMethods[paymentNotifier.selectedRadioPaymentMethod].code}");
            if (paymentNotifier.lstPaymentMethods[paymentNotifier.selectedRadioPaymentMethod].code != "cashondelivery") {
              //var argArrData = [value.cartResponseId,grandTotal,];

              Navigator.pushNamed(context, PaymentCardScreen1.routeName,
                  arguments: value.cartResponseId);
              //Navigator.pushNamed(context, PaymentCardScreen.routeName,arguments: argArrData);

            } else {
              Navigator.pushNamed(context, OrderConfirmationScreen.routeName,
                  arguments: value.cartResponseId);
            }
          } else {
            print("errors:asdfghj");
            paymentNotifier.showSnackBarMessageWithContext(value.message);
          }
        } else {
          print("error:asdfghj");
          paymentNotifier.showSnackBarMessageWithContext(AppConstants.ERROR);
        }
      });
      //Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmationScreen()), );
    }
  }

// Common ReUsable-Widgets
  Text _buildSubHeading(String caption) {
    return Text(caption,
        //  style: getStyleTitle(context).copyWith(color: Colors.black),
        style: getStyleSubHeading(context)
            .copyWith(fontSize: 18.0, fontWeight: AppFont.fontWeightSemiBold));
  }

  SizedBox _buildVerticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  SizedBox _buildHorizontalSpace(double width) {
    return SizedBox(
      width: width,
    );
  }

  SizedBox _buildImageLabel(String imagePath) {
    return SizedBox(
      height: 25.0,
      child: Image.asset(imagePath),
    );
  }

  Column _buildSavedCardsRadioCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: FractionalOffset.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[]..addAll(createSavedCardsList()),
          ),
        )
      ],
    );
  }

  List<Widget> createSavedCardsList() {
    return savedCardList
        .asMap()
        .map((index, value) => MapEntry(index, _buildItemCard(index, value)))
        .values
        .toList();
  }

  Widget _buildItemCard(index, value) {
    return Container(
      margin: EdgeInsets.only(
          left: adjustContainerLeftRightMargin,
          right: adjustContainerLeftRightMargin,
          bottom: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(boxCornerRadius)),
          color: colorWhite),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: index,
                groupValue:
                    currentlySelected[0] != null ? currentlySelected[0] : "",
                onChanged: (value) {
                  this.setState(() {
                    currentlySelected[0] = value;
                  });
                },
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 4.0),
                  child: Text(
                    value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getStyleBody1(context)
                        .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 12.0, right: 16.0),
                  child: Image.asset(AppImages.IMAGE_CITRUS_LOGO,
                      height: 24, alignment: Alignment.center)),
            ],
          ),
          Container(
              margin: EdgeInsets.only(left: 48.0, right: 16.0),
              alignment: Alignment.centerLeft,
              child: Text('51**  ****  **** 5146')),
          Container(
            margin: EdgeInsets.only(left: 48.0, right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'CVV Number',
                      style:
                          getStyleCaption(context).copyWith(color: colorBlack),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' *',
                            style: getStyleSubHeading(context)
                                .copyWith(color: colorPrimary))
                      ]),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
                  child: Text(
                    "859",
                    style: getStyleSubHeading(context)
                        .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                  ),
                  decoration: BoxDecoration(
                      color: colorGrey,
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorGrey,
        contentPadding: EdgeInsets.all(16));
  }
}
