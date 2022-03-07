import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/Signup.dart';
import 'package:sal_user/UI/login.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Articledetail.dart';
import 'ClientDetailsNotLogged.dart';
import 'Schedulescreen.dart';
import 'Sessions.dart';

class CounsellorProfile extends StatefulWidget {
  final Map<String, dynamic> getData;

  final String mediaUrl;
  final String type;

  const CounsellorProfile(
      {Key key, this.getData, this.mediaUrl, this.type})
      : super(key: key);

  @override
  _CounsellorProfileState createState() => _CounsellorProfileState();
}

class _CounsellorProfileState extends State<CounsellorProfile> {
  @override
  void initState() {
    print("mkermpfvvpr" + widget.getData.toString());

    getCounsellordetail();
  }
  bool isError = false;
  bool isLoading = false;

  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                  spreadRadius: 3.0)
            ],
            borderRadius: BorderRadius.circular(10)),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.1,
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "₹ ${widget.getData['price']}",
                  style: TextStyle(
                      color: Color(backgroundColorBlue),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "/ session",
                  style: TextStyle(
                      color: Color(fontColorGray), fontWeight: FontWeight.w400),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print('CLIENT ID :${prefs.getString("cleintid")}');
                print('DATA :${widget.getData}');
                if (prefs.getString("cleintid") == null) {
                  showAlertDialogs();

                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DynamicEvent(
                            data: widget.getData,
                            mediaurl: widget.mediaUrl,
                            type: widget.type,

                          )));
                }
              },
              color: Color(backgroundColorBlue),
              child: Text(
                "SCHEDULE",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              minWidth: SizeConfig.screenWidth * 0.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:isLoading?Container(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.5,
            ),
            Center(child: CircularProgressIndicator(),),
          ],
        ),): Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg/my profile bg.png'),
                        fit: BoxFit.cover),
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
                        leading: InkWell(
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        elevation: 0.0,
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        title: Text(
                          widget.type == "1"
                              ? "Counsellor"
                              : widget.type == "2"
                                  ? "Listener"
                                  : "Therapist",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),
                        ),
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
                              top: SizeConfig.screenHeight * 0.15),
                          width: SizeConfig.screenWidth * 0.25,
                          height: SizeConfig.screenHeight * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: widget.getData['photo'] == null
                                ? Image.asset(
                                    'assets/bg/person.png',
                                    fit: BoxFit.cover,
                                  )
                                : widget.getData['photo'] == ""
                                    ? Image.asset(
                                        'assets/bg/person.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        widget.mediaUrl +
                                            widget.getData['photo'],
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Text(
                          widget.getData['first_name'],
                          style: GoogleFonts.openSans(
                              color: Color(backgroundColorBlue),
                              fontSize: SizeConfig.blockSizeVertical * 2.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.type == "1"
                                  ? "Counsellor"
                                  : widget.type == "2"
                                      ? "Listener"
                                      : "Therapist",
                              style: GoogleFonts.openSans(
                                color: Color(fontColorSteelGrey),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Image.asset(
                              'assets/bg/circle.png',
                              height: SizeConfig.blockSizeVertical * 0.5,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.getData['average_rating'],
                                  style: TextStyle(
                                      color: Color(fontColorSteelGrey),
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.50),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0XFFF0CA03),
                                  size: SizeConfig.blockSizeVertical * 2,
                                )
                              ],
                            )
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
                                    tabs: [
                                      Tab(text: 'OVERVIEW'),
                                      Tab(text: 'REVIEWS'),
                                      Tab(
                                        text: 'CONTENT',
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 600, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.025,
                                          top: SizeConfig.blockSizeVertical * 3,
                                          right: SizeConfig.screenWidth * 0.025,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "About",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(
                                                      backgroundColorBlue),
                                                ),
                                              ),
                                              Text(
                                                widget.getData['about'],
                                                style: TextStyle(
                                                  color: Color(fontColorGray),
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Container(
                                                width: SizeConfig.screenWidth,
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.1,
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          3.5,
                                                      padding:
                                                          EdgeInsets.all(8),
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
                                                          left: SizeConfig
                                                                  .screenWidth *
                                                              0.05),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Experience",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  backgroundColorBlue),
                                                            ),
                                                          ),
                                                          Text(
                                                            "${overview==null||overview['experience']==null?"":overview['experience']}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  fontColorGray),
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
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.1,
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          3.5,
                                                      padding:
                                                          EdgeInsets.all(8),
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
                                                          left: SizeConfig
                                                                  .screenWidth *
                                                              0.05),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Speciality",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  backgroundColorBlue),
                                                            ),
                                                          ),
                                                          Text(
                                                          "${overview['education']}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  fontColorGray),
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
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.1,
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          3.5,
                                                      padding:
                                                          EdgeInsets.all(8),
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
                                                          left: SizeConfig
                                                                  .screenWidth *
                                                              0.05),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Languages",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  backgroundColorBlue),
                                                            ),
                                                          ),
                                                          Text(
                                                            "English, Hindi",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  fontColorGray),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.screenWidth * 0.05,
                                            vertical:
                                                SizeConfig.blockSizeVertical),
                                        child: ListView.builder(
                                          itemBuilder: (context, int index) {
                                            return Container(
                                              width: SizeConfig.screenWidth,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                      .blockSizeVertical),
                                              child:reviews.length==0?Text("No review "): Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    child: Image.asset(
                                                      'assets/icons/user.png',
                                                      color: Color(
                                                          backgroundColorBlue),
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          3,
                                                    ),
                                                    backgroundColor:
                                                        Color(0XFFE0EDF6),
                                                  ),
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.7,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ankita Rathi",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      fontColorSteelGrey),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              "19 Feb,20",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      fontColorGray),
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .blockSizeVertical *
                                                                          1.5),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0XFFF0CA03),
                                                              size: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0XFFF0CA03),
                                                              size: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0XFFF0CA03),
                                                              size: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0XFFF0CA03),
                                                              size: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0XFFF0CA03),
                                                              size: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2,
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      SizeConfig
                                                                              .blockSizeVertical *
                                                                          0.5),
                                                          child: Text(
                                                            "“Dr Sushmita is an extremely great counsellor who was highly patient and understanding. I would be definitely be booking a session again.”",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  fontColorGray),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          primary: false,
                                          itemCount: reviews.length,
                                          shrinkWrap: true,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.screenWidth * 0.02,
                                            right:
                                                SizeConfig.screenWidth * 0.02,
                                            top: SizeConfig.blockSizeVertical,
                                            bottom:
                                                SizeConfig.screenHeight * 0.1),
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            /* if(colors.length < getHomeContentModal.articles.length){
                                    colors.addAll(colors);
                                  }*/
                                            return GestureDetector(
                                              onTap: (){
                                                Get.to(ArticleDetail(
                                                    description: content[index]['description'],
                                                    image: content[index]['photo'],
                                                    title: content[index]['title'],
                                                    id: content[index]['id'],
                                                    bg:content[index]['background_photo']
                                                ));
                                              },
                                              child: Container(
                                                width:
                                                    SizeConfig.screenWidth * 0.4,
                                                alignment: Alignment.bottomCenter,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://sal-prod.s3.ap-south-1.amazonaws.com/"+content[index]['background_photo'],
                                                    ),
                                                    fit: BoxFit.fitWidth
                                                  ),
                                                ),
                                                child: Container(
                                                  width: SizeConfig.screenWidth,
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          SizeConfig.screenWidth *
                                                              0.02,
                                                      right:
                                                          SizeConfig.screenWidth *
                                                              0.02),
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      8,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: colors[index],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      20))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.3,
                                                        child: Text(
                                                          content[index]['title'],
                                                          style: GoogleFonts.openSans(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2),
                                                        ),
                                                      ),
                                                      Text(
                                                        "3m",
                                                        style: GoogleFonts.openSans(
                                                            color: Colors.white,
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                1.75),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: content.length,
                                        ),
                                      )
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
dynamic overview =new List();
dynamic reviews =new List();
dynamic content =new List();

  void getCounsellordetail() async {
    setState(() {
      isLoading = true;
    });
var url='';
if(widget.type=="1"){
   url= "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/counsellor?counsellor_id=${widget.getData['id']}";
}
else if(widget.type=="2"){
  url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/listener?listener_id=${widget.getData['id']}";
}
else {
  url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/therapist?therapist_id=${widget.getData['id']}';
}
    try {
      final response = await get(Uri.parse(
          url));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);


        setState(() {
          content = responseJson['contents'];
          reviews = responseJson['reviews'];
          if(widget.type=="1"){
          //  url= "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/counsellor?counsellor_id=${widget.getData['id']}";
            overview = responseJson['counsellor'];
          }
          else if(widget.type=="2"){
            overview = responseJson['listener'];
            //url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/listener?listener_id=${widget.getData['id']}";
          }
          else {
          //  url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/therapist?therapist_id=${widget.getData['id']}';
            overview = responseJson['therapist'];
          }

          isError = false;
          isLoading = false;
          print('setstate'+reviews.length.toString());
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
  showAlertDialogs() {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                alignment: Alignment.center,
                child: Text(
                  "Please Do Login First",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2.2,
                      color: Colors.black),),
              ),
              Container(
                margin:
                EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen(
                            data: widget.getData,
                            mediaurl: widget.mediaUrl,
                            screen: "Appointment",
                            type: widget.type)));
                  },
                  child: Container(
                    decoration:
                    boxDecoration(bgColor: Color(backgroundColorBlue), radius: 30),
                    padding: EdgeInsets.fromLTRB(38, 8, 38, 10),
                    child: Text("Ok",style: TextStyle( color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }






  BoxDecoration boxDecoration(
      {double radius = 2,
        Color color = Colors.transparent,
        Color bgColor,
        var showShadow = false}) {
    return BoxDecoration(
      color: bgColor ,
      boxShadow: [BoxShadow(
        blurRadius: 2.0, // soften the shadow
        spreadRadius: 1,
        color: Colors.grey,//extend the shadow
        offset: Offset(
          0.0, // Move to right 10  horizontally
          1.0, // Move to bottom 5 Vertically
        ),
      ),],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

}
