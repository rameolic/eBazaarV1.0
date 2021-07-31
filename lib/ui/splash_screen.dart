import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[getWidgetBackground()],
      ),
    );
  }

  Widget getWidgetBackground() {
    return Container(
      child: Image.asset('images/bg_splash_screen.png'),
    );
  }
}
