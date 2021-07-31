import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/router.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/ui/login_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_font.dart';

import 'core/notifier/common_notifier.dart';
import 'core/notifier/login_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.debug;

  //debugPaintSizeEnabled = true;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: colorBlack, // navigation bar color
    statusBarColor: colorPrimary, // status bar color
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CommonNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => StateDrawer(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginNotifier(),
      )
    ],
    child: MaterialApp(
      theme: ThemeData(
        fontFamily: AppFont.fontFamilyName,
        textTheme: TextTheme(
          button: TextStyle(fontWeight: AppFont.fontWeightRegular),
          caption: TextStyle(fontWeight: AppFont.fontWeightRegular),
          body1: TextStyle(fontWeight: AppFont.fontWeightRegular),
          body2: TextStyle(fontWeight: AppFont.fontWeightRegular),
          subhead: TextStyle(fontWeight: AppFont.fontWeightRegular),
          title: TextStyle(fontWeight: AppFont.fontWeightRegular),
          headline: TextStyle(fontWeight: AppFont.fontWeightRegular),
          display1: TextStyle(fontWeight: AppFont.fontWeightRegular),
          display2: TextStyle(fontWeight: AppFont.fontWeightRegular),
        ),
        primaryColor: colorPrimary,
        accentColor: colorAccent,
        buttonColor: colorPrimary,
        buttonTheme: const ButtonThemeData(
            buttonColor: colorPrimary, textTheme: ButtonTextTheme.primary),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      onGenerateRoute: MyRouter.generateRoute,
    ),
  ));
}
