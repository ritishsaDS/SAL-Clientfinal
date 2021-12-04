import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/UI/CousellorProfile.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/NavigationBar.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/data/repo/getTherapistDetailRepo.dart';
import 'package:sal_user/models/getTherapistDetailModal.dart';

import 'SearchResult.dart';

class Connects extends StatefulWidget {

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connects> {
  bool isError = false;
 bool isLoading = false;
 String date='2021-12-19';
  var value = [];
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
    "23:30",
    "24:00"
  ];
@override
  void initState() {getdatafromserver();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
return Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        RaisedButton(
          onPressed: (){
            setState(() {
              date="2021-12-05";
              getdatafromserver();
            });

          },
          child: Text("jkhjino"),
        ),
        Expanded(
          child: ListView(
            children:  slotarray()
            ,
          ),
        )
      ],
    ),
  ),
);
  }

dynamic myslots=new List();

void getdatafromserver() async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await get(Uri.parse(
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/counsellor/slots?counsellor_id=p2zg2'));
    print("bjkb" + response.body.toString());
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      setState(() {
        isError = false;
        isLoading = false;
        print('setstate');
      });
      value=[];
      for(int i =0; i<responseJson['slots'].length;i++){
        if(responseJson['slots'][i]['date']==date){
          print("jfvjnfvjnl");
          print(responseJson['slots'][i]);
         setState(() {
           myslots=responseJson['slots'][i];

         });

        setState(() {
          myslots.keys.forEach((key) {
            value.add(key);
            print(value.length);

          });
        });
        }
        else{
          setState(() {

          });
        }
      }
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
  }}
  List<Widget> slotarray() {

      print(value.length);
      List<Widget> slotlist = new List();
      for (int i = 0; i < value.length; i++) {
        print('INdex:${(i / 2) == 0}');
        print("knejknp" + value[i].length.toString());
        if (i.isEven) {
          slotlist.add(
            value[i].length < 3
                ? GestureDetector(
              onTap: () {

              },
              child: Container(
                width: SizeConfig.screenWidth * 0.2,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Text(moodstatic[int.parse(value[i])].toString()),
                alignment: Alignment.center,
              ),
            )
                : Container(),
          );
        }
      }
      return slotlist;
    }
  }


