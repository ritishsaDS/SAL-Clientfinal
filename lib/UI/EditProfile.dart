import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/ActionSheet.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Uploadimage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Myprofile.dart';
import 'Professionalinfo.dart';

class Editprofile extends StatefulWidget{
  var firstname;
  var lastname;
  var gender;
  var phone;
  var email;
  var photo;
  Editprofile({this.lastname,this.gender,this.email,this.firstname,this.phone,this.photo});
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  var imagefromserver;

  bool   isError = false;
  var uploadImage = UploadImagesRepo();
  String profileimage;
  bool isloding = false;
  GlobalKey<FormState> nameForm = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController dob = TextEditingController();
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
    firstNameController = TextEditingController(text: widget.firstname);
    lastNameController = TextEditingController(text: widget.lastname);
radioValue=widget.gender;
  //  about = TextEditingController();
   // experience = TextEditingController();
    experience = TextEditingController(text:widget.phone);
    email = TextEditingController(text: widget.email);
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
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4.5),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: SizeConfig.blockSizeVertical * 7.5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: SizeConfig.blockSizeVertical * 7.45,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: image != null
                                    ? FileImage(File(image.path))
                                    :widget.photo==null? NetworkImage("https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png"):NetworkImage(widget.photo),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 55,
                        top: SizeConfig.blockSizeVertical * 10),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) => ActionSheet()
                                .actionSheet(context, onCamera: () {

                              FocusScope.of(context).unfocus();
                              chooseCameraFile().then((File file) {
                                if (file != null) {
                                  Dialogs.showLoadingDialog(context, loginLoader);
                                  uploadImage
                                      .uploadImage(
                                      context, image: image
                                  )
                                      .then((value) {
                                        print(value);
                                    if (value != null) {
                                      if (value.meta.status == "200") {
                                        setState(() {
                                          profileimage = value.file.toString();
                                          print("jnsdamkod"+ value.file.toString());
                                        });
                                        Navigator.of(loginLoader.currentContext,
                                            rootNavigator: true)
                                            .pop();
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
                                }
                              }).catchError((onError) {});
                            }, onGallery: () {

                              FocusScope.of(context).unfocus();
                              androidchooseImageFile().then((value) {
                                if (value != null) {
                                  Dialogs.showLoadingDialog(context, loginLoader);
                                  uploadImage
                                      .uploadImage(
                                      context, image: image
                                  )
                                      .then((value) {
                                    if (value != null) {
                                      if (value.meta.status == "200") {
                                        setState(() {
                                          profileimage = value.file.toString();
                                        });
                                        Navigator.of(loginLoader.currentContext,
                                            rootNavigator: true)
                                            .pop();
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
                                }
                                setState(() {
                                  //  loading = true;
                                });
                              }).catchError((onError) {});
                            }, text: "Select profile image"));
                      },
                      child: Container(
                        width: SizeConfig.blockSizeVertical * 4.5,
                        height: SizeConfig.blockSizeVertical * 4.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.blue,
                            size: SizeConfig.blockSizeVertical * 5,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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

                    // SizedBox(height: 10,),
                    // Container(
                    //   width:MediaQuery.of(context).size.width,
                    //   child: TextFormField(
                    //     controller: dob,
                    //     // focusNode: firstNameFocusNode,
                    //     textInputAction: TextInputAction.next,
                    //     keyboardType: TextInputType.number,
                    //    // maxLines: 5,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Color(fontColorGray)
                    //           )
                    //       ),
                    //       disabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Color(fontColorGray)
                    //           )
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Color(fontColorGray)
                    //           )
                    //       ),
                    //       errorBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Color(fontColorGray)
                    //           )
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Color(fontColorGray)
                    //           )
                    //       ),
                    //       focusedErrorBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Color(fontColorGray)
                    //           )
                    //       ),
                    //       hintText: "Age",
                    //       isDense: true,
                    //       contentPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                    //     ),
                    //     onFieldSubmitted: (term){
                    //       firstNameFocusNode.unfocus();
                    //       FocusScope.of(context).requestFocus(lastNameFocusNode);
                    //       filledFn = true;
                    //     },
                    //     onChanged: (v){
                    //       setState(() {
                    //         filledFn = true;
                    //       });
                    //     },
                    //     validator: (c){
                    //       if(c.isEmpty)
                    //         return "Please fill required fields";
                    //     },
                    //   ),
                    // ),
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
                          hintText: "Phone",
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

              SizedBox(
                height: 20,

            ),
            Container(child:MaterialButton(
              onPressed: () {
                print(email.text);
                updateprofile();
               // Dialogs.showLoadingDialog(context, loginLoader);
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
  updateprofile() async {
    setState(() {
      isloding = true;
    });
    SharedPreferences prefs=await  SharedPreferences.getInstance();
    prefs.getString("cleintid");
    var data={
      "age": dob.text,
      "device_id": "ffrers2383",
      "first_name": firstNameController.text,
      "gender": radioValue.toString(),
      "last_name": lastNameController.text,
      "location": "45.33",
      "timezone": "+5:30",
      "photo":profileimage,
      "topicid":list
    };
    var uri =
        "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client?client_id=${prefs.getString("cleintid")}";

  print(jsonEncode(data));
    try {
      final response = await put(Uri.parse(uri),body: (jsonEncode(data)));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
       // profile = responseJson['client'];
        // counsellorid=upcominglist['appointment_slots'][0]['counsellor_id'];
        //  print( upcominglist['appointment_slots'][0]['counsellor_id'],);

        if(responseJson["meta"]['status']=="200"){
          prefs.setString("name", firstNameController.text);
          showAlertDialog(
            context,
            "Profile Updated",
          "",

          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyProfile()));
        }
        setState(() {
          isError = false;
          isloding = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isloding = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isloding = false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
  File image;
  Future<File> chooseCameraFile() async {
    await ImagePicker.platform
        .pickImage(
      source: ImageSource.camera,
    )
        .then((value) async {
      setState(() {
        FocusScope.of(context).unfocus();
        image = new File(value.path);
      });
      if (image.path != null) {}

    }).catchError((error) {
      print(error.toString());
    });
    return image;
  }

  Future<File> androidchooseImageFile() async {
    await ImagePicker.platform
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) async {
      setState(() {
        FocusScope.of(context).unfocus();
        image = new File(value.path);
      });
      if (image.path != null) {}
    }).catchError((error) {
      print(error.toString());
    });
    return image;
  }
  }
