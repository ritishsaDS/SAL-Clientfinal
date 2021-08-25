import 'package:flutter/material.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/ListTileCafe1.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/upcomingappointmentrepo.dart';
import 'package:sal_user/models/bookedappointment.dart';

class UpcomingAppointment extends StatefulWidget{
  @override
  _UpcomingAppointmentState createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  Future<void> _launched;
  var upcomintAppointments = UpcomingAppointmentRepo();
  bool isloading = false;
  List<Appointment> appointments = new List();
  Map<String, Counsellor> counsellor ;
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
          appointments.addAll(value.appointments);

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.02,
          vertical: SizeConfig.blockSizeVertical),
      child:GestureDetector(onTap: (){
        // print(appointments.elementAt(index).time.toString());
      },
        child: Container(
          height:SizeConfig.blockSizeVertical * 80 ,
          child: appointments != null && appointments.length > 0  ?  ListView.builder(itemBuilder: (context, index){
            return appointments != null && appointments.length > 0 ?  listTileCafe1(context,"Counsellor",moodstatic[int.parse(appointments.elementAt(index).time)],appointments.elementAt(index).date.toString()

            ): Container(
              child: Center(child: Text("No Upcoming Appointments", style:  TextStyle(color: Colors.black),)),
            );
          }, itemCount: appointments.length,): Container(
            child: Center(child: Text("No Upcoming Appointments", style:  TextStyle(color: Colors.black),)),
          ),
        ),
      )
    );
  }
}