import 'package:flutter/material.dart';
var showb=false;
class Moodwidget extends StatefulWidget {
  String mood;
  String image;
  Moodwidget({this.mood,this.image});
  @override
  _MoodwidgetState createState() => _MoodwidgetState();
}

class _MoodwidgetState extends State<Moodwidget> {
  var opacuit=1.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        setState(() {

          if(opacuit==1.0){
            opacuit=0.5;
            showb=true;
          }
          else{
            opacuit=  1.0;
            showb=false;
          }
        });
      },
      child: Container(
        child: Column(
          children: [
            Opacity(
              opacity: opacuit,
              child: Container(

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
            ),
            Text(widget.mood),
          ],
        ),
      ),
    );
  }
}
