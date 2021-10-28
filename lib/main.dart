import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/UI/OnBoardScreens.dart';

import 'UI/MySessions.dart';
import 'UI/Splash.dart';
import 'UI/login.dart';
import 'UI/mood.dart';

void main() {
  runApp(MentalHealth());
}

class MentalHealth extends StatelessWidget {
  const MentalHealth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Initial');
    return GetMaterialApp(
      title: "Mental Health",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: Splash(),
      // home: Demo(),
      routes: {
        '/Login': (context) => LoginScreen(),
      },
    );
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('hllo'),
    );
  }
}
