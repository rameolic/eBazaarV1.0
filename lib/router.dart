import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thought_factory/ui/compare/bottom_sheet_try.dart';
import 'package:thought_factory/ui/compare/compare_screen.dart';
import 'package:thought_factory/ui/distributor_app_pages/distributor_profile_screen.dart';
import 'package:thought_factory/ui/invoice/invoice_screen.dart';
import 'package:thought_factory/ui/login_screen.dart';
import 'package:thought_factory/ui/main/main_screen.dart';
import 'package:thought_factory/ui/menu/manage_payment/add_new_card_screen.dart';
import 'package:thought_factory/ui/menu/my_cart/my_cart_screen.dart';
import 'package:thought_factory/ui/menu/my_cart/payment_screen.dart';
import 'package:thought_factory/ui/menu/my_order/my_order_detail_screen.dart';
import 'package:thought_factory/ui/menu/my_profile/edit_profile.dart';
import 'package:thought_factory/ui/menu/product_review/product_review_detail_screen.dart';
import 'package:thought_factory/ui/order/order_confirmation_screen.dart';
import 'package:thought_factory/ui/password/forgot_pwd_screen.dart';
import 'package:thought_factory/ui/password/reset_pwd_screen.dart';
import 'package:thought_factory/ui/payment/payment_card_screen.dart';
import 'package:thought_factory/ui/payment/payment_card_screen1.dart';
import 'package:thought_factory/ui/product/product_detail_screen.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/ui/register_screen.dart';
import 'package:thought_factory/ui/review/review_screen.dart';
import 'package:thought_factory/ui/menu/manage_address/edit_address_screen.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/ui/product/build_filter_screen.dart';

final log = getLogger('Router');

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log.i(
        'generateRoute | to :${settings.name} arguments:${settings.arguments}');
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      case RegisterScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => RegisterScreen(), settings: settings);
      case MainScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => MainScreen(), settings: settings);
      case ProductListScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => ProductListScreen(), settings: settings);
      case ProductDetailScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(), settings: settings);
      case ProductReviewDetailScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ProductReviewDetailScreen(), settings: settings);
      case MyOrderDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => MyOrderDetailScreen(), settings: settings);
      case ForgotPasswordScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => ForgotPasswordScreen(), settings: settings);
      case ResetPasswordScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => ResetPasswordScreen(), settings: settings);
      case EditAddress.routeName:
        return CupertinoPageRoute(
            builder: (_) => EditAddress(), settings: settings);
      case CompareProductScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => CompareProductScreen(), settings: settings);
      case BuildFilterScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BuildFilterScreen(), settings: settings);
      case PaymentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(), settings: settings);
      case InvoiceScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => InvoiceScreen(), settings: settings);
      case ReviewScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => ReviewScreen(), settings: settings);
      case AddNewCardScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => AddNewCardScreen(), settings: settings);
      case BottomSheetTryScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BottomSheetTryScreen(), settings: settings);
      case DistributorProfileScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => DistributorProfileScreen(), settings: settings);
      case MyCartScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => MyCartScreen(), settings: settings);
      case OrderConfirmationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => OrderConfirmationScreen(), settings: settings);
      case EditProfile.routeName:
        return MaterialPageRoute(
            builder: (_) => EditProfile(), settings: settings);
      case PaymentCardScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentCardScreen1(), settings: settings);
      default:
        return CupertinoPageRoute(builder: (_) => Container());
    }
  }
}
