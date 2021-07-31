import 'package:flutter/material.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/dummy_products_list.dart';

class InvoiceScreen extends StatefulWidget {
  static const routeName = '/invoice_screen';

  @override
  InvoiceScreenState createState() => InvoiceScreenState();
}

class InvoiceScreenState extends State<InvoiceScreen> {
  bool isAndroid;

  @override
  Widget build(BuildContext context) {
    isAndroid = checkPlatForm(context);

    TextStyle styleContentTitle = getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);
    TextStyle styleContent = getStyleCaption(context).copyWith(color: colorBlack, fontWeight: AppFont.fontWeightMedium);
    final lstPurchasedProducts = getDummyInvoiceProducts(3);

    return Scaffold(
        backgroundColor: colorGrey,
        appBar: _buildAppbar(),
        body: Container(
          color: colorGrey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: Image.asset(
                            AppImages.IMAGE_LOGO_THOUGHT_FACTORY,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: Container(
                            margin: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'No. 213, Blue chill Complex,\nVedern street, Rastrofest,\nNewYork, California,\nAmerica - CB 410.',
                              style: styleContent,
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            AppConstants.INVOICE,
                            style: getStyleSubHeading(context)
                                .copyWith(color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'TRN #',
                              style: styleContent,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '2415848963012',
                              style: styleContent.copyWith(fontWeight: AppFont.fontWeightSemiBold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Divider(
                    color: colorDarkGrey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(AppConstants.ORDER_SUMMARY, style: styleContentTitle),
                ),
                Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Order#',
                            style: styleContent,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Text(
                              '2415848963',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: styleContent.copyWith(fontWeight: AppFont.fontWeightSemiBold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Text(
                          'Order Date',
                          style: styleContent,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.0),
                          child: Text(
                            '02/05/2019',
                            style: styleContent.copyWith(fontWeight: AppFont.fontWeightSemiBold),
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(AppConstants.SHIPPING_ADDRESS, style: styleContentTitle),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'No. 213, Blue chill Complex, Vedern street, Rastrofest, NewYork, California, America - CB 410.',
                    style: styleContent,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14.0, right: 14.0, top: 16.0, bottom: 16.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    color: colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: _buildListProduct(context, lstPurchasedProducts),
                      ),
                    ),
                  ),
                ),
                buildButtonCallUs(),
              ],
            ),
          ),
        ));
  }

  Widget _buildAppbar() {
    return AppBar(
        elevation: 3.0,
        centerTitle: true,
        title: Text(AppConstants.INVOICE, style: getAppBarTitleTextStyle(context)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    AppCustomIcon.icon_cart,
                    size: 18.0,
                  ),
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
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: colorBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]);
  }

  List<Widget> _buildListProduct(BuildContext context, List<ItemProduct> lstPurchasedProducts) {
    List<Widget> lstProduct = [];
    lstProduct = lstPurchasedProducts.map<Widget>((item) {
      return _buildPurchasedProductListCard(context, item);
    }).toList();
    //build header
    lstProduct.insert(0, _buildTableHeader(context));
    //build Payment methods
    lstProduct.add(_buildTilePayment('Payment Method', 'Card'));
    lstProduct.add(_buildTilePayment('Consolidate Delivery', '\$7.00'));
    lstProduct.add(_buildTilePayment('Sub Total', '\$250.00'));
    lstProduct.add(_buildTilePayment('Shipping', '\$10.00'));
    lstProduct.add(_buildTilePayment('Tax', '\$5.00', addDivider: true));
    lstProduct.add(_buildTilePayment('OrderTotal', '\$265.00'));
    return lstProduct;
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      color: colorGrey,
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 16.0),
      child: Row(
        children: <Widget>[
          _buildItemCardTitle(context, AppConstants.PRODUCTS, nFlex: 5),
          _buildItemCardTitle(context, AppConstants.QUANTITY, nFlex: 3, isMiddleTitle: true),
          _buildItemCardTitle(context, AppConstants.PRICE, nFlex: 2),
        ],
      ),
    );
  }

  Widget _buildItemCardTitle(context, String title,
      {int nFlex: 1, bool isContentText: false, bool isMiddleTitle: false}) {
    return Expanded(
        flex: nFlex,
        child: Text(
          title,
          style: getStyleBody1(context).copyWith(
              color: isContentText ? colorDarkGrey : colorBlack,
              fontWeight: isContentText ? FontWeight.normal : AppFont.fontWeightSemiBold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: isMiddleTitle ? TextAlign.center : TextAlign.start,
        ));
  }

  Widget _buildPurchasedProductListCard(BuildContext context, ItemProduct item) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Center(
                          child: Image.asset(
                            item.imageUrl,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Container(
                          margin: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Lenin Red 54899',
                                style: getStyleCaption(context)
                                    .copyWith(color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'The Product is excellent, cheap, best worth.',
                                  style: getStyleCaption(context)
                                      .copyWith(color: colorBlack, fontWeight: AppFont.fontWeightMedium),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '1000',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: getStyleBody1(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '\$100.00',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getStyleBody1(context).copyWith(color: colorBlack),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Divider(
            height: 1.0,
            color: colorDarkGrey,
          )
        ],
      ),
    );
  }

  Widget _buildTilePayment(String stValue1, String stValue2, {bool addDivider = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 8.0,
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Text(
                    stValue1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: getStyleBody1(context),
                  )),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  stValue2,
                  textAlign: TextAlign.right,
                  style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
                ),
              )
            ],
          ),
          addDivider
              ? Row(
                  children: <Widget>[
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Divider(
                          height: 1.0,
                          color: colorDarkGrey,
                        ),
                      ),
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  Widget buildButtonCallUs() {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  "Call Us at 1-800-652-2458",
                  style: getStyleButtonText(context),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                color: colorPrimary,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        AppCustomIcon.icon_24hrs,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Icon(AppCustomIcon.icon_free_shipping, size: 30),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Icon(AppCustomIcon.icon_100_guarantee, size: 30),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Icon(AppCustomIcon.icon_return, size: 30),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Customer Service',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Free Shipping',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Satisfaction Gauranteed',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Easy return',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: getStyleCaption(context).copyWith(color: colorBlack),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
