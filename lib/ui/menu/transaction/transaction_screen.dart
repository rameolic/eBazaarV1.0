import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
          child: Column(
        children: <Widget>[
          buildTableHeader(context),
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: buildItemContent(context),
                    onTap: () {
                      print('Clicked Item Index : $index');
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(
                      color: colorDarkGrey,
                    )),
                itemCount: 20),
          )
        ],
      )),
    );
  }

  ClipRRect buildTableHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
      child: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
        color: colorGrey,
        child: Row(
          children: <Widget>[
            buildItemTitle(context, 'Card'),
            buildItemTitle(context, 'Date'),
            buildItemTitle(context, 'Narration'),
            buildItemTitle(context, 'Amount', isLastTitle: true)
          ],
        ),
      ),
    );
  }

  Expanded buildItemTitle(context, String title, {bool isContentText: false, bool isLastTitle: false}) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Text(
        title,
        style: getStyleCaption(context).copyWith(
            color: isContentText ? colorDarkGrey : colorBlack,
            fontWeight: isContentText ? FontWeight.normal : AppFont.fontWeightMedium),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: isLastTitle ? TextAlign.end : TextAlign.start,
      ),
    ));
  }

  Container buildItemContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 8.0),
      color: colorWhite,
      child: Row(
        children: <Widget>[
          buildItemTitle(context, 'MasterCard', isContentText: true),
          buildItemTitle(context, '30/04/2019', isContentText: true),
          buildItemTitle(context, 'seller', isContentText: true),
          buildItemTitle(context, '\$260.00', isContentText: true, isLastTitle: true)
        ],
      ),
    );
  }
}
