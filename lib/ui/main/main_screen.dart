import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/home_notifier.dart';
import 'package:thought_factory/core/notifier/login_notifier.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/main/drawer/item_content.dart';
import 'package:thought_factory/ui/menu/beauty_personal/beauty_and_personal_screen.dart';
import 'package:thought_factory/ui/menu/distrubutor/distributors_screen_dummy.dart';
import 'package:thought_factory/ui/menu/fashion/fashion_screen.dart';
import 'package:thought_factory/ui/menu/grocery/grocery_screen.dart';
import 'package:thought_factory/ui/menu/home/home_screen.dart';
import 'package:thought_factory/ui/menu/home_appliances/home_appliances.dart';
import 'package:thought_factory/ui/menu/manage_payment/manage_payment_screen.dart';
import 'package:thought_factory/ui/menu/my_cart/my_cart_screen.dart';
import 'package:thought_factory/ui/menu/my_order/my_order_screen.dart';
import 'package:thought_factory/ui/menu/my_profile/my_profile_screen.dart';
import 'package:thought_factory/ui/menu/my_wishlist/my_wishlist_screen.dart';
import 'package:thought_factory/ui/menu/contact_us/contact_us_screen.dart';
import 'package:thought_factory/ui/menu/privacy_policy/privacy_policy_screen.dart';
import 'package:thought_factory/ui/menu/product_review/product_review_screen.dart';
import 'package:thought_factory/ui/menu/terms_condition/terms_and_condition_screen.dart';
import 'package:thought_factory/ui/menu/transaction/transaction_screen.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_network_check.dart';
import 'package:thought_factory/utils/app_text_style.dart';

import 'drawer/my_drawer.dart';

class MainScreen extends StatelessWidget {
  final log = getLogger('MainScreen');

  //final tag = 'MainScreen';
  static const routeName = '/main_screen';
  final GlobalKey<ScaffoldState> _keyScaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey _keyDrawer = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeNotifier(),
        ),
      ],
      child: Consumer<StateDrawer>(
        builder: (context, stateDrawer, _) => WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            RenderBox boxDrawer = _keyDrawer.currentContext?.findRenderObject();
            if (boxDrawer != null) {
              log.i('nav drawer | box is rendered, poping to main screen');
              Navigator.popUntil(context, ModalRoute.withName(routeName));
            } else {
              log.i('nav drawer | box is not rendered');
              if (stateDrawer.selectedDrawerItem ==
                  AppConstants.DRAWER_ITEM_HOME) {
                log.i('page status | reached last, show exit app dialogue');
                showDialogueExitApp(context);
              } else {
                log.i('page status | navigate to home page');
                stateDrawer.selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
              }
            }
          },
          child: Scaffold(
            //key: _keyScaffold, making issue of search so commenting it out
            //resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            appBar: _buildAppbar(context),
            drawer: MyDrawer(_keyDrawer, stateDrawer),
            body: _buildContentPage(stateDrawer.selectedDrawerItem, stateDrawer,
                context, stateDrawer.selectedId, stateDrawer.itemContent),
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Consumer<StateDrawer>(
            builder: (BuildContext context, stateDrawer, _) => Text(
                  stateDrawer.selectedDrawerItem,
                  style: getAppBarTitleTextStyle(context),
                )),
        actions: <Widget>[
          Consumer<StateDrawer>(
              builder: (BuildContext context, stateDrawer, _) => stateDrawer
                          .selectedDrawerItem ==
                      AppConstants.DRAWER_ITEM_MY_CART
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: Stack(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              _onClickButtonCart(stateDrawer);
                            },
                            icon: Icon(
                              AppCustomIcon.icon_cart,
                              size: 18,
                            ),
                            tooltip: 'Open shopping cart',
                          ),
                          Positioned(
                            top: 10,
                            left: 25,
                            height: 17.0,
                            width: 17.0,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Consumer<CommonNotifier>(
                                builder: (context, commonNotifier, _) => Text(
                                  commonNotifier.cartCount ?? '0',
                                  style: getStyleOverLine(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
        ]);
  }

  Widget _buildContentPage(String selectedPage, StateDrawer stateDrawer,
      BuildContext context, String selectedId, ItemContent itemContent) {
    log.i("selected id ---> $selectedId -------------- $selectedPage");
    log.i("item  ---> $selectedId -------------- $itemContent");
    log.i('drawerNavigation | to :$selectedPage');
    switch (selectedPage) {
      case AppConstants.DRAWER_ITEM_HOME:
        return HomeScreen(stateDrawer, context);
      case AppConstants.DRAWER_ITEM_DISTRIBUTORS:
        return DistributorsScreen();
      /*case AppConstants.DRAWER_ITEM_FASHION:
      case AppConstants.DRAWER_ITEM_HOME_APPLIANCES:
        return HomeAppliancesScreen();
      case AppConstants.DRAWER_ITEM_BEAUTY_AND_PERSONAL_CARE:
        return BeautyAndPersonalCareScreen();
      case AppConstants.DRAWER_ITEM_GROCERY:
        return GroceryScreen();*/
      case AppConstants.DRAWER_ITEM_MY_ORDER:
        return MyOrderScreen();
      case AppConstants.DRAWER_ITEM_MY_CART:
        return MyCartScreen();
      case AppConstants.DRAWER_ITEM_MY_WISH_LIST:
        return MyWishListScreen();
      case AppConstants.DRAWER_ITEM_MY_PROFILE:
        return MyProfile();
      case AppConstants.DRAWER_ITEM_MANAGE_PAYMENT:
        return ManagePaymentScreen();
      case AppConstants.DRAWER_ITEM_PRODUCT_REVIEW:
        return ProductReviewScreen();
      case AppConstants.DRAWER_ITEM_CONTACT_US:
        return ContactUsScreen(stateDrawer);
      /*  case AppConstants.DRAWER_ITEM_TRANSACTION:
        return TransactionScreen();*/
      case AppConstants.DRAWER_ITEM_CONTACT_US:
        return Container();
      case AppConstants.DRAWER_ITEM_TERMS_AND_CONDITION:
        return TermsAndConditionScreen();
      case AppConstants.DRAWER_ITEM_PRIVACY_POLICY:
        return PrivacyPolicy();
      case AppConstants.DRAWER_ITEM_LOGOUT:
        return Container();
      default:
        if (itemContent.imageIconPath != null) {
          InfoHomeTap infoHomeTap1 = InfoHomeTap(
              id: int.parse(itemContent.id), toolBarName: itemContent.name);
          stateDrawer.selectedDrawerItem = stateDrawer.itemContent.name;
          return ProductListScreen(infoHomeTap1: infoHomeTap1);

          //ProductListScreen(infoHomeTap1: infoHomeTap1);
        } else {
          return Container();
        }
    }
  }

  void _onClickViewAllProducts(
      BuildContext context, InfoHomeTap infoHomeTap) async {
    HomeNotifier homeNotifier = Provider.of<HomeNotifier>(context);
    print('onClickViewAllProducts, params category Id: ${infoHomeTap.id}');

    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      Navigator.pushNamed(context, ProductListScreen.routeName,
          arguments: infoHomeTap);
    }
  }

  void showDialogueExitApp(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Exit App !',
              style: getAppBarTitleTextStyle(context).copyWith(
                  color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
            ),
            content: Text('Sure you want to exit ?'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  AppConstants.NO,
                  style: getStyleSubHeading(context).copyWith(
                      color: colorPrimary,
                      fontWeight: AppFont.fontWeightSemiBold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(AppConstants.YES,
                    style: getStyleSubHeading(context).copyWith(
                        color: colorPrimary,
                        fontWeight: AppFont.fontWeightSemiBold)),
                onPressed: () {
                  SystemNavigator.pop();
                },
              )
            ],
          );
        });
  }

  void showSnackBarExitApp(context) {
    _keyScaffold.currentState
        .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
    _keyScaffold.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text('Sure you want to exit app !! '),
      action: SnackBarAction(
          label: 'YES',
          onPressed: () {
            SystemNavigator.pop();
          }),
    ));
  }

  //onClick: button cart
  void _onClickButtonCart(StateDrawer stateDrawer) {
    log.i('Button cart is pressed');
    stateDrawer.selectedDrawerItem = AppConstants.DRAWER_ITEM_MY_CART;
  }
}
