import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/dummy_products_list.dart';
import 'package:thought_factory/utils/widgetHelper/custom_expendable_widget.dart';


class ReviewScreen extends StatefulWidget {
  static const routeName = '/review_screen';

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  bool isAndroid;
  final cornerRadius = 5.0;
  final listQty = ['1', '2', '3', '4'];
  String selectedQty = "";
  final lstPurchasedProducts = getDummyListProducts(2);

  int selectedG1Radio;
  bool thirdPartyRadioIsExpanded = true;
  int selectedG2Radio;

  @override
  void initState() {
    super.initState();
    selectedQty = this.listQty[0];
    selectedG1Radio = 2;
    selectedG2Radio = 1;
  }

  @override
  Widget build(BuildContext context) {
    isAndroid = checkPlatForm(context);

    TextStyle styleForLabel = getStyleSubHeading(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);

    return Scaffold(
        backgroundColor: colorGrey,
        appBar: _buildAppbar(),
        body: Container(
          color: colorGrey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _buildLabel(context, AppConstants.CONTACT_DETAILS, styleForLabel),
                  _buildContactDetailInfo(context),
                  _buildButtonChangeOrAddAddresss(context),
                  _buildLabel(context, AppConstants.PRODUCT_DETAILS, styleForLabel),
                  _buildListReviewProduct(context),
                  _buildDeliveryType(context, styleForLabel),
                  _buildButtonProceedToCheckOut(context)
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildAppbar() {
    return AppBar(
        elevation: 3.0,
        centerTitle: true,
        title: Text(AppConstants.REVIEW, style: getAppBarTitleTextStyle(context)),
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

  Widget _buildContactDetailInfo(context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        child: RichText(
          text: TextSpan(
              text: 'S M Steve Smith\n',
              style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
              children: <TextSpan>[
                TextSpan(text: '\n'),
                TextSpan(
                    text:
                        'No. 54/54, Venderno Street, Blue Hills. Newyork, California, UnitedStates - 745696\n+41 58796 36475',
                    style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightMedium))
              ]),
        ),
      ),
    );
  }

  Widget _buildButtonChangeOrAddAddresss(context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 16.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Change or Add Address",
          style: getStyleButtonText(context),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        color: colorPrimary,
        padding: EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }

  Widget _buildListReviewProduct(context) {
    return Column(
      children: lstPurchasedProducts.map((item) => _buildTileProduct()).toList(),
    );
  }

  Widget _buildTileProduct() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Card(
        color: colorGrey,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildProductImage(),
            ),
            Expanded(
              flex: 3,
              child: _buildProductInfo(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return AspectRatio(
      aspectRatio: 1.0 / 1.2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(cornerRadius), bottomLeft: Radius.circular(cornerRadius)),
            color: colorGrey,
          ),
          child: Icon(
            FontAwesomeIcons.tshirt,
            color: colorPrimary,
          )),
    );
  }

  Widget _buildProductInfo(context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                'Lenin Red 54899 ',
                maxLines: 1,
                style: getWLProductNameTextStyle(context),
                overflow: TextOverflow.ellipsis,
              )),
              Material(
                color: colorWhite,
                child: InkWell(
                  splashColor: colorPrimary,
                  onTap: () {},
                  child: Icon(
                    Icons.clear,
                    color: colorDarkGrey,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text('\$25.75', style: getWLProductAmtTextStyle(context)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '\$35.75',
                  style: getWLProductStrikeAmtTextStyle(context),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              '20% off',
              style: getWLProductOfferAmtTextStyle(context),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                'Seller ',
                style: getStyleCaption(context).copyWith(color: colorBlack),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'A2B Shoppie',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getStyleCaption(context).copyWith(color: colorPrimary, fontWeight: AppFont.fontWeightSemiBold),
                ),
              ),
              Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    height: 30,
                    padding: EdgeInsets.only(left: 8.0, right: 4.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          value: selectedQty,
                          items: listQty.map((String nQty) {

                            return DropdownMenuItem(
                                value: nQty,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Qty : ',
                                      style: getWLQtyLabelTextStyle(context),
                                      children: <TextSpan>[TextSpan(text: '$nQty', style: getWLQtyTextStyle(context))]),
                                ));
                          }).toList(),
                          onChanged: (selectedValue) {
                            setState(() {
                              this.selectedQty = selectedValue;
                            });
                          }),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeliveryType(context, TextStyle styleForLabel) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
          padding: EdgeInsets.only(left: 8.0, top: 16.0, right: 16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _buildLabel(context, AppConstants.DELIVERY_TYPE, styleForLabel),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: selectedG1Radio,
                        onChanged: (val) {
                          print('Radio val $val');
                          onClickDeliveryTypeRadio(val);
                        }),
                    Text('Distributor Delivery'),
                    Expanded(
                        child: Text(
                      '\$10.00',
                      textAlign: TextAlign.right,
                      style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
                    ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: selectedG1Radio,
                        onChanged: (val) {
                          print('Radio val $val');
                          onClickDeliveryTypeRadio(val);
                        }),
                    Text('Third Party Delivery')
                  ],
                ),
              ),
              CustomExpandableContainer(context: context, childWidget: _buildThirdPartyShippingExpenderBody(context), duration: 500, expand: thirdPartyRadioIsExpanded),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: _buildLabel(context, AppConstants.FLAT_RATE, styleForLabel),
              ),
              _buildFlatRateSubTile('Sub Total', '\$250.00'),
              _buildFlatRateSubTile('Shipping', '\$10.00'),
              _buildFlatRateSubTile('Tax', '\$5.00'),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Divider(
                  height: 1,
                  color: colorDarkGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildFlatRateSubTile('Order Total', '\$265.00'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlatRateSubTile(String stName, String stAmt) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 16),
      child: Row(
        children: <Widget>[
          Text(stName),
          Expanded(
              child: Text(
            stAmt,
            textAlign: TextAlign.right,
            style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
          ))
        ],
      ),
    );
  }

  onClickDeliveryTypeRadio(val) {
    setState(() {
      if(val == 1){
        thirdPartyRadioIsExpanded = false;
      }else{
        thirdPartyRadioIsExpanded = true;
      }
      selectedG1Radio = val;
    });
  }

  onClickThirdPartyDlyChildRadio(val) {
    setState(() {
      selectedG2Radio = val;
    });
  }

  Widget _buildButtonProceedToCheckOut(context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 16.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Proceed to checkout",
          style: getStyleButtonText(context),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        color: colorPrimary,
        padding: EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }

  Widget _buildThirdPartyShippingExpenderBody(context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 32.0),
          child: Row(
            children: <Widget>[
              Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: 1,
                  groupValue: selectedG2Radio,
                  onChanged: (val) {
                    print('Radio val $val');
                    onClickThirdPartyDlyChildRadio(val);
                  }),
              Text('Direct Delivery'),
              Expanded(
                  child: Text(
                    '\$5.00',
                    textAlign: TextAlign.right,
                    style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
                  ))
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 32.0),
          child: Row(
            children: <Widget>[
              Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: 2,
                  groupValue: selectedG2Radio,
                  onChanged: (val) {
                    print('Radio val $val');
                    onClickThirdPartyDlyChildRadio(val);
                  }),
              Text('Consolidate Delivery'),
              Expanded(
                  child: Text(
                    '\$5.00',
                    textAlign: TextAlign.right,
                    style: getStyleBody1(context).copyWith(fontWeight: AppFont.fontWeightSemiBold),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
