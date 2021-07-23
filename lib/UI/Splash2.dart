import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'Splash3.dart';

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
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
                value: 0.6,
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(child: SizedBox()),
              Text(
                "Access Your\nEmotional Health",
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
                        MaterialPageRoute(builder: (context) => Splash3()));
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
