import 'package:shared_preferences/shared_preferences.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

class AppSharedPreference {
  final log = getLogger('App SP');

  // singleton boilerplate
  AppSharedPreference._internal();

  static final AppSharedPreference _singleInstance = AppSharedPreference._internal();

  factory AppSharedPreference() => _singleInstance;

  //save: token of user after successful login
  Future<bool> saveUserToken(String token) async {
    log.i('called: saveUserToken');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstants.KEY_TOKEN_USER, token);
  }

  //get: token of user
  Future<String> getUserToken() async {
    log.i('called: getUserToken');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.KEY_TOKEN_USER);
  }

  //save: token of Admin after successful Trigger
  Future<bool> saveAdminToken(String token) async {
    log.i('called: saveAdminToken');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstants.KEY_TOKEN_ADMIN, token);
  }

  //get: token of Admin
  Future<String> getAdminToken() async {
    log.i('called: getAdminToken');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.KEY_TOKEN_ADMIN);
  }

  //save: cart quote id
  Future<bool> saveCartQuoteId(String cartQuoteId) async {
    log.i('called: saveQuoteId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstants.KEY_QUOTE_ID, cartQuoteId);
  }

  //save
  Future<bool> save(String key, String value) async {
    log.i('called: common save $key value $value');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }


  //get: cart quote Id
  Future<String> getCartQuoteId() async {
    log.i('called: getCartQuoteId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.KEY_QUOTE_ID);
  }

  //save: customer id
  Future<bool> saveCustomerId(String customerId) async {
    log.i('called: saveCustomerId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstants.KEY_CUSTOMER_ID, customerId);
  }

  //get: cart quote Id
  Future<String> getCustomerId() async {
    log.i('called: getCustomerId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.KEY_CUSTOMER_ID);
  }

  Future<bool> setPreferenceData(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key,value);
  }

  Future<String> getPreferenceData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future saveStringValue(String keyName, String value) async {
    log.i('called { ' + keyName + " " + value + "}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(keyName, value);
  }

  Future<String> getStringValue(String keyName) async {
    log.i('getStringValue' + keyName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyName);
  }

  Future saveBooleanValue(String keyName, bool value) async {
    log.i('called { ' + keyName + " " + value.toString() + "}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(keyName, value);
  }

  Future<bool> getBoolValue(String keyName) async {
    log.i('getIntValue' + keyName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyName);
  }

}
