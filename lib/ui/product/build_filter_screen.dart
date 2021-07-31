import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/model/filter/filter_state_model.dart';
import 'package:thought_factory/core/notifier/build_filter_notifier.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/router.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class BuildFilterScreen extends StatefulWidget {
  static const routeName = '/filter_screen';
  final log = getLogger('ProductListScreen');

  @override
  BuildFilterScreenState createState() => BuildFilterScreenState();
}

class BuildFilterScreenState extends State<BuildFilterScreen> {
  String categoryId;
  double cardRadius = 6.0;
  double _lower = 20.0;
  double _upper = 70.0;

  @override
  Widget build(BuildContext context) {
    categoryId = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<BuildFilterNotifier>(
      create: (context) => BuildFilterNotifier(context, categoryId),
      child: Consumer<BuildFilterNotifier>(
          builder: (BuildContext context, buildFilterNotifier, _) => Scaffold(
                backgroundColor: colorGrey,
                appBar: _buildAppbar(),
                body: ModalProgressHUD(
                    inAsyncCall: buildFilterNotifier.isLoading,
                    child: _buildPageContent(buildFilterNotifier, context)),
                bottomNavigationBar: buildBottom(buildFilterNotifier, context),
              )),
    );
  }

  Widget _buildPageContent(
      BuildFilterNotifier buildFilterNotifier, BuildContext context) {
    double height = getScreenHeight(context);
    //var stateFilter = Provider.of<StateFilter>(context);
    //stateFilter.selectedFilterItem = AppConstants.PRICE;

    return (buildFilterNotifier.isLoading)
        ? Container(child: Text('Loading...'))
        : Container(
            color: colorGrey,
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 15.0, bottom: 16.0),
            child: Column(
              children: <Widget>[
                Card(
                  color: colorWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(cardRadius))),
                  child: Container(
                    height: height / 1.6,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 0, bottom: 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 8, top: 16.0, bottom: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    _buildFilterItemsList(
                                        context, buildFilterNotifier)
                                  ],
                                ),
                              )),
                          Container(
                            width: 1.0,
                            color: colorGrey,
                          ),
                          Expanded(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 0, top: 16.0, bottom: 16.0),
                                //child: Column(
                                //  children: <Widget>[
                                child: _buildItemContentScreen(
                                    buildFilterNotifier, context),
                                //  ],
                                //),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildFilterItemsList(
      BuildContext context, BuildFilterNotifier profileFilterNotifier) {
    return ListView(
      shrinkWrap: true,
      key: PageStorageKey(0),
      children:
          profileFilterNotifier.filterStateModel.listFilterMenu.map((item) {
        return _buildFilterItemOption(context, item);
      }).toList(),
    );
  }

  Widget _formMenuOptions(BuildContext context, ItemContent item) {
    Widget widget;
    switch (item.name) {
      /*case AppConstants.PRICE :
        if(this.stateFilter.priceAvailable){
          widget = _buildFilterItemOption(context, item);
        } break;
      case AppConstants.BRAND :
        if(this.stateFilter.brandAvailable){
          widget = _buildFilterItemOption(context, item);
        } break;
      case AppConstants.COLOR :
        if(this.stateFilter.colorAvailable){
          widget = _buildFilterItemOption(context, item);
        } break;
      case AppConstants.SIZE :
        if(this.stateFilter.sizeAvailable){
          widget = _buildFilterItemOption(context, item);
        } break;
      default :
        return null;*/

    }
    return widget;
  }

  Widget _buildFilterItemOption(BuildContext context, ItemContent item) {
    //return null;
    return Consumer<BuildFilterNotifier>(
      builder: (context, productFilterNotifier, _) => Material(
          color: colorWhite,
          child: InkWell(
            splashColor: colorPrimary,
            onTap: () {
              //close navigation drawer
              productFilterNotifier.selectedFilterItem = item.name;
              log.d(productFilterNotifier.selectedFilterItem);
              productFilterNotifier.loadSubItemsListData();
            },
            child: Container(
              decoration: productFilterNotifier.selectedFilterItem == item.name
                  ? BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 3.0, color: colorPrimary)),
                      gradient: LinearGradient(
                          colors: [colorAccentMild, colorWhite],
                          begin: Alignment.centerLeft,
                          end: Alignment(1.0, 0.0)))
                  : null,
              child: Text(
                item.name,
                style: getStyleBody2(context).copyWith(
                  color: productFilterNotifier.selectedFilterItem == item.name
                      ? colorPrimary
                      : null,
                  fontWeight:
                      productFilterNotifier.selectedFilterItem == item.name
                          ? AppFont.fontWeightSemiBold
                          : AppFont.fontWeightRegular,
                ),
              ),
              padding: EdgeInsets.only(
                  left: 12.0, right: 8.0, top: 8.0, bottom: 8.0),
            ),
          )),
    );
  }

  Widget _buildItemContentScreen(
      BuildFilterNotifier buildFilterNotifier, BuildContext context) {
    switch (buildFilterNotifier.selectedFilterItem) {
      case AppConstants.PRICE:
        return _buildPriceTab(context, buildFilterNotifier);
      default:
        return _buildFilterItem(buildFilterNotifier, context);
    }
  }

  Widget _buildPriceTab(
      BuildContext context, BuildFilterNotifier buildFilterNotifier) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "min ${buildFilterNotifier.currencySymbol} \n ${buildFilterNotifier.filterStateModel.filterPriceItemModel.selectedMinValue.toStringAsFixed(2)}",
                      style: getStyleCaption(context)
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      "max ${buildFilterNotifier.currencySymbol} \n ${buildFilterNotifier.filterStateModel.filterPriceItemModel.selectedMaxValue.toStringAsFixed(2)}",
                      style: getStyleCaption(context)
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                ],
              )),
          frs.RangeSlider(
            min: buildFilterNotifier
                .filterStateModel.filterPriceItemModel.minValue,
            max: buildFilterNotifier
                .filterStateModel.filterPriceItemModel.maxValue,
            lowerValue: buildFilterNotifier
                .filterStateModel.filterPriceItemModel.selectedMinValue,
            upperValue: buildFilterNotifier
                .filterStateModel.filterPriceItemModel.selectedMaxValue,
            showValueIndicator: true,
            valueIndicatorMaxDecimals: 1,
            onChanged: (double newLowerValue, double newUpperValue) {
              setState(() {
                buildFilterNotifier.filterStateModel.filterPriceItemModel
                    .selectedMinValue = newLowerValue;
                buildFilterNotifier.filterStateModel.filterPriceItemModel
                    .selectedMaxValue = newUpperValue;
              });
            },
            allowThumbOverlap: true,
            //divisions: 20,
            touchRadiusExpansionRatio: 3,
            valueIndicatorFormatter: (int index, double value) {
              String twoDecimals = value.toStringAsFixed(2);
              return '$twoDecimals ${buildFilterNotifier.currencySymbol}';
            },
          )
        ],
      ),
    );
  }

  Widget _buildFilterItem(
      BuildFilterNotifier buildFilterNotifier, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        ListView.builder(
            padding: EdgeInsets.only(left: 16.0),
            shrinkWrap: true,
            itemCount: buildFilterNotifier.subItemsList.length,
            itemBuilder: (context, index) => Row(
                  children: <Widget>[
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: buildFilterNotifier.subItemsList[index].isSelected,
                      onChanged: (bool value) {
                        buildFilterNotifier
                            .allItemsList[buildFilterNotifier.allItemsList
                                .indexOf(
                                    buildFilterNotifier.subItemsList[index])]
                            .isSelected = value;
                        setState(() {
                          buildFilterNotifier.subItemsList[index].isSelected =
                              value;
                        });
                      },
                    ),
                    Text(
                      buildFilterNotifier.subItemsList[index].display,
                      style: buildFilterNotifier.subItemsList[index].isSelected
                          ? getStyleBody2(context)
                          : getStyleBody1(context),
                      overflow: TextOverflow.fade,
                    )
                  ],
                ))
      ],
    );
  }

  Widget _buildColorTab(BuildContext context) {
    return Text("This is Color");
  }

  Widget _buildSizeTab(BuildContext context) {
    return Text("This is Size");
  }

  Widget _buildAppbar() {
    return AppBar(
      elevation: 3.0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          )),
      title: Text(
        "Filter",
        style: getAppBarTitleTextStyle(context),
      ),
    );
  }

  Widget buildBottom(
      BuildFilterNotifier buildFilterNotifier, BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(bottom: 16.0),
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  _onPressButtonApply(buildFilterNotifier);
                },
                child: Text(
                  AppConstants.APPLY,
                  style: getStyleButtonText(context),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                color: colorPrimary,
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  buildFilterNotifier.resetFilter();
                  //_onPressButtonReset(buildFilterNotifier);
                },
                child: Text(
                  AppConstants.RESET,
                  style: getStyleButtonText(context),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                color: colorLightGrey,
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  void _onPressButtonApply(BuildFilterNotifier buildFilterNotifier) {
    buildFilterNotifier.filterStateModel.itemsModelList =
        buildFilterNotifier.allItemsList;
    Navigator.pop(context, 1);
  }
}
