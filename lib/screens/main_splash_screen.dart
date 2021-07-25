
import 'package:firebase_storage/firebase_storage.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'auth_screen.dart';


class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({Key key}) : super(key: key);

  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {

  // FirebaseStorage storage ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.blueAccent,
          photoSize: 180,
          image: Image.asset('assets/images/s1.jpg'),
          seconds: 3,
          navigateAfterSeconds: AuthScreen(),
          title: Text("Splash Screen Tutorial"),
          loaderColor: Colors.yellow,
          loadingText: Text("Getting Page Ready!"),
        ),
      ),
    );
  }
}
