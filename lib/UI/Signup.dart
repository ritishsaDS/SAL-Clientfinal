import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  TextEditingController dobController=TextEditingController();
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
          height: MediaQuery.of(context).size.height * 0.90,
          // child: Column(
          //   children: [
          //     Container(
          //       margin: EdgeInsets.only(
          //         top: SizeConfig.blockSizeVertical * 2,
          //         right: SizeConfig.screenWidth * 0.05,
          //         left: SizeConfig.screenWidth * 0.05,
          //       ),
          //       alignment: Alignment.center,
          //       child: Form(
          //         key: nameForm,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             TextFormField(
          //               controller: firstNameController,
          //               focusNode: firstNameFocusNode,
          //               textInputAction: TextInputAction.next,
          //               keyboardType: TextInputType.name,
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 disabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 errorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 focusedErrorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 hintText: "First Name",
          //                 isDense: true,
          //                 contentPadding: EdgeInsets.all(
          //                     SizeConfig.blockSizeVertical * 1.5),
          //               ),
          //               onFieldSubmitted: (term) {
          //                 firstNameFocusNode.unfocus();
          //                 FocusScope.of(context)
          //                     .requestFocus(lastNameFocusNode);
          //                 filledFn = true;
          //               },
          //               onChanged: (v) {
          //                 setState(() {
          //                   filledFn = true;
          //                 });
          //               },
          //               validator: (c) {
          //                 if (c.isEmpty) return "Please fill required fields";
          //                 return null;
          //               },
          //             ),
          //             SizedBox(
          //               height: SizeConfig.blockSizeVertical * 2,
          //             ),
          //             TextFormField(
          //               onChanged: (v) {
          //                 setState(() {
          //                   filledLn = true;
          //                 });
          //               },
          //               controller: lastNameController,
          //               focusNode: lastNameFocusNode,
          //               textInputAction: TextInputAction.done,
          //               keyboardType: TextInputType.name,
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 disabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 errorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 focusedErrorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                         BorderSide(color: Color(fontColorGray))),
          //                 hintText: "Last Name",
          //                 isDense: true,
          //                 contentPadding: EdgeInsets.all(
          //                     SizeConfig.blockSizeVertical * 1.5),
          //               ),
          //               onFieldSubmitted: (term) {
          //                 lastNameFocusNode.unfocus();
          //                 filledLn = true;
          //               },
          //               validator: (c) {
          //                 if (c.isEmpty) return "Please fill required fields";
          //                 return null;
          //               },
          //             ),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             Text(
          //               "Gender",
          //               style: GoogleFonts.openSans(
          //                 color: Color(fontColorGray),
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             Container(
          //               child: RadioListTile<String>(
          //                 value: "Male",
          //                 groupValue: radioValue.toString(),
          //                 onChanged: (String value) {
          //                   setState(() {
          //                     radioValue = value;
          //                     selected = true;
          //                   });
          //                 },
          //                 title: Text(
          //                   "Male",
          //                   style: TextStyle(color: Color(fontColorGray)),
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               child: RadioListTile<String>(
          //                 value: "Female",
          //                 groupValue: radioValue.toString(),
          //                 onChanged: (String value) {
          //                   setState(() {
          //                     radioValue = value;
          //                     selected = true;
          //                   });
          //                 },
          //                 title: Text(
          //                   "Female",
          //                   style: TextStyle(color: Color(fontColorGray)),
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               child: RadioListTile<String>(
          //                 value: "Other",
          //                 groupValue: radioValue.toString(),
          //                 onChanged: (String value) {
          //                   setState(() {
          //                     radioValue = value;
          //                     selected = true;
          //                   });
          //                 },
          //                 title: Text(
          //                   "Other",
          //                   style: TextStyle(color: Color(fontColorGray)),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Text("DOB"),
          //             SizedBox(
          //               height: 5,
          //             ),
          //             Container(
          //               width: MediaQuery.of(context).size.width,
          //               child: InkWell(
          //                 onTap: () {
          //                   selectDate(context);
          //                 },
          //                 child: Container(
          //                   padding: EdgeInsets.all(5),
          //                   // alignment: Alignment.center,
          //                   width: SizeConfig.screenWidth * 0.3,
          //                   child: Text(
          //                     "${selectedDob.day}" +
          //                         "/" +
          //                         "${selectedDob.month}" +
          //                         "/" +
          //                         "${selectedDob.year}"
          //                             .split(' ')[0]
          //                             .replaceAll("-", "/"),
          //                     style: TextStyle(
          //                         fontSize: SizeConfig.blockSizeVertical * 2),
          //                   ),
          //                   height: SizeConfig.blockSizeVertical * 4,
          //                   decoration: BoxDecoration(
          //                       border: Border.all(
          //                         color: Colors.grey[800],
          //                       ),
          //                       borderRadius: BorderRadius.circular(5)),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //               width: MediaQuery.of(context).size.width,
          //               child: TextFormField(
          //                 controller: experience,
          //                 // focusNode: firstNameFocusNode,
          //                 textInputAction: TextInputAction.next,
          //                 keyboardType: TextInputType.number,
          //
          //                 decoration: InputDecoration(
          //                   border: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   disabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   enabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   errorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   focusedBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   focusedErrorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   hintText: "Experience",
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(
          //                       SizeConfig.blockSizeVertical * 1.5),
          //                 ),
          //                 onFieldSubmitted: (term) {
          //                   firstNameFocusNode.unfocus();
          //                   FocusScope.of(context)
          //                       .requestFocus(lastNameFocusNode);
          //                   filledFn = true;
          //                 },
          //                 onChanged: (v) {
          //                   setState(() {
          //                     filledFn = true;
          //                   });
          //                 },
          //                 validator: (c) {
          //                   if (c.isEmpty) return "Please fill required fields";
          //                   return null;
          //                 },
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //               width: MediaQuery.of(context).size.width,
          //               child: TextFormField(
          //                 controller: email,
          //                 // focusNode: firstNameFocusNode,
          //                 textInputAction: TextInputAction.next,
          //                 keyboardType: TextInputType.name,
          //
          //                 decoration: InputDecoration(
          //                   border: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   disabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   enabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   errorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   focusedBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   focusedErrorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   hintText: "Email",
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(
          //                       SizeConfig.blockSizeVertical * 1.5),
          //                 ),
          //                 onFieldSubmitted: (term) {
          //                   firstNameFocusNode.unfocus();
          //                   FocusScope.of(context)
          //                       .requestFocus(lastNameFocusNode);
          //                   filledFn = true;
          //                 },
          //                 onChanged: (v) {
          //                   setState(() {
          //                     filledFn = true;
          //                   });
          //                 },
          //                 validator: (c) {
          //                   if (c.isEmpty) return "Please fill required fields";
          //                   return null;
          //                 },
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //               width: MediaQuery.of(context).size.width,
          //               child: TextFormField(
          //                 controller: phone,
          //                 // focusNode: firstNameFocusNode,
          //                 textInputAction: TextInputAction.next,
          //                 keyboardType: TextInputType.number,
          //                 maxLength: 10,
          //
          //                 decoration: InputDecoration(
          //                   counterText: "",
          //                   border: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   disabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   enabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   errorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   focusedBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   focusedErrorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                       borderSide:
          //                           BorderSide(color: Color(fontColorGray))),
          //                   hintText: "Phone Number",
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(
          //                       SizeConfig.blockSizeVertical * 1.5),
          //                 ),
          //                 onFieldSubmitted: (term) {
          //                   firstNameFocusNode.unfocus();
          //                   FocusScope.of(context)
          //                       .requestFocus(lastNameFocusNode);
          //                   filledFn = true;
          //                 },
          //                 onChanged: (v) {
          //                   setState(() {
          //                     filledFn = true;
          //                   });
          //                 },
          //                 validator: (c) {
          //                   if (c.isEmpty) return "Please fill required fields";
          //                   return null;
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 20,
          //     ),
          //     Container(
          //       margin: EdgeInsets.only(left: 15),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Checkbox(
          //               value: checkboxvalue,
          //               onChanged: (val) {
          //                 setState(() {
          //                   checkboxvalue = val;
          //                 });
          //               }),
          //           Text(
          //             "I Agree to ",
          //             style: GoogleFonts.openSans(
          //                 fontSize: SizeConfig.blockSizeVertical * 1.7,
          //                 fontWeight: FontWeight.w400),
          //           ),
          //           Container(
          //             child: GestureDetector(
          //               onTap: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => WebViewClass(
          //                             link:
          //                                 "https://sal-foundation.com/about-sal")));
          //               },
          //               child: Text(
          //                 "Terms & Condition",
          //                 style: GoogleFonts.openSans(
          //                     color: Color(backgroundColorBlue),
          //                     fontSize: SizeConfig.blockSizeVertical * 2,
          //                     fontWeight: FontWeight.w400),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Container(
          //       child: MaterialButton(
          //         onPressed: () {
          //           print(widget.type.toString());
          //           print(selectedDob.toString().substring(0, 10));
          //           Dialogs.showLoadingDialog(context, loginLoader);
          //           /* Future.delayed(Duration(seconds: 2)).then((value) {
          //         SharedPreferencesTest().checkIsLogin("0");
          //         Navigator.of(context).pushNamed('/Price5');
          //       });*/
          //           // print(mobileController.text);
          //           createUser
          //               .createCounsellor(
          //                   age: selectedDob.toString().substring(0, 10),
          //                   context: context,
          //                   timezone: "4:50",
          //                   device_id: "frst5533",
          //                   gender: radioValue.toString(),
          //                   location: "45.333",
          //                   email: email.text,
          //                   experience: experience.text,
          //                   first_name: firstNameController.text,
          //                   last_name: lastNameController.text,
          //                   phone: "91" + phone.text)
          //               .then((value) async {
          //             if (value != null) {
          //               print(value.meta.status);
          //               print(createUser.createCounsellor());
          //               if (value.meta.status == "200") {
          //                 Navigator.of(loginLoader.currentContext,
          //                         rootNavigator: true)
          //                     .pop();
          //                 print(value.meta.message);
          //                 print(value.meta.status);
          //                 print(value.clientId);
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
          //                         builder: (context) => DynamicEvent(
          //                               data: widget.data,
          //                               mediaurl: widget.mediaurl,
          //                           slot: widget.slot,
          //
          //                         )));
          //               }
          //               else {
          //                 Navigator.of(loginLoader.currentContext,
          //                         rootNavigator: true)
          //                     .pop();
          //                 showAlertDialog(
          //                   context,
          //                   value.meta.message,
          //                   "",
          //                 );
          //                 if (value.meta.message ==
          //                     "Verify phone number wth OTP") {
          //                   print("knrjorn");
          //
          //                   Dialogs.showLoadingDialog(context, loginLoader);
          //                   sendOtp
          //                       .sendOtp(
          //                     context: context,
          //                     phone: "91" + phone.text,
          //                   )
          //                       .then((value) {
          //                     if (value != null) {
          //                       if (value.meta.status == "200") {
          //                         Navigator.of(loginLoader.currentContext,
          //                                 rootNavigator: true)
          //                             .pop();
          //                         Navigator.push(context,
          //                             MaterialPageRoute(builder: (conext) {
          //                           return OTPScreen(
          //                               phonenumber: phone.text,
          //                               screen: "Signup",
          //                               data: widget.data,
          //                               mediaurl: widget.mediaurl,
          //                               type: widget.type,
          //                               gender: radioValue.toString(),
          //                               dob: selectedDob
          //                                   .toString()
          //                                   .substring(0, 10));
          //                         }));
          //                       } else {
          //                         Navigator.of(loginLoader.currentContext,
          //                                 rootNavigator: true)
          //                             .pop();
          //                         showAlertDialog(
          //                           context,
          //                           value.meta.message,
          //                           "",
          //                         );
          //                       }
          //                     } else {
          //                       Navigator.of(loginLoader.currentContext,
          //                               rootNavigator: true)
          //                           .pop();
          //                       showAlertDialog(
          //                         context,
          //                         value.meta.message,
          //                         "",
          //                       );
          //                     }
          //                   }).catchError((error) {
          //                     Navigator.of(loginLoader.currentContext,
          //                             rootNavigator: true)
          //                         .pop();
          //                     showAlertDialog(
          //                       context,
          //                       error.toString(),
          //                       "",
          //                     );
          //                   });
          //
          //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(screen:"Signup")));
          //                 } else {
          //                   print(value.meta.message);
          //                 }
          //               }
          //             } else {
          //               print("nkascdsdjsdv;jo");
          //               Navigator.of(loginLoader.currentContext,
          //                       rootNavigator: true)
          //                   .pop();
          //               showAlertDialog(
          //                 context,
          //                 value.meta.message,
          //                 "",
          //               );
          //               if (value.meta.message ==
          //                   "Verify phone number with OTP") {
          //                 print("knrjorn");
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) =>
          //                             LoginScreen(screen: "Signup")));
          //               } else {
          //                 print("kaanrjorn");
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
          //         },
          //         color: Colors.blue,
          //         minWidth: SizeConfig.screenWidth * 0.4,
          //         child: Text(
          //           "SUBMIT",
          //           style: GoogleFonts.openSans(
          //             color: Colors.white,
          //           ),
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           side: BorderSide(color: Colors.blue),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Please provide us the \n following details",style: TextStyle( color: Color(0xff77849C),

                    fontSize: 20,
                    fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                        title: 'Name',
                        hint: 'Enter Name',
                        controller: firstNameController),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date of Birth',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    dateTimeFormField(
                      hint: 'Enter DOB',
                      controller: dobController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Gender',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 'Male',
                            groupValue: radioValue.toString(),
                            onChanged: (value) {
                              setState(() {
                                radioValue = 'Male';
                              });
                            }),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              color: Color(0xff77849C),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Radio(
                            value: 'Female',
                            groupValue: radioValue.toString(),
                            onChanged: (value) {
                              setState(() {
                                radioValue = 'Female';
                              });
                            }),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                              color: Color(0xff77849C),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Radio(
                            value: 'Other',
                            groupValue: radioValue.toString(),
                            onChanged: (value) {
                              setState(() {
                                radioValue = 'Other';
                              });
                            }),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Other',
                          style: TextStyle(
                              color: Color(0xff77849C),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textField(
                        title: 'Email Id',
                        hint: 'Enter Email Id',
                        controller: email),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                        title: 'Mobile Number',
                        hint: 'Enter Mobile number',
                        controller: phone),
                    SizedBox(
                      height: 20,
                    ),
                Container(
                       // margin: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                        Checkbox(
                                      value: checkboxvalue,
                                      onChanged: (val) {
                                        setState(() {
                                          checkboxvalue = val;
                                        });
                                      }),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I Agree to ",style: GoogleFonts.openSans(
                                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                                      color: Color(0xff77849C),
                                      fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: "Terms of Services",style:  GoogleFonts.openSans(
                                      color: Color(backgroundColorBlue),
                                      fontSize: SizeConfig.blockSizeVertical * 1.8,
                                      fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: " & ", style: GoogleFonts.openSans(
                                      color: Color(0xff77849C),
                                                    fontSize: SizeConfig.blockSizeVertical * 1.7,
                                                    fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: "\nPrivacy Policy ",style:  GoogleFonts.openSans(
                                                        color: Color(backgroundColorBlue),
                                                        fontSize: SizeConfig.blockSizeVertical * 1.8,
                                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 30),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => WebViewClass(
                    //                   link:
                    //                   "https://sal-foundation.com/about-sal")));
                    //     },
                    //     child: Text(
                    //       "Privacy Policy",
                    //       style: GoogleFonts.openSans(
                    //           color: Color(backgroundColorBlue),
                    //           fontSize: SizeConfig.blockSizeVertical * 2,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //   ),
                    // ),

                    doneBtn()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Column textField(
      {String title, String hint, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Color(0xff77849C),
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return '* Required';
            }
            return null;
          },
          controller: controller,
          keyboardType: title == 'Mobile Number'
              ? TextInputType.number
              : title == 'Email Id'
              ? TextInputType.emailAddress
              : TextInputType.text,
          inputFormatters: title == 'Mobile Number'
          ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff77849C)))),
        ),
      ],
    );
  }
  Future<DateTime> getDate(BuildContext context, {DateTime date}) async {
    final datePicked = await showDatePicker(
        context: context,
        firstDate:  DateTime(1947, 4),
        initialDate: date ?? DateTime.now(),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day);
    return datePicked;
  }

  Padding dateTimeFormField({String hint, TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DateTimeField(
        onShowPicker: (BuildContext context, DateTime currentValue) async {
          final datePicked = await getDate(context);
          if (datePicked != null) {
            print(datePicked);
          setState(() {
            dobController=TextEditingController(text: datePicked.toString().substring(0,10));
            //dobController.text = DateFormat('yyyy-MM-dd').format(datePicked);
            return datePicked;
          });
          }
          return null;
        },
        validator: (value) {
          if (value == null) {
            return '* Required';
          }
          return null;
        },
        // initialValue: date,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        format: DateFormat('dd-MM-yyyy'),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey.withOpacity(0.7),
              fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.only(
              top: Get.height * 0.010, bottom: Get.height * 0.01, left: 15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xff77849C))),
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
  Padding doneBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: MaterialButton(
        color: Color(0xff0066B3),
        height: 48,
        minWidth: Get.width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
    setState(() {

    });
    print(widget.type.toString());
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
    last_name: "",
    phone: "91" + phone.text)
        .then((value) async {
          print("jnkdjn;nkl"+value.toString());
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
    }
    else {
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
    }},
        child: Text(
          'NEXT',
          style: TextStyle(color: Colors.white, letterSpacing: 0.5),
        ),
      ),
    );
  }
}
