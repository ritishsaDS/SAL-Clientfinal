import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:sal_user/UI/Connect.dart';
import 'package:sal_user/UI/Sessions.dart';
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/models/Appointmentlistener.dart';
import 'package:sal_user/models/Appointmenttherapistmodel.dart';
import 'package:sal_user/models/appointmentmode.dart';


class Reschedulebooking {

  static Future<void> diomwthod(appointment,slotid,selectdate,type,name,context) async {
    var types;
    var model;
    var type;
    var body = {



      "date":selectdate.toString().substring(0,10),
      "time": slotid,

    };
    dynamic loginwithserver=new List();

    print(body);
    try {
      final response = await http.put(Uri.parse("https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment?appointment_id=${appointment}"),


          body:json.encode(body));
      print("bjkb" + body.toString());
      //print("bjkb" + model.toJson().toString());
      // showToast("Dish Added Successfully");

      if (response.statusCode == 200)
      {
        final responseJson = json.decode(response.body);

        loginwithserver = responseJson;
        if(loginwithserver['meta']['status']=="200"){

          showAlertDialog(
            context,
            "Appointment Reschedule Successfully",
            "",
          );
          Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              backgroundColor: Colors.transparent,
              child: Container(
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.screenHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 2
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Appointment has been successfully scheduled!",
                      style: TextStyle(
                          color: Color(fontColorSteelGrey),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 2.5
                      ),),
                    Container(
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(name,
                            style: GoogleFonts.openSans(
                              color: Color(fontColorSteelGrey),
                            ),),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal,
                          ),
                          Image.asset('assets/bg/circle.png',
                            height: SizeConfig.blockSizeVertical * 0.5,),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal,
                          ),
                          Text(type=="1"?"Counsellor":type=="2"?"Listener":"Therapist", style: GoogleFonts.openSans(
                            color: Color(fontColorSteelGrey),
                          ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TIME",
                            style: TextStyle(
                                color: Color(fontColorGray),
                                fontWeight: FontWeight.w600
                            ),),
                          Text("DATE",
                            style: TextStyle(
                                color: Color(fontColorGray),
                                fontWeight: FontWeight.w600
                            ),)
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(slotid,
                            style: TextStyle(
                              color: Color(fontColorGray),
                            ),),
                          Text(selectdate.toString().substring(0,10),
                            style: TextStyle(
                              color: Color(fontColorGray),
                            ),),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 6,
                      ),
                      child: MaterialButton(onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Connect()));
                      },
                        child: Text("CONTINUE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),),
                        minWidth: SizeConfig.screenWidth,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        color: Color(backgroundColorBlue),),
                    ),
                  ],
                ),
              )
          );
        }
        else{
          showAlertDialog(
            context,
            loginwithserver['meta']['message'],
            "",
          );
        }

        // print(loginwithserver['data']['email']);
        print(loginwithserver);

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // preferences.setString("token", loginwithserver['token']['original']['access_token']);
        // preferences.setInt("chefid", loginwithserver['data'][0]['id']);
        // // preferences.setString("token", loginwithserver['token']['original']['access_token']);
        // print(preferences.getInt("chefid"));
        // print( preferences.getString("token"));
        // showToast("Login Successfully");
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyBottomBarDemo()));
        // preferences.setString("login", "cook");


        // showToast("");
        //savedata();

      } else {
        print("bjkb" + response.statusCode.toString());
        //showToast("Mismatch Credentials");

      }
    } catch (e) {
      print(e);

    }
  }
}