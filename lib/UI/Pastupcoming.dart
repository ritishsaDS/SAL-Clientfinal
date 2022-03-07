import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/ListTileCafe1.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Widgets/pastappointwidget.dart';
import 'package:sal_user/data/repo/pastAppointmentrepo.dart';
import 'package:sal_user/data/repo/upcomingappointmentrepo.dart';
import 'package:sal_user/models/bookedappointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastAppointment extends StatefulWidget {
  @override
  _PastAppointmentState createState() => _PastAppointmentState();
}

class _PastAppointmentState extends State<PastAppointment> {
  Future<void> _launched;
  var upcomintAppointments = PastAppointmentRepo();
  bool isloading = false;
 bool isError = false;
  List<Appointment> appointments = new List();
  Map<String, Counsellor> counsellor;

  @override
  void initState() {
    super.initState();
    isloading = true;
    getAppointment();
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.02,
            vertical: SizeConfig.blockSizeVertical),
        child: GestureDetector(
          onTap: () {
            // print(appointments.elementAt(index).time.toString());
          },
          child: Container(
            height: SizeConfig.blockSizeVertical * 80,
            child: appointments != null && appointments.length > 0
                ? ListView(
              children: appointwidget(),
            )
                : Container(
                    child: Center(
                        child: Text(
                      "You have not attended any sessions yet.",
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
          ),
        ));
  }
  dynamic appointvalue = new List();
  dynamic counsellors = new List();

  void getAppointment() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(' CLient ID ${prefs.getString("cleintid")}');
    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/past?client_id=${prefs.getString("cleintid")}';

    try {
      final response = await get(Uri.parse(uri));
      // print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("----------------"+responseJson["counsellors"].toString());

        setState(() {
          appointvalue = responseJson['appointments'];
          counsellors = responseJson;
          isError = false;
          isloading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isloading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isloading = false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }

  List<Widget> appointwidget() {
    List<Widget> appointmentlist = new List();
    for (int i = 0; i < appointvalue.length; i++) {
      print(appointvalue[i]['counsellor_id']);
      var counsellorid;
      counsellorid = counsellors[appointvalue[i]['counsellor_id']];
      appointmentlist.add(
          pastappointmentwidget(
              context,
              counsellors["counsellors"][appointvalue[i]['counsellor_id']]
              ["first_name"]==null?"":counsellors["counsellors"][appointvalue[i]['counsellor_id']]
              ["first_name"],
              counsellors["counsellors"][appointvalue[i]['counsellor_id']]
              ["type"],
              moodstatic[int.parse(appointvalue[i]['time'])],
              appointvalue[i]['date'].toString(),
            appointvalue[i]['counsellor_id'],
            appointvalue[i]['appointment_id'],
          ));

    }
    return appointmentlist;
  }
}
