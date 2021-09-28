import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

Widget pastappointmentwidget(
    BuildContext context,
    String contactName,
    String time,

    String date
)
    {
  return Container(
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.02,
        vertical: SizeConfig.blockSizeVertical),
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
                "Sushmita Sinha",
                style: TextStyle(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "SCHEDULE",
                style: TextStyle(
                    color: Color(backgroundColorBlue),
                    fontSize:
                    SizeConfig.blockSizeVertical *
                        1.5,fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Counsellor",
                style: TextStyle(
                  color: Color(fontColorGray),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "3 Sessions",
                style: TextStyle(
                    color: Color(fontColorGray),
                    fontSize:
                    SizeConfig.blockSizeVertical *
                        1.5,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),

        SizedBox(
          height: SizeConfig.screenHeight * 0.2,
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal:
              SizeConfig.screenWidth * 0.1,
              vertical: SizeConfig.blockSizeVertical),
          child: Text(
              "You have no unused sessions scheduled. ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(fontColorSteelGrey))),
        ),
        MaterialButton(
          child: Text(
            "BOOK APPOINTMENT",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Color(backgroundColorBlue),
          onPressed: () {},
          minWidth: SizeConfig.screenWidth,
          height: SizeConfig.blockSizeVertical * 6,
        ),
      ],
    ),
  );
}