import 'dart:async';

import 'package:flutter/material.dart';

import 'mood.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
    void initState() 
    {Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) =>
                                                          Mood()
                                                         )
                                       )
         );
      // TODO: implement initState
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
            child: Image.asset(
          "assets/logo/Group.png",
          width: 150,
          height: 150,
        )),
      ),
    );
  }
}
