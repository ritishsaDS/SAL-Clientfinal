import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

Widget listTileCafe1(BuildContext context,
    String contactName,
    String time,

    String date
    ){
  SizeConfig().init(context);
  return InkWell(
    onTap: (){
     // Navigator.of(context).pushNamed('/Cafe3');
    },
    child: Container(
      //color: Colors.blue[900],
      margin: EdgeInsets.only(
        bottom: SizeConfig.blockSizeVertical * 2,
        right: SizeConfig.screenWidth * 0.05
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: SizeConfig.screenWidth * 0.45,
            child: Text(contactName,style: GoogleFonts.openSans(
              color: Color(fontColorGray),
              fontWeight: FontWeight.w400
            ),),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  // onTap: onTap,
                  child: Container(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Text(date.substring(0,10),style: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                ),
                GestureDetector(
                  // onTap: onTap,
                  child: Container(
                    width: SizeConfig.screenWidth * 0.1,
                    child: Text(time,style: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}