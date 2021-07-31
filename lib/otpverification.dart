import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ui/login_screen.dart';
import 'ui/register_screen.dart';
bool otpforregistartion = false;
String otpenter;
String tokenfromotp;
int customernumber;
Uri sendotp = Uri.parse("https://ebazaar.ae/rest//V1/sendotp");
Uri verifyotp = Uri.parse("https://ebazaar.ae/rest/V1/customertoken");
Uri registeruserwithotp = Uri.parse("https://ebazaar.ae/rest/V1/customersignupwithotp");

Future<void> SendOtp() async {
  Map body = {
    "resend": 1,
    "storeId": 1,
    "mobile" :'$customernumber',
    "eventType": otpforregistartion ? 'customer_signup_otp':'customer_login_otp'
  };
  print(jsonEncode(body));
  http.Response response = await http.post(sendotp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  print(response.body);
}

Future<bool> IsOtpVerified() async {
  Map body = {
    "mobile" :customernumber,
    "otp":int.parse(otpenter),
    'websiteId':1,
  };
  print(jsonEncode(body));
  http.Response response = await http.post(verifyotp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  String data = response.body;
  if(data.contains("message")){
    print('not verified');
    return false;
  }else{
    print('token : ${jsonDecode(data)}');
    tokenfromotp = jsonDecode(data);
    return true;
  }
}

Future<int> registereduser() async {
  Map body = {
    "customer":{
      "email":register.email,
      "firstname":register.firstname,
      "lastname":register.lastname,
      "custom_attributes":[{"attribute_code":"trn_no","value":"${register.trn}"}],
    },
    "password":register.password,
    "mobile":"$customernumber",
    "otp":register.otp,
    "redirectUrl":""
  };
  print(jsonEncode(body));
  http.Response response = await http.post(registeruserwithotp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  var bodys = '[]';
  if(bodys == '[]'){
    return 0;
  }else{
    return 1;
  }
}
class register{
  static String firstname;
  static String lastname;
  static String email;
  static String password;
  static String otp;
  static dynamic trn;

}
