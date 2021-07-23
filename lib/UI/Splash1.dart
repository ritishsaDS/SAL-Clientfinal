import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'Splash2.dart';

class Splash1 extends StatefulWidget {
  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
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
                value: 0.3,
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(child: SizedBox()),
              Text(
                "Elevate Your Mood",
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
                        MaterialPageRoute(builder: (context) => Splash2()));
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
