import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_response.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';
import 'package:thought_factory/utils/common_widgets/app_bar.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/dummy/dummy_list.dart';
import 'package:thought_factory/core/notifier/add_newcard_notifier.dart';
import 'package:thought_factory/core/model/add_new_card.dart';

class AddNewCardScreen extends StatefulWidget {
  static const routeName = '/add_new_card_screen';

  @override
  AddNewCardScreenState createState() => AddNewCardScreenState();
}

class AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextEditingController _textCardNumber = TextEditingController();
  final TextEditingController _textCardHolderName = TextEditingController();
  final TextEditingController _textCvv = TextEditingController();

  final FocusNode _focusNodeCardHolderName = FocusNode();
  final FocusNode _focusNodeCvv = FocusNode();

  double captionAndTextFieldDistance = 6.0;
  double textFieldAndCaptionDistance = 12.0;
  final _keyForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedMonth;
  var selectedYear;
  //final List<String> initialMonth = getListMonth();
  final List<String> _yearsList = getListYear();
  final List _monthList = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  TextStyle textFieldStyle;
  double radiusValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddNewCardNotifier>(
      create: (context) => AddNewCardNotifier(
        context,
      ),
      child: Consumer<AddNewCardNotifier>(
        builder: (BuildContext context, stateAddNewCard, _) => ModalProgressHUD(
          inAsyncCall: stateAddNewCard.isLoading,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: buildAppBar(context, '0', AppConstants.ADD_NEW_CARD),
            body: _buildAddNewCardForm(context),
            bottomNavigationBar: buildBottomButtons(context, stateAddNewCard),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthList() {
    return DropdownButtonHideUnderline(
      child: Container(
        //width: MediaQuery.of(context).size.width * 0.83,
        // height: 40,
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(25.0),
//            border: Border.all(color: Theme.of(context).focusColor)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: DropdownButton(
            style: textFieldStyle,
            hint: Text(
              'Select',
              // style: Theme.of(context).textTheme.overline,
              style: getAppFormTextStyle(context),
            ),
            value: selectedMonth,
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
            items: _monthList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  //style: getAppFormTextStyle(context),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildYearsList() {
    return DropdownButtonHideUnderline(
      child: Container(
        //width: MediaQuery.of(context).size.width * 0.83,
        // height: 40,
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(25.0),
//            border: Border.all(color: Theme.of(context).focusColor)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: DropdownButton(
            style: textFieldStyle,
            hint: Text(
              'Select',
              // style: Theme.of(context).textTheme.overline,
              style: getAppFormTextStyle(context),
            ),
            value: selectedYear,
            onChanged: (value) {
              setState(() {
                selectedYear = value;
              });
            },
            items: _yearsList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  //style: getAppFormTextStyle(context),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewCardForm(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _buildScreenContent(context),
        ],
      ),
    );
  }

  Widget _buildScreenContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(top: 8.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              buildAddNewCardSession(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddNewCardSession(BuildContext context) {
    textFieldStyle =
        getStyleTitle(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildVerticalSpace(16),
        Text(
          'Edit Saved Card',
          style: getStyleSubHeading(context)
              .copyWith(fontWeight: AppFont.fontWeightSemiBold),
          textAlign: TextAlign.start,
        ),
        _buildVerticalSpace(16),

        // Card Number
        buildSmallCaption('Card Number ', context),
        _buildVerticalSpace(captionAndTextFieldDistance),
        TextFormField(
          controller: _textCardNumber,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          style: textFieldStyle,
          maxLines: 1,
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(_focusNodeCardHolderName);
          },
          validator: (value) => validateEmptyCheck(
              value, "${AppConstants.CARD_NUMBER} can\'t be empty"),
          decoration: _buildTextDecoration(),
        ),
        _buildVerticalSpace(textFieldAndCaptionDistance),

        // Card Holder Name
        /* buildSmallCaption('Card Holder Name ', context),
        _buildVerticalSpace(captionAndTextFieldDistance),
        TextFormField(
          controller: _textCardHolderName,
          keyboardType: TextInputType.text,
          focusNode: _focusNodeCardHolderName,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          style: textFieldStyle,
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(_focusNodeCvv);
          },
          validator: (value) => validateEmptyCheck(
              value, "${AppConstants.CARD_HOLDER_NAME} can\'t be empty"),
          decoration: _buildTextDecoration(),
        ),*/
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
                          left: 0.0, right: 16.0, top: 2.0, bottom: 2.0),
//                      child: DropdownButtonHideUnderline(
////
//                        child: ButtonTheme(
//                          alignedDropdown: true,
//                          child: DropdownButton(
//                            style: textFieldStyle,
//                            iconEnabledColor: colorDarkGrey,
//                            icon: Icon(Icons.keyboard_arrow_down),
//                            value: 1,
//                            items: <DropdownMenuItem<int>>[
//                              DropdownMenuItem(
//                                child: new Text('06'),
//                                value: 0,
//                              ),
//                              DropdownMenuItem(
//                                child: new Text('07'),
//                                value: 1,
//                              ),
//                              DropdownMenuItem(
//                                child: new Text('08'),
//                                value: 2,
//                              ),
//                              DropdownMenuItem(
//                                child: new Text('09'),
//                                value: 2,
//                              ),
//                            ],
//                            onChanged: (dynamic value) {
//                              //  stateEditProfile.countryNumber = value;
//                            },
//                          ),
//                        ),
//                      ),
                      child: _buildMonthList(),
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
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 0.0, right: 16.0, top: 2.0, bottom: 2.0),
                      child: _buildYearsList(),
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
          ],
        ),

        _buildVerticalSpace(textFieldAndCaptionDistance),

        // CVV
        buildSmallCaption('CVV ', context),
        _buildVerticalSpace(captionAndTextFieldDistance),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _textCvv,
                  focusNode: _focusNodeCvv,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  validator: (value) => validateEmptyCheck(
                      value, "${AppConstants.CVV} can\'t be empty"),
                  style: textFieldStyle,
                  //decoration: _buildTextDecoration(),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none))),
                ),
                flex: 9,
              ),
              Expanded(
                child: Icon(
                  Icons.help_outline,
                  color: colorDarkGrey,
                ),
                flex: 1,
              )
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
      BuildContext context, AddNewCardNotifier stateAddNewCard) {
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
                AppConstants.ADD,
                style: getStyleButtonText(context),
              ),
              onPressed: () {
                if (_keyForm.currentState.validate()) {
                  CardInfo cardInfo = CardInfo();
                  cardInfo.cardholderName = _textCardHolderName.text;
                  cardInfo.cardno = _textCardNumber.text;
                  cardInfo.cvv = _textCvv.text;
                  cardInfo.expmonth = selectedMonth;
                  cardInfo.expyear = selectedYear;

                  _onClickUpdateNewCard(stateAddNewCard, cardInfo);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
        /* Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 16, bottom: 36.0),
            width: double.infinity,
            child: RaisedButton(
              color: colorLightGrey,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                AppConstants.MAKE_DEFAULT,
                style: getStyleButtonText(context),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),*/

        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 16, bottom: 36.0),
            width: double.infinity,
            child: RaisedButton(
              color: colorLightGrey,
              textColor: Colors.white,
              elevation: 3.0,
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                AppConstants.CANCEL,
                style: getStyleButtonText(context),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
        ),
      ],
    );
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

  Future<void> _onClickUpdateNewCard(
      AddNewCardNotifier newcardNotifier, CardInfo cardInfo) async {
    await newcardNotifier.callApiAddNewReCord(context, cardInfo).then((value) {
      postFormResponse(value);
    });
  }

  postFormResponse(AddNewCardResponse response) {
    if (response.status != 0) {
      _showSnackBarMessage(response.message);
      Navigator.pop(context, true);
    } else {
      _showSnackBarMessage(response.cardMessage);
    }
  }

  _showSnackBarMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
