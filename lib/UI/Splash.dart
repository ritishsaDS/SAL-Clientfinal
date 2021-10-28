
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'OnBoardScreens.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {

    super.initState();

    Future.delayed(Duration(seconds: 13),(){
      Get.to(DTWalkThoughScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/splashIcon.gif')),
    
    );
  }
}
