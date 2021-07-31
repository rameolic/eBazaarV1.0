import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/notifier/order_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';

import 'my_order_detail_screen.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  MyOrderScreenContent createState() => MyOrderScreenContent();
}

class MyOrderScreenContent extends State<MyOrderScreen> {
  double itemCardRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderNotifier>(
      create: (context) => OrderNotifier(context),
      child: Consumer<OrderNotifier>(
        builder: (context, orderNotifier, _) => ModalProgressHUD(
            inAsyncCall: orderNotifier.isLoading,
            child: (orderNotifier.orderResponse != null &&
                    orderNotifier.orderResponse.items != null &&
                    orderNotifier.orderResponse.items.length > 0)
                ? ListView.builder(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                    itemCount: orderNotifier.orderResponse.items.length,
                    itemBuilder: (_, index) {
                      return buildListItemOrder(index, orderNotifier);
                    },
                  )
                : (orderNotifier.isLoading)
                    ? Container()
                    : Container(
                        child: Center(
                          child: Text('No data found'),
                        ),
                      )),
      ),
    );
  }

  Widget buildListItemOrder(index, OrderNotifier orderNotifier) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: colorPrimary,
            onTap: () {
              onTappedProductItem(index, orderNotifier);
            },
            child: Card(
              color: colorWhite,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(itemCardRadius))),
              child: Container(
                padding:
                    EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 8),
                child: Column(
                  children: <Widget>[
                    buildRowItem(
                        "Order #: ",
                        orderNotifier.orderResponse.items[index].incrementId
                            .toString(),
                        "Date: ",
                        '${customDate(orderNotifier.orderResponse.items[index].updatedAt)}'),
                    SizedBox(height: 10.0),
                    buildRowItem(
                        "Status: ",
                        orderNotifier.orderResponse.items[index].status,
                        "Total: ",
                        orderNotifier
                            .convertToDecimal(
                                orderNotifier
                                    .orderResponse.items[index].baseGrandTotal
                                    .toString(),
                                2)
                            .toString())
                  ],
                ),
              ),
            ),
          )
          // onTap: () => onTappedProductItem(index),
          ),
    );
  }

  Widget buildRowItem(String status, String statusDetails, String statusSecond,
      statusDetailsSecond) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        status,
                        textAlign: TextAlign.start,
                        style: getStyleCaption(context).copyWith(
                            color: Colors.black45,
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal),
                      ),
                      Flexible(
                        child: Text(
                          statusDetails,
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          style: getStyleCaption(context).copyWith(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      statusSecond,
                      textAlign: TextAlign.start,
                      style: getStyleCaption(context).copyWith(
                          color: Colors.black45,
                          fontSize: 13.0,
                          fontWeight: FontWeight.normal),
                    ),
                    (statusSecond != "Total: ")
                        ? Text(statusDetailsSecond,
                            style: getStyleCaption(context).copyWith(
                                color: Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal))
                        : Flexible(
                            child: Text(statusDetailsSecond,
                                style: getStyleSubHeading(context).copyWith(
                                    color: colorPrimary,
                                    fontSize: 13.0,
                                    fontWeight: AppFont.fontWeightSemiBold)))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildProductImage() {
    return AspectRatio(
      aspectRatio: 1.0 / 1.2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0)),
            color: colorGrey,
          ),
          child: Icon(
            FontAwesomeIcons.tshirt,
            color: colorPrimary,
          )),
    );
  }

  onTappedProductItem(int index, OrderNotifier orderNotifier) {
    Navigator.pushNamed(context, MyOrderDetailScreen.routeName,
        arguments: orderNotifier.orderResponse.items[index]);
  }
}
