import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'EditProfile.dart';
import 'Professionalinfo.dart';
import 'login.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
 @override
  void initState(){
    getid();
  }

  Future<void> getid() async {
   SharedPreferences preferences= await SharedPreferences.getInstance();
  print( preferences.getString("cleintid"));
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
                                                        Editprofile()));
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
                                        child: Image.asset(
                                            'assets/bg/profile.png'),
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
                                    child: Text(
                                      "Suman Aggarwal",
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
                                          "Gender",
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
                                        Image.asset(
                                          'assets/icons/star.png',
                                          height:
                                              SizeConfig.blockSizeVertical * 2,
                                        )
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
                                          "Date Of Birth",
                                          style: GoogleFonts.openSans(
                                              color: Color(fontColorGray),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.75),
                                        ),
                                        Text(
                                          "23/12/1999",
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
                                          mobileController.text,
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
                                          "ritishs39@gmail.com",
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
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 4),
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.blockSizeVertical * 42,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig
                                                          .blockSizeVertical *
                                                      2.5,
                                                  left: SizeConfig.screenWidth *
                                                      0.05,
                                                  right:
                                                      SizeConfig.screenWidth *
                                                          0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "My Intersets",
                                                    style: GoogleFonts.openSans(
                                                        color: Color(
                                                            fontColorGray),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            2),
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.grey[400],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      21,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30,
                                              child: GridView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              200,
                                                          childAspectRatio:
                                                              4 / 1,
                                                          crossAxisSpacing: 30,
                                                          mainAxisSpacing: 20),
                                                  itemCount: list.length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    return Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        list[index],
                                                        style: GoogleFonts.openSans(
                                                            color: Color(
                                                                fontColorSteelGrey),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                1.90),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0XFFE4F0F8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
}
