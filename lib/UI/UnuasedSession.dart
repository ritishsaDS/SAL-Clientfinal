import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/RescheduleAppointment.dart';
import 'package:sal_user/UI/Schedulescreen.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Unusedappointmentrepo.dart';
import 'package:sal_user/models/Unusedappointmentmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnusedSession extends StatefulWidget{
  @override
  _UnusedSessionState createState() => _UnusedSessionState();
}

class _UnusedSessionState extends State<UnusedSession> {
  bool   isError = false;
bool  isLoading = false;
  var upcomintAppointments = Unusedappointmentrepo();
  bool isloading = false;
  List<Unusedappointmodel> appointments = new List();
  List<AppointmentSlot> unusedappointments = new List();
 List<Counsellors> counsellor ;
  @override
  void initState() {
    super.initState();
    getunusedsession();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body:  Container(child: upcominglist.length==0?
         Container(child: Center(child: Text("No Unused Session")),):ListView(
       children: unusedsession(),
     ),),
   );
  }
  dynamic upcominglist= new List();
  dynamic counsellorlist= new List();

 Future<void> getunusedsession() async {
   setState(() {
     isLoading=true;
   });
   SharedPreferences prefs= await SharedPreferences.getInstance();
   print( prefs.getString("cleintid"));
   final uri = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/slots?client_id=${prefs.getString("cleintid")}';

   try {
     final response = await get(Uri.parse(uri));
     print("bjkb" + response.body.toString());
     if (response.statusCode == 200) {
       final responseJson = json.decode(response.body);
       upcominglist=responseJson['appointment_slots'];
       counsellorlist=responseJson['counsellors'];
print(upcominglist);
      // counsellorid=upcominglist['appointment_slots'][0]['counsellor_id'];
     //  print( upcominglist['appointment_slots'][0]['counsellor_id'],);
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
 List <Widget>unusedsession(){
   List<Widget> sessionlist=new List();
   for(int i = 0; i<upcominglist.length;i++){
     var counsellorid=upcominglist[i]['counsellor_id'];
     sessionlist.add( Container(
       width: SizeConfig.screenWidth,
       margin: EdgeInsets.symmetric(
           horizontal: SizeConfig.screenWidth * 0.05,
           vertical: SizeConfig.blockSizeVertical),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           ListTile(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(8)),
             title: Text(
               counsellorlist['${counsellorid}']['first_name'].toString(),
               style: TextStyle(
                 color: Color(backgroundColorBlue),
                 fontWeight: FontWeight.bold,
               ),
             ),
             subtitle: Text(

               counsellorlist['${counsellorid}']['type']=="1"?"Counsellor":counsellorlist['${counsellorid}']['type']=="2"?"Listener":"Therapist",
               style: TextStyle(
                 color: Color(fontColorGray),
                 fontWeight: FontWeight.bold,
               ),
             ),
             trailing: Column(
               mainAxisAlignment:
               MainAxisAlignment.start,
               crossAxisAlignment:
               CrossAxisAlignment.start,
               children: [
                 Text(
                   "08:00 AM",
                   style: TextStyle(
                       color: Color(fontColorGray),
                       fontSize:
                       SizeConfig.blockSizeVertical *
                           1.5),
                 ),
                 Text(
                   "",
                   style: TextStyle(
                       color: Color(fontColorGray),
                       fontSize:
                       SizeConfig.blockSizeVertical *
                           1.5),
                 ),
               ],
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               MaterialButton(
                 onPressed: (){
                   Navigator.pop(context);
                 },
                 color: Colors.white,
                 child: Text("RATE",style: TextStyle(
                   color: Color(fontColorGray),
                 ),),
                 minWidth: SizeConfig.screenWidth * 0.4,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8),
                   side: BorderSide(
                       color: Color(fontColorGray)
                   ),
                 ),
               ),
               MaterialButton(
                 onPressed: (){
                   print(upcominglist[i]['appointment_slot_id']);
                   Navigator.push(context, MaterialPageRoute(builder: (conetxt)=>RescheduleAppointmet(
                     appointment: upcominglist[i]['appointment_slot_id'],
                     type: counsellorlist['${counsellorid}']['type'] ,



                  )));
                 },
                 color: Color(backgroundColorBlue),
                 child: Text("BOOK AGAIN",style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.w600
                 ),),
                 minWidth: SizeConfig.screenWidth * 0.4,
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8)
                 ),
               ),
             ],
           ),


         ],
       ),

     ),);
   }
   return sessionlist;
 }
}