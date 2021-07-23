import 'package:flutter/material.dart';

class Moodwidget extends StatefulWidget {
  String mood;
  String image;
  Moodwidget({this.mood,this.image});
  @override
  _MoodwidgetState createState() => _MoodwidgetState();
}

class _MoodwidgetState extends State<Moodwidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/icons/Rectangle 412.png",
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            // color: Colors.blue,
            child: Image.asset(
             widget.image
            ),
          ),
          Text(widget.mood),
        ],
      ),
    );
  }
}
