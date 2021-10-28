import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/Sessions.dart';
import 'package:sal_user/UI/webview.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/CreatetherapistProfileRepo.dart';
import 'package:sal_user/data/repo/sendOtpRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Myprofile.dart';
import 'Otp.dart';
import 'Schedulescreen.dart';
import 'login.dart';

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController price2 = TextEditingController();
TextEditingController about = TextEditingController();
TextEditingController experience = TextEditingController();
TextEditingController email = TextEditingController();
DateTime selectedDob = DateTime.now();

class SignUp extends StatefulWidget {
  dynamic data;
  dynamic mediaurl;
  dynamic type;
  final Map<String, dynamic> slot;


  SignUp({this.data, this.mediaurl, this.type, this.slot});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkboxvalue = false;
  GlobalKey<FormState> nameForm = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();

  String date = DateTime.now().toString();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: DateTime(1980, 1),
      lastDate: DateTime(2101),
      currentDate: selectedDob,
    );

    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
      });
    }
  }

  FocusNode firstNameFocusNode;
  FocusNode lastNameFocusNode;
  var createUser = CreateTherapistProfileRepo();
  bool selected = false;
  bool filledFn = false;
  bool filledLn = false;
  String radioValue = "";
  var sendOtp = SendOtptoPhoneRepo();

  @override
  void initState() {
    // TODO: implement initState
    // print(widget.gender);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Color(0XFF001736),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0XFF001736),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height * 1.05,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                  right: SizeConfig.screenWidth * 0.05,
                  left: SizeConfig.screenWidth * 0.05,
                ),
                alignment: Alignment.center,
                child: Form(
                  key: nameForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        focusNode: firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          hintText: "First Name",
                          isDense: true,
                          contentPadding: EdgeInsets.all(
                              SizeConfig.blockSizeVertical * 1.5),
                        ),
                        onFieldSubmitted: (term) {
                          firstNameFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(lastNameFocusNode);
                          filledFn = true;
                        },
                        onChanged: (v) {
                          setState(() {
                            filledFn = true;
                          });
                        },
                        validator: (c) {
                          if (c.isEmpty) return "Please fill required fields";
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      TextFormField(
                        onChanged: (v) {
                          setState(() {
                            filledLn = true;
                          });
                        },
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          hintText: "Last Name",
                          isDense: true,
                          contentPadding: EdgeInsets.all(
                              SizeConfig.blockSizeVertical * 1.5),
                        ),
                        onFieldSubmitted: (term) {
                          lastNameFocusNode.unfocus();
                          filledLn = true;
                        },
                        validator: (c) {
                          if (c.isEmpty) return "Please fill required fields";
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Gender",
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        child: RadioListTile<String>(
                          value: "Male",
                          groupValue: radioValue.toString(),
                          onChanged: (String value) {
                            setState(() {
                              radioValue = value;
                              selected = true;
                            });
                          },
                          title: Text(
                            "Male",
                            style: TextStyle(color: Color(fontColorGray)),
                          ),
                        ),
                      ),
                      Container(
                        child: RadioListTile<String>(
                          value: "Female",
                          groupValue: radioValue.toString(),
                          onChanged: (String value) {
                            setState(() {
                              radioValue = value;
                              selected = true;
                            });
                          },
                          title: Text(
                            "Female",
                            style: TextStyle(color: Color(fontColorGray)),
                          ),
                        ),
                      ),
                      Container(
                        child: RadioListTile<String>(
                          value: "Other",
                          groupValue: radioValue.toString(),
                          onChanged: (String value) {
                            setState(() {
                              radioValue = value;
                              selected = true;
                            });
                          },
                          title: Text(
                            "Other",
                            style: TextStyle(color: Color(fontColorGray)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("DOB"),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            selectDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            // alignment: Alignment.center,
                            width: SizeConfig.screenWidth * 0.3,
                            child: Text(
                              "${selectedDob.day}" +
                                  "/" +
                                  "${selectedDob.month}" +
                                  "/" +
                                  "${selectedDob.year}"
                                      .split(' ')[0]
                                      .replaceAll("-", "/"),
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                            height: SizeConfig.blockSizeVertical * 4,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[800],
                                ),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: experience,
                          // focusNode: firstNameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            hintText: "Experience",
                            isDense: true,
                            contentPadding: EdgeInsets.all(
                                SizeConfig.blockSizeVertical * 1.5),
                          ),
                          onFieldSubmitted: (term) {
                            firstNameFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(lastNameFocusNode);
                            filledFn = true;
                          },
                          onChanged: (v) {
                            setState(() {
                              filledFn = true;
                            });
                          },
                          validator: (c) {
                            if (c.isEmpty) return "Please fill required fields";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: email,
                          // focusNode: firstNameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            hintText: "Email",
                            isDense: true,
                            contentPadding: EdgeInsets.all(
                                SizeConfig.blockSizeVertical * 1.5),
                          ),
                          onFieldSubmitted: (term) {
                            firstNameFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(lastNameFocusNode);
                            filledFn = true;
                          },
                          onChanged: (v) {
                            setState(() {
                              filledFn = true;
                            });
                          },
                          validator: (c) {
                            if (c.isEmpty) return "Please fill required fields";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: phone,
                          // focusNode: firstNameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 10,

                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(fontColorGray))),
                            hintText: "Phone Number",
                            isDense: true,
                            contentPadding: EdgeInsets.all(
                                SizeConfig.blockSizeVertical * 1.5),
                          ),
                          onFieldSubmitted: (term) {
                            firstNameFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(lastNameFocusNode);
                            filledFn = true;
                          },
                          onChanged: (v) {
                            setState(() {
                              filledFn = true;
                            });
                          },
                          validator: (c) {
                            if (c.isEmpty) return "Please fill required fields";
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: checkboxvalue,
                        onChanged: (val) {
                          setState(() {
                            checkboxvalue = val;
                          });
                        }),
                    Text(
                      "I Agree to ",
                      style: GoogleFonts.openSans(
                          fontSize: SizeConfig.blockSizeVertical * 1.7,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewClass(
                                      link:
                                          "https://sal-foundation.com/about-sal")));
                        },
                        child: Text(
                          "Terms & Condition",
                          style: GoogleFonts.openSans(
                              color: Color(backgroundColorBlue),
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    print(radioValue.toString());
                    print(selectedDob.toString().substring(0, 10));
                    Dialogs.showLoadingDialog(context, loginLoader);
                    /* Future.delayed(Duration(seconds: 2)).then((value) {
                  SharedPreferencesTest().checkIsLogin("0");
                  Navigator.of(context).pushNamed('/Price5');
                });*/
                    // print(mobileController.text);
                    createUser
                        .createCounsellor(
                            age: selectedDob.toString().substring(0, 10),
                            context: context,
                            timezone: "4:50",
                            device_id: "frst5533",
                            gender: radioValue.toString(),
                            location: "45.333",
                            email: email.text,
                            experience: experience.text,
                            first_name: firstNameController.text,
                            last_name: lastNameController.text,
                            phone: "91" + phone.text)
                        .then((value) async {
                      if (value != null) {
                        print(value.meta.status);
                        print(createUser.createCounsellor());
                        if (value.meta.status == "200") {
                          Navigator.of(loginLoader.currentContext,
                                  rootNavigator: true)
                              .pop();
                          print(value.meta.message);
                          print(value.meta.status);
                          print(value.clientId);

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString("cleintid", value.clientId);
                          prefs.setString("email", email.text);
                          prefs.setString("phone", "91" + phone.text);
                          prefs.setString("name", firstNameController.text);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DynamicEvent(
                                        data: widget.data,
                                        mediaurl: widget.mediaurl,
                                    slot: widget.slot,

                                  )));
                        }
                        else {
                          Navigator.of(loginLoader.currentContext,
                                  rootNavigator: true)
                              .pop();
                          showAlertDialog(
                            context,
                            value.meta.message,
                            "",
                          );
                          if (value.meta.message ==
                              "Verify phone number wth OTP") {
                            print("knrjorn");

                            Dialogs.showLoadingDialog(context, loginLoader);
                            sendOtp
                                .sendOtp(
                              context: context,
                              phone: "91" + phone.text,
                            )
                                .then((value) {
                              if (value != null) {
                                if (value.meta.status == "200") {
                                  Navigator.of(loginLoader.currentContext,
                                          rootNavigator: true)
                                      .pop();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (conext) {
                                    return OTPScreen(
                                        phonenumber: phone.text,
                                        screen: "Signup",
                                        data: widget.data,
                                        mediaurl: widget.mediaurl,
                                        type: widget.type,
                                        gender: radioValue.toString(),
                                        dob: selectedDob
                                            .toString()
                                            .substring(0, 10));
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

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(screen:"Signup")));
                          } else {
                            print(value.meta.message);
                          }
                        }
                      } else {
                        print("nkascdsdjsdv;jo");
                        Navigator.of(loginLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        showAlertDialog(
                          context,
                          value.meta.message,
                          "",
                        );
                        if (value.meta.message ==
                            "Verify phone number with OTP") {
                          print("knrjorn");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreen(screen: "Signup")));
                        } else {
                          print("kaanrjorn");
                        }
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
                  color: Colors.blue,
                  minWidth: SizeConfig.screenWidth * 0.4,
                  child: Text(
                    "SUBMIT",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
