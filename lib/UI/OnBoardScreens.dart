import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' as utils;
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/login.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:dots_indicator/dots_indicator.dart';

class DTWalkThoughScreen extends StatefulWidget {
  static String tag = '/DTWalkThoughScreen';

  @override
  DTWalkThoughScreenState createState() => DTWalkThoughScreenState();
}

class DTWalkThoughScreenState extends State<DTWalkThoughScreen>
    with SingleTickerProviderStateMixin {
  var pages = List<Widget>();
  var selectedIndex = 0;
  bool isRegisterd = false;
  PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // init();
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.90,
                child: PageView(
                  controller: _pageController,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin:
                      EdgeInsets.only(top: SizeConfig.screenWidth * 0.06),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/onBoard1.png',
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.60,
                            fit: BoxFit.fitHeight,
                          ),
                          Text(
                            "Elevate Your Mood",
                            style: TextStyle(
                                color: Color(midnightBlue),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    /* GifImage(
          controller: controller,
          image: AssetImage("assets/onboard.gif"),
        ),*/
                    Container(
                      alignment: Alignment.topCenter,
                      margin:
                      EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/onBoard2.png',
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.55,
                            fit: BoxFit.fitHeight,
                          ),
                          Text(
                            "Access Your\nEmotional Health",
                            style: TextStyle(
                                color: Color(midnightBlue),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin:
                      EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/onBoard3.png',
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.55,
                            fit: BoxFit.fitHeight,
                          ),
                          Text(
                            "Connect with your\nChancellor",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(midnightBlue),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                  onPageChanged: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DotsIndicator(
                dotsCount: 3,
                position: currentPage,
                decorator: DotsDecorator(
                  color: Colors.grey, // Inactive color
                  activeColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 6),
                alignment: Alignment.center,
                width: SizeConfig.blockSizeHorizontal * 80,
                height: SizeConfig.blockSizeVertical * 6,
                child: Center(
                  child: Text('Get Started',
                      style: boldTextStyle(
                          color: Colors.white,
                          size: (SizeConfig.blockSizeVertical * 2.25).toInt())),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              ).onTap(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginScreen(screen: "Home")));
              }),
              SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
