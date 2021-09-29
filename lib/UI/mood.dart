import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/OnBoardScreens.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Widgets/Moodwidget.dart';
import 'package:sal_user/data/repo/Addmoodrepo.dart';
import 'Addnote.dart';
import 'Splash1.dart';

class Mood extends StatefulWidget {
  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  bool isError = false;
  bool isLoading = false;
  var moodid;
  int _selectedIndex;
  Addmoodrepo addmoodrepo=Addmoodrepo();
  var image=[
    "assets/icons/Group 7041.png",
    "assets/icons/Group 7042.png",
      "assets/icons/anxious.png",
      "assets/icons/Group 7044.png",
      "assets/icons/Group 7044.png",
      "assets/icons/Group 7043.png"];

  @override
  void initState() {
    getmoodsfromserver();
    // TODO: implement initState
    super.initState();
  }
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
                children: moodswidget()

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
                  // addmoodrepo.addmood(context: context,moodid: moodid);
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
  dynamic moods= new List();
  void getmoodsfromserver() async {
    setState(() {
      isLoading=true;
    });

    try {
      final response = await get(Uri.parse('https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/mood'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        moods=responseJson['moods'];
print(moods);
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

List<Widget>moodswidget(){
  var opacuit=1.0;
    List <Widget>moodlist=new List();
    for(int i =0; i<moods.length;i++){
      moodlist.add(GestureDetector(
        onTap: (){
          _onSelected(i);
          print(moods[i]['id']);
          moodid=moods[i]['id'];
        },
        child: Container(
          child: Column(
            children: [
              Opacity(
                opacity: _selectedIndex != null && _selectedIndex == i
          ?0.7
              :  1.0,
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
                      image[i]
                  ),
                ),
              ),
              Text(moods[i]['title']),
            ],
          ),
        ),
      ));
    }
return moodlist;
}
}
