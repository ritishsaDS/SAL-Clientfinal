import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sal_user/UI/AllEvents.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/NavigationBar.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'CafeEventdetails.dart';
import 'MyEvents.dart';


class CafeEvents extends StatefulWidget {
  const CafeEvents({Key key}) : super(key: key);

  @override
  _CafeEventsState createState() => _CafeEventsState();
}

class _CafeEventsState extends State<CafeEvents> {

  List<String> images = ['https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg',
    'https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg'];

  List<String> topic = ['Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop',
    'Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop'];

  List<Color> colors = [Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),Color.fromRGBO(0, 90, 100, 0.75),Color.fromRGBO(0, 90, 100, 0.75)];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(index: 3,),
      body: DefaultTabController(length: 2, child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: TabBar(
            unselectedLabelStyle: TextStyle(
              color: Color(fontColorGray),
              fontWeight: FontWeight.w600,
            ),
            labelStyle: TextStyle(
              color: Color(backgroundColorBlue),
              fontWeight: FontWeight.w700,
            ),
            indicatorColor: Color(backgroundColorBlue),
            labelColor: Color(backgroundColorBlue),
            unselectedLabelColor: Color(fontColorGray),
            tabs: [
              Tab(
                text: "ALL EVENTS",
              ),
              Tab(
                text: "MY EVENTS",
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            Allevents(),
            Myevents()
                ],
    )))));
  }
}