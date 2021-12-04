import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/MoodDoneScreen.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Widgets/Moodwidget.dart';
import 'package:sal_user/data/repo/Addmoodrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Addnote.dart';
import 'Splash1.dart';
import 'calander/calander_screen.dart';

class Mood extends StatefulWidget {
  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  bool isError = false;
  bool isLoading = false;
  var moodid;
  int _selectedIndex;
  Addmoodrepo addmoodrepo = Addmoodrepo();
  var image = [
    "assets/icons/Group 7041.png",
    "assets/icons/Group 7042.png",
    "assets/icons/anxious.png",
    "assets/icons/Group 1.png",
    "assets/icons/Group 7044.png",
    "assets/icons/Group 7043.png"
  ];

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
      backgroundColor: Colors.white,
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
        actions: [
          TextButton(
            onPressed: () {
              Get.to(CalanderScreen());
            },
            child: Text(
              'Mood Diary',
              style: TextStyle(
                  color: Color(
                    0xff0066B3,
                  ),
                  fontSize: 18),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "How are you feeling today ?",
                style:  GoogleFonts.openSans(

                    fontWeight: FontWeight.w600,
                    color: Color(0xff445066),
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              child: GridView.count(crossAxisCount: 3, children: moodswidget()),
            ),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                if (moodid == null) {
                  Get.showSnackbar(GetBar(
                    message: 'Please select any one mood',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addnote(
                              moodId: moodid,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/icons/editIcon.png',),
                    SizedBox(width: 10,),
                    Text(
                      "Add a Note to express yourself",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
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
                color: Color(0xff0066B3),
                child: Text("DONE",style: GoogleFonts.openSans(
                  fontSize: 16,
                ),),
                textColor: Colors.white,
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  print('CLIENT ID:${prefs.getString("cleintid")}');
                  if(prefs.getString("cleintid")==null){
                    Get.showSnackbar(GetBar(
                      message: 'Please First Login',
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  if (moodid == null) {
                    Get.showSnackbar(GetBar(
                      message: 'Please select any one mood',
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  final response = await addmoodrepo.addmood(
                      context: context, moodid: moodid);
                  if (response == null) {
                    Get.showSnackbar(GetBar(
                      message: 'Hey, your mood is already set for today!',
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  Get.to(MoodDoneScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic moods = new List();

  void getmoodsfromserver() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/mood'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        moods = responseJson['moods'];
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

  List<Widget> moodswidget() {
    var opacuit = 1.0;
    List<Widget> moodlist = new List();
    for (int i = 0; i < moods.length; i++) {
      moodlist.add(GestureDetector(
        onTap: () {
          _onSelected(i);
          print(moods[i]['id']);
          moodid = moods[i]['id'];
          print('mood Id :$moodid');
        },
        child: Container(
          child: Column(
            children: [
              Opacity(
                opacity:
                    _selectedIndex != null && _selectedIndex == i ? 0.5 : 1.0,
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
                  child: Image.asset(image[i],),
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
