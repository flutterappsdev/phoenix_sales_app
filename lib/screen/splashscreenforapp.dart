import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
//import 'package:splashscreen/splashscreen.dart';
import 'login_screen.dart';
import 'MyLoginScreen.dart';

class SplashScreenForApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      //seconds: 5,
      //navigateAfterSeconds: new MyLoginScreen(),
      //title: new Text(
        //'Welcome To Phoenix',
        //style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      //),
      //image:  Image.asset('assets/images/logo.JPG'),
      //backgroundColor: Colors.white,
      //loaderColor: Colors.lightBlueAccent,
      //photoSize: 100.0,


      navigateRoute: MyLoginScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: 'assets/images/logo.JPG',
      backgroundColor: Colors.white,
    );
  }
}
