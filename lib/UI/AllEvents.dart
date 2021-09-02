import 'package:flutter/material.dart';
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
  var upcomintAppointments = Availableeventrepo();
  bool isloading = false;
  List<Event> appointments = new List();
  //Map<String, Counsellor> counsellor ;
  @override
  void initState() {
    super.initState();
    isloading = true;
    upcomintAppointments
        .upcomingAppointmentRepo(
      context,
    )
        .then((value) {
      print("value");
      print(value);
      if (value != null) {
        if (value.meta.status == "200") {
          setState(() {
            isloading = false;
          });
          print("jnjnjonaeno");
          appointments.addAll(value.events);
          print(appointments.length);

          //toast(value.meta.message);
          /*  SharedPreferencesTest().checkIsLogin("0");
                                          SharedPreferencesTest()
                                              .saveToken("set", value: value.token);*/

          /*  Navigator.push(context,
              MaterialPageRoute(
                  builder: (conext) {
                    return OTPScreen(
                      phoneNumber: mobileController.text,
                    );
                  }));*/
        } else {
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      } else {
        showAlertDialog(
          context,
          "No data found",
          "",
        );
      }
    }).catchError((error) {
      showAlertDialog(
        context,
        error.toString(),
        "",
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Container(
     margin: EdgeInsets.symmetric(
         horizontal: SizeConfig.screenWidth * 0.02,
         vertical: SizeConfig.blockSizeVertical * 2
     ),
     child:appointments != null && appointments.length > 0  ?  ListView.builder(itemBuilder: (context, index){
       return appointments != null && appointments.length > 0 ?
        InkWell(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>CafeEventsDetails(
             id:appointments.elementAt(index).orderId
//title:appointments.elementAt(index).title,
           )));
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
                 image: Image.network(images[index]).image,
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
                   color: colors[index],
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
                       Text(appointments.elementAt(index).title,
                         style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.w600
                         ),),
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text(appointments.elementAt(index).date.toString(),
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: SizeConfig.blockSizeVertical * 1.5
                         ),),
                       SizedBox(
                         width: SizeConfig.blockSizeHorizontal * 10,
                       ),
                       Text(moodstatic[int.parse(appointments.elementAt(index).time)],
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: SizeConfig.blockSizeVertical * 1.5
                         ),),
                       SizedBox(
                         width: SizeConfig.blockSizeHorizontal * 10,
                       ),
                       Text(appointments.elementAt(index).actualAmount,
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: SizeConfig.blockSizeVertical * 1.5
                         ),),
                     ],
                   ),
                 ],
               ),
             ),
           ),
         ),
       ): Container(
         child: Center(child: Text("No Upcoming Appointments", style:  TextStyle(color: Colors.black),)),
       );
     }, itemCount: appointments.length,): Container(
       child: Center(child: Text("No Upcoming Appointments", style:  TextStyle(color: Colors.black),)),
     )

   );


  }
}