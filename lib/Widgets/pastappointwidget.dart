import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/UI/Connect.dart';
import 'package:sal_user/UI/Rating.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

Widget pastappointmentwidget(
    BuildContext context,
    String contactName,
    String type,
    String time,

    String date,
    String counsellorid,
    String appointmentid,


)

    {
      List months =
      ['jan', 'feb', 'mar', 'apr', 'may','jun','jul','aug','sep','oct','nov','dec'];
  return Container(
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.02,
       ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contactName,
                style: TextStyle(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                time.toString(),
                style: TextStyle(
                    color: Color(fontColorGray),
                    fontSize:
                    SizeConfig.blockSizeVertical *
                        1.5,
                    fontWeight: FontWeight.bold),
              )

            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type=="4"?"Therapist":type=="2"?"Listener":"Counsellor",style: GoogleFonts.openSans(
                  color: Color(fontColorGray),
                  fontWeight: FontWeight.w400
              ),),
              Container(
                  alignment: Alignment.centerRight,
                  width: SizeConfig.screenWidth * 0.5,
                  child:  Text("${date.toString().split("-")[2]+" "+months[int.parse(date.toString().split("-")[1])-1]}",
                    style: TextStyle(
                        color: Color(fontColorGray)
                    ),)

              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Rating(appointmentid: appointmentid,counsellorid:counsellorid ,)));
              },
              child: Container(
                width: SizeConfig.screenWidth*0.4,
                height: SizeConfig.blockSizeVertical*5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color:Color(fontColorGray))
                ),
                child: Center(child: Text("Rate")),),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Connect()));
              },
              child: Container(
                width: SizeConfig.screenWidth*0.4,
                height: SizeConfig.blockSizeVertical*5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0XFF0066B3)
                ),
                child: Center(child: Text("Book Again",style: TextStyle(color: Colors.white),)),),
            ),
          ],
        )


      ],
    ),
  );
}