import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thought_factory/ui/menu/manage_payment/add_new_card_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/core/notifier/manage_payment_list_notifier.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';

class ManagePaymentScreen extends StatefulWidget {
  @override
  _ManagePaymentScreenState createState() => _ManagePaymentScreenState();
}

class _ManagePaymentScreenState extends State<ManagePaymentScreen> {
  String customerName;

  @override
  void initState() {
    super.initState();
    _getCustomerName(); //method
  }

  _getCustomerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerName = (prefs.getString(AppConstants.KEY_CUSTOMER_NAME) ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagePaymentListNotifier>(
      create: (context) => ManagePaymentListNotifier(context),
      child: Consumer<ManagePaymentListNotifier>(
          builder: (BuildContext context, notifier, _) => ModalProgressHUD(
                inAsyncCall: notifier.isLoading,
                child: (isShowCardsList(notifier))
                    ? buildListPaymentCards(notifier)
                    : (notifier.isLoading)
                        ? Container()
                        : _buildEmptyScreen(notifier),
              )),
    );
  }

  Widget _buildEmptyScreen(ManagePaymentListNotifier notifier) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text("No Cards found"),
            ),
          ),
          _buildButtonAddNewCard(context, notifier)
        ],
      ),
    );
  }

  bool isShowCardsList(ManagePaymentListNotifier notifier) {
    return (notifier.paymentCardsList != null &&
        notifier.paymentCardsList.length > 0);
  }

  //build list: cards list
  Widget buildListPaymentCards(ManagePaymentListNotifier notifier) {
    List<NewCard> items = notifier.paymentCardsList;
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Saved Cards',
              style: getStyleSubHeading(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 20.0),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return buildItemCardForList(
                          context, colorCard1, items, index, notifier);
                    case 1:
                      return buildItemCardForList(
                          context, colorCard2, items, index, notifier);
                    case 2:
                      return buildItemCardForList(
                          context, colorCard3, items, index, notifier);
                    default:
                      return buildItemCardForList(
                          context, colorFbBlue, items, index, notifier);
                  }
                }),
          ),
          _buildButtonAddNewCard(context, notifier)
        ],
      ),
    );
  }

  //build item: card item
  Widget buildItemCardForList(context, colorRandom, List<NewCard> items,
      int index, ManagePaymentListNotifier addCardsListNotifier) {
    return Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 4.0),
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16.0 / 7.0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [colorRandom.withAlpha(120), colorRandom],
                begin: Alignment(-.5, -2.5),
                end: Alignment.bottomRight,
                stops: [0.1, 0.6],
              )),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.beach_access,
                            color: Colors.red,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Citrus',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: getStyleSubHeading(context)
                                  .copyWith(fontWeight: AppFont.fontWeightBold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(customerName,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: getStyleButton(context)
                                    .copyWith(color: colorWhite)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(items[index].card_no.substring(0, 4),
                                  style: getStyleTitle(context).copyWith(
                                      color: colorWhite,
                                      fontWeight: AppFont.fontWeightMedium))),
                          Expanded(
                              child: Text(
                            items[index].card_no.substring(4, 8),
                            style: getStyleTitle(context).copyWith(
                                color: colorWhite,
                                fontWeight: AppFont.fontWeightMedium),
                          )),
                          Expanded(
                              child: Text(items[index].card_no.substring(8, 12),
                                  style: getStyleTitle(context).copyWith(
                                      color: colorWhite,
                                      fontWeight: AppFont.fontWeightMedium))),
                          Expanded(
                              child: Text(items[index].card_no.substring(12),
                                  style: getStyleTitle(context).copyWith(
                                      color: colorWhite,
                                      fontWeight: AppFont.fontWeightMedium))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                  'Exp' "  " +
                                      items[index].exp_month +
                                      " / " +
                                      items[index].exp_year,
                                  style: getStyleButton(context).copyWith(
                                      color: colorWhite,
                                      fontWeight: AppFont.fontWeightMedium))),
                          InkWell(
                              splashColor: colorPrimary,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Delete Card'),
                                    content: Text(
                                        'Are you sure you want to delete this Card ?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("NO"),
                                        onPressed: () {
                                          //Put your code here which you want to execute on No button click.
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            addCardsListNotifier
                                                .callApiRemoveCardItem(
                                                    items[index].card_id);
                                          }),
                                    ],
                                  ),
                                );
//
                              },
                              child: Icon(
                                Icons.delete,
                                color: colorWhite,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  //build button: add new card
  Widget _buildButtonAddNewCard(
      BuildContext context, ManagePaymentListNotifier notifier) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: double.infinity,
      child: RaisedButton(
        color: colorAccent,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          AppConstants.ADD_NEW_CARD,
          style: getStyleSubHeading(context).copyWith(
              fontWeight: AppFont.fontWeightMedium, color: colorWhite),
        ),
        onPressed: () {
          _openScreenAddNewCard(context, notifier);
          //Navigator.pushNamed(context, PaymentCardScreen.routeName);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  //open screen: AddNewCardScreen
  void _openScreenAddNewCard(context, ManagePaymentListNotifier notifier) {
    Navigator.pushNamed(context, AddNewCardScreen.routeName)
        .then((isCardAddedSuccessfully) {
      if (null != isCardAddedSuccessfully && isCardAddedSuccessfully) {
        notifier.setData();
        notifier.showSnackBarMessageWithContext("Successfully saved"
            " your card Details");
      }
    });
  }
}
