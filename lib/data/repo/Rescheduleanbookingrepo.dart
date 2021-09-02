import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:sal_user/UI/Sessions.dart';
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/models/Appointmentlistener.dart';
import 'package:sal_user/models/Appointmenttherapistmodel.dart';
import 'package:sal_user/models/appointmentmode.dart';


class Reschedulebooking {

  static Future<void> diomwthod(appointment,slotid,selectdate,context) async {
    var types;
    var model;
    var body = {

      "appointment_slot_id": appointment,

      "date":selectdate.toString().substring(0,10),
      "time": slotid,

    };
    dynamic loginwithserver=new List();

    print(body);
    try {
      final response = await http.post(Uri.parse("https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment"),


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
            "Appointment Book Successfully",
            "",
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