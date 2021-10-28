import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/ListTileCafe1.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/upcomingappointmentrepo.dart';
import 'package:sal_user/models/bookedappointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Connect.dart';

class UpcomingAppointment extends StatefulWidget {
  @override
  _UpcomingAppointmentState createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  Future<void> _launched;
  var upcomintAppointments = UpcomingAppointmentRepo();
  bool isloading = false;
  bool isError = false;
  List<Appointment> appointments = new List();
  Map<String, Counsellor> counsellor;

  @override
  void initState() {
    super.initState();
    getAppointment();
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
          // appointments.addAll(value.appointments);

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
        child: GestureDetector(
            onTap: () {
              // print(appointments.elementAt(index).time.toString());
            },
            child: Container(
              height: SizeConfig.blockSizeVertical * 80,
              child: appointvalue != null && appointvalue.length > 0
                  ? ListView(
                      children: appointwidget(),
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You have no upcoming sessions scheduled. ",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Connect();
                            }));
                          },
                          child: Text(
                            "BOOK APPOINTMENT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color(backgroundColorBlue),
                          minWidth: SizeConfig.screenWidth - 100,
                          height: SizeConfig.blockSizeVertical * 6,
                        ),
                      ],
                    )),
            )));
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
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/upcoming?client_id=${prefs.getString("cleintid")}';

    try {
      final response = await get(Uri.parse(uri));
      // print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        appointvalue = responseJson['appointments'];
        counsellors = responseJson;
        setState(() {
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
      appointmentlist.add(listTileCafe1(
          context,
          counsellors["counsellors"][appointvalue[i]['counsellor_id']]
              ["first_name"],
          moodstatic[int.parse(appointvalue[i]['time'])],
          appointvalue[i]['date'].toString()));
    }
    return appointmentlist;
  }
}
