import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Availableeventrepo.dart';
import 'package:sal_user/models/Availableeventmodel.dart';

import 'CafeEventdetails.dart';
class Allevents extends StatefulWidget{
  @override
  _AlleventsState createState() => _AlleventsState();
}

class _AlleventsState extends State<Allevents> {
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
    "0:30 AM",
    "1:00 AM",
    "1:30 AM",
    "2:00 AM",
    "2:30 AM",
    "3:00 AM",
    "3:30 AM",
    "4:00 AM",
    "4:30 AM",
    "5:00 AM",
    "5:30 AM",
    "6:00 AM",
    "6:30 AM",
    "7:00 AM",
    "7:30 AM",
    "8:00 AM",
    "8:30 AM",
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
    "1:30 PM",
    "2:00 PM",
    "2:30 PM",
    "3:00 PM",
    "3:30 PM",
    "4:00 PM",
    "4:30 PM",
    "5:00 PM",
    "5:30 PM",
    "6:00 PM",
    "6:30 PM",
    "7:00 PM",
    "7:30 PM",
    '8:00 PM',
    '8:30 PM',
    "9:00 PM",
    "9:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "12:00 AM",
    "",""
  ];

  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),Color.fromRGBO(0, 90, 100, 0.75),Color.fromRGBO(0, 90, 100, 0.75)];
  var upcomintAppointments = Availableeventrepo();
  bool isloading = false;
  List<Event> appointments = new List();
  //Map<String, Counsellor> counsellor ;
  @override
  void initState() {

    AllEvents();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Container(
     margin: EdgeInsets.symmetric(
         horizontal: SizeConfig.screenWidth * 0.02,
         vertical: SizeConfig.blockSizeVertical * 2
     ),
     child:all != null && all.length > 0  ?  ListView.builder(itemBuilder: (context, index){
       return all != null && all.length > 0 ?
        InkWell(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>CafeEventsDetails(
             id:all[index]['order_id'],
               screen:"All Events"

//title:appointments.elementAt(index).title,
           )));
         },
         child: Container(
           margin: EdgeInsets.symmetric(
               vertical: SizeConfig.blockSizeVertical
           ),

           alignment: Alignment.bottomCenter,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             image: DecorationImage(
                 image: Image.network("https://sal-prod.s3.ap-south-1.amazonaws.com/"+all[index]['photo']).image,
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
                   color: Color.fromRGBO(0, 90, 100, 0.75),
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
                       Text(all[index]['title'],
                         style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.w600
                         ),),
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text("${DateFormat('EEEE').format(DateTime.parse(all[index]['date'].toString()))}"+", "+(all[index]['date'].toString().split("-")[2])+" ${DateFormat('MMMM').format(DateTime.parse(all[index]['date'].toString()))}",
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
                       Text(moodstatic[int.parse(all[index]['time'])],
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
                       Text("₹"+all[index]['price'],
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
       ): Container(
         child: Center(child: Text("No Events Avaialable", style:  TextStyle(color: Colors.black),)),
       );
     }, itemCount: all.length,): Container(
       child: Center(child: Text("No Events Avaialable", style:  TextStyle(color: Colors.black),)),
     )

   );


  }
  dynamic all=new List();
  void AllEvents() async {
    setState(() {

    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/events'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        all=responseJson['events'];

        setState(() {
print(all);
print(DateTime.parse(all[0]['date']));
        });
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointmentcancel()));

      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {

        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
}