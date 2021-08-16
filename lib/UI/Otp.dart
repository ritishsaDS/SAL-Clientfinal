import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sal_user/data/repo/verifyOtpRepo.dart';

import 'Professionalinfo.dart';

class OTPScreen extends StatefulWidget {
  String phonenumber;
  OTPScreen({this.phonenumber});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var digit;
  var verifyOtp = VerifyOtpRepo();
 // var sendOtp = send.SendOtptoPhone();
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
                length: 4,
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
                  digit=pin;
                  print(digit);
                  print("Completed: " + pin);

                 setState(() {
                   selected=true;
                 });


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
      floatingActionButton:FloatingActionButton(
          child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
          backgroundColor: selected == true? Colors.blue : Colors.grey,
          onPressed: () {
            if (digit.isNotEmpty
            ) {
              Dialogs.showLoadingDialog(context, loginLoader);
              verifyOtp
                  .verifyOtp(

                  phone: "91"+widget.phonenumber,
                  otp: digit

              ).then((value) async {

                if (value != null) {
                  if (value.meta.status == "200") {
                    Navigator.of(loginLoader.currentContext,
                        rootNavigator: true)
                        .pop();

                    toast(value.meta.message);
Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfessionalInfo1()));
                    if(value.therapist!=null){
                     // SharedPreferences prefs=await SharedPreferences.getInstance();
                     //  prefs.setString("therapistid",value.therapist.therapistId );
                     //  prefs.remove("firstname");
                     //  prefFs.remove("lastname");
                     //  prefs.setString("firstname",value.therapist.firstName );
                     //  prefs.setString("lastname",value.therapist.lastName );
                     //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMain()));

                    }
                    else{

                      // // Navigator.push(context, MaterialPageRoute(builder: (conext){
                      // //   return Price1(getOtp:  firstController.text
                      // //   );
                      // }));

                    }




                  } else {
                    // firstController.clear();
                    //
                    Navigator.of(loginLoader.currentContext,
                        rootNavigator: true)
                        .pop();
                    showAlertDialog(
                      context,
                      value.meta.message,
                      "",
                    );
                  }
                } else {
                  Navigator.of(loginLoader.currentContext,
                      rootNavigator: true)
                      .pop();
                  showAlertDialog(
                    context,
                    value.meta.message,
                    "",
                  );
                }
              }).catchError((error) {
                Navigator.of(loginLoader.currentContext,
                    rootNavigator: true)
                    .pop();
                showAlertDialog(
                  context,
                  error.toString(),
                  "",
                );
              });
            }else{
              toast("Otp is required");
            }
          }
      ),
    );
  }
}
