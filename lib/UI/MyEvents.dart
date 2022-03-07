import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:countdown_timer_simple/countdown_timer_simple.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CafeEventdetails.dart';
import 'Callpage.dart';

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
  var buttontext="Starts in :";
  var moodstatic = [
    "00:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    '08:00 PM',
    '08:30 PM',
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "12:00 PM"
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
        height: SizeConfig.screenHeight-200,
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
print(response.request.toString());
print(response.request.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        myevents=responseJson['upcoming_events'];
        setState(() {
          isError = false;
          isLoading = false;
          print(myevents);
        });


      } else {
        print("bjkb" + response.statusCode.toString());

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
      var startTime;
print("+---------"+(int.parse(moodstatic[int.parse(myevents[i]['time'])].toString().substring(0,1))).toString());
if(int.parse(myevents[i]['time'])<=22){

  startTime = DateTime(
      int.parse(
          myevents[i]['date'].toString().substring(0, 4)),
      int.parse(
          myevents[i]['date'].toString().substring(5, 7)),
      int.parse(myevents[i]['date']
          .toString()
          .substring(8, 10)),

      int.parse(
          moodstatic[int.parse(myevents[i]['time'])]
              .toString()
              .substring(0, 2)),
      int.parse(
          moodstatic[int.parse(myevents[i]['time'])]
              .toString()
              .substring(3, 5)));
  print("PMPMPOMPM"+startTime.toString());
}
else{
  startTime = DateTime(
      int.parse(
          myevents[i]['date'].toString().substring(0, 4)),
      int.parse(
          myevents[i]['date'].toString().substring(5, 7)),
      int.parse(myevents[i]['date']
          .toString()
          .substring(8, 10)),
      12 +
          int.parse(
              moodstatic[int.parse(myevents[i]['time'])]
                  .toString()
                  .substring(0, 2)),
      int.parse(
          moodstatic[int.parse(myevents[i]['time'])]
              .toString()
              .substring(3, 5)));
  print("AMAMAMAMA"+startTime.toString());
}
      var currentTime = DateTime.now();
      var diff = startTime.difference(currentTime).inMinutes;
      print(diff);
      if(diff==0||diff<=0&&diff>=-59){
print("jhkbwefjn");
        buttontext="Join";

      }
      else{
        buttontext="Starts in :";
      }
      eventlist.add(
          InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CafeEventsDetails(
              id:myevents[i]['order_id']
                  ,
screen:"My Events"
//title:appointments.elementAt(i).title,
          )));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width:MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical
              ),
              //width: SizeConfig.screenWidth * 0.4,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: Image.network("https://sal-prod.s3.ap-south-1.amazonaws.com/"+myevents[i]['photo']).image,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(myevents[i]['title'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${DateFormat('EEEE').format(DateTime.parse(myevents[i]['date'].toString()))}"+", "+(myevents[i]['date'].toString().split("-")[2])+" ${DateFormat('MMMM').format(DateTime.parse(myevents[i]['date'].toString()))}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeVertical * 1.5
                            ),),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,),

                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 8,
                          ),
                          Text(moodstatic[int.parse(myevents[i]['time'])],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeVertical * 1.8,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,),

                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 8,
                          ),
                          Text("₹"+myevents[i]['price'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeVertical * 1.8,
                                fontWeight: FontWeight.w600
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DateTime.now().toString().substring(0,10)==myevents[i]['date']?diff>0||diff<=0&&diff>=-59

                ? Container(
              decoration: BoxDecoration(color:buttontext=="Join"?Colors.white:Color(0xFF0066B3),
                  borderRadius: BorderRadius.circular(10)),

              child: Card(
                elevation: 2,
                child: Container(
decoration: BoxDecoration(color: buttontext!="Join"?Colors.white:Color(0xFF0066B3),borderRadius: BorderRadius.circular(10)),


                  child:MaterialButton(
                    elevation: 0,
                    onPressed: () async {
                    //  var startTime = DateTime(2021, 12, 10, 11, 30); // TODO: change this to your DateTime from firebase
                      var currentTime = DateTime.now();
                      var diff = startTime.difference(currentTime).inMinutes;
                      print(diff);
                      if(buttontext=="Join"){
                        print("----------------->"+startTime.difference(currentTime).inSeconds.toString());
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallPage(
                              id:myevents[i]['counsellor_id'],
                              session: "2",type: "1",
                              channelName: myevents[i]['order_id'],
                              name:"VideoCall",
                              role: ClientRole.Broadcaster,

                                dif:startTime.difference(currentTime).inSeconds
                            ),
                          ),
                        );
                      }
                    },

                    color: buttontext!="Join"?Colors.white: Color(0xFF0066B3),
                    minWidth: SizeConfig.screenWidth ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                         buttontext,
                          style: GoogleFonts.openSans(
                            color: buttontext!="Join"?Color(0xFF0066B3):Colors.white,
                          ),
                        ),
                        DateTime.now().toString().substring(0,10)==myevents[i]['date']?
                        CountdownTimerSimple(
                            textStyle: TextStyle(color: Color(0xFF0066B3),fontSize: 14),
                            endTime: DateTime.now().millisecondsSinceEpoch + 1000 *60*diff ,

                            onEnd: () {

setState(() {
  buttontext="Join";
});
                              // print(endTime+"Your time is up!");
                            }
                        ):SizedBox(),
                      ],
                    ),

                  ),),
              ),
            ):SizedBox():SizedBox()
          ],
        ),
      ));
    }
    return eventlist;
  }

}