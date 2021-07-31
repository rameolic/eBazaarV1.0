import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/order/distributor_wise_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/order/order_response.dart';
import 'package:thought_factory/core/notifier/order_detail_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/common_widgets/app_bar.dart';

class MyOrderDetailScreen extends StatefulWidget {
  static const routeName = '/my_order_detail_screen';

  @override
  MyOrderDetailScreenState createState() => MyOrderDetailScreenState();
}

class MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  MyOrderDetailScreenState();

  @override
  Widget build(BuildContext context) {
    final Items itemDetails = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<OrderDetailNotifier>(
      create: (context) => OrderDetailNotifier(context, itemDetails.entityId),
      child: Scaffold(
        backgroundColor: colorGrey,
        appBar: buildAppBar(context, "0", 'My Orders'),
        //_buildAppbar(index),
        body: Consumer<OrderDetailNotifier>(
            builder: (BuildContext context, orderNotifier, _) =>
                ModalProgressHUD(
                    inAsyncCall: orderNotifier.isLoading,
                    child: (orderNotifier.orderResponse != null &&
                            orderNotifier.orderResponse.data != null &&
                            orderNotifier.orderResponse.data.orderedItemList !=
                                null &&
                            orderNotifier
                                    .orderResponse.data.orderedItemList.length >
                                0)
                        ? _buildContentPage(context, itemDetails, orderNotifier)
                        : (orderNotifier.isLoading)
                            ? Container()
                            : Container(
                                child: Center(
                                  child: Text(
                                      orderNotifier.orderResponse.message ??
                                          ""),
                                ),
                              ))),
        // bottomNavigationBar: buildButtonCancelOrder(context),
      ),
    );
  }

  Widget _buildContentPage(BuildContext context, Items itemDetails,
      OrderDetailNotifier orderNotifier) {
    return SingleChildScrollView(
      child: Container(
        color: colorGrey,
        padding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Order Detail ",
                style: getStyleSubHeading(context).copyWith(
                    color: Colors.black,
                    fontWeight: AppFont
                        .fontWeightSemiBold) //.copyWith(fontWeight: FontWeight.bold),
                ),
            Card(
              elevation: 3.0,
              margin: EdgeInsets.only(top: 20.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    buildListView(itemDetails, orderNotifier),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                          width: double.maxFinite,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildSubTitle('Shipping Address'),
                              Text(
                                itemDetails
                                        .extensionAttributes
                                        .shippingAssignments[0]
                                        .shipping
                                        .address
                                        .firstname +
                                    " " +
                                    itemDetails
                                        .extensionAttributes
                                        .shippingAssignments[0]
                                        .shipping
                                        .address
                                        .lastname,
                                style: getStyleSubHeading(context).copyWith(
                                    color: Colors.black,
                                    fontWeight: AppFont.fontWeightMedium),
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              Text(
                                "${(itemDetails.extensionAttributes.shippingAssignments[0].shipping.address.company != null) ? "${itemDetails.extensionAttributes.shippingAssignments[0].shipping.address.company},\n" : ""}"
                                "${getStreet(itemDetails.extensionAttributes.shippingAssignments[0].shipping.address)},"
                                "\n${itemDetails.extensionAttributes.shippingAssignments[0].shipping.address.city} - "
                                "${itemDetails.extensionAttributes.shippingAssignments[0].shipping.address.postcode} "
                                "\n${itemDetails.extensionAttributes.shippingAssignments[0].shipping.address.telephone}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13.0,
                                    height: 1.5),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 3.0,
              margin: EdgeInsets.only(top: 15.0),
              child: Container(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSubTitle('Payment'),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: _buildSmallContentLabelName('Payment Method'),
                        ),
                        Expanded(
                            flex: 5,
                            child: _buildPriceOrContentLabel(
                                itemDetails.payment.additionalInformation[0])),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
//                    _buildSubTitle('Delivery Type'),
//                    Row(
//                      children: <Widget>[
//                        Expanded(
//                            flex: 5,
//                            child: _buildSmallContentLabelName(
//                                'Consolidate Delivery')),
//                        Expanded(
//                            flex: 5,
//                            child: _buildPriceOrContentLabel('\$7.00')),
//                      ],
//                    ),
//                    SizedBox(
//                      height: 20.0,
//                    ),
                    _buildSubTitle('Flat Rate'),
                    Row(children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: _buildSmallContentLabelName('Sub Total')),
                      Expanded(
                          flex: 5,
                          child: _buildPriceOrContentLabel(
                              '${itemDetails.baseCurrencyCode} ' +
                                  orderNotifier
                                      .convertToDecimal(
                                          itemDetails.subtotal.toString(), 2)
                                      .toString())),
                    ]),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: _buildSmallContentLabelName('Shipping')),
                        Expanded(
                            flex: 5,
                            child: _buildPriceOrContentLabel(
                                '${itemDetails.baseCurrencyCode} ' +
                                    orderNotifier.convertToDecimal(
                                        itemDetails.shippingAmount.toString(),
                                        2))),
                      ],
                    ),

                    (itemDetails.couponCode != null &&
                            itemDetails.discountAmount != null &&
                            itemDetails.couponCode.isNotEmpty)
                        ? Container(
                            margin: EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 5,
                                    child: _buildSmallContentLabelName(
                                        'Discount (${itemDetails.couponCode})')),
                                Expanded(
                                    flex: 5,
                                    child: _buildPriceOrContentLabel(
                                        '${itemDetails.baseCurrencyCode} ' +
                                            orderNotifier.convertToDecimal(
                                                itemDetails.discountAmount
                                                    .toString(),
                                                2))),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 5, child: _buildSmallContentLabelName('Tax')),
                        Expanded(
                            flex: 5,
                            child: _buildPriceOrContentLabel(
                                '${itemDetails.baseCurrencyCode} ' +
                                    orderNotifier.convertToDecimal(
                                        itemDetails.taxAmount.toString(), 2))),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      height: 0.7,
                      width: double.maxFinite,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: _buildSmallContentLabelName('Order Total')),
                        Expanded(
                            flex: 5,
                            child: _buildPriceOrContentLabel(
                                '${itemDetails.baseCurrencyCode} ' +
                                    orderNotifier.convertToDecimal(
                                        itemDetails.grandTotal.toString(), 2))),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListView(Items itemDetails, OrderDetailNotifier orderNotifier) {
    return ListView.builder(
        shrinkWrap: true,
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        primary: false,
        itemCount: orderNotifier.orderResponse.data.orderedItemList.length,
        itemBuilder: (_, index) {
          return buildListItemOrder(index, orderNotifier,
              orderNotifier.orderResponse.data.orderedItemList);
        });
  }

  Widget buildButtonCancelOrder(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.transparent,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                onClickButtonCancelOrder(context);
              },
              child: Text(
                AppConstants.CANCEL_ORDER,
                style: getStyleButtonText(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              color: colorPrimary,
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }

  void onClickButtonCancelOrder(BuildContext context) {
    // ignore: deprecated_member_use
    //showDialog(context: context, child: _buildPopUpDialogCancelOrder(context));
    // showDialog(context: context, builder: builder)
    showDialog(
        context: context,
        builder: (_) => _buildPopUpDialogCancelOrder(context));
  }

  Widget _buildPopUpDialogCancelOrder(BuildContext context) {
    double height = getScreenHeight(context);
    double widget = getScreenWidth(context);

    return Container(
      margin: EdgeInsets.all(16),
      child: Center(
        //heightFactor: getScreenHeight(context),
        child: SizedBox(
          height: height / 1.9,
          width: widget - 32,
          child: Card(
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 10.0,
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 24.0, bottom: 32.0, left: 24.0, right: 24.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Image.asset(
                              AppImages.IMAGE_CANCEL_ORDER_DIALOG_IMAGE,
                              height: height / 3.5,
                            ))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text(AppConstants.ARE_YOU_SURE_CANCEL_ORDER,
                                textAlign: TextAlign.center,
                                style: getStyleSubHeading(context).copyWith(
                                    color: Colors.black,
                                    fontWeight: AppFont.fontWeightSemiBold)))),
                    buildDialogBottomButtons(context)
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget buildDialogBottomButtons(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(left: 0.0, right: 8, bottom: 16.0),
            width: double.infinity,
            child: RaisedButton(
              color: colorAccent,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                AppConstants.YES,
                style: getStyleButtonText(context),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(left: 8.0, right: 0.0, bottom: 16.0),
            width: double.infinity,
            child: RaisedButton(
              color: colorLightGrey,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                AppConstants.NO,
                style: getStyleButtonText(context),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
      ],
    );
  }

//  Column _buildStatusTileWithDate(String statusTitle, String date) {
//    return Column(
//      children: <Widget>[
//        SizedBox(
//          height: 10.0,
//        ),
//        Text(
//          statusTitle,
//          textAlign: TextAlign.center,
//          style: getStyleCaption(context).copyWith(
//              fontWeight: AppFont.fontWeightSemiBold, color: colorBlack),
//        ),
//        SizedBox(
//          height: 5.0,
//        ),
//        Text(
//          date,
//          textAlign: TextAlign.center,
//          style: getStyleCaption(context).copyWith(),
//        )
//      ],
//    );
//  }

  Widget _buildStatusTileWithDate(String label, double boxWidth) {
    return Container(
      child: AutoSizeText(
        label,
        maxLines: 1,
        style: getStyleCaption(context).copyWith(
            color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
      ),
    );
  }

  _buildPriceOrContentLabel(String content) {
    return Text(
      content.toString(),
      style: getStyleBody1(context).copyWith(
          color: Colors.black, fontWeight: AppFont.fontWeightSemiBold),
      textAlign: TextAlign.right,
    );
  }

  _buildSubTitle(String subTitle) {
    return Column(
      children: <Widget>[
        Text(subTitle,
            style: getStyleSubHeading(context).copyWith(
                color: Colors.black,
                fontWeight: AppFont
                    .fontWeightSemiBold) // .copyWith(fontWeight: FontWeight.bold),
            ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  _buildSmallContentLabelName(String labelName) {
    return Text(
      labelName,
      style: getStyleBody1(context),
    );
  }

  SizedBox _marginHeight(double d) {
    return SizedBox(
      height: d,
    );
  }

  Widget buildListItemOrder(int index, OrderDetailNotifier orderDetailNotifier,
      List<OrderedItemList> orderedItemList) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _marginHeight(10.0),
                    Text(
                      _buildProductName(orderedItemList[index].productName,
                          orderedItemList[index].customOption),
                      style: getStyleSubHeading(context)
                          .copyWith(fontWeight: AppFont.fontWeightSemiBold),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    (orderedItemList[index].shopName != null)
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Text(
                                    "Store Name: ",
                                    textAlign: TextAlign.start,
                                    style: getStyleCaption(context).copyWith(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.normal),
                                  )),
                                  Flexible(
                                      child: Text(
                                          orderedItemList[index].shopName,
                                          style: getStyleCaption(context)
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontWeight:
                                                      FontWeight.normal)))
                                ],
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildRowItem("SKU: ", orderedItemList[index].productSku,
                        "Qty: ", orderedItemList[index].quantity.toString()),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildRowItem(
                        "Price: ",
                        orderDetailNotifier
                            .convertToDecimal(
                                orderedItemList[index].price.toString(), 2)
                            .toString(),
                        "Total: ",
                        orderDetailNotifier
                            .convertToDecimal(
                                orderedItemList[index].total.toString(), 2)
                            .toString()),
                    Visibility(
                        visible: true,
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 16.0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              orderedItemList[index].shippingStatus != null &&
                                      orderedItemList[index]
                                              .shippingStatus
                                              .length >
                                          0
                                  ? _buildTrackBar(orderedItemList[index]
                                                  .shippingStatus[0]
                                                  .logstatus !=
                                              null &&
                                          orderedItemList[index]
                                                  .shippingStatus[0]
                                                  .logstatus
                                                  .length >
                                              0
                                      ? orderedItemList[index]
                                          .shippingStatus[0]
                                          .logstatus
                                          .length
                                      : 1)
                                  : Container(
                                      height: 0,
                                    )
                            ],
                          ),
                        )),
                    //_buildStatusTrackBar(orderedItemList[index]),
                    Visibility(
                        visible: false,
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 16.0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              orderedItemList[index].shippingStatus != null &&
                                      orderedItemList[index]
                                              .shippingStatus
                                              .length >
                                          0
                                  ? _buildDynamicTrackBar(
                                      orderedItemList[index]
                                                      .shippingStatus[0]
                                                      .logstatus !=
                                                  null &&
                                              orderedItemList[index]
                                                      .shippingStatus[0]
                                                      .logstatus
                                                      .length >
                                                  0
                                          ? orderedItemList[index]
                                              .shippingStatus[0]
                                              .logstatus
                                              .length
                                          : 1,
                                      orderedItemList[index]
                                                      .shippingStatus[0]
                                                      .overallstatus !=
                                                  null &&
                                              orderedItemList[index]
                                                      .shippingStatus[0]
                                                      .overallstatus
                                                      .length >
                                                  0
                                          ? (orderedItemList[index]
                                                  .shippingStatus[0]
                                                  .overallstatus
                                                  .length -
                                              1)
                                          : 0,
                                      orderedItemList[index]
                                          .shippingStatus[0]
                                          .overallstatus)
                                  : Container(
                                      height: 0,
                                    )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 0.4,
            width: double.maxFinite,
            color: Colors.black26,
          ),
        ],
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
                      (status != "Price: ")
                          ? Flexible(
                              child: Text(
                                statusDetails,
                                maxLines: 5,
                                textAlign: TextAlign.start,
                                style: getStyleCaption(context).copyWith(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          : Flexible(
                              child: Text(
                                statusDetails,
                                maxLines: 5,
                                textAlign: TextAlign.start,
                                style: getStyleSubHeading(context).copyWith(
                                    color: colorPrimary,
                                    fontSize: 13.0,
                                    fontWeight: AppFont.fontWeightSemiBold),
                              ),
                            )
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

  Widget _buildTrackBar(int statusFlag) {
    double boxWidth = getScreenWidth(context) / 6;
    double boxHeight = boxWidth;
    double lineTopMarginRatio = 3.4;
    double spaceBetween = 4;
    return Stack(
      children: <Widget>[
        Container(
          child: Row(
            //mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: boxWidth,
                  //margin: EdgeInsets.only(top: 6),
                  margin: EdgeInsets.only(
                      left: boxWidth / 2, top: boxWidth / lineTopMarginRatio),
                  color: statusFlag > 1 ? colorFlashGreen : colorDarkGrey,
                  height: 2,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: boxWidth,
                  margin: EdgeInsets.only(top: boxWidth / lineTopMarginRatio),
                  color: statusFlag > 2 ? colorFlashGreen : colorDarkGrey,
                  height: 2,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: boxWidth,
                  margin: EdgeInsets.only(top: boxWidth / lineTopMarginRatio),
                  //margin: EdgeInsets.only(left: getScreenWidth(context) / 8),
                  color: statusFlag > 3 ? colorFlashGreen : colorDarkGrey,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.brightness_1,
                        color:
                            statusFlag >= 1 ? colorFlashGreen : colorDarkGrey,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: spaceBetween,
                      ),
                      _buildStatusTileWithDate('Ordered', boxWidth),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.brightness_1,
                        color:
                            statusFlag >= 2 ? colorFlashGreen : colorDarkGrey,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: spaceBetween,
                      ),
                      _buildStatusTileWithDate('Packed', boxWidth),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.brightness_1,
                        color:
                            statusFlag >= 3 ? colorFlashGreen : colorDarkGrey,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: spaceBetween,
                      ),
                      _buildStatusTileWithDate('Shipped', boxWidth),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.brightness_1,
                        color:
                            statusFlag >= 4 ? colorFlashGreen : colorDarkGrey,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: spaceBetween,
                      ),
                      _buildStatusTileWithDate('Delivered', boxWidth),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
//      Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              Icon(
//                Icons.brightness_1,
//                color: colorFlashGreen,
//                size: 14.0,
//              ),
//              _buildStatusTileWithDate('Ordered'),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Container(
//                    color: Colors.orange,
//                    height: 5.0,
//                  ),
//                  Icon(
//                    Icons.brightness_1,
//                    color: colorFlashGreen,
//                    size: 14.0,
//                  ),
//                ],
//              ),
//              //Icon(Icons.brightness_1, color: Colors.orange, size: 14.0,),
//              _buildStatusTileWithDate('Packed'),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              Icon(
//                Icons.brightness_1,
//                color: colorFlashGreen,
//                size: 14.0,
//              ),
//              _buildStatusTileWithDate('Shipped'),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              Icon(
//                Icons.brightness_1,
//                color: colorFlashGreen,
//                size: 14.0,
//              ),
//              _buildStatusTileWithDate('Delivered'),
//            ],
//          ),
//
//        ]);
  }

  Widget _buildDynamicTrackBar(
      int statusFlag, int totalStatus, List<Overallstatus> overallstatus) {
    double boxWidth = getScreenWidth(context) / 6;
    double boxHeight = boxWidth;
    List<Widget> _horizontalLine = List();
    List<Widget> _stateContent = List();
    for (int i = 0; i < totalStatus; i++) {
      _horizontalLine.add(_buildHorizontalLine(i + 1, boxWidth, statusFlag));
    }
    for (int i = 0; i < totalStatus + 1; i++) {
      _stateContent.add(_buildStateContent(totalStatus, statusFlag, boxWidth,
          boxHeight, overallstatus[i].statusLabel));
    }
    return Stack(
      children: <Widget>[
        Row(
            //mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: _horizontalLine),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _stateContent),
      ],
    );
//      Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              Icon(
//                Icons.brightness_1,
//                color: colorFlashGreen,
//                size: 14.0,
//              ),
//              _buildStatusTileWithDate('Ordered'),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Container(
//                    color: Colors.orange,
//                    height: 5.0,
//                  ),
//                  Icon(
//                    Icons.brightness_1,
//                    color: colorFlashGreen,
//                    size: 14.0,
//                  ),
//                ],
//              ),
//              //Icon(Icons.brightness_1, color: Colors.orange, size: 14.0,),
//              _buildStatusTileWithDate('Packed'),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              Icon(
//                Icons.brightness_1,
//                color: colorFlashGreen,
//                size: 14.0,
//              ),
//              _buildStatusTileWithDate('Shipped'),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              Icon(
//                Icons.brightness_1,
//                color: colorFlashGreen,
//                size: 14.0,
//              ),
//              _buildStatusTileWithDate('Delivered'),
//            ],
//          ),
//
//        ]);
  }

  Widget _buildHorizontalLine(
      int countAllStatus, double boxWidth, int activeState) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: boxWidth,
        //margin: EdgeInsets.only(top: 6),
        margin: (countAllStatus == 1)
            ? EdgeInsets.only(left: boxWidth / 2, top: boxWidth / 2.8)
            : EdgeInsets.only(top: boxWidth / 2.8),
        color: activeState > countAllStatus ? colorFlashGreen : colorDarkGrey,
        height: 2,
      ),
    );
  }

  Widget _buildStateContent(int countAllStatus, int activeState,
      double boxWidth, double boxHeight, String label) {
    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.brightness_1,
              color: activeState >= countAllStatus
                  ? colorFlashGreen
                  : colorDarkGrey,
              size: 14.0,
            ),
            _buildStatusTileWithDate(label, boxWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTrackBar(OrderedItemList orderedItemList) {
    int countAllStatus = orderedItemList.shippingStatus[0].overallstatus.length;
    int activeState = (orderedItemList.shippingStatus[0].logstatus != null &&
            orderedItemList.shippingStatus[0].logstatus.length > 0)
        ? orderedItemList.shippingStatus[0].logstatus.length
        : 1;
    List<String> listStatusLabel = List();
    for (int i = 0;
        i < orderedItemList.shippingStatus[0].overallstatus.length;
        i++) {
      listStatusLabel
          .add(orderedItemList.shippingStatus[0].overallstatus[i].statusLabel);
    }
    return (countAllStatus >= activeState)
        ? _buildAppStatusBar(countAllStatus, activeState, listStatusLabel)
        : Container();
  }

  Widget _buildAppStatusBar(
      int countAllStatus, int activeState, List<String> listStatusLabel) {
    List<Widget> _listOfLineWidgets = List();
    List<Widget> _listOfDotWidgets = List();
    double boxWidth = getScreenWidth(context) / 6;
    double boxHeight = boxWidth;
    if (countAllStatus > 1) {
      for (int i = 0; i < (countAllStatus - 1); i++) {
        _listOfLineWidgets
            .add(_buildHorizontalLine(countAllStatus, boxWidth, activeState));
      }
    }

    for (int i = 0; i < countAllStatus; i++) {
      _listOfDotWidgets.add(_buildStateContent(countAllStatus, activeState,
          boxWidth, boxHeight, listStatusLabel[i]));
    }

    return Stack(
      children: <Widget>[
        Row(children: _listOfLineWidgets),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _listOfDotWidgets),
      ],
    );
  }

  String _buildProductName(
      String productName, List<CustomOption> customOption) {
    String value = productName ?? '';
    if (customOption != null &&
        customOption.length > 0 &&
        customOption[0].value != null) {
      value =
          "$productName\n(${customOption[0].label}: ${customOption[0].value})";
    }
    return value;
  }
}

String getStreet(Address address) {
  String name = "";
  int i = 0;
  address.street.forEach((streetList) {
    String street = streetList;
    (i == 0) ? name = street : name = name + "," + street;
    i++;
  });
  return name;
}
