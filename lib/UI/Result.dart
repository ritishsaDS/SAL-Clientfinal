import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class Result extends StatefulWidget {
  const Result({Key key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Result",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  'assets/icons/download.png',
                  height: SizeConfig.blockSizeVertical * 3,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  'assets/icons/share.png',
                  height: SizeConfig.blockSizeVertical * 3,
                ),
              ),
            ],
          ),
        ],
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
      ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.15,
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 2
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/bg/result tile.png'),
                      fit: BoxFit.cover
                    ),
                  ),
                  child: Text("You can handle stress at work well!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 3
                  ),
                  textAlign: TextAlign.center,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/icons/download.png',
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/icons/share.png',
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical
                  ),
                  child: Text("Past Assessment Result",
                  style: TextStyle(
                    color: Color(midnightBlue),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 2.5
                  ),),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent
                        ),
                        child: ExpansionTile(title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("16/03/21",
                            style: TextStyle(
                              color: Color(fontColorSteelGrey),
                            ),),
                            Container(
                              alignment: Alignment.center,
                              height: SizeConfig.blockSizeVertical * 3,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 5
                              ),
                              child: Image.asset('assets/icons/dot.png',
                              width: SizeConfig.blockSizeHorizontal,),
                            ),
                            Text("12:46 PM",
                            style: TextStyle(
                              color: Color(fontColorSteelGrey),
                            ),),
                          ],
                        ),
                        children: [
                          Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight * 0.15,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.05,
                                  vertical: SizeConfig.blockSizeVertical * 2
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage('assets/bg/result tile.png'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              child: Text("You can handle stress at work well!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeConfig.blockSizeVertical * 3
                                ),
                                textAlign: TextAlign.center,)
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/icons/download.png',
                                  height: SizeConfig.blockSizeVertical * 3,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/icons/share.png',
                                  height: SizeConfig.blockSizeVertical * 3,
                                ),
                              ),
                            ],
                          ),
                        ],),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent
                        ),
                        child: ExpansionTile(title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("31/02/21",
                              style: TextStyle(
                                color: Color(fontColorSteelGrey),
                              ),),
                            Container(
                              alignment: Alignment.center,
                              height: SizeConfig.blockSizeVertical * 3,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.blockSizeHorizontal * 5
                              ),
                              child: Image.asset('assets/icons/dot.png',
                                width: SizeConfig.blockSizeHorizontal,),
                            ),
                            Text("4:26 PM",
                              style: TextStyle(
                                color: Color(fontColorSteelGrey),
                              ),),
                          ],
                        ),
                          children: [
                            Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.15,
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.05,
                                    vertical: SizeConfig.blockSizeVertical * 2
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage('assets/bg/result tile.png'),
                                      fit: BoxFit.cover
                                  ),
                                ),
                                child: Text("You can handle stress at work well!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.blockSizeVertical * 3
                                  ),
                                  textAlign: TextAlign.center,)
                            ),
                          ],),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.3,
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    height: SizeConfig.blockSizeVertical * 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Color(backgroundColorBlue),
                    child: Text("Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                ),
              ],
            ),
          ),
          
    ));
  }
}
