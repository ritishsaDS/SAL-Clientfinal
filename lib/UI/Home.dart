import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Widgets/Drawemenu.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Notifications()));
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
                        child: Text("Suman",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 3.5)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.25),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(65)),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3.5,
                      ),
                      Container(
                          margin: EdgeInsets.all(15),
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(65)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/bg/gridCard1.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "In a world you can be \n anything,\n choose to be kind, always.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/bg/gridCard1.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                            children:[ Text(
                          "How Are You \n Feeling Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                            )]),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
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
                            horizontal: SizeConfig.screenWidth * 0.02,
                            vertical: SizeConfig.blockSizeVertical),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: SizeConfig.screenWidth * 0.4,
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: Image.asset(images[index]).image,
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
                                    color: colors[index],
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      desc[index],
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
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
                            );
                          },
                          itemCount: images.length,
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
      // bottomNavigationBar: NavigationBar(
      //   index: 0,
      // ),
    ));
  }
}
