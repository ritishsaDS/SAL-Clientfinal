import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'Myprofile.dart';

class Editprofile extends StatefulWidget{
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  GlobalKey<FormState> nameForm = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController email = TextEditingController();
  FocusNode firstNameFocusNode;
  FocusNode lastNameFocusNode;

  bool selected = false;
  bool filledFn = false;
  bool filledLn = false;
  String radioValue = "";

  @override void initState() {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
          child: Column(children: [
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
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        hintText: "First Name",
                        isDense: true,
                        contentPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                      ),
                      onFieldSubmitted: (term){
                        firstNameFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(lastNameFocusNode);
                        filledFn = true;
                      },
                      onChanged: (v){
                        setState(() {
                          filledFn = true;
                        });
                      },
                      validator: (c){
                        if(c.isEmpty)
                          return "Please fill required fields";
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    TextFormField(
                      onChanged: (v){
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
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(fontColorGray)
                            )
                        ),
                        hintText: "Last Name",
                        isDense: true,
                        contentPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                      ),
                      onFieldSubmitted: (term){
                        lastNameFocusNode.unfocus();
                        filledLn = true;
                      },
                      validator: (c){
                        if(c.isEmpty)
                          return "Please fill required fields";
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Gender",
                      style: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      child: RadioListTile<String>(
                        value: "Male", groupValue: radioValue.toString(), onChanged: (String value){
                        setState(() {
                          radioValue = value;
                          selected = true;
                        });
                      },
                        title: Text("Male",style: TextStyle(
                            color: Color(fontColorGray)
                        ),),),
                    ),
                    Container(
                      child: RadioListTile<String>(
                        value: "Female", groupValue: radioValue.toString(), onChanged: (String value){
                        setState(() {
                          radioValue = value;
                          selected = true;
                        });
                      },
                        title: Text("Female",style: TextStyle(
                            color: Color(fontColorGray)
                        ),),),
                    ),
                    Container(
                      child: RadioListTile<String>(
                        value: "Other", groupValue: radioValue.toString(), onChanged: (String value){
                        setState(() {
                          radioValue = value;
                          selected = true;
                        });
                      },
                        title: Text("Other",style: TextStyle(
                            color: Color(fontColorGray)
                        ),),),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: about,
                        // focusNode: firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                       // maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          hintText: "Date Of Birth",
                          isDense: true,
                          contentPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                        ),
                        onFieldSubmitted: (term){
                          firstNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(lastNameFocusNode);
                          filledFn = true;
                        },
                        onChanged: (v){
                          setState(() {
                            filledFn = true;
                          });
                        },
                        validator: (c){
                          if(c.isEmpty)
                            return "Please fill required fields";
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: experience,
                        // focusNode: firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          hintText: "Experience",
                          isDense: true,
                          contentPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                        ),
                        onFieldSubmitted: (term){
                          firstNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(lastNameFocusNode);
                          filledFn = true;
                        },
                        onChanged: (v){
                          setState(() {
                            filledFn = true;
                          });
                        },
                        validator: (c){
                          if(c.isEmpty)
                            return "Please fill required fields";
                        },
                      ),
                    ), SizedBox(height: 10,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: email,
                        // focusNode: firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color(fontColorGray)
                              )
                          ),
                          hintText: "Email",
                          isDense: true,
                          contentPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                        ),
                        onFieldSubmitted: (term){
                          firstNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(lastNameFocusNode);
                          filledFn = true;
                        },
                        onChanged: (v){
                          setState(() {
                            filledFn = true;
                          });
                        },
                        validator: (c){
                          if(c.isEmpty)
                            return "Please fill required fields";
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 40,
              ),
            ),
            Container(child:MaterialButton(
              onPressed: () {
                print(email.text);
                Dialogs.showLoadingDialog(context, loginLoader);
                /* Future.delayed(Duration(seconds: 2)).then((value) {
                      SharedPreferencesTest().checkIsLogin("0");
                      Navigator.of(context).pushNamed('/Price5');
                    });*/
                // print(mobileController.text);
                // createUser
                //     .createCounsellor(
                //     aadhar: "adhaarDoc", about: about.text, certificate: "certificateDoc" , device_id: "",education: "",email:email.text,experience: experience.text,first_name: firstNameController.text,gender: "Male",language_ids: "2",last_name: lastNameController.text, linkedin:"linkController.text" ,phone: "91"+ widget.phone,photo: "",price: price1.text,price_3:price2.text ,price_5:price2.text,resume: "",topic_ids:""
                // )
                    //.then((value) async {
                // if (value != null) {
                //   print("jkbsdvbjk"+value.meta.status.toString());
                //   if (value.meta.status == "200") {
                //     Navigator.of(loginLoader.currentContext,
                //         rootNavigator: true)
                //         .pop();
                //     toastLong("Profile Updated");
                //     Navigator.push(context,MaterialPageRoute(builder: (context)=>MyProfile()));
                //
                //     // toastLong(value.meta.message);
                //     // toastLong("Profile Update")
                //     //toast(value.meta.message);
                //     // SharedPreferencesTest().checkIsLogin("0");
                //     // SharedPreferencesTest().saveTherapistId(value.therapistId);
                //     // SharedPreferences prefs= await SharedPreferences.getInstance();
                //     // prefs.setString("therapistid", value.therapistId);
                //     // prefs.setString("firstname", firstNameController.text);
                //     // prefs.setString("lastname", lastNameController.text);
                //         ;
                //   } else {
                //     toastLong("Profile Update");
                //     Navigator.of(loginLoader.currentContext,
                //         rootNavigator: true)
                //         .pop();
                //     showAlertDialog(
                //       context,
                //       value.meta.message,
                //       "",
                //     );
                //   }
                //   // } else {
                //     Navigator.of(loginLoader.currentContext,
                //         rootNavigator: true)
                //         .pop();
                //     showAlertDialog(
                //       context,
                //       value.meta.message,
                //       "",
                //     );
                //   }
                // }).catchError((error) {
                //   Navigator.of(loginLoader.currentContext,
                //       rootNavigator: true)
                //       .pop();
                //   showAlertDialog(
                //     context,
                //     error.toString(),
                //     "",
                //   );
                // });
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
            ),)
          ],),
        ),
      ),
    );
  }
}