import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/register/register_request.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/payment_card_notifier.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/main/main_screen.dart';
import 'package:thought_factory/ui/order/order_confirmation_screen.dart';
import 'package:thought_factory/utils/widgetHelper/alert_overlay.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/dummy/dummy_list.dart';

class PaymentCardScreen extends StatefulWidget {
  static const routeName = '/payment_card_screen';

  @override
  PaymentCardScreenState createState() => PaymentCardScreenState();
}

class PaymentCardScreenState extends State<PaymentCardScreen> {
  double captionAndTextFieldDistance = 6.0;
  double textFieldAndCaptionDistance = 12.0;

  final List<String> initialMonth = List();
  final List<String> initialYear = getListYear();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextStyle textFieldStyle;
  static const platform = const MethodChannel('com.startActivity/testChannel');

  double radiusValue = 50.0;
  PaymentCardNotifier paymentCardNotifier;
  String cartResponseId = "", grandTotalAmt = "", orderId = "", orderName = "";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartResponseId = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<PaymentCardNotifier>(
        create: (context) => PaymentCardNotifier(context, cartResponseId),
        child: Consumer<PaymentCardNotifier>(
            builder: (BuildContext context, paymentCardNotifier, _) => Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    elevation: 3.0,
                    centerTitle: true,
                    leading: GestureDetector(
                        onTap: () {
                          callApiCartQuoteId(paymentCardNotifier);
                          // Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20.0,
                        )),
                    title: Text(
                      AppConstants.CARD_PAYMENT,
                      style: getAppBarTitleTextStyle(context),
                    ),
                  ),
                  body: ModalProgressHUD(
                    inAsyncCall: paymentCardNotifier.isLoading,
                    child: WillPopScope(
                        child:
                            _buildAddNewCardForm(context, paymentCardNotifier),
                        onWillPop: () async => false),
                  ),
                  bottomNavigationBar:
                      buildBottomButtons(context, paymentCardNotifier),
                )));
  }

  void callApiCartQuoteId(PaymentCardNotifier paymentCardNotifier) {
    StateDrawer stateDrawer = Provider.of<StateDrawer>(context);
    print("Statedrawerrrr ----> ${stateDrawer.selectedDrawerItem}");
    paymentCardNotifier.callApiCartQuoteId().then((value) {
      if (value != null) {
        CommonNotifier().quoteId = value;
        AppSharedPreference().saveCartQuoteId(value);
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.routeName, (e) => false);
        stateDrawer.selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
      }
    });
  }

  Widget _buildAddNewCardForm(
      BuildContext context, PaymentCardNotifier paymentCardNotifier) {
//    if (paymentCardNotifier.getOrderByIdResponse != null) {
//      var  response = paymentCardNotifier.getOrderByIdResponse;
//      if(response != null)
//        grandTotalAmt = response.grandTotal.toString();
//      orderId = response.incrementId.toString();
//      orderName = response.extensionAttributes.shippingAssignments[0].items[0].name;
//    }
    return Container(
      child: Stack(
        children: <Widget>[
          _buildScreenContent(context, paymentCardNotifier),
        ],
      ),
    );
  }

  Widget _buildScreenContent(
      BuildContext context, PaymentCardNotifier paymentCardNotifier) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(top: 8.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            buildAddNewCardSession(context, paymentCardNotifier),
          ],
        ),
      ),
    );
  }

  Widget buildAddNewCardSession(
      BuildContext context, PaymentCardNotifier paymentCardNotifier) {
    textFieldStyle =
        getStyleTitle(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);
    if (paymentCardNotifier.getOrderByIdResponse.extensionAttributes != null &&
        paymentCardNotifier
                .getOrderByIdResponse.extensionAttributes.shippingAssignments !=
            null &&
        paymentCardNotifier.getOrderByIdResponse.extensionAttributes
                .shippingAssignments[0].items[0] !=
            null)
      orderName = paymentCardNotifier.getOrderByIdResponse.extensionAttributes
              .shippingAssignments[0].items[0].name ??
          "";

    if (paymentCardNotifier.getOrderByIdResponse != null)
      orderId = paymentCardNotifier.getOrderByIdResponse.incrementId ?? "";

    if (paymentCardNotifier.getOrderByIdResponse != null &&
        paymentCardNotifier.getOrderByIdResponse.baseTotalDue != null)
      grandTotalAmt = paymentCardNotifier.convertToDecimal(
          paymentCardNotifier.getOrderByIdResponse.baseTotalDue.toString(), 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildVerticalSpace(16),
//        Text(
//          'Card',
//          style: getStyleSubHeading(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
//          textAlign: TextAlign.start,
//        ),
        _buildVerticalSpace(16),

        // Card Number
        buildSmallCaption('Card Number ', context),
        _buildVerticalSpace(captionAndTextFieldDistance),
        TextFormField(
          controller: paymentCardNotifier.textCardNumber,
          focusNode: paymentCardNotifier.focusNodeCardNumber,
          inputFormatters: [
            MaskTextInputFormatter(
                mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')}),
          ],
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          style: textFieldStyle,
          maxLines: 1,
          onFieldSubmitted: (String value) {
            FocusScope.of(context)
                .requestFocus(paymentCardNotifier.focusNodeExpMonth);
          },
          decoration: InputDecoration(
              hintText: "XXXX XXXX XXXX XXXX",
              hintStyle:
                  getStyleSubHeading(context).copyWith(color: Colors.black87),
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none))),
        ),
        _buildVerticalSpace(textFieldAndCaptionDistance),

        // Card Holder Name
        // buildSmallCaption('Card Holder Name ', context),
//        _buildVerticalSpace(captionAndTextFieldDistance),
//        TextFormField(
//          controller: paymentCardNotifier.textCardHolderName,
//          focusNode: paymentCardNotifier.focusNodeCardHolderName,
//          keyboardType: TextInputType.text,
//          textCapitalization: TextCapitalization.sentences,
//          textInputAction: TextInputAction.next,
//          maxLines: 1,
//          style: textFieldStyle,
//          onFieldSubmitted: (String value) {
//            FocusScope.of(context).requestFocus(paymentCardNotifier.focusNodeExpMonth);
//          },
//          decoration: _buildTextDecoration(),
//        ),
        _buildVerticalSpace(textFieldAndCaptionDistance),

        // Expiry Month And Year
        Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildSmallCaption('Expiry Month ', context),
                    _buildVerticalSpace(captionAndTextFieldDistance),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 10.0, right: 16.0, top: 2.0, bottom: 2.0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: TextFormField(
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '##',
                                    filter: {"#": RegExp(r'[0-9]')}),
                              ],
                              controller: paymentCardNotifier.textExpMonth,
                              focusNode: paymentCardNotifier.focusNodeExpMonth,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              // maxLength: 2,
                              style: textFieldStyle,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context).requestFocus(
                                    paymentCardNotifier.focusNodeExpYear);
                              },
                              decoration: InputDecoration(
                                  hintText: "MM",
                                  hintStyle: getStyleSubHeading(context)
                                      .copyWith(color: Colors.black87),
                                  contentPadding: EdgeInsets.all(0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),
                            )),
                      ),
                      decoration: ShapeDecoration(
                        color: colorWhite,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: colorWhite,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              width: 24.0,
            ),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildSmallCaption('Expiry Year ', context),
                    _buildVerticalSpace(captionAndTextFieldDistance),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 16.0, top: 2.0, bottom: 2.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '####',
                                    filter: {"#": RegExp(r'[0-9]')}),
                              ],
                              controller: paymentCardNotifier.textExpYear,
                              focusNode: paymentCardNotifier.focusNodeExpYear,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              style: textFieldStyle,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context).requestFocus(
                                    paymentCardNotifier.focusNodeCvv);
                              },
                              decoration: InputDecoration(
                                  hintText: "YYYY",
                                  hintStyle: getStyleSubHeading(context)
                                      .copyWith(color: Colors.black87),
                                  contentPadding: EdgeInsets.all(0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),
                            ),
                            flex: 9,
                          ),
                          //Expanded(child: Icon(Icons.help_outline, color: colorDarkGrey,), flex: 1,)
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ],
                )),
          ],
        ),

        _buildVerticalSpace(textFieldAndCaptionDistance),

        // CVV
        buildSmallCaption('CVV ', context),
        _buildVerticalSpace(captionAndTextFieldDistance),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '###', filter: {"#": RegExp(r'[0-9]')}),
                  ],
                  controller: paymentCardNotifier.textCvv,
                  focusNode: paymentCardNotifier.focusNodeCvv,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  style: textFieldStyle,
                  //decoration: _buildTextDecoration(),
                  decoration: InputDecoration(
                      hintText: "CCV",
                      hintStyle: getStyleSubHeading(context)
                          .copyWith(color: Colors.black87),
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none))),
                ),
                flex: 9,
              ),
              //Expanded(child: Icon(Icons.help_outline, color: colorDarkGrey,), flex: 1,)
            ],
          ),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        _buildVerticalSpace(textFieldAndCaptionDistance),
      ],
    );
  }

  Widget buildBottomButtons(
      BuildContext context, PaymentCardNotifier paymentCardNotifier) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(left: 16.0, right: 10, bottom: 36.0),
            width: double.infinity,
            child: RaisedButton(
              color: colorAccent,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                AppConstants.PAY_NOW,
                style: getStyleButtonText(context),
              ),
              onPressed: () async {
                if (paymentCardNotifier.textCardNumber.text.toString() == "" &&
                    paymentCardNotifier.textCvv.text.toString() == "" &&
                    paymentCardNotifier.textExpMonth.text.toString() == "" &&
                    paymentCardNotifier.textExpYear.text.toString() == "") {
                  _showSnackBarMessage(AppConstants.FILL_DETAILS);
                } else if (paymentCardNotifier.textCardNumber.text.toString() ==
                    "") {
                  _showSnackBarMessage("Enter " + AppConstants.CARD_NUMBER);
                } else if (paymentCardNotifier.textExpMonth.text.toString() ==
                    "") {
                  _showSnackBarMessage("Enter " + AppConstants.EXPIRY_MONTH);
                } else if (paymentCardNotifier.textExpYear.text.toString() ==
                    "") {
                  _showSnackBarMessage("Enter " + AppConstants.EXPIRY_YEAR);
                } else if (paymentCardNotifier.textCvv.text.toString() == "") {
                  _showSnackBarMessage("Enter " + AppConstants.CVV);
                } else {
                  if (paymentCardNotifier.textCardNumber.text
                          .toString()
                          .length <
                      16) {
                    _showSnackBarMessage(
                        "Enter valid " + AppConstants.CARD_NUMBER);
                  } else if (paymentCardNotifier.textExpMonth.text
                          .toString()
                          .length <
                      2) {
                    _showSnackBarMessage(
                        "Enter valid " + AppConstants.EXPIRY_MONTH);
                  } else if (paymentCardNotifier.textExpYear.text
                          .toString()
                          .length <
                      4) {
                    _showSnackBarMessage(
                        "Enter  valid " + AppConstants.EXPIRY_YEAR);
                  } else if (paymentCardNotifier.textCvv.text
                          .toString()
                          .length <
                      3) {
                    _showSnackBarMessage("Enter valid " + AppConstants.CVV);
                  } else {
                    PaymentCardRequest paymentCardRequest =
                        new PaymentCardRequest();
                    paymentCardRequest.authorization = new Authorization();

                    //Entered value
                    paymentCardRequest.authorization.cardNumber =
                        paymentCardNotifier.textCardNumber.text
                            .toString()
                            .replaceAll(new RegExp(r"\s+"), "");
                    paymentCardRequest.authorization.expiryMonth =
                        paymentCardNotifier.textExpMonth.text.toString();
                    paymentCardRequest.authorization.expiryYear =
                        paymentCardNotifier.textExpYear.text.toString();
                    paymentCardRequest.authorization.verifyCode =
                        paymentCardNotifier.textCvv.text.toString();
                    paymentCardRequest.authorization.orderName =
                        orderName.length > 20
                            ? orderName.substring(0, 20)
                            : orderName;
                    paymentCardRequest.authorization.orderID = orderId;
                    paymentCardRequest.authorization.amount = grandTotalAmt;
                    //Manual data
                    paymentCardRequest.authorization.customer = "Demo Merchant";
                    paymentCardRequest.authorization.language = "en";
                    paymentCardRequest.authorization.transactionHint = "CPT:Y;";
                    paymentCardRequest.authorization.channel = "Phone";
                    paymentCardRequest.authorization.currency = "AED";
                    paymentCardRequest.authorization.userName = "Demo_fY9c";
                    paymentCardRequest.authorization.password =
                        "Comtrust@20182018";

                    paymentCardNotifier.isLoading = true;
                    await _startActivity(
                            Customer: paymentCardRequest.authorization.customer,
                            OrderName:
                                paymentCardRequest.authorization.orderName,
                            OrderID: paymentCardRequest.authorization.orderID,
                            Currency: paymentCardRequest.authorization.currency,
                            Language: paymentCardRequest.authorization.language,
                            Channel: paymentCardRequest.authorization.channel,
                            Amount: paymentCardRequest.authorization.amount,
                            TransactionHint: paymentCardRequest
                                .authorization.transactionHint,
                            CardNumber:
                                paymentCardRequest.authorization.cardNumber,
                            ExpiryMonth:
                                paymentCardRequest.authorization.expiryMonth,
                            ExpiryYear:
                                paymentCardRequest.authorization.expiryYear,
                            VerifyCode:
                                paymentCardRequest.authorization.verifyCode,
                            UserName: paymentCardRequest.authorization.userName,
                            Password: paymentCardRequest.authorization.password,
                            paymentCardNotifier: paymentCardNotifier)
                        .then((returnResponse) {
                      if (returnResponse != null) {
                        if (returnResponse.length == 2 &&
                            returnResponse.values.elementAt(0) == "Success") {
                          Navigator.pushNamed(
                              context, OrderConfirmationScreen.routeName,
                              arguments: cartResponseId);
                        } else if (returnResponse.length == 2 &&
                            returnResponse.values.elementAt(0) == "Error") {
                          showDialog(
                            context: context,
                            builder: (_) => AlertOverlay(
                                AppConstants.ALERT,
                                returnResponse.values.elementAt(1),
                                AppConstants.OKAY),
                          );
                        }
                      }
                    });

                    /* PaymentCardResponse paymentCardResponse =
                        await paymentCardNotifier
                            .callApiCardPayment(paymentCardRequest);*/

                    /*try {
                      BaseOptions options = BaseOptions(
                          baseUrl: AppUrl.paymentBaseUrl,
                          responseType: ResponseType.json,
                          connectTimeout: 30000,
                          receiveTimeout: 30000,
                          // ignore: missing_return
                          validateStatus: (code) {
                            if (code >= 200) {
                              print("Response reached");
                              return true;
                            }
                          });
                      Dio dio = Dio(options);
                      dio.options.headers = {
                        'content-type': 'application/json',
                        'accept': 'application/json',
                        'connection': 'keep-alive'
                      };
                      print("Length : " +
                          json
                              .encode(paymentCardRequest.toJson())
                              .toString()
                              .split("\\")
                              .length
                              .toString());
                      RequestOptions requestOptions = RequestOptions(
                        headers: {
                          "content-type": "application/json",
                          "accept": "application/json",
                          "host": "demo-ipg.ctdev.comtrust.ae"
                        },
                        data: json
                            .encode(paymentCardRequest.toJson())
                            .replaceAll("\\", ""),
                      );
                      var response = await dio
                          .post("", options: requestOptions)
                          .catchError((err) {
                        print("CatchErro : " + err.toString());
                      });

                      if (response != null) {
                        if (response.statusCode == 200) {
                          print("Success");
                        } else {
                          print("Failed");
                        }
                      }
                    } on DioError catch (e) {
                      if (e.response.statusCode == 404) {
                        print(e.response.statusCode);
                      } else {
                        print(e.message);
                        print(e.request);
                      }
                    }*/

                    /*if (paymentCardResponse != null &&
                        paymentCardResponse.transaction != null &&
                        paymentCardResponse
                                .transaction.responseClassDescription !=
                            null &&
                        paymentCardResponse
                                .transaction.responseClassDescription ==
                            "Success") {
                      Navigator.pushNamed(
                          context, OrderConfirmationScreen.routeName,
                          arguments: cartResponseId);
                    } else {
                      if (paymentCardResponse != null &&
                          paymentCardResponse.transaction != null &&
                          paymentCardResponse
                                  .transaction.responseClassDescription !=
                              null &&
                          paymentCardResponse
                                  .transaction.responseClassDescription ==
                              "Error") {
                        showDialog(
                          context: context,
                          builder: (_) => AlertOverlay(
                              AppConstants.ALERT,
                              paymentCardResponse
                                  .transaction.responseDescription,
                              AppConstants.OKAY),
                        );
                        //_showSnackBarMessage(paymentCardResponse.transaction.responseDescription);
                      } else {
                        _showSnackBarMessage(AppConstants.ERROR);
                      }
                    }*/
                  }
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
      ],
    );
  }

  //show: snackBar toast
  void _showSnackBarMessage(String message) {
    final snackBar = SnackBar(content: Text(message ?? ""));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<dynamic> _startActivity(
      {String Customer,
      String Language,
      String Currency,
      String OrderName,
      String OrderID,
      String Channel,
      String Amount,
      String TransactionHint,
      String CardNumber,
      String ExpiryMonth,
      String ExpiryYear,
      String VerifyCode,
      String UserName,
      String Password,
      PaymentCardNotifier paymentCardNotifier}) async {
    var sendHashMap = <String, dynamic>{
      'Customer': Customer,
      'Language': Language,
      'Currency': Currency,
      'OrderName': OrderName,
      'OrderID': OrderID,
      'Channel': Channel,
      'Amount': Amount,
      'TransactionHint': TransactionHint,
      'CardNumber': CardNumber,
      'ExpiryMonth': ExpiryMonth,
      'ExpiryYear': ExpiryYear,
      'VerifyCode': VerifyCode,
      'UserName': UserName,
      'Password': Password
    };
    try {
      var result =
          await platform.invokeMethod('StartSecondActivity', sendHashMap);
      if (result != null) {
        if (result is Map<int, String>) {
          Map<int, String> response = result as Map<int, String>;
          if (response.length == 2) {
            for (int i = 0; i < response.length; i++) {
              print(">>> " + response.values.elementAt(i));
            }
          }
        }
      }
      paymentCardNotifier.isLoading = false;
      debugPrint('Result Tho: $result ');
      return result;
    } on PlatformException catch (e) {
      paymentCardNotifier.isLoading = false;
      debugPrint("Error: '${e.message}'.");
      return null;
    }
  }

  SizedBox _buildVerticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusValue),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }
}
