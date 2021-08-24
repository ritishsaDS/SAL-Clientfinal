import 'package:flutter/material.dart';
import 'package:sal_user/UI/OnBoardScreens.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Widgets/Moodwidget.dart';
import 'Addnote.dart';
import 'Splash1.dart';

class Mood extends StatefulWidget {
  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Moods ",
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
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "How are you feeling today ?",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  Moodwidget(
                    mood: "Happy",
                    image: "assets/icons/Group 7041.png",
                  ),
                  Moodwidget(mood: "Sad", image: "assets/icons/Group 7042.png"),
                  Moodwidget(
                      mood: "Anxious", image: "assets/icons/Group 7042.png"),
                  Moodwidget(
                      mood: "Concerned", image: "assets/icons/Group 7044.png"),
                  Moodwidget(
                      mood: "Lonely", image: "assets/icons/Group 7044.png"),
                  Moodwidget(
                      mood: "Frustrated", image: "assets/icons/Group 7043.png"),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Addnote()));
              },
              child: Text(
                "Add a Note to Express Yourself",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.blue,
                child: Text("Done"),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DTWalkThoughScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
