import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/get_order_by_id/CreateOrderByIdResponse.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/order_confirmation_notifier.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/main/main_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';

class OrderConfirmationScreen extends StatefulWidget {
  static const routeName = '/OrderConfirmationScreen';

  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  var _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "order_confirmation_screen");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String cartResponseId = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
        child: ChangeNotifierProvider<OrderConfirmationNotifier>(
          create: (context) =>
              OrderConfirmationNotifier(context, cartResponseId),
          child: Consumer<OrderConfirmationNotifier>(
            builder: (context, orderConfirmationNotifier, _) => Scaffold(
              key: _scaffoldKey,
              appBar: buildAppBar(context, AppConstants.SCREEN_ORDER_CONFIRMED,
                  orderConfirmationNotifier),
              //_buildAppbar(),
              body: ModalProgressHUD(
                inAsyncCall: orderConfirmationNotifier.isLoading,
                child: _buildBodyContent(context, orderConfirmationNotifier),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }

  Widget buildAppBar(context, String title,
      OrderConfirmationNotifier orderConfirmationNotifier) {
    return AppBar(
      elevation: 3.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          _onTappedTextContinueShopping(context, orderConfirmationNotifier);
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20.0,
        ),
      ),
      title: Text(
        title,
        style: getAppBarTitleTextStyle(context),
      ),
    );
  }

  Widget _buildBodyContent(
      context, OrderConfirmationNotifier orderConfirmationNotifier) {
    return Container(
      color: colorGrey,
      child: Stack(
        children: <Widget>[
          _buildContentDetails(context, orderConfirmationNotifier),
          //_buildButtonViews(context, orderConfirmationNotifier)
        ],
      ),
    );
  }

  Widget _buildContentDetails(
      context, OrderConfirmationNotifier orderConfirmationNotifier) {
    GetOrderByIdResponse response;
    if (orderConfirmationNotifier.getOrderByIdResponse != null) {
      response = orderConfirmationNotifier.getOrderByIdResponse;
      // if(response != null)
//       grandTotal = response.grandTotal.toString();
//       orderId = response.incrementId.toString();
//       orderName = response.extensionAttributes.shippingAssignments[0].items[0].name;
    }
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(top: 26.0, bottom: 115.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              onPressed: null,
              child: Icon(
                Icons.check,
                color: colorFlashGreen,
                size: 48,
              ),
              shape: CircleBorder(
                side: BorderSide(color: colorFlashGreen, width: 2.0),
              ),
              padding: EdgeInsets.all(12.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Text(
                AppConstants.YOUR_ORDER_IS_CONFIRMED,
                style: getStyleTitle(context)
                    .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: getStyleBody1(context),
                  children: <TextSpan>[
                    TextSpan(text: AppConstants.THANKS_SHOPPING_TEXT_1),
                    TextSpan(
                        text: (isAssignShipmentAvailable(
                                orderConfirmationNotifier)
                            ? '${orderConfirmationNotifier.getOrderByIdResponse.extensionAttributes.shippingAssignments[0].items[0].name}'
                            : ""),
                        style: getStyleBody1(context).copyWith(
                            color: colorPrimary, fontWeight: FontWeight.bold)),
                    TextSpan(text: ' and '),
                    TextSpan(
                        text: (isAssignShipmentAvailable(
                                    orderConfirmationNotifier)
                                ? '${orderConfirmationNotifier.getOrderByIdResponse.extensionAttributes.shippingAssignments[0].items.length}'
                                : "") +
                            AppConstants.THANKS_SHOPPING_TEXT_2,
                        style: getStyleBody1(context).copyWith(
                            color: colorPrimary, fontWeight: FontWeight.bold)),
                    TextSpan(text: AppConstants.THANKS_SHOPPING_TEXT_3)
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    getSingleItemView(context, 'Order Detail'),
                    getTwoItemView(context, 'Order ID',
                        '${orderConfirmationNotifier.getOrderByIdResponse.incrementId ?? ""}'),
                    getTwoItemView(
                        context,
                        'Order Date',
                        (isAssignShipmentAvailable(orderConfirmationNotifier)
                            ? '${customDate(orderConfirmationNotifier.getOrderByIdResponse.updatedAt)}'
                            : "")),
                    SizedBox(
                      height: 10.0,
                    ),
                    getSingleItemView(context, 'Flat Rate'),
                    getTwoItemView(context, 'Sub Total',
                        '${orderConfirmationNotifier.getOrderByIdResponse.globalCurrencyCode ?? ""} ${orderConfirmationNotifier.convertToDecimal(orderConfirmationNotifier.getOrderByIdResponse.baseSubtotal.toString(), 2)}'),
                    getTwoItemView(context, 'Shipping',
                        '${orderConfirmationNotifier.getOrderByIdResponse.globalCurrencyCode ?? ""} ${orderConfirmationNotifier.convertToDecimal(orderConfirmationNotifier.getOrderByIdResponse.shippingAmount.toString(), 2)}'),
                    getTwoItemView(context, 'Tax',
                        '${orderConfirmationNotifier.getOrderByIdResponse.globalCurrencyCode ?? ""} ${orderConfirmationNotifier.convertToDecimal(orderConfirmationNotifier.getOrderByIdResponse.baseTaxAmount.toString(), 2)}'),
                    Divider(
                      color: colorDarkGrey,
                    ),
                    getTwoItemView(context, 'Order Total',
                        '${orderConfirmationNotifier.getOrderByIdResponse.globalCurrencyCode ?? ""} ${orderConfirmationNotifier.convertToDecimal(orderConfirmationNotifier.getOrderByIdResponse.baseTotalDue.toString(), 2)}'),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: InkWell(
                    splashColor: colorAccent.withOpacity(0.5),
                    onTap: () {
                      _onTappedTextContinueShopping(
                          context, orderConfirmationNotifier);
                    },
                    child: Text(
                      AppConstants.CONTINUE_SHOPPING,
                      style: getStyleButtonText(context)
                          .copyWith(color: colorPrimary),
                    ),
                  ),
                ), //button:continue shopping
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isAssignShipmentAvailable(
      OrderConfirmationNotifier orderConfirmationNotifier) {
    if (orderConfirmationNotifier.getOrderByIdResponse != null &&
        orderConfirmationNotifier.getOrderByIdResponse.extensionAttributes !=
            null &&
        orderConfirmationNotifier
                .getOrderByIdResponse.extensionAttributes.shippingAssignments !=
            null) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildButtonViews(
      context, OrderConfirmationNotifier orderConfirmationNotifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 18.0),
          width: double.infinity,
          child: RaisedButton(
            color: colorAccent,
            textColor: Colors.white,
            elevation: 3.0,
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              AppConstants.TRACK_ORDER,
              style: getStyleButtonText(context),
            ),
            onPressed: () {
              _onTappedButtonTrackOrder();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ), //button: track Order
        Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: InkWell(
            splashColor: colorAccent.withOpacity(0.5),
            onTap: () {
              _onTappedTextContinueShopping(context, orderConfirmationNotifier);
            },
            child: Text(
              AppConstants.CONTINUE_SHOPPING,
              style: getStyleButtonText(context).copyWith(color: colorPrimary),
            ),
          ),
        ), //button:continue shopping
      ],
    );
  }

  void _onTappedButtonTrackOrder() {}

  void _onTappedTextContinueShopping(
      context, OrderConfirmationNotifier orderConfirmationNotifier) {
    StateDrawer stateDrawer = Provider.of<StateDrawer>(context, listen: false);
    print("Statedrawerrrr ----> ${stateDrawer.selectedDrawerItem}");
    orderConfirmationNotifier.callApiCartQuoteId().then((value) {
      if (value != null) {
        CommonNotifier().quoteId = value;
        AppSharedPreference().saveCartQuoteId(value);
        //Navigator.of(context).popUntil(ModalRoute.withName(MainScreen.routeName));
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.routeName, (e) => false);
        stateDrawer.selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
        // in StuffPage
//        Navigator.of(context).popUntil((route) {
//          if (route.settings.name == HomeScreen.routeName) {
//            (route.settings.arguments as Map)['result'] = 'something';
//            return true;
//          } else {
//            return false;
//          }
//        });
      }
    });
  }

  getSingleItemView(context, value1) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value1,
          textAlign: TextAlign.start,
          style: getStyleSubHeading(context)
              .copyWith(fontWeight: AppFont.fontWeightSemiBold),
        ),
      ),
    );
  }

  getTwoItemView(context, value1, value2) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            value1,
            style: getStyleBody1(context),
          ),
          Expanded(
            child: Text(
              value2,
              style: getStyleBody2(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
