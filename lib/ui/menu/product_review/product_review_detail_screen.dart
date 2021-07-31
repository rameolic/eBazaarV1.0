import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/product_review/product_review_response.dart';
import 'package:thought_factory/core/notifier/product_review_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_star_rating.dart';
import 'package:thought_factory/utils/app_text_style.dart';

class ProductReviewDetailScreen extends StatefulWidget {
  static const routeName = '/product_review_detail_screen';

  @override
  ProductReviewScreenState createState() => ProductReviewScreenState();
}

class ProductReviewScreenState extends State<ProductReviewDetailScreen> {
  bool isAndroid;
  double itemCardRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    isAndroid = checkPlatForm(context);
    final ProductReviewItem productReviewItem =
        ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => ProductReviewNotifier(context),
      child: Scaffold(
        backgroundColor: colorGrey,
        appBar: _buildAppbar(),
        body: Consumer<ProductReviewNotifier>(
            builder: (BuildContext context, productReviewNotifier, _) =>
                _buildContentPage(context, productReviewItem)),
        //   bottomNavigationBar: buildBotton(),
      ),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      elevation: 3.0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            onBackPress();
          },
          child: Icon(Icons.arrow_back_ios)),
      title: Text('Product Review', style: getAppBarTitleTextStyle(context)),
      /*actions: <Widget>[
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
        ]*/
    );
  }

  Widget _buildContentPage(
      BuildContext context, ProductReviewItem productReviewItem) {
    return SingleChildScrollView(
      child: Container(
        color: colorGrey,
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              productReviewItem.name + "${" Product Review"}",
              style: getStyleSubHeading(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
            ),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0))),
              margin: EdgeInsets.only(top: 20.0),
              child: Container(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: (productReviewItem.ratingDetails != null)
                    ? buildListProductReview(productReviewItem.ratingDetails)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "No Reviews Found",
                            textAlign: TextAlign.center,
                            style: getStyleSubHeading(context),
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Product Detail",
              style: getStyleSubHeading(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              child: Card(
                color: colorWhite,
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(itemCardRadius))),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 12.0, top: 12, bottom: 12, right: 12),
                  child: buildRowItem(productReviewItem, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(
      ProductReviewItem productReviewItem, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: (productReviewItem.detail != "" &&
                            productReviewItem.detail != null)
                        ? _buildTextLabel(productReviewItem.detail, context)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "No Details Found",
                                textAlign: TextAlign.center,
                                style: getStyleSubHeading(context),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  ListView buildListProductReview(List<RatingDetails> ratingDetails) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding:
          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
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
                          _buildTextLabel(
                              ratingDetails[index].ratingCode, context),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          //Icon(Icons.brightness_1, color: Colors.orange, size: 14.0,),
                          SizedBox(
                            height: 10.0,
                          ),
                          AppStarRating(
                            starCount: 5,
                            size: 24,
                            color: colorYellow,
                            rating: (ratingDetails[index].value != null &&
                                    ratingDetails[index].value != "")
                                ? double.parse(ratingDetails[index].value)
                                : 0.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      },
      itemCount: ratingDetails.length,
    );
  }

  Widget buildBotton() {
    return Container(
      height: 110,
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 10.0),
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                onBackPress();
              },
              child: Text(
                " Submit ",
                style: getStyleButtonText(context),
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

  void onBackPress() {
    Navigator.of(context).pop();
  }

  Widget _buildTextLabel(String content, BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.start,
      style: getStyleSubHeading(context),
    );
  }
}
