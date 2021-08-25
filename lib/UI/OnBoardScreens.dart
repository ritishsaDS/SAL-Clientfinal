import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/login.dart';
import 'package:sal_user/Utils/SizeConfig.dart';


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
        margin: EdgeInsets.only(top: context.height() * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/onBoard1.png',
              width: context.width(),
              height: context.height() * 0.75,
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
        margin: EdgeInsets.only(top: context.height() * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/onBoard2.png',
              width: context.width(),
              height: context.height() * 0.65,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: context.height() * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/onBoard3.png',
              width: context.width(),
              height: context.height() * 0.6,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      )
      /* Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: context.height()*0.04),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/onboard.gif',width:  context.width(),
              height: context.height() * 0.95,fit: BoxFit.fitHeight,),
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
    init();
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              child: PageView(
                controller: _pageController,
                children: pages,
                onPageChanged: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
              ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              bottom: SizeConfig.blockSizeVertical * 12,
              left: 0,
              right: 0,
              child: DotIndicator(
                pageController:  _pageController,
                  pages: pages,
                  indicatorColor: Colors.blue),
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
                          color: white,
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
