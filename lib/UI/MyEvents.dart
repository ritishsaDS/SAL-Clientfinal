import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myevents extends StatefulWidget{
  @override
  _MyeventsState createState() => _MyeventsState();
}

class _MyeventsState extends State<Myevents> {
  bool  isError = false;
  bool isLoading = false;
  List<String> images = ['https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg',
    'https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg'];

  List<String> topic = ['Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop',
    'Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop'];
  var moodstatic = [
    "0:30",
    "1:00",
    "1:30",
    "2:00",
    "2:30",
    "3:00",
    "3:30",
    "4:00",
    "4:30",
    "5:00",
    "5:30",
    "6:00",
    "6:30",
    "7:00",
    "7:30",
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    '20:00',
    '20:30',
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30"
        "24:00"
  ];
  List<Color> colors = [Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),Color.fromRGBO(0, 90, 100, 0.75),Color.fromRGBO(0, 90, 100, 0.75)];
@override
  void initState() {
  getid();
  getmyEvent();
    // TODO: implement initState
    super.initState();
  }
  void getid() async {
  SharedPreferences prefs= await SharedPreferences.getInstance();
  prefs.getString("cleintid");
  prefs.getString("email");
  prefs.getString("phone");
  prefs.getString("name");
  print( prefs.getString("cleintid")+ prefs.getString("email")+ prefs.getString("phone"));

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SingleChildScrollView(
      child: Container(
          child:
      // Container(
      //   margin: EdgeInsets.symmetric(
      //       horizontal: SizeConfig.screenWidth * 0.02
      //   ),
      //   child: MaterialButton(onPressed: (){
      //     Navigator.of(context).pushNamed('/AddNewEvent');
      //   },
      //     minWidth: SizeConfig.screenWidth,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //       side: BorderSide(
      //           color: Color(backgroundColorBlue)
      //       ),
      //     ),
      //     child: Text("SCHEDULE NEW EVENT",
      //       style: TextStyle(
      //           color: Color(backgroundColorBlue),
      //           fontWeight: FontWeight.w600
      //       ),),),
      // ),
      Container(
      margin: EdgeInsets.symmetric(
      horizontal: SizeConfig.screenWidth * 0.02,
          vertical: SizeConfig.blockSizeVertical * 2
      ),
      child:myevents.length==0?Center(child: Text("No Event Available yet"),): Container(
        height: SizeConfig.screenHeight,
        child: ListView(
          children:
            getEventwidget()

        ),
      )
    )));
  }
  dynamic myevents=new List();
  void getmyEvent() async {
    setState(() {
      isLoading=true;
    });
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.getString("cleintid");
    try {
      final response = await get(Uri.parse('https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/event/booked?client_id=${ prefs.getString("cleintid")}'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        myevents=responseJson['upcoming_events'];
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
  List <Widget> getEventwidget(){
    List <Widget> eventlist = new List();
    for(int i =0; i<myevents.length;i++){
      eventlist.add( InkWell(
        onTap: (){
          Navigator.of(context).pushNamed('/CafeEventsDetails');
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical
          ),
          width: SizeConfig.screenWidth * 0.4,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: Image.network(images[0]).image,
                fit: BoxFit.cover
            ),
          ),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.25,
            alignment: Alignment.bottomCenter,
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.02,
                  right: SizeConfig.screenWidth * 0.02
              ),
              height: SizeConfig.blockSizeVertical * 8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: colors[0],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(myevents[i]['title'],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                  Text(moodstatic[int.parse(myevents[i]['time'])],
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return eventlist;
  }

}