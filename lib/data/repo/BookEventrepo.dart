import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:sal_user/UI/Razorpay.dart';
import 'package:sal_user/UI/Sessions.dart';
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/models/Appointmentlistener.dart';
import 'package:sal_user/models/Appointmenttherapistmodel.dart';
import 'package:sal_user/models/BookEventmodel.dart';
import 'package:sal_user/models/appointmentmode.dart';


class BookEventRepo {

   Future<void> diomwthod(Bookeventmodel adddishmodel,context) async {
    var types;
    var model;


      model = Bookeventmodel(eventOrderId:adddishmodel.eventOrderId,userId: adddishmodel.userId,couponCode: "" );


    dynamic loginwithserver=new List();

    print(adddishmodel.toJson());
    try {
      final response = await http.post(Uri.parse("https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/event/order"),


          body:json.encode(model));
      print("bjkb" + model.toString());
      print("bjkb" + model.toJson().toString());
      // showToast("Dish Added Successfully");

      if (response.statusCode == 200)
      {
        final responseJson = json.decode(response.body);

        loginwithserver = responseJson;
        print(responseJson);
        if(loginwithserver['meta']['status']=="200"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Razor(payment:loginwithserver['paid_amount_razorpay'],order:loginwithserver['order_id'],screen:"Event")));

          // if(screen=="Schedule"){
          //   Navigator.push(context,MaterialPageRoute(builder: (context)=>Sessions(mediaUrl: mediaurl,getData:data,date:adddishmodel.date,slot:adddishmodel.time,type:type,bill:loginwithserver)));
          //
          // }
          // else{
          //   Navigator.push(context,MaterialPageRoute(builder: (context)=>SummaryPayment(mediaUrl: mediaurl,getData:data,
          //       date:adddishmodel.date,slot:adddishmodel.time    ,sessionNumbers: session.toString(),billing:loginwithserver['paid_amount_razorpay'],order:loginwithserver['order_id'],type:type,bill:loginwithserver)));
          //
          // }
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