
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'OnBoardScreens.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
var clientid;
  @override
  void initState() {
    detail();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/splashIcon.gif')),
    
    );
  }
  Future<void> detail() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {
      prefs.getString("cleintid")== null? Future.delayed(Duration(seconds: 13),(){
        Get.to(

            DTWalkThoughScreen());
      }):Get.to(HomeMain());

    });
  }
}
