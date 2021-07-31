import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/request_response/product_review/product_review_response.dart';
import 'package:thought_factory/core/notifier/product_review_notifier.dart';
import 'package:thought_factory/ui/menu/product_review/product_review_detail_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_star_rating.dart';
import 'package:thought_factory/utils/app_text_style.dart';

class ProductReviewScreen extends StatefulWidget {
  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  final cornerRadius = 5.0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductReviewNotifier>(
      create: (context) => ProductReviewNotifier(context),
      child: Consumer<ProductReviewNotifier>(
        builder: (context, productReviewNotifier, _) => ModalProgressHUD(
            inAsyncCall: productReviewNotifier.isLoading,
            child: (productReviewNotifier.productReviewList != null &&
                    productReviewNotifier.productReviewList.length > 0)
                ? buildListProductReview(
                    productReviewNotifier.productReviewList)
                : (productReviewNotifier.isLoading)
                    ? Container()
                    : Container(
                        child: Center(
                          child: Text(productReviewNotifier.message),
                        ),
                      )),
      ),
    );
  }

  ListView buildListProductReview(List<ProductReviewItem> items) {
    return ListView.builder(
      shrinkWrap: true,
      padding:
          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      itemBuilder: (context, index) {
        return buildListItemReview(context, index, items);
      },
      itemCount: items.length,
    );
  }

  Widget buildListItemReview(
    context,
    int index,
    List<ProductReviewItem> items,
  ) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 4.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: buildProductImage(index, items),
              ),
              Expanded(
                flex: 3,
                child: buildProductReviewInfo(context, items, index),
              )
            ],
          ),
        ),
      ),
      onTap: () => onTapped(index, items),
    );
  }

  Widget buildProductImage(index, List<ProductReviewItem> items) {
    return AspectRatio(
      aspectRatio: 1.0 / 1.2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cornerRadius),
                bottomLeft: Radius.circular(cornerRadius)),
            color: colorGrey,
          ),
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (items[index].productImage != null &&
                          items[index].productImage != "")
                      ? CachedNetworkImage(
                          imageUrl:
                              AppUrl.baseImageUrl + items[index].productImage)
                      : Image.asset("assets/logo_thought_factory.png")))),
    );
  }

  Widget buildProductReviewInfo(
      context, List<ProductReviewItem> items, int index) {
    return Container(
      padding:
          EdgeInsets.only(left: 8.0, top: AppConstants.SIDE_MARGIN, right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
              bottom: 8.0,
            ),
            child: AutoSizeText(
              items[index].name ?? '',
              maxLines: 2,
              style: getStyleSubHeading(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              items[index].detail ?? '',
              maxLines: 2,
              style: getStyleCaption(context).copyWith(
                  color: colorBlack, fontWeight: AppFont.fontWeightMedium),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          /*Container(
            margin: EdgeInsets.only(top: 8.0),
            alignment: Alignment.bottomLeft,
            child: AppStarRating(
              starCount: 5,
              size: 20,
              color: colorYellow,
              rating: (items[index].ratingDetails[0].value != "")
                  ? double.parse(items[index].ratingDetails[0].value)
                  : 0,
            ),
          )*/
        ],
      ),
    );
  }

  onTapped(int index, List<ProductReviewItem> items) {
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => ProductReviewDetailScreen(index)));
    Navigator.pushNamed(context, ProductReviewDetailScreen.routeName,
        arguments: items[index]);
  }
}
