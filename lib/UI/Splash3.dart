import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'login.dart';

class Splash3 extends StatefulWidget {
  @override
  _Splash3State createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                value: 1,
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(child: SizedBox()),
              Text(
                "Connect with your\nChancellor",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(midnightBlue), fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  child: Text("Get Started"),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
