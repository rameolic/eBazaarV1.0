import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/login_screen.dart';
import 'package:thought_factory/ui/main/main_screen.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';

import 'item.dart';
import 'item_content.dart';
import 'item_divider.dart';
import 'item_header.dart';

class MyDrawer extends StatelessWidget {
  final GlobalKey _key;
  StateDrawer _stateDrawer;
  List<Item> drawerData;

  MyDrawer(this._key, StateDrawer stateDrawer) {
    _stateDrawer = stateDrawer;
    if (_stateDrawer.lstCategory != null) {
      //print("lssss ------------> length ${_stateDrawer.lstCategory.length}");
      getListDrawerItem();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final mainModel = Provider.of<StateDrawer>(context);

    return Drawer(
      key: _key,
      child: Container(
        color: colorWhite,
        child: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            key: PageStorageKey(0),
            children: drawerData.map((item) {
              switch (item.getViewType()) {
                case AppConstants.APP_DRAWER_TYPE_HEADER:
                  return _buildItemDrawerHeader(context);

                case AppConstants.APP_DRAWER_TYPE_ITEM:
                  return _buildItemDrawer(context, item);

                case AppConstants.APP_DRAWER_TYPE_DIVIDER:
                  return _buildItemDivider();

                default:
                  return _buildItemDivider();
              }
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItemDrawerHeader(BuildContext context) {
    return Container(
      height: 150,
      color: colorWhite,
      child: DrawerHeader(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [colorPrimary, colorWhite],
                begin: Alignment.topCenter,
                stops: [0.7, 0.4],
                end: Alignment.bottomCenter)),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                  alignment: Alignment(0.0, 0.60),
                  imageUrl: _stateDrawer.imageUrl != null &&
                      _stateDrawer.imageUrl.isNotEmpty
                      ? _stateDrawer.imageUrl
                      : "",
                  imageBuilder: (context, imageProvider) => Container(
                    padding: EdgeInsets.only(top: 28.0),
                    child: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorWhite,
                            width: 2.0,
                          ),
                          boxShadow: [BoxShadow(color: colorLightGrey, spreadRadius: 0.5, blurRadius: 2.0)]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: imageProvider,
                                  fit: BoxFit.scaleDown),
                              //borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                                        border: Border.all(
//                                          color: Colors.transparent,
//                                          width: 1.0,
//                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Icon(
                        AppCustomIcon.icon_white_logo_ebazaar,
                        color: colorWhite,
                        size: 48,
                      ),
                  errorWidget: (context, url, error) =>
                      Icon(
                        AppCustomIcon.icon_white_logo_ebazaar,
                        color: colorWhite,
                        size: 48,
                      )),
            ),
            Align(
                alignment: Alignment(0.0, -0.90),
                child: Text(
                  'Menu',
                  style: getStyleTitle(context).copyWith(
                      color: colorWhite, fontWeight: AppFont.fontWeightBold),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDrawer(BuildContext context, ItemContent item) {
    return Consumer<StateDrawer>(
      builder: (context, state, _) => Material(
        color: colorWhite,
        child: InkWell(
          splashColor: colorPrimary,
          onTap: () {
            //close navigation drawer
            if (item.name == "Logout") {
              _clearUserCredential().whenComplete(() {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName,
                    ModalRoute.withName(MainScreen.routeName));
              });
            } else if (!AppConstants.DRAWER_STABLE_ITEMS_COLLECTIONS
                .contains(item.name)) {
              InfoHomeTap infoHomeTap1 =
                  InfoHomeTap(id: int.parse(item.id), toolBarName: item.name);
              Future.delayed(Duration(milliseconds: 500), () {
                //Navigator.of(context).pop();
                //if(state.selectedDrawerItem == AppConstants.DRAWER_ITEM_HOME) {

                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  } else {
                    print("Error : No Page At back");
                  }
                  state.onValueChange.value = infoHomeTap1;
                //}
//                else {
//                  state.selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
//                  Future.delayed(Duration(milliseconds: 100), (){
//                    state.onValueChange.value = infoHomeTap1;
//                    if (Navigator.canPop(context)) {
//                      Navigator.of(context).pop();
//                    } else {
//                      print("Error : No Page At back");
//                    }
//                  });
//                }

//                Navigator.pushNamed(context, ProductListScreen.routeName,
//                        arguments: infoHomeTap1)
//                    .whenComplete(() {
//                  state.selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
//                });
              });
            } else {
              state.selectedDrawerItem = item.name;
              state.selectedId = item.id;
              state.itemContent = item;
//              Future.delayed(Duration(milliseconds: 500),
//                  () => {Navigator.of(context).pop()});
              Future.delayed(Duration(milliseconds: 500), () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                } else {
                  print("Error : No Page At back");
                }
              });
            }
          },
          child: Container(
            decoration: state.selectedDrawerItem == item.name
                ? BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 3.0, color: colorPrimary),
                    ),
                    gradient: LinearGradient(
                      colors: [colorAccentMild, colorWhite],
                      begin: Alignment.centerLeft,
                      end: Alignment(1.0, 0.0),
                    ),
                  )
                : null,
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                    child: (item.imageIconPath == null
                        ? Icon(
                            item.iconData,
                            color: state.selectedDrawerItem == item.name
                                ? colorPrimary
                                : null,
                            size: 18,
                          )
                        : Image.network(
                            item.imageIconPath,
                            height: 18.0,
                            width: 18.0,
                          ))),
                Text(
                  item.name,
                  style: getStyleSubHeading(context).copyWith(
                      color: state.selectedDrawerItem == item.name
                          ? colorPrimary
                          : null,
                      fontWeight: state.selectedDrawerItem == item.name
                          ? AppFont.fontWeightSemiBold
                          : AppFont.fontWeightRegular),
                ),
              ],
            ),
            padding:
                EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildItemDivider() {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      color: colorWhite,
      child: Divider(
        color: Colors.grey,
      ),
    );
    /*return SizedBox(
      height: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          color: Colors.grey,
        ),
      ),
    );*/
  }

  /*void _handelDrawerItemClick(ItemContent item) {
    //step 1: set pre selected item to false
    (_listDrawerItem
            .where((item) => item is ItemContent)
            .where((item) => (item as ItemContent).isSelected)
            .first as ItemContent)
        ?.isSelected = false;

    //step 2: set current selected item to true & reflect in UI
    setState(() {
      item.isSelected = true;
    });
  }*/

  /*static final List<Item> _listDrawerItem = [
    ItemHeader(),
    ItemContent(
        iconData:AppCustomIcon.drawer_home_outline, name:AppConstants.DRAWER_ITEM_HOME),
    ItemContent(
        iconData:AppCustomIcon.drawer_flow_tree, name:AppConstants.DRAWER_ITEM_DISTRIBUTORS),
    ItemContent(iconData:AppCustomIcon.drawer_shirt, name:AppConstants.DRAWER_ITEM_FASHION),
    ItemContent(iconData:AppCustomIcon.drawer_television,
        name:AppConstants.DRAWER_ITEM_HOME_APPLIANCES),
    ItemContent(iconData: AppCustomIcon.drawer_cosmetics,
        name:AppConstants.DRAWER_ITEM_BEAUTY_AND_PERSONAL_CARE),
    ItemContent(iconData:
        AppCustomIcon.drawer_groceries, name:AppConstants.DRAWER_ITEM_GROCERY),
    ItemDivider(),
    ItemContent(
        iconData:AppCustomIcon.drawer_my_order, name:AppConstants.DRAWER_ITEM_MY_ORDER),
    ItemContent(iconData:AppCustomIcon.drawer_shopping_bag_cart,
        name:AppConstants.DRAWER_ITEM_MY_CART),
    ItemContent(
        iconData:AppCustomIcon.drawer_like_heart, name:AppConstants.DRAWER_ITEM_MY_WISH_LIST),
    ItemContent(
        iconData:AppCustomIcon.drawer_profile_user, name:AppConstants.DRAWER_ITEM_MY_PROFILE),
    ItemContent(
        iconData:AppCustomIcon.drawer_manage_payment,
        name:AppConstants.DRAWER_ITEM_MANAGE_PAYMENT),
    ItemContent(iconData:AppCustomIcon.drawer_review_star,
        name:AppConstants.DRAWER_ITEM_PRODUCT_REVIEW),
//    ItemContent(iconData:AppCustomIcon.drawer_money_transaction,
//        name:AppConstants.DRAWER_ITEM_TRANSACTION),
    ItemDivider(),
    ItemContent(
        iconData:AppCustomIcon.drawer_phone_ring, name:AppConstants.DRAWER_ITEM_CONTACT_US),
    ItemContent(iconData:AppCustomIcon.drawer_terms_condition,
        name:AppConstants.DRAWER_ITEM_TERMS_AND_CONDITION),
    ItemContent(iconData:AppCustomIcon.drawer_privacy_policy,
        name:AppConstants.DRAWER_ITEM_PRIVACY_POLICY),
    ItemContent(iconData:AppCustomIcon.drawer_log_out, name:AppConstants.DRAWER_ITEM_LOGOUT),
  ];*/

  List<Item> getListDrawerItem() {
    //_listDrawerItem.insert(index, element)
    drawerData = [
      ItemHeader(),
      ItemContent(
          iconData: AppCustomIcon.drawer_home_outline,
          name: AppConstants.DRAWER_ITEM_HOME),
      ItemContent(
          iconData: AppCustomIcon.drawer_flow_tree,
          name: AppConstants.DRAWER_ITEM_DISTRIBUTORS),
      /*ItemContent(iconData:AppCustomIcon.drawer_shirt, name:AppConstants.DRAWER_ITEM_FASHION),
      ItemContent(iconData:AppCustomIcon.drawer_television,
          name:AppConstants.DRAWER_ITEM_HOME_APPLIANCES),
      ItemContent(iconData: AppCustomIcon.drawer_cosmetics,
          name:AppConstants.DRAWER_ITEM_BEAUTY_AND_PERSONAL_CARE),
      ItemContent(iconData:
      AppCustomIcon.drawer_groceries, name:AppConstants.DRAWER_ITEM_GROCERY),*/
      ItemDivider(),
      ItemContent(
          iconData: AppCustomIcon.drawer_my_order,
          name: AppConstants.DRAWER_ITEM_MY_ORDER),
      ItemContent(
          iconData: AppCustomIcon.drawer_shopping_bag_cart,
          name: AppConstants.DRAWER_ITEM_MY_CART),
      ItemContent(
          iconData: AppCustomIcon.drawer_like_heart,
          name: AppConstants.DRAWER_ITEM_MY_WISH_LIST),
      ItemContent(
          iconData: AppCustomIcon.drawer_profile_user,
          name: AppConstants.DRAWER_ITEM_MY_PROFILE),
      ItemContent(
          iconData: AppCustomIcon.drawer_manage_payment,
          name: AppConstants.DRAWER_ITEM_MANAGE_PAYMENT),
      ItemContent(
          iconData: AppCustomIcon.drawer_review_star,
          name: AppConstants.DRAWER_ITEM_PRODUCT_REVIEW),
//      ItemContent(iconData:AppCustomIcon.drawer_money_transaction,
//          name:AppConstants.DRAWER_ITEM_TRANSACTION),
      ItemDivider(),
      ItemContent(
          iconData: AppCustomIcon.drawer_phone_ring,
          name: AppConstants.DRAWER_ITEM_CONTACT_US),
      ItemContent(
          iconData: AppCustomIcon.drawer_terms_condition,
          name: AppConstants.DRAWER_ITEM_TERMS_AND_CONDITION),
      ItemContent(
          iconData: AppCustomIcon.drawer_privacy_policy,
          name: AppConstants.DRAWER_ITEM_PRIVACY_POLICY),
      ItemContent(
          iconData: AppCustomIcon.drawer_log_out,
          name: AppConstants.DRAWER_ITEM_LOGOUT),
    ];

    if (_stateDrawer.lstCategory != null) {
      print("lssss ------------> length ${_stateDrawer.lstCategory.length}");
      for (int i = 0; i < _stateDrawer.lstCategory.length; i++) {
        if(i != 0) {
          drawerData.insert(
              i + 1,
              ItemContent(
                  imageIconPath: _stateDrawer.lstCategory[i].imageIconUrl,
                  id: _stateDrawer.lstCategory[i].id.toString(),
                  name: _stateDrawer.lstCategory[i].name));
        }
      }

      for (int i = 0; i < drawerData.length; i++) {
        print("DrawerData -----------> ${drawerData[i].toString()}");
      }
    }

    return drawerData;
  }

  Future _clearUserCredential() async {
    await AppSharedPreference().saveUserToken("");
    await AppSharedPreference()
        .saveStringValue(AppConstants.KEY_USER_EMAIL_ID, "");
    await AppSharedPreference()
        .saveStringValue(AppConstants.KEY_USER_PASSWORD, "");
  }
}
