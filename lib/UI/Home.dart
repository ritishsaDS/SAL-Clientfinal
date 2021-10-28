import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/mood.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/NavigationBar.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Widgets/Drawemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'Articledetail.dart';
import 'Notification.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key key}) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  Future<void> _launched;
  List<String> images = [
    'assets/bg/gridCard1.png',
    'assets/bg/gridCard2.png',
    'assets/bg/gridCard1.png',
    'assets/bg/gridCard4.png',
    'assets/bg/gridCard4.png',
    'assets/bg/gridCard4.png'
  ];
  bool isError = false;
  bool isLoading = false;

  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75)
  ];

  List<String> desc = [
    "How to have a\npeaceful mind",
    "Worlds of the\nwaterfall",
    "How to have a\npeaceful mind",
    "Worlds of the\nwaterfall",
    "Worlds of the\nwaterfall",
    "Worlds of the\nwaterfall"
  ];
  var name = "";

  @override
  void initState() {
    getname();
    getHomedata();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("name"));
    setState(() {
      name = prefs.getString("name");
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RefreshIndicator(
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/bg/Frame.png'),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          actions: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationsScreen()));
                                },
                                child: Icon(
                                  Icons.notifications_none_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          child: Text("Hello,",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 3)),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          child: Text(name == null ? "" : name,
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      SizeConfig.blockSizeVertical * 3.5)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.25),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(65)),
                        color: Colors.white),
                    child: isLoading
                        ? /*Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue)),
                          )*/
                        LoadingShimmer()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(65),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15)),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image:
                                          Image.asset('assets/bg/gridCard4.png')
                                              .image,
                                      fit: BoxFit.fill,
                                    ),
                                    // image: DecorationImage(
                                    //   image: Image.network(mediaurl +
                                    //           rommended[1]['background_photo'])
                                    //       .image,
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(65),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            topLeft: Radius.circular(15)),
                                        child: Container(
                                          color: Colors.blue[900].withOpacity(0.4),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            "$homequote",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mood()));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  height: SizeConfig.screenHeight * 0.20,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image:
                                            Image.asset('assets/bg/Frame.png')
                                                .image,
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "How Are You \nFeeling Today",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: SizedBox(),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ]),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: SizeConfig.blockSizeVertical * 2),
                                child: Text(
                                  "Recommended For You",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      color: Color(fontColorGray)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: SizeConfig.blockSizeVertical),
                                child: GridView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8),
                                  children: homewidget(),
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: DrawerMenu(),
        bottomNavigationBar: NavigationBar(
          index: 0,
        ),
        // bottomNavigationBar: NavigationBar(
        //   index: 0,
        // ),
      )),
      onRefresh: () => getHomedata(),
    );
  }

  dynamic homelist = new List();
  dynamic homequote = new List();
  dynamic rommended = new List();
  dynamic mediaurl = new List();

  Future<void> getHomedata() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String clientId = prefs.getString("cleintid");
    print('CLIENT ID:$clientId');
    try {
      // final response = await get(Uri.parse(
      //     'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/home'));
      String url =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/home?client_id=$clientId';
      print('HOME URL:$url');
      final response = await get(Uri.parse(url));
      print("RESPONSE::::" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        homelist = responseJson['articles'];
        homequote = responseJson['quote'];
        mediaurl = responseJson['media_url'];
        rommended = responseJson['recommended'];
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

  List<Widget> homewidget() {
    List<Widget> homitemlist = new List();
    for (int i = 0; i < homelist.length; i++) {
      homitemlist.add(GestureDetector(
        onTap: () {
          print('TYPE:${homelist[i].runtimeType}');
          Get.to(ArticleDetail(
            description: homelist[i]['description'],
            image: homelist[i]['photo'],
            title: homelist[i]['title'],
            id: homelist[i]['id'],
          ));
        },
        child: Container(
          width: SizeConfig.screenWidth * 0.4,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: Image.network(mediaurl + homelist[i]['photo']).image,
                fit: BoxFit.cover),
          ),
          child: Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.02,
                right: SizeConfig.screenWidth * 0.02),
            height: SizeConfig.blockSizeVertical * 8,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colors[0],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    homelist[i]['title'],
                    style: GoogleFonts.openSans(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "3m",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return homitemlist;
  }
}

class LoadingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.5,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[400],
          highlightColor: Colors.grey[200],
          child: Container(
              margin: EdgeInsets.all(15),
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(65)),
                color: Colors.grey[300],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mood()));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: SizeConfig.screenHeight * 0.20,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: Image.asset('assets/bg/Frame.png').image,
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "How Are You \nFeeling Today",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ]),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.05,
              vertical: SizeConfig.blockSizeVertical * 2),
          child: Text(
            "",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600, color: Color(fontColorGray)),
          ),
        ),
      ],
    );
  }
}
