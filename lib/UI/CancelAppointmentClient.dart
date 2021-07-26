import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';


class CancelAppointmentClient extends StatefulWidget {
  const CancelAppointmentClient({Key key}) : super(key: key);

  @override
  _CancelAppointmentClientState createState() => _CancelAppointmentClientState();
}

class _CancelAppointmentClientState extends State<CancelAppointmentClient> {

  int radioGroup = -1;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text("Cancel Appointment",style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),),
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05
              ),
              child: Text("Please tell us the reason for cancelling the appointment",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    color: Color(fontColorSteelGrey),
                    fontSize: SizeConfig.blockSizeVertical * 2.5
                ),),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05
              ),
              child: Text("15% cancellation fees applicable",
                style: GoogleFonts.openSans(
                    color: Color(fontColorGray),
                ),),
            ),
            RadioListTile(
                value: 1,
                activeColor: Color(backgroundColorBlue),
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text("I found help elsewhere",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),),
                onChanged: (value){
                  setState(() {
                    radioGroup = value;
                  });
                }),
            RadioListTile(
                value: 2,
                activeColor: Color(backgroundColorBlue),
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text("I want a different counsellor",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),),
                onChanged: (value){
                  setState(() {
                    radioGroup = value;
                  });
                }),
            RadioListTile(
                value: 3,
                activeColor: Color(backgroundColorBlue),
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text("I want to change date and time",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),),
                onChanged: (value){
                  setState(() {
                    radioGroup = value;
                  });
                }),
            RadioListTile(
                value: 4,
                activeColor: Color(backgroundColorBlue),
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text("Other",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),),
                onChanged: (value){
                  setState(() {
                    radioGroup = value;
                  });
                }),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 2
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/CounsellorProfile2');
                    },
                    color: Colors.white,
                    minWidth: SizeConfig.screenWidth * 0.4,
                    child: Text("DON'T",style: GoogleFonts.openSans(
                      color: Color(fontColorGray),
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Color(fontColorGray)
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      toast("Appointment Cancel successfully");
                      Navigator.of(context).pushNamed('/CancelSuccessful');
                    },
                    color: Color(backgroundColorBlue),
                    minWidth: SizeConfig.screenWidth * 0.4,
                    child: Text("CANCEL",style: GoogleFonts.openSans(
                      color: Colors.white,
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.blue
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class GoogleFonts {
}
