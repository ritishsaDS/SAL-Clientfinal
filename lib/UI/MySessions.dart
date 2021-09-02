import 'package:flutter/material.dart';
import 'package:sal_user/UI/UpcomingAppointment.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'Pastupcoming.dart';
import 'UnuasedSession.dart';

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
                            UpcomingAppointment(),
                            UnusedSession(),

                            PastAppointment(),
                          ]))
                    ])),
          ],
        ),
      ),
    ));
  }
}
