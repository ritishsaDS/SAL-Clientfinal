import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/AddRatingcomment.dart';
import 'package:sal_user/UI/Home.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Addnote.dart';

class Rating extends StatefulWidget{
  var appointmentid;
  var counsellorid;
  Rating({this.appointmentid,this.counsellorid});
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var image = [
    "assets/icons/Angry.png",
    "assets/icons/Angry.png",
    "assets/icons/2star.png",

    "assets/icons/3star.png",
    "assets/icons/4star.png",
    "assets/icons/5star.png"

  ];
  bool isError = false;
  bool isLoading = false;
  var ratinglength=0;
  var ratingtypeapi;
  List<String> selectedList = [];

  var subtitle = [
    "Judgemental",
    "Insensitive",
    "Not Fruitful",
    "Uncomfortable",
    "Therapist Not Show"
  ];
  int _selectedIndex = 0;
  double price = 4.0;
  int rate = 0;
  @override
  void initState() {
    getRating();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
  body: SafeArea(child:  Container(
    height: SizeConfig.screenHeight,
    width: SizeConfig.screenWidth,
    child:SingleChildScrollView(
      child: Column( children: [
        Container(

          height: SizeConfig.screenHeight*0.8,

          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/icons/longcontainer.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          // color: Colors.blue,
          child: Image.asset(image[rate],scale: 1,),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: Colors.white,
            activeTrackColor: Color(backgroundColorBlue),
            inactiveTrackColor: Color(fontColorGray),
          ),
          child: Slider(
            min: 0,
            max: 5,
            value: price,
            divisions: 5,

            onChanged: (value) {

              setState(() {
                price = value;
                print(price.toString().split(".")[0]);
                rate=int.parse(price.toString().split(".")[0]);
                if(rate==1){
                  ratinglength=rating1.length;
                }
                else if(rate==2){
                  ratinglength=rating2.length;
                }
                else if(rate==3){
                  ratinglength=rating3.length;
                }
                else if(rate==4){
                  ratinglength=rating4.length;
                }
               else if(rate==5){
                  ratinglength=rating5.length;
                }
                else if(rate==0){
                  ratinglength=rating1.length;
                }
              });
            },
          ),
        ),
        Container(

child: Wrap(
  runSpacing: 20,
  spacing: 10,
children: moodswidget(),
),
        ),
        SizedBox(height: 30,),
        GestureDetector(
          onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddnoteRating(

                    )));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/Group 6894.png',),
                SizedBox(width: 10,),
                Text(
                  "Add a Comment",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        doneBtn()
      ]),
    ),
  ),),
);
  }
  List<Widget> moodswidget() {
    var opacuit = 1.0;
    List<Widget> moodlist = new List();
    for (int i = 0; i < ratinglength; i++) {
      moodlist.add(GestureDetector(
        onTap: () {
          if(rate==1){
           print(rating1[i]['rating_type']);
           ratingtypeapi=rating1[i]['rating_type'];
          }
          else if(rate==2){
            print(rating2[i]['rating_type']);
            ratingtypeapi=rating2[i]['rating_type'];
          }
          else if(rate==3){
            print(rating3[i]['rating_type']);
            ratingtypeapi=rating3[i]['rating_type'];
          }
          else if(rate==4){
            print(rating4[i]['rating_type']);
            ratingtypeapi=rating4[i]['rating_type'];
          }
          else if(rate==5){
            print(rating5[i]['rating_type']);
            ratingtypeapi=rating5[i]['rating_type'];
          }
          else if(rate==0){
            ratinglength=rating1.length;
          }
         _onSelected(i);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          decoration: BoxDecoration(
              color:  _selectedIndex != null &&
                  _selectedIndex == i
                  ? Colors.blue
                  : Colors.white,
              borderRadius:
              BorderRadius.circular(8),
              border: Border.all(
                  color:  _selectedIndex != null &&
                      _selectedIndex == i
                      ? Colors.white
                      : Colors.black,
                  width: 1.0)),
          height: SizeConfig.blockSizeVertical * 5,
          child:Text(price==0?rating1[i]['rating_type']:price==2?rating2[i]['rating_type']:price==3?rating3[i]['rating_type']:price==4?rating4[i]['rating_type']:price==1?rating1[i]['rating_type']:rating5[i]['rating_type'],style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _selectedIndex != null &&
              _selectedIndex == i
              ? Colors.white
              : Colors.black ),)
        ),
      ));
    }
    return moodlist;
  }
  Padding doneBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: MaterialButton(
        color: Color(0xff0066B3),
        height: 48,
        minWidth:Get.width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () async {
          giveRating();
        },
        child: Text(
          'Done',
          style: TextStyle(color: Colors.white, letterSpacing: 0.5),
        ),
      ),
    );
  }
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  dynamic rating1=new List();
  dynamic rating2=new List();
  dynamic rating3=new List();
  dynamic rating4=new List();
  dynamic rating5=new List();
  dynamic rating_types=new List();
  void getRating() async {
    setState(() {
      isLoading = true;
    });


    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/rating-type'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        rating_types=responseJson['rating_types'];

        setState(() {
          for(int i =0; i<rating_types.length;i++){
            if(rating_types[i]['rating_star']=="1"){
              rating1.add(rating_types[i]);
              ratinglength=rating1.length;
            }
            else if(rating_types[i]['rating_star']=="2"){
              rating2.add(rating_types[i]);


            }
            else if(rating_types[i]['rating_star']=="3"){
              rating3.add(rating_types[i]);

            }
            else if(rating_types[i]['rating_star']=="4"){
              rating4.add(rating_types[i]);

            }
            else if(rating_types[i]['rating_star']=="5"){
              rating5.add(rating_types[i]);

            }
          }
print(rating3);
          isError = false;
          isLoading = false;

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
  void giveRating() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("cleintid");
    Map<String, dynamic> data = {
      "appointment_id": widget.appointmentid.toString(),
      "client_id": pref.getString("cleintid"),
      "counsellor_id": widget.counsellorid,
      "rating": rate.toString(),
      "rating_comment": "string",
      "rating_types": ratingtypeapi.toString()
    };
    setState(() {
      isLoading = true;
    });
  
    try {
      final response = await post(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/rate'),body: jsonEncode(data));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        
          isError = false;
          isLoading = false;
Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeMain()));
      
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
}