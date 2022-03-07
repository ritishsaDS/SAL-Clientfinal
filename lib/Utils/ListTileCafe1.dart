import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sal_user/UI/Callpage.dart';
import 'package:sal_user/UI/CounsellorProfile2.dart';
import 'package:sal_user/UI/CousellorProfile.dart';
import 'package:sal_user/UI/RescheduleAppointment.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
class listTileCafe1 extends StatefulWidget{
          var slot;
          var id;
          var appointmentid;
  BuildContext   context;
          var contactName;
          var type;
          var time;
          var date;
          var timec;
          listTileCafe1({this.slot,this.id,this.timec,this.appointmentid,this.context,this.contactName,this.type,this.time,this.date});
  @override
  _listTileCafe1State createState() => _listTileCafe1State();
}

class _listTileCafe1State extends State<listTileCafe1> {
  var moodstatic = [
    "12:00 AM",
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
    "01:00 PM",
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
    "12:00 AM"
  ];
  List months =
  ['jan', 'feb', 'mar', 'apr', 'may','jun','jul','aug','sep','oct','nov','dec'];
   @override
  void initState() {

    // print("+---------"+(int.parse(moodstatic[int.parse(widget.timec)].toString().substring(0,1))).toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
  
  return  InkWell(


    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CounsellorProfile2(id:widget.id,name: widget.contactName,appointment:widget.appointmentid,time:widget.slot,date:widget.date,)));
    },
    child: Container(
      //color: Colors.blue[900],
      margin: EdgeInsets.only(
          bottom: SizeConfig.blockSizeVertical * 2,
          right: SizeConfig.screenWidth * 0.05
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: SizeConfig.screenWidth * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.contactName,style: GoogleFonts.openSans(
                    color: Color(backgroundColorBlue),
                    fontWeight: FontWeight.bold
                ),),
                Text(widget.type=="4"?"Therapist":widget.type=="2"?"Listener":"Counsellor",style: GoogleFonts.openSans(
                    color: Color(fontColorGray),
                    fontWeight: FontWeight.w400
                ),),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              print("--------"+ moodstatic[25]);
              print("--------"+ moodstatic[24]);
              var startTime;
              //toast("In Progress");
              await _handleCameraAndMic(Permission.camera);
              await _handleCameraAndMic(Permission.microphone);
              if(int.parse(widget.timec)<=22){

                startTime = DateTime(
                    int.parse(
                        widget.date.toString().substring(0, 4)),
                    int.parse(
                        widget.date.toString().substring(5, 7)),
                    int.parse(widget.date
                        .toString()
                        .substring(8, 10)),

                    int.parse(
                        moodstatic[int.parse(widget.timec)]
                            .toString()
                            .substring(0, 2)),
                    int.parse(
                        moodstatic[int.parse(widget.timec)]
                            .toString()
                            .substring(3, 5)));
                print("PMPMPOMPM"+startTime.toString());
              }
              else{
                if(int.parse(widget.timec)==24||int.parse(widget.timec)==25){
                  print("AMAMAMAMA");
                  startTime = DateTime(
                      int.parse(
                          widget.date.toString().substring(0, 4)),
                      int.parse(
                          widget.date.toString().substring(5, 7)),
                      int.parse(widget.date
                          .toString()
                          .substring(8, 10)),

                      int.parse(
                          moodstatic[int.parse(widget.timec)]
                              .toString()
                              .substring(0, 2)),
                      int.parse(
                          moodstatic[int.parse(widget.timec)]
                              .toString()
                              .substring(3, 5)));
                  print("AMAMAMAMA"+startTime.toString());
                }
                else{
                  print("AMAMAMAMA");
                  startTime = DateTime(
                      int.parse(
                          widget.date.toString().substring(0, 4)),
                      int.parse(
                          widget.date.toString().substring(5, 7)),
                      int.parse(widget.date
                          .toString()
                          .substring(8, 10)),
                      12 +
                          int.parse(
                              moodstatic[int.parse(widget.timec)]
                                  .toString()
                                  .substring(0, 2)),
                      int.parse(
                          moodstatic[int.parse(widget.timec)]
                              .toString()
                              .substring(3, 5)));
                  print("AMAMAMAMA"+startTime.toString());
                }
              }
              var currentTime = DateTime.now();
              var diff = startTime.difference(currentTime).inMinutes;
              print("________________"+diff.toString());
    if(startTime.difference(currentTime).inSeconds==0||startTime.difference(currentTime).inSeconds<=0&&startTime.difference(currentTime).inSeconds>=-3600){
      print(widget.contactName);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            id:widget.id,
              ctype:widget.type,
            counsellorname:widget.contactName,
            session: "1",type: "1",
            channelName: widget.appointmentid,
            name:"VideoCall",
            role: ClientRole.Broadcaster,
            dif:startTime.difference(currentTime).inSeconds
          ),
        ),
      );
    }
    else{
      Fluttertoast.showToast(msg: "Call button will be activated at the scheduled time");
    }
              // push video page with given channel name

            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/Ellipse 3.png'),
                      fit: BoxFit.cover
                  )
              ),
              child: Image.asset('assets/icons/video call.png',
                scale: SizeConfig.blockSizeVertical * 0.5,),
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.8),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  // onTap: onTap,
                  child: Container(
                    width: SizeConfig.screenWidth * 0.2,
                    child: Text(widget.time,style: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                ),
                GestureDetector(
                  // onTap: onTap,
                  child: Container(
                      width: SizeConfig.screenWidth * 0.5,
                      child:  Text("${widget.date.toString().split("-")[2]+" "+months[int.parse(widget.date.toString().split("-")[1])-1]}",
                        style: TextStyle(
                            color: Color(fontColorGray)
                        ),)

                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
   
  }
}

  
  
Future<void> _handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
  print(status);
}
