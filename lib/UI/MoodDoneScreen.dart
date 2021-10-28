import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/UI/Articledetail.dart';
import 'package:sal_user/data/repo/Calendarrepo.dart';
import 'package:sal_user/models/Calendarmodel.dart';
import 'package:sal_user/models/forYouResponseModel.dart';

import 'calander/calander_screen.dart';

class MoodDoneScreen extends StatefulWidget {
  @override
  _MoodDoneScreenState createState() => _MoodDoneScreenState();
}

class _MoodDoneScreenState extends State<MoodDoneScreen> {
  String basePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';

  List<DateTime> weekDateList = [];

  String getMoodIcon(String key) {
    print('KEY:$key');
    String icon;
    if (key == '1') {
      icon = "Group 7041.png";
    } else if (key == '2') {
      icon = "Group 7042.png";
    } else if (key == '3') {
      icon = "anxious.png";
    } else if (key == '4') {
      icon = "concerned.png";
    } else if (key == '5') {
      icon = "Group 7044.png";
    } else if (key == '6') {
      icon = "Group 7043.png";
    } else {
      icon = "Group 7041.png";
    }

    return 'assets/icons/' + icon;
  }

  DateTime now = DateTime.now();

  void addWeekDate() {
    DateTime weekStartDate = now.subtract(Duration(days: now.weekday - 1));
    for (int index = 0; index < 7; index++) {
      weekDateList.add(weekStartDate.add(Duration(days: index)));
    }
  }

  @override
  void initState() {
    super.initState();
    addWeekDate();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            _customAppBar(),
            Expanded(
              child: FutureBuilder<Calendarmodel>(
                  future: Calendarrepo().upcomingAppointmentRepo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Server Error'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff0066B3)),
                            child: Center(
                              child: Text(
                                'Your Mood has been\nsuccessfully recorded!',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Your moods this week',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _weekDays(snapshot.data.moodResults),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(
              child: FutureBuilder(
                future: Calendarrepo().forYouRepo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Server Error'),
                    );
                  }
                  ForYouResponse response = snapshot.data;
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'For you',
                          style: TextStyle(
                              color: Color(0xff0066B3),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: GridView(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1 / 0.8),
                          children: List.generate(
                              response.articles.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Article article =
                                          response.articles[index];
                                      Get.to(ArticleDetail(
                                        description: article.description,
                                        image: article.photo,
                                        title: article.title,
                                        id: article.id,
                                      ));
                                    },
                                    child: boxContainer(
                                        image: basePath +
                                            response.articles[index].photo,
                                        title: response.articles[index].title),
                                  )),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container boxContainer({String image, String title}) {
    return Container(
      width: Get.width * 0.45,
      height: Get.height * 0.2,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
      ),
      child: Container(
        width: Get.width,
        padding:
            EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02),
        height: Get.height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title ?? 'N/A',
                style: GoogleFonts.openSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              "",
              style: GoogleFonts.openSans(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _weekDays(List<MoodResult> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDateList
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('EEEE').format(e).substring(0, 3).toUpperCase(),
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: data.isNotEmpty
                        ? data.indexWhere((element) =>
                                    DateFormat('yyyy-MM-dd')
                                        .format(element.date) ==
                                    DateFormat('yyyy-MM-dd').format(e)) >
                                -1
                            ? BoxDecoration(
                                image: DecorationImage(
                                  scale: 2,
                                  image: AssetImage(
                                    "assets/icons/Rectangle 412.png",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : BoxDecoration(
                                color: Color(0xffE0EDF6),
                                borderRadius: BorderRadius.circular(4),
                              )
                        : BoxDecoration(
                            color: Color(0xffE0EDF6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                    child: Center(
                        child: data.isNotEmpty
                            ? data.indexWhere((element) =>
                                        DateFormat('yyyy-MM-dd')
                                            .format(element.date) ==
                                        DateFormat('yyyy-MM-dd').format(e)) >
                                    -1
                                ? Padding(
                                    padding: EdgeInsets.all(data
                                                .firstWhere((element) =>
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(element.date) ==
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(e))
                                                .moodId ==
                                            '4'
                                        ? 0
                                        : 7),
                                    child: Image.asset(
                                      getMoodIcon(data
                                          .firstWhere((element) =>
                                              DateFormat('yyyy-MM-dd')
                                                  .format(element.date) ==
                                              DateFormat('yyyy-MM-dd')
                                                  .format(e))
                                          .moodId),
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox()),
                  ),
                ],
              ))
          .toList(),
    );
  }

  Row _customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
    );
  }
}
