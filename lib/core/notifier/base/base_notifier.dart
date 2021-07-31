import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:toast/toast.dart';

class BaseNotifier extends ChangeNotifier {
  final log = getLogger('BaseNotifier');

  bool _isLoading = false;
  var context;

  //getter
  get isLoading => _isLoading;

  //setter
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  String convertToDecimal(String value, int count) {
    return (value != null && value != "" && value != 'null')
        ? double.parse(value).toStringAsFixed(count)
        : "";
  }

  //show snack bar message
  void showSnackBarMessageWithContext(String message) {
    try {
      if (message.isNotEmpty) {
        final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 5),
        );
        // Find the Scaffold in the widget tree and use it to show a SnackBar.
        if (context != null) {
          Scaffold.of(context).showSnackBar(snackBar);
        } else {
          log.e('Context is NULL, coudn\'t show snackbar toast');
        }
      } else {
        log.e('server message is NULL | EMPTY');
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //show Toast
  void showToast(String message) {
    try {
      if (message.isNotEmpty) {
        Toast.show(message, this.context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        log.e('server message is NULL | EMPTY');
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //show snack bar message with context as param
  void showSnackBarMessageParamASContext(var context, String message) {
    try {
      if (message.isNotEmpty) {
        final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 5),
        );
        // Find the Scaffold in the widget tree and use it to show a SnackBar.
        if (context != null) {
          Scaffold.of(context).showSnackBar(snackBar);
        } else {
          log.e('Context is NULL, coudn\'t show snackbar toast');
        }
      } else {
        log.e('server message is NULL | EMPTY');
      }
    } catch (e) {
      log.e(e.toString());
    }
  }
  void showCustomSnackBarMessageWithContext(String message,{ Color bgColor, Color txtColor, BuildContext ctx}) {
    final snackBar = SnackBar(
      content: Text(message, style: getStyleButtonText(ctx).copyWith(color: txtColor),),
      duration: Duration(seconds: AppConstants.TIME_SHOW_SNACK_BAR),
      backgroundColor: bgColor,
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    if (ctx != null) {
      Scaffold.of(ctx).showSnackBar(snackBar);
    } else {
      log.e('Context is Null, coudn\'t show snackbar toast');
    }
  }


  void showSnackBarContextDuration(var context, String message, int duration) {
    try {
      if (message.isNotEmpty) {
        final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: duration),
        );
        // Find the Scaffold in the widget tree and use it to show a SnackBar.
        if (context != null) {
          Scaffold.of(context).showSnackBar(snackBar);
        } else {
          log.e('Context is NULL, coudn\'t show snackbar toast');
        }
      } else {
        log.e('server message is NULL | EMPTY');
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  String getThumbnailImageUrlForProduct(Items item) {
    try {
      if (item != null &&
          item.customAttributes != null &&
          item.customAttributes.length > 0) {
        CustomAttributes itemCustomAttribute = item.customAttributes.firstWhere(
            (itemCustomAttribute) =>
                itemCustomAttribute.attributeCode == 'thumbnail');

        if (itemCustomAttribute != null &&
            itemCustomAttribute.value.isNotEmpty) {
          log.i('getThumbnailImageUrl : ${itemCustomAttribute.value}');
          return '${AppUrl.baseImageUrl}${itemCustomAttribute.value}';
        }
      }
    } catch (e) {
      log.e(e.toString());
    }
    return '';
  }
}
