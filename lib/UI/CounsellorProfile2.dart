import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';

class CounsellorProfile2 extends StatefulWidget {
  const CounsellorProfile2({Key key}) : super(key: key);

  @override
  _CounsellorProfile2State createState() => _CounsellorProfile2State();
}

class _CounsellorProfile2State extends State<CounsellorProfile2> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(
                color: Colors.grey[200],
                offset: Offset(1,1),
                blurRadius: 5.0,
                spreadRadius: 3.0
            )],
            borderRadius: BorderRadius.circular(10)
        ),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.1,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
              },
              color: Colors.white,
              child: Text("CANCEL",style: TextStyle(
                  color: Color(fontColorGray),
              ),),
              minWidth: SizeConfig.screenWidth * 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Color(fontColorGray)
                ),
              ),
            ),
            MaterialButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/ClientDetails');
              },
              color: Color(backgroundColorBlue),
              child: Text("RESCHEDULE",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),),
              minWidth: SizeConfig.screenWidth * 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg/my profile bg.png'),
                        fit: BoxFit.cover
                    ),
                  ),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.4,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        leading: InkWell(child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                          onTap: (){
                            Navigator.pop(context);
                          },),
                        elevation: 0.0,
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        title: Text("Counsellor Profile",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),),
                        /*actions: [
                          Padding(
                            padding:EdgeInsets.only(
                              right: SizeConfig.screenWidth * 0.05,),
                            child: Icon(Icons.edit_outlined,color: Colors.white,),
                          )
                        ],*/
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.15
                          ),
                          width: SizeConfig.screenWidth * 0.25,
                          height: SizeConfig.screenHeight * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            // child: image.path != null && image.path != "" ? Image.file(
                            //     File(image.path)):
                            child:Image.asset('assets/bg/profile.png'),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Text("Dr Sushmita Sinha",
                          style: GoogleFonts.openSans(
                              color: Color(backgroundColorBlue),
                              fontSize: SizeConfig.blockSizeVertical * 2.5,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Counsellor",
                              style: GoogleFonts.openSans(
                                color: Color(fontColorSteelGrey),
                              ),),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Image.asset('assets/bg/circle.png',
                              height: SizeConfig.blockSizeVertical * 0.5,),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Text("4.5", style: GoogleFonts.openSans(
                              color: Color(fontColorSteelGrey),
                            ),
                            ),
                            Image.asset('assets/icons/star.png',
                              height: SizeConfig.blockSizeVertical * 2,)
                          ],
                        ),
                      ),
                      DefaultTabController(
                          length: 3, // length of tabs
                          initialIndex: 0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  child: TabBar(
                                    labelColor: Color(backgroundColorBlue),
                                    unselectedLabelColor:
                                    Color(fontColorSteelGrey),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                    tabs: [
                                      Tab(text: 'BOOKING'),
                                      Tab(text: 'OVERVIEW'),
                                      Tab(text: 'REVIEW',),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight * 0.6, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey, width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.screenWidth * 0.05,
                                          vertical: SizeConfig.blockSizeVertical
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: SizeConfig.blockSizeVertical
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Appointment Date & Time",
                                                  style: TextStyle(
                                                    color: Color(backgroundColorBlue),
                                                    fontWeight: FontWeight.w600
                                                  ),),
                                                  Text("24 July 2020 at 11:00 AM",
                                                    style: TextStyle(
                                                        color: Color(fontColorGray)
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: SizeConfig.blockSizeVertical
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Sessions Bought",
                                                    style: TextStyle(
                                                        color: Color(backgroundColorBlue),
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("1",
                                                    style: TextStyle(
                                                        color: Color(fontColorGray)
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: SizeConfig.blockSizeVertical
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Booking Amount",
                                                    style: TextStyle(
                                                        color: Color(backgroundColorBlue),
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("₹ 608",
                                                    style: TextStyle(
                                                        color: Color(fontColorGray)
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: SizeConfig.blockSizeVertical
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Booking Date",
                                                    style: TextStyle(
                                                        color: Color(backgroundColorBlue),
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("21 July, 2020 01:38 Pm",
                                                    style: TextStyle(
                                                        color: Color(fontColorGray)
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: SizeConfig.blockSizeVertical
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Transaction ID",
                                                    style: TextStyle(
                                                        color: Color(backgroundColorBlue),
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("BVDSAIN3262341",
                                                    style: TextStyle(
                                                        color: Color(fontColorGray)
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: SizeConfig.blockSizeVertical
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Payment Mode",
                                                    style: TextStyle(
                                                        color: Color(backgroundColorBlue),
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("Card Payment",
                                                    style: TextStyle(
                                                        color: Color(fontColorGray)
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.025,
                                          top: SizeConfig.blockSizeVertical * 3,
                                          right: SizeConfig.screenWidth * 0.025,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "About Event",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Color(backgroundColorBlue),
                                              ),
                                            ),
                                            Text(
                                              "Sushmita has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people when... See more ",
                                              style: TextStyle(
                                                color: Color(fontColorGray),
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                              SizeConfig.blockSizeVertical *
                                                  8,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                    SizeConfig.screenWidth *
                                                        0.1,
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        3.5,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/bg/minusBg.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    child: Image.asset(
                                                        'assets/icons/minus.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig.screenWidth * 0.05
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Experience",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(backgroundColorBlue),
                                                          ),),
                                                        Text("12+ years",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(fontColorGray),
                                                          ),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                              SizeConfig.blockSizeVertical *
                                                  8,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                    SizeConfig.screenWidth *
                                                        0.1,
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        3.5,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/bg/minusBg.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    child: Image.asset(
                                                        'assets/icons/minus.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig.screenWidth * 0.05
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Speciality",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(backgroundColorBlue),
                                                          ),),
                                                        Text("Parenting, Stress",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(fontColorGray),
                                                          ),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                              SizeConfig.blockSizeVertical *
                                                  8,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                    SizeConfig.screenWidth *
                                                        0.1,
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        3.5,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/bg/minusBg.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    child: Image.asset(
                                                        'assets/icons/minus.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig.screenWidth * 0.05
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Languages",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(backgroundColorBlue),
                                                          ),),
                                                        Text("English, Hindi",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(fontColorGray),
                                                          ),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: SizeConfig.screenWidth * 0.05,
                                            vertical: SizeConfig.blockSizeVertical
                                        ),
                                        child: ListView.builder(itemBuilder: (context,int index){
                                          return Container(
                                            width: SizeConfig.screenWidth,
                                            margin: EdgeInsets.symmetric(
                                                vertical: SizeConfig.blockSizeVertical
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  child: Image.asset('assets/icons/user.png',
                                                    color: Color(backgroundColorBlue),
                                                    height: SizeConfig.blockSizeVertical * 3,),
                                                  backgroundColor: Color(0XFFE0EDF6),
                                                ),
                                                Container(
                                                  width: SizeConfig.screenWidth * 0.7,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Ankita Rathi",
                                                            style: TextStyle(
                                                                color: Color(fontColorSteelGrey),
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                          Text("19 Feb,20",
                                                            style: TextStyle(
                                                                color: Color(fontColorGray),
                                                                fontSize: SizeConfig.blockSizeVertical * 1.5
                                                            ),),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,),
                                                          Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,),
                                                          Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,),
                                                          Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,),
                                                          Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,),

                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: SizeConfig.blockSizeVertical * 0.5
                                                        ),
                                                        child: Text("“Dr Sushmita is an extremely great counsellor who was highly patient and understanding. I would be definitely be booking a session again.”",
                                                          style: TextStyle(
                                                            color: Color(fontColorGray),
                                                          ),),
                                                      ),
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig.blockSizeHorizontal * 2,
                                                  ),),
                                              ],
                                            ),
                                          );
                                        },
                                          primary: false,
                                          itemCount: 10,
                                          shrinkWrap: true,),
                                      ),
                                    ]))
                              ])),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
