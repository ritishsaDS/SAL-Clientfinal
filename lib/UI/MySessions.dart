import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class MySessions extends StatefulWidget {
  const MySessions({Key key}) : super(key: key);

  @override
  _MySessionsState createState() => _MySessionsState();
}

class _MySessionsState extends State<MySessions> {
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
          "My Sessions",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
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
            DefaultTabController(
                length: 3, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelColor: Color(backgroundColorBlue),
                          unselectedLabelColor: Color(fontColorSteelGrey),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          tabs: [
                            Tab(text: 'UPCOMING'),
                            Tab(text: 'UNUSED'),
                            Tab(
                              text: 'PAST',
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height:
                              SizeConfig.screenHeight, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(children: <Widget>[
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.02,
                              vertical: SizeConfig.blockSizeVertical),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sushmita Sinha",
                                          style: TextStyle(
                                            color: Color(backgroundColorBlue),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "08:00 AM",
                                          style: TextStyle(
                                              color: Color(fontColorGray),
                                              fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.5),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Counsellor",
                                          style: TextStyle(
                                            color: Color(fontColorGray),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "10 July",
                                          style: TextStyle(
                                              color: Color(fontColorGray),
                                              fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.5),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.screenWidth * 0.1,
                                        vertical: SizeConfig.blockSizeVertical),
                                    child: Text(
                                        "You have no upcoming sessions scheduled. ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(fontColorSteelGrey))),
                                  ),
                                  MaterialButton(
                                    child: Text(
                                      "BOOK APPOINTMENT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Color(backgroundColorBlue),
                                    onPressed: () {},
                                    minWidth: SizeConfig.screenWidth,
                                    height: SizeConfig.blockSizeVertical * 6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.02,
                                  vertical: SizeConfig.blockSizeVertical),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sushmita Sinha",
                                          style: TextStyle(
                                            color: Color(backgroundColorBlue),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "SCHEDULE",
                                          style: TextStyle(
                                              color: Color(backgroundColorBlue),
                                              fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.5,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Counsellor",
                                          style: TextStyle(
                                            color: Color(fontColorGray),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "3 Sessions",
                                          style: TextStyle(
                                              color: Color(fontColorGray),
                                              fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.5,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                        SizeConfig.screenWidth * 0.1,
                                        vertical: SizeConfig.blockSizeVertical),
                                    child: Text(
                                        "You have no unused sessions scheduled. ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(fontColorSteelGrey))),
                                  ),
                                  MaterialButton(
                                    child: Text(
                                      "BOOK APPOINTMENT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Color(backgroundColorBlue),
                                    onPressed: () {},
                                    minWidth: SizeConfig.screenWidth,
                                    height: SizeConfig.blockSizeVertical * 6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.05,
                                  vertical: SizeConfig.blockSizeVertical),
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                        title: Text(
                                          "Sushmita Sinha",
                                          style: TextStyle(
                                            color: Color(backgroundColorBlue),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Counsellor",
                                          style: TextStyle(
                                            color: Color(fontColorGray),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "08:00 AM",
                                              style: TextStyle(
                                                  color: Color(fontColorGray),
                                                  fontSize:
                                                      SizeConfig.blockSizeVertical *
                                                          1.5),
                                            ),
                                            Text(
                                              "10 July",
                                              style: TextStyle(
                                                  color: Color(fontColorGray),
                                                  fontSize:
                                                      SizeConfig.blockSizeVertical *
                                                          1.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            color: Colors.white,
                                            child: Text("RATE",style: TextStyle(
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
                                            child: Text("BOOK AGAIN",style: TextStyle(
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
                                      SizedBox(
                                        height: SizeConfig.screenHeight * 0.2,
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                            SizeConfig.screenWidth * 0.1,
                                            vertical: SizeConfig.blockSizeVertical),
                                        child: Text(
                                            "You have not attended any sessions yet.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(fontColorSteelGrey))),
                                      ),
                                    ],
                                  ),

                            ),
                          ]))
                    ])),
          ],
        ),
      ),
    ));
  }
}
