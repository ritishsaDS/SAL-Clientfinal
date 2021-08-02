import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sal_user/UI/Splash1.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'components/calanderSceeenWidget.dart';


class CalanderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          leading: Icon(Icons.arrow_back_ios),
          actions: [
            Center(child: Container(padding:EdgeInsets.only(right: 10),child: Text("Next",style: TextStyle(color: Colors.blue),)))
          ],
          title: GestureDetector(onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Splash1()));
          },child: Text("Mood Diary",style: TextStyle(color: Colors.black,fontSize: 14),)),
        ),
        body: CalanderScreenWidget(),


      ),
    );
  }
}
