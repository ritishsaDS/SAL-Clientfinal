import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditProfile.dart';
import 'Professionalinfo.dart';
import 'login.dart';

List<String> selectedInterestList = [];

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String imgBasePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';

  @override
  void initState() {}

  // bool isError = false;
  // bool isLoading = false;

  Future<void> getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("email"));
    print('EMAIL:${preferences.getString("email")}');
    await getprofile(preferences.getString("email"));
  }

  // bool isloding = false;

  Widget build(BuildContext context) {
    print('DSATA:$profile}');
    SizeConfig().init(context);
    List<Widget> widgetList = new List<Widget>();
    var child = SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            body: FutureBuilder(
                future: getid(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Server Error'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        leading: InkWell(
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        elevation: 0.0,
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        title: Text(
                          "My Profile",
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                          ),
                        ),
                        actions: [
                          Container(
                            padding: EdgeInsets.only(
                              right: SizeConfig.screenWidth * 0.02,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                            name: profile['first_name'] +
                                                ' ' +
                                                profile['last_name'],
                                            email: profile['email'],
                                            gender: profile['gender'],
                                            dob: profile['date_of_birth'],
                                            phone: profile['phone'],
                                            photo: profile['photo'])));
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profile['photo']
                                                  .toString() ==
                                              "" ||
                                          profile['photo'] == null
                                      ? AssetImage(
                                          'assets/icons/profileImg.png')
                                      : NetworkImage(
                                          '$imgBasePath${profile['photo']}'),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  profile['first_name'] == null
                                      ? ""
                                      : profile['first_name'] +
                                          " " +
                                          profile['last_name'],
                                  style: GoogleFonts.openSans(
                                      color: Color(backgroundColorBlue),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      profile['gender'],
                                      style: GoogleFonts.openSans(
                                          color: Color(fontColorSteelGrey),
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal,
                                    ),

                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal,
                                    ),
                                    // Text(
                                    //   getTherapistData != null &&
                                    //       getTherapistData.totalRating != null
                                    //       ? getTherapistData.totalRating
                                    //       : "",
                                    //   style: GoogleFonts.openSans(
                                    //     color: Color(fontColorSteelGrey),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DATE OF BIRTH",
                                      style: GoogleFonts.openSans(
                                          color: Color(fontColorGray),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${DateFormat('dd MMMM yyyy').format(DateTime.parse(profile['date_of_birth']))}",
                                      style: GoogleFonts.openSans(
                                          color: Color(0xff445066),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "PHONE NUMBER",
                                      style: GoogleFonts.openSans(
                                          color: Color(fontColorGray),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      profile['phone'],
                                      style: GoogleFonts.openSans(
                                          color: Color(0xff445066),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "EMAIL ID",
                                      style: GoogleFonts.openSans(
                                          color: Color(fontColorGray),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      profile['email'],
                                      style: GoogleFonts.openSans(
                                          color: Color(0xff445066),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "MY INTERESTS",
                                      style: GoogleFonts.openSans(
                                          color: Color(fontColorGray),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Get.to(ProfessionalInfo1());
                                      },
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Wrap(
                                  runSpacing: 20,
                                  spacing: 10,
                                  children: selectedInterestList
                                      .map((e) => Container(
                                            padding: EdgeInsets.fromLTRB(
                                                13, 8, 13, 0),
                                            child: Text(
                                              e,
                                              style: GoogleFonts.openSans(
                                                  color: Color(0xff0066B3),
                                                  fontSize: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                            // alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color(0xffE4F0F8),
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    5,
                                          ))
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                })));
    widgetList.add(child);

    return Stack(children: widgetList);
  }

  dynamic profile;

  Future<void> getprofile(email) async {
    var uri =
        "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client?email=${email}";
    print('My PROFILE URL :$uri');
    try {
      final response = await get(Uri.parse(uri));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        profile = responseJson['client'];
        if (profile['photo'] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("photo",
              "https://sal-prod.s3.ap-south-1.amazonaws.com/${profile['photo']}");
        } else {}
        // counsellorid=upcominglist['appointment_slots'][0]['counsellor_id'];
        //  print( upcominglist['appointment_slots'][0]['counsellor_id'],);
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");

      }
    } catch (e) {
      print(e);

      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
}
