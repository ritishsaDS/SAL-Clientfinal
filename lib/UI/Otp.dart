import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/Home.dart';
import 'package:sal_user/UI/Schedulescreen.dart';
import 'package:sal_user/UI/Signup.dart';
import 'package:sal_user/UI/mood.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sal_user/data/repo/CreatetherapistProfileRepo.dart';
import 'package:sal_user/data/repo/sendOtpRepo.dart';
import 'package:sal_user/data/repo/verifyOtpRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Connect.dart';
import 'Professionalinfo.dart';

class OTPScreen extends StatefulWidget {
  String phonenumber;
  String screen;
  dynamic data;
  dynamic mediaurl;
  String type;
  var dob;
  var gender;

  OTPScreen(
      {this.phonenumber,
      this.screen,
      this.type,
      this.data,
      this.gender,
      this.dob,
      this.mediaurl});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var digit;
  bool  isError = false;
 bool isLoading = false;
  var sendOtp = SendOtptoPhoneRepo();
  var verifyOtp = VerifyOtpRepo();
  var createUser = CreateTherapistProfileRepo();
  bool selected=false;

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
                  digit = pin;
                  print(digit);
                  print("Completed: " + pin);

                  setState(() {
                    selected = true;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Dialogs.showLoadingDialog(context, loginLoader);
                  sendOtp
                      .sendOtp(
                    context: context,
                    phone: "+91" + widget.phonenumber,
                  )
                      .then((value) {
                        print(value);
                    if (value != null) {
                      if (value.meta.status == "200") {
                        Navigator.of(loginLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (conext) {
                          return OTPScreen(phonenumber:widget.phonenumber,screen:widget.screen,mediaurl: widget.mediaurl,data: widget.data,type: widget.type,);
                        }));
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
                },
                child: Text(
                  "RESEND OTP",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.blockSizeVertical * 1.5,
                    color: Color(backgroundColorBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          backgroundColor: selected == true ? Colors.blue : Colors.grey,
          onPressed: () {
            // if (digit.isNotEmpty) {
            //   Dialogs.showLoadingDialog(context, loginLoader);
            //
            //
            //   verifyOtp
            //       .verifyOtp(phone: "91" + widget.phonenumber, otp: digit)
            //       .then((value) async {
            //     print('STATUS:${value}');
            //     if (value != null) {
            //       print('STATUS:${value}');
            //       if (value.meta.status == "200") {
            //         print('STATUS:${value.meta.status}');
            //         Navigator.of(loginLoader.currentContext,
            //                 rootNavigator: true)
            //             .pop();
            //
            //         // toast(value.meta.message);
            //         print('Client ID:${ value.client.clientId}');
            //         if (widget.screen == "Home") {
            //           SharedPreferences prefs =
            //               await SharedPreferences.getInstance();
            //
            //           prefs.setString("cleintid", value.client.clientId);
            //           prefs.setString("email", value.client.email);
            //           prefs.setString("phone", value.client.phone);
            //           prefs.setString("name", value.client.firstName);
            //           Get.offAll(ProfessionalInfo1());
            //           // setState(() {
            //           //   Navigator.push(
            //           //       context,
            //           //       MaterialPageRoute(
            //           //           builder: (context) => ProfessionalInfo1()));
            //           // });
            //         }
            //
            //         else if(  widget.screen == null){
            //           SharedPreferences prefs =
            //           await SharedPreferences.getInstance();
            //
            //           prefs.setString("cleintid", value.client.clientId);
            //           prefs.setString("email", value.client.email);
            //           prefs.setString("phone", value.client.phone);
            //           prefs.setString("name", value.client.firstName);
            //           Get.offAll(HomeMain());
            //         }
            //         else {
            //           Dialogs.showLoadingDialog(context, loginLoader);
            //           Get.to(ProfessionalInfo1());
            //           /* Future.delayed(Duration(seconds: 2)).then((value) {
            //       SharedPreferencesTest().checkIsLogin("0");
            //       Navigator.of(context).pushNamed('/Price5');
            //     });*/
            //           // print(mobileController.text);
            //           createUser
            //               .createCounsellor(
            //                   age: widget.dob,
            //                   gender: widget.gender,
            //                   context: context,
            //                   timezone: "4:50",
            //                   device_id: "frst5533",
            //                   location: "45.333",
            //                   email: email.text,
            //                   experience: experience.text,
            //                   first_name: firstNameController.text,
            //                   last_name: lastNameController.text,
            //                   phone: "91" + phone.text)
            //               .then((value) async {
            //             if (value != null) {
            //               //print(value.meta.status);
            //               print(createUser.createCounsellor());
            //               if (value.meta.status == "200") {
            //                 Navigator.of(loginLoader.currentContext,
            //                         rootNavigator: true)
            //                     .pop();
            //                 // print(value.meta.message);
            //                 // print(value.meta.status);
            //                 // print(value.clientId);
            //
            //                 SharedPreferences prefs =
            //                     await SharedPreferences.getInstance();
            //
            //                 prefs.setString("cleintid", value.clientId);
            //                 prefs.setString("email", email.text);
            //                 prefs.setString("phone", "91" + phone.text);
            //                 prefs.setString("name", firstNameController.text);
            //
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => Connect()));
            //               } else {
            //                 Navigator.of(loginLoader.currentContext,
            //                         rootNavigator: true)
            //                     .pop();
            //                 showAlertDialog(
            //                   context,
            //                   value.meta.message,
            //                   "",
            //                 );
            //               }
            //             }
            //           }).catchError((error) {
            //             Navigator.of(loginLoader.currentContext,
            //                     rootNavigator: true)
            //                 .pop();
            //             showAlertDialog(
            //               context,
            //               error.toString(),
            //               "",
            //             );
            //           });
            //         }
            //       }
            //       else {
            //         // firstController.clear();
            //         //
            //         Navigator.of(loginLoader.currentContext,
            //                 rootNavigator: true)
            //             .pop();
            //         showAlertDialog(
            //           context,
            //           value.meta.message,
            //           "",
            //         );
            //       }
            //     }
            //     else {
            //       Navigator.of(loginLoader.currentContext, rootNavigator: true)
            //           .pop();
            //       showAlertDialog(
            //         context,
            //         value.meta.message,
            //         "",
            //       );
            //     }
            //   }).catchError((error) {
            //     print('error MSG:$error');
            //     // Navigator.of(loginLoader.currentContext, rootNavigator: true)
            //     //     .pop();
            //
            //     // Fluttertoast.showToast(msg: "Please Do Signup First");
            //     // Get.offAll(SignUp());
            //   });
            // } else {
            //   //  toast("Otp is required");
            // }
            verifyOTP();
          }),
    );
  }
  void verifyOTP()async{
    setState(() {
      isLoading = true;
    });
print(digit);
    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/verifyotp?phone=${"91" + widget.phonenumber}&otp=${digit}'));

      print(response.request);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
       print(responseJson);
if(responseJson['meta']['status']=="200"){
  if(responseJson['meta']['message']=="Incorrect OTP"){
    showAlertDialog(
      context,
      responseJson['meta']['message'],
      "",
    );
  }
  else if(responseJson['access_token']==null){
    if(widget.screen=="Appointment"){
      Get.to(ProfessionalInfo1(signup:false,phone:widget.phonenumber,screen:widget.screen,mediaurl: widget.mediaurl,data: widget.data,type: widget.type,));

    }
    else{
      Get.to(ProfessionalInfo1(signup:false,phone:widget.phonenumber,screen: widget.screen,));

    }

  }
  else{
    print(responseJson["client"]['client_id']);
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    prefs.setString("cleintid", responseJson["client"]['client_id']);
    prefs.setString("email", responseJson["client"]['email']);
    prefs.setString("phone",  responseJson["client"]['phone']);
    prefs.setString("name",responseJson["client"]['first_name']);
    print(widget.screen);
    if(widget.screen=="Appointment"){
      Get.to(DynamicEvent( data: widget.data,
        mediaurl: widget.mediaurl,
        type: widget.type,));

    }
    else if(widget.screen=="Mood"){
      Get.to(Mood());
    }
    else{
      Get.to(HomeMain());
    }
  }
}
else{
  showAlertDialog(context, responseJson['meta']['message'], "");
}
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
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
}
