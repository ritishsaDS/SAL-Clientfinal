import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditProfile.dart';
import 'Professionalinfo.dart';
import 'login.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    print(list);
    getid();
  }

  bool isError = false;
  bool isLoading = false;
  Future<void> getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("email"));
    getprofile(preferences.getString("email"));
  }

  bool isloding = false;
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> widgetList = new List<Widget>();
    var child = SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          child: Stack(
                            children: [
                              Column(
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
                                                    builder: (context) =>
                                                        Editprofile(
                                                            firstname: profile[
                                                                'first_name'],
                                                            lastname: profile[
                                                                'last_name'],email:profile['email'],
                                                          gender:profile['gender'],
                                                          phone:profile['phone'],
                                                          photo:"https://sal-prod.s3.ap-south-1.amazonaws.com/${profile['photo']}"
                                                        )));
                                          },
                                          child: Icon(
                                            Icons.edit_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () async {
                                      //     SharedPreferences prefs =
                                      //     await SharedPreferences.getInstance();
                                      //
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) => Editprofile(
                                      //                  )));
                                      //     }),
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) => Editprofile(
                                      //                   firstname: getlistenermodel
                                      //                       .listener.firstName,
                                      //                   lastname: getlistenermodel
                                      //                       .listener.lastName,
                                      //                   image: getlistenermodel
                                      //                       .listener.photo,
                                      //                   gender: getlistenermodel
                                      //                       .listener.gender,
                                      //                   price: getlistenermodel
                                      //                       .listener.price,
                                      //                   email: getlistenermodel
                                      //                       .listener.email,
                                      //                   experience: getlistenermodel
                                      //                       .listener.experience,
                                      //                   phone: getlistenermodel
                                      //                       .listener.phone)));
                                      //     }
                                      //   },
                                    ],
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.05),
                                      width: SizeConfig.screenWidth * 0.25,
                                      height: SizeConfig.screenHeight * 0.12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        child:profile['photo']==""? Image.network("https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png"):Image.network("https://sal-prod.s3.ap-south-1.amazonaws.com/${profile['photo']}"),

                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 8),
                                  //   width: SizeConfig.screenWidth,
                                  //   alignment: Alignment.center,
                                  //   child: Text(
                                  //     "${first}" + " " + "${last}",
                                  //     style: GoogleFonts.openSans(
                                  //         color: Color(backgroundColorBlue),
                                  //         fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child:isloding==true?Center(
                                      child: CircularProgressIndicator(color: Colors.blue,),
                                    ): Text(
                                      profile['first_name'] == null
                                          ? ""
                                          : profile['first_name'] +
                                              " " +
                                              profile['last_name'],
                                      style: GoogleFonts.openSans(
                                          color: Color(backgroundColorBlue),
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profile['gender'],
                                          style: GoogleFonts.openSans(
                                            color: Color(fontColorSteelGrey),
                                          ),
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
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Age",
                                          style: GoogleFonts.openSans(
                                              color: Color(fontColorGray),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.75),
                                        ),
                                        Text(
                                          profile['age'],
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.90),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Phone Number",
                                          style: GoogleFonts.openSans(
                                              color: Color(fontColorGray),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.75),
                                        ),
                                        Text(
                                          profile['phone'],
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.90),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Email",
                                          style: GoogleFonts.openSans(
                                              color: Color(fontColorGray),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.75),
                                        ),
                                        Text(
                                          profile['email'],
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.90),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(
                                  //       top: SizeConfig.blockSizeVertical * 4),
                                  //   width: SizeConfig.screenWidth,
                                  //   height: SizeConfig.blockSizeVertical * 42,
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     children: [
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         children: [
                                  //           Container(
                                  //             margin: EdgeInsets.only(
                                  //                 top: SizeConfig
                                  //                         .blockSizeVertical *
                                  //                     2.5,
                                  //                 left: SizeConfig.screenWidth *
                                  //                     0.05,
                                  //                 right:
                                  //                     SizeConfig.screenWidth *
                                  //                         0.05),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  //                 Text(
                                  //                   "My Intersets",
                                  //                   style: GoogleFonts.openSans(
                                  //                       color: Color(
                                  //                           fontColorGray),
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                       fontSize: SizeConfig
                                  //                               .blockSizeVertical *
                                  //                           2),
                                  //                 ),
                                  //                 Icon(
                                  //                   Icons.edit,
                                  //                   color: Colors.grey[400],
                                  //                 )
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             height:
                                  //                 SizeConfig.blockSizeVertical *
                                  //                     21,
                                  //             margin: EdgeInsets.symmetric(
                                  //                 horizontal: 15, vertical: 10),
                                  //             width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width -
                                  //                 30,
                                  //             child: GridView.builder(
                                  //                 physics:
                                  //                     NeverScrollableScrollPhysics(),
                                  //                 gridDelegate:
                                  //                     SliverGridDelegateWithMaxCrossAxisExtent(
                                  //                         maxCrossAxisExtent:
                                  //                             200,
                                  //                         childAspectRatio:
                                  //                             4 / 1,
                                  //                         crossAxisSpacing: 30,
                                  //                         mainAxisSpacing: 20),
                                  //                 itemCount: list.length,
                                  //                 itemBuilder:
                                  //                     (BuildContext ctx,
                                  //                         index) {
                                  //                   return Container(
                                  //                     alignment:
                                  //                         Alignment.center,
                                  //                     child: Text(
                                  //                       list[index],
                                  //                       style: GoogleFonts.openSans(
                                  //                           color: Color(
                                  //                               fontColorSteelGrey),
                                  //                           fontWeight:
                                  //                               FontWeight.w600,
                                  //                           fontSize: SizeConfig
                                  //                                   .blockSizeVertical *
                                  //                               1.90),
                                  //                     ),
                                  //                     decoration: BoxDecoration(
                                  //                         color:
                                  //                             Color(0XFFE4F0F8),
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(
                                  //                                     15)),
                                  //                   );
                                  //                 }),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])
                    ]))));
    widgetList.add(child);
    if (isloding) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          // new Center(
          //   child: new CircularProgressIndicator(
          //     valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
          //   ),
          // ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }

  dynamic profile = new List();
  Future<void> getprofile(email) async {
    setState(() {
      isloding = true;
      isLoading=true;
    });
    var uri =
        "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client?email=${email}";
    try {
      final response = await get(Uri.parse(uri));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        profile = responseJson['client'];
       if(profile['photo']!=null){
         SharedPreferences prefs=await SharedPreferences.getInstance();
         prefs.setString("photo","https://sal-prod.s3.ap-south-1.amazonaws.com/${profile['photo']}");
       }
       else{}
        // counsellorid=upcominglist['appointment_slots'][0]['counsellor_id'];
        //  print( upcominglist['appointment_slots'][0]['counsellor_id'],);
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
          isLoading=false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isloding = false;
        isLoading=false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
}
