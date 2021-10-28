import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/calander/calander_screen.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Calendarrepo.dart';
import 'package:sal_user/models/Calendarmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';
import 'custom_calendar.dart';

enum CalendarViews { dates, months, year }

class CalanderScreenWidget extends StatefulWidget {
  @override
  _CalanderScreenWidgetState createState() => _CalanderScreenWidgetState();
}

class _CalanderScreenWidgetState extends State<CalanderScreenWidget> {
  DateTime _currentDateTime;
  DateTime _selectedDateTime;
  List<Calendar> _sequentialDates;
  var next;
  var start;
  var apidate;
  int midYear;
  CalendarViews _currentView = CalendarViews.dates;
  final List<String> _weekDays = [
    //MON
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final TextStyle _textStyle = TextStyle(color: Colors.blue);
  var token;
  var notesdate;
  var usernotes;
  var listOfDates;
  var value;
  dynamic notes = new List();
  var upcomintAppointments = Calendarrepo();
  bool isLoading = true;
  Calendarmodel calendarmodel;

  @override
  void initState() {
    final date = DateTime.now();
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
    super.initState();

    isLoading = true;
    upcomintAppointments.upcomingAppointmentRepo().then((value) {
      print('Response:$value');
      if (value != null) {
        if (value.meta.status == "200") {
          setState(() {
            isLoading = false;
          });
          calendarmodel = value;
        } else {
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      } else {
        showAlertDialog(
          context,
          "No data found",
          "",
        );
      }
    }).catchError((error) {
      showAlertDialog(
        context,
        error.toString(),
        "",
      );
    });
  }

  // void initState() {
  //   super.initState();
  //   getdot();
  //   //getnotescountbymonth();
  //   getnextdate();
  //  // getNotesdate();
  //   //getnotescount(
  //       //_selectedDateTime == null ? DateTime.now() : _selectedDateTime);
  //
  // }

  // String (DateTime solar) {
  //   List<int> lunar = CalendarConverter.solarToLunar(
  //       solar.year, solar.month, solar.day, Timezone.Japanese);
  //   return DateFormat.Md('ja').format(DateTime(lunar[2], lunar[1], lunar[0]));
  // }

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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedMonthDays =
        DateTime(_currentDateTime.year, _currentDateTime.month + 1, 0).day;
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      SizedBox(
        height: 20,
      ),
      isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
              child: GetBuilder<MoodController>(
                builder: (controller) {
                  if (!controller.isDay.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _datesHeaderView(),
                          Expanded(
                            child: ListView(
                              children:
                                  List.generate(selectedMonthDays, (index) {
                                String noteTxt = calendarmodel.moodResults
                                    .firstWhere(
                                        (element) =>
                                            element.date ==
                                            DateTime(
                                                _currentDateTime.year,
                                                _currentDateTime.month,
                                                index + 1),
                                        orElse: () => null)
                                    ?.notes;
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${index + 1} ${DateFormat('EEEE').format(DateTime(_currentDateTime.year, _currentDateTime.month, index + 1)).replaceFirst('day', '').toUpperCase()}',
                                              style: TextStyle(
                                                  color: Color(0xff77849C),
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  '${noteTxt == null || noteTxt == '' ? '' : noteTxt}',
                                                  style: TextStyle(
                                                      color: Color(0xff445066),
                                                      fontSize: 14),
                                                ),
                                              )),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: calendarmodel
                                                    .moodResults.isNotEmpty
                                                ? calendarmodel.moodResults
                                                            .indexWhere((element) =>
                                                                element.date ==
                                                                DateTime(
                                                                    _currentDateTime
                                                                        .year,
                                                                    _currentDateTime
                                                                        .month,
                                                                    index +
                                                                        1)) >
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
                                                        color:
                                                            Color(0xffE0EDF6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      )
                                                : BoxDecoration(
                                                    color: Color(0xffE0EDF6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                            child: calendarmodel
                                                    .moodResults.isNotEmpty
                                                ? calendarmodel.moodResults
                                                            .indexWhere((element) =>
                                                                element.date ==
                                                                DateTime(
                                                                    _currentDateTime
                                                                        .year,
                                                                    _currentDateTime
                                                                        .month,
                                                                    index +
                                                                        1)) >
                                                        -1
                                                    ? Padding(
                                                        padding: EdgeInsets.all(calendarmodel
                                                                    .moodResults
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .date ==
                                                                        DateTime(
                                                                            _currentDateTime
                                                                                .year,
                                                                            _currentDateTime
                                                                                .month,
                                                                            index +
                                                                                1))
                                                                    .moodId ==
                                                                '4'
                                                            ? 0
                                                            : 7),
                                                        child: Image.asset(
                                                          getMoodIcon(calendarmodel
                                                              .moodResults
                                                              .firstWhere((element) =>
                                                                  element
                                                                      .date ==
                                                                  DateTime(
                                                                      _currentDateTime
                                                                          .year,
                                                                      _currentDateTime
                                                                          .month,
                                                                      index +
                                                                          1))
                                                              .moodId),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      )
                                                    : SizedBox()
                                                : SizedBox(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Color(0xff445066),
                                    )
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.all(16),
                      height: getProportionateScreenHeight(460),
                      child: (_currentView == CalendarViews.dates)
                          ? _datesView()
                          : (_currentView == CalendarViews.months)
                              ? _showMonthsList()
                              : _yearsView(midYear ?? _currentDateTime.year),
                    );
                  }
                },
              ),
            ),
    ])));
  }

  // List<Widget> notesdatewidget() {
  //   List<Widget> productList = new List();
  //   for (int i = 0; i < nextfromserver.length; i++) {
  //     productList.add(Padding(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: getProportionateScreenWidth(20),
  //       ),
  //       child: Container(
  //           margin: EdgeInsets.only(top: 10),
  //           height: getProportionateScreenHeight(100),
  //           width: SizeConfig.screenWidth,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.blue),
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text(
  //                 nextfromserver[i]['date'].toString().replaceAll("-", "/"),
  //                 style: _textStyle.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               Text(
  //                 nextfromserver[i]['note'],
  //                 style: _textStyle,
  //               ),
  //             ],
  //           )),
  //     ));
  //   }
  //   return productList;
  // }

  // dates view
  Widget _datesView() {
    return SizedBox(
      height: getProportionateScreenHeight(400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // prev month button
              _toggleBtn(false, Colors.black),
              // month and year
              InkWell(
                onTap: () =>
                    setState(() => _currentView = CalendarViews.months),
                child: Center(
                  child: Text(
                    '${_monthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // next month button
              _toggleBtn(true, Colors.black),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: getProportionateScreenHeight(390),
            // padding: EdgeInsets.only(left:16,right: 16),
            child: _calendarBody(),
          ),
        ],
      ),
    );
  }

  Widget _datesHeaderView() {
    return Container(
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // prev month button
              _toggleBtn(false, Colors.black),
              // month and year
              Center(
                child: Text(
                  '${_monthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // next month button
              _toggleBtn(true, Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  // next / prev month buttons
  Widget _toggleBtn(bool next, Color color) {
    return InkWell(
      onTap: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next) ? _getNextMonth() : _getPrevMonth());
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear =
                (midYear == null) ? _currentDateTime.year + 9 : midYear + 9;
          } else {
            midYear =
                (midYear == null) ? _currentDateTime.year - 9 : midYear - 9;
          }
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Icon((next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            color: color),
      ),
    );
  }

  // calendar
  Widget _calendarBody() {
    if (_sequentialDates == null) return Container();
    return SwipeDetector(
      onSwipeRight: () {
        setState(() {
          _getPrevMonth();

          print("swipe right");
        });
      },
      onSwipeLeft: () {
        setState(() {
          _getNextMonth();
        });
      },
      child: GridView.builder(
        // shrinkWrap: true,
        padding: EdgeInsets.zero,

        itemCount: _sequentialDates.length + 7,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisCount: 7,
            crossAxisSpacing: 14,
            childAspectRatio: 7 / 9),
        itemBuilder: (context, index) {
          if (index < 7) return _weekDayTitle(index);

          // if (_sequentialDates[index - 7].date == _selectedDateTime)
          //   return _selector(_sequentialDates[index - 7]);
          //  nextdate();

          return _calendarDates(_sequentialDates[index - 7]);
        },
      ),
    );
  }

  getdot() {
    var now = DateTime.now();

    // Getting the total number of days of the month
    var totalDays = daysInMonth(now);

    // Stroing all the dates till the last date
    // since we have found the last date using generate
    listOfDates =
        new List<String>.generate(totalDays, (i) => "2020/06/${i + 1}");
    print(listOfDates);
  }

// this returns the last date of the month using DateTime
  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  // calendar header
  Widget _weekDayTitle(int index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          _weekDays[index],
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // calendar element
  Widget _calendarDates(Calendar calendarDate) {
    // print('response:${calendarmodel.moodResults}');
    // print('DAte:${calendarDate.date}');
    return InkWell(
        onTap: () async {
          if (_selectedDateTime != calendarDate.date) {
            if (calendarDate.nextMonth) {
              _getNextMonth();
            } else if (calendarDate.prevMonth) {
              _getPrevMonth();
            }
            setState(() => _selectedDateTime = calendarDate.date);

            print(_selectedDateTime);
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 7, right: 7),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 25,
                      width: 60,
                      decoration: calendarmodel.moodResults.isNotEmpty
                          ? calendarmodel.moodResults.indexWhere((element) =>
                                      element.date == calendarDate.date) >
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
                      child: calendarmodel.moodResults.isNotEmpty
                          ? calendarmodel.moodResults.indexWhere((element) =>
                                      element.date == calendarDate.date) >
                                  -1
                              ? Padding(
                                  padding: EdgeInsets.all(calendarmodel
                                              .moodResults
                                              .firstWhere((element) =>
                                                  element.date ==
                                                  calendarDate.date)
                                              .moodId ==
                                          '4'
                                      ? 0
                                      : 7),
                                  child: Image.asset(
                                    getMoodIcon(calendarmodel.moodResults
                                        .firstWhere((element) =>
                                            element.date == calendarDate.date)
                                        .moodId),
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : SizedBox()
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${calendarDate.date.day}',
                        style: TextStyle(
                          fontSize: 10,
                        ))
                  ],
                ),
                // Text(
                //   '${calendarDate.date.day}',
                //   style: TextStyle(
                //     fontSize: 10,
                //     color: (calendarDate.thisMonth)
                //         ? (calendarDate.date.weekday == DateTime.sunday)
                //             ? Colors.black
                //             : Colors.black
                //         : (calendarDate.date.weekday == DateTime.sunday)
                //             ? Colors.black.withOpacity(0.5)
                //             : Colors.black.withOpacity(0.5),
                //   ),
                // ),
              ]),
        ));
  }

  // date selector
  Widget _selector(Calendar calendarDate) {
    return GestureDetector(
      onTap: () {
        print('${calendarDate.date.day}');
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${calendarDate.date.day.toString()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${(DateTime.parse(calendarDate.date.toString()))}',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  // show months list
  Widget _showMonthsList() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _currentView = CalendarViews.year),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '${_currentDateTime.year}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue),
            ),
          ),
        ),
        Divider(
          color: Colors.black38,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _monthNames.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                _currentDateTime = DateTime(_currentDateTime.year, index + 1);
                _getCalendar();
                setState(() => _currentView = CalendarViews.dates);
              },
              title: Center(
                child: Text(
                  _monthNames[index],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: (index == _currentDateTime.month - 1)
                          ? Colors.blue
                          : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // years list views
  Widget _yearsView(int midYear) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _toggleBtn(false, Colors.black),
              Spacer(),
              _toggleBtn(true, Colors.black),
            ],
          ),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  int thisYear;
                  if (index < 4) {
                    thisYear = midYear - (4 - index);
                  } else if (index > 4) {
                    thisYear = midYear + (index - 4);
                  } else {
                    thisYear = midYear;
                  }
                  return ListTile(
                    onTap: () {
                      _currentDateTime =
                          DateTime(thisYear, _currentDateTime.month);
                      _getCalendar();
                      setState(() => _currentView = CalendarViews.months);
                    },
                    title: Text(
                      '$thisYear',
                      style: TextStyle(
                          fontSize: 18,
                          color: (thisYear == _currentDateTime.year)
                              ? Colors.blue
                              : Colors.black),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void getnextdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    next = prefs.getString("nextdate");
    start = prefs.getString("startdate");
    var one;
    var two;
    var three;
    one = DateTime.parse(start).day + 1;
    two = one + 1;
    one = two + 1;
    //print(one+two+three);
    print("sndlljnsdl" + start);
    if (prefs.getString("selecteddate") == null) {
    } else {
      _selectedDateTime = DateTime.parse(prefs.getString("selecteddate"));
    }

    //print(next.toString().substring(8));
  }
}
