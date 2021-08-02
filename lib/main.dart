import 'package:flutter/material.dart';

import 'UI/MySessions.dart';
import 'UI/login.dart';
import 'UI/mood.dart';

void main() {
  runApp(MentalHealth());
}

class MentalHealth extends StatelessWidget {
  const MentalHealth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mental Health",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: Mood(),
      routes: {
        '/Login': (context) => LoginScreen(),
      },
    );
  }
}
