import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' as utils;
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/login.dart';
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
    _pageController.addListener((){
      setState(() {
        currentPage = _pageController.page;
      });
    });
    super.initState();
  }

  init() async {
    pages = [
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: SizeConfig.screenWidth * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/onBoard1.png',
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenWidth * 0.75,
              fit: BoxFit.fitHeight,
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
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/onBoard2.png',
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.65,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/onBoard3.png',
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.6,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      )
      /* Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: SizeConfig.screenHeight*0.04),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/onboard.gif',width:  context.width(),
              height: SizeConfig.screenHeight * 0.95,fit: BoxFit.fitHeight,),
          ],
        ),
      ),*/
    ];
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
   // init();
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight*0.90,
              child: PageView(
                controller: _pageController,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: SizeConfig.screenWidth * 0.06),
                    child:
                        Image.asset(
                          'assets/onBoard1.png',
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight*0.60 ,
                          fit: BoxFit.fitHeight,
                        ),

                  ),
                  /* GifImage(
        controller: controller,
        image: AssetImage("assets/onboard.gif"),
      ),*/
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/onBoard2.png',
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight*0.55 ,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/onBoard3.png',
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight*0.55 ,
                          fit: BoxFit.fitHeight,
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

            // AnimatedPositioned(
            //   duration: Duration(seconds: 1),
            //   bottom: SizeConfig.blockSizeVertical * 12,
            //   left: 0,
            //   right: 0,
            //   child: Dotind(
            //     pageController:  _pageController,
            //       pages: pages,
            //       indicatorColor: Colors.blue),
            // ),
            DotsIndicator(
              dotsCount:3,
              position: currentPage,
              decorator: DotsDecorator(
                color: Colors.grey, // Inactive color
                activeColor: Colors.blue,
              ),
            ),
            Positioned(
              bottom: 8,
              left: 15,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 6),
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8)),
              ).onTap(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(screen:"Home")));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
