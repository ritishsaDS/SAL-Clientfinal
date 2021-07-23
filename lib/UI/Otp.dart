import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'Professionalinfo.dart';

class OTP extends StatefulWidget {
  String phonenumber;
  OTP({this.phonenumber});
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.05,
          right: SizeConfig.screenWidth * 0.05,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Enter your \nVerification Code",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  color: Color(fontColorSteelGrey),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              Text(
                "Sent to ${widget.phonenumber}",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                  color: Color(fontColorGray),
                ),
              ),
              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 55,
                fieldStyle: FieldStyle.underline,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfessionalInfo1()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "RESEND OTP",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                  color: Color(backgroundColorBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
