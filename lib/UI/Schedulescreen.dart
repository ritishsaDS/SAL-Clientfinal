import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/Sessions.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Appointmentorder.dart';
import 'package:sal_user/models/appointmentmode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class DynamicEvent extends StatefulWidget {
  dynamic data;
  var appointment;
  dynamic mediaurl;
  var type;
  var id;
  Map<String, dynamic> slot;

  DynamicEvent(
      {this.data, this.id,this.mediaurl, this.type, this.appointment, this.slot});

  @override
  _DynamicEventState createState() => _DynamicEventState();
}

class _DynamicEventState extends State<DynamicEvent> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  int _selectedIndex;
  var value = [];
  bool  isError = false;
 bool isLoading = false;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  String slotid;
  var selectdate = DateTime.now();

  var moodstaticList = [
    ' ',
    "0:30",
    "1:00",
    "1:30",
    "2:00",
    "2:30",
    "3:00",
    "3:30",
    "4:00",
    "4:30",
    "5:00",
    "5:30",
    "6:00",
    "6:30",
    "7:00",
    "7:30",
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    '20:00',
    '20:30',
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30",
    "24:00"
  ];
  var slot = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    '37',
    '38',
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47"
  ];

  List<String> listAvailableSlot = [];

  @override
  void initState() {
    super.initState();
    print("jndfvko"+widget.data.toString());
    getdatafromserver();
    setSlotTime();

    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    prefsData();
  }

  List<String> list = [];

  void setSlotTime() {
    widget.slot.keys.forEach((element) {
      if (element != 'date') {
        listAvailableSlot.add(element);
      }
    });

    for (int index = 0; index < listAvailableSlot.length; index++) {
      if (index.isEven) {
        list.add(listAvailableSlot[index]);
      }
    }
    listAvailableSlot = list;
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Schedule",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  TableCalendar(
                    events: _events,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.black),
                      weekendStyle: TextStyle(color: Colors.black),
                    ),
                    initialCalendarFormat: CalendarFormat.week,
                    calendarStyle: CalendarStyle(
                      // canEventMarkersOverflow: true,
                      weekdayStyle: TextStyle(color: Colors.black),
                      highlightToday: false,
                      weekendStyle: TextStyle(color: Colors.black),
                      //outsideWeekendStyle: TextStyle(color: Colors.white60),
                      // outsideStyle: TextStyle(color: Colors.white60),
                      // outsideWeekendStyle:TextStyle(color: Colors.black),
                      /// todayColor: Colors.orange,
                      selectedColor: Theme.of(context).primaryColor,
                      // todayStyle: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 18.0,
                      //     color: Colors.white)),
                    ),
                    headerStyle: HeaderStyle(
                      headerMargin: EdgeInsets.symmetric(vertical: 5),
                      // formatButtonVisible: true,
                      // formatButtonShowsNext: true,
                      formatButtonDecoration:
                          BoxDecoration(color: Colors.transparent),
                      formatButtonTextStyle:
                          TextStyle(color: Colors.transparent),
                      //
                      // decoration: BoxDecoration(
                      //   //color: Colors.blue,
                      //     border: Border(bottom: BorderSide(color: Colors.blue))),
                      centerHeaderTitle: true,
                      leftChevronIcon: Icon(Icons.arrow_back_ios,
                          size: 15, color: Color(backgroundColorBlue)),
                      rightChevronIcon: Icon(Icons.arrow_forward_ios,
                          size: 15, color: Color(backgroundColorBlue)),

                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events, holidays) {
                      setState(() {
                        _selectedEvents = events;
                        selectdate = date;
                        print(selectdate);
                        getdatafromserver();
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFF0066B3),
                              borderRadius: BorderRadius.circular(40.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      // todayDayBuilder: (context, date, events) => Container(
                      //     margin:  EdgeInsets.all(4.0),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: Theme.of(context).primaryColor,
                      //         borderRadius: BorderRadius.circular(40.0)),
                      //     child: Text(
                      //       date.day.toString(),
                      //       style: TextStyle(color: Colors.white),
                      //     )),
                    ),
                    calendarController: _controller,
                  ),
                  Positioned(
                      right: 5,
                      top: 60,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.toggleCalendarFormat();
                            });
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                      ))
                ],
              ),
              ..._selectedEvents.map((event) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Center(
                          child: Text(
                        event,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  )),
              Divider(
                height: 20,
                thickness: 1.6,
                color: Colors.grey[300],
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: SizeConfig.screenHeight * 0.54,
                  child: value.isEmpty
                      ? Center(child: Text('Slot not available'))
                      : GridView.count(
                          childAspectRatio: 3.5 / 2,
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 15,
                          // Generate 100 widgets that display their index in the List.
                          children:slotarray()
                          //     List.generate(value.length, (index) {
                          //   return GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         _onSelected(index);
                          //
                          //         slotid =
                          //             slot[int.parse(listAvailableSlot[index])];
                          //         print(slotid);
                          //       });
                          //     },
                          //     child: Container(
                          //       padding: EdgeInsets.all(5),
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           color: _selectedIndex != null &&
                          //                   _selectedIndex == index
                          //               ? Color(backgroundColorBlue)
                          //               : Colors.white,
                          //           border: Border.all(
                          //             color: _selectedIndex != null &&
                          //                     _selectedIndex == index
                          //                 ? Color(backgroundColorBlue)
                          //                 : Colors.grey,
                          //           )),
                          //       child: Center(
                          //         child: Text(
                          //           moodstaticList[
                          //               int.parse(value[index])],
                          //           style: TextStyle(
                          //             color: _selectedIndex != null &&
                          //                     _selectedIndex == index
                          //                 ? Colors.white
                          //                 : Colors.grey,
                          //           ),
                          //           // style: Theme.of(context).textTheme.headline5,
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          // }),
                        )),
              Container(
                margin: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () async {

                    if (slotid==null) {
                      Get.showSnackbar(GetBar(
                        message: 'Please any one slot',
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }

                    // if(sessionRadio > 0){
                    print('widget.appointment${widget.appointment}');

                    if (widget.appointment == null) {
                      var data;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      print(prefs.getString("cleintid"));
                      data = AppointmentModel(
                          clientId: prefs.getString("cleintid"),
                          counsellorId: widget.data['id'],
                          couponCode: "",
                          date: selectdate.toString(),
                          noSession: "1",
                          time: slotid);
                      Appointmentorder.diomwthod(data, context, widget.mediaurl,
                          widget.data, "1", widget.type, "Schedule");
                    }
                    else {
                      AppointmentModel data;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      print(prefs.getString("cleintid"));
                      data = AppointmentModel(
                          clientId: prefs.getString("cleintid"),
                          counsellorId: widget.data,
                          couponCode: "",
                          date: selectdate.toString(),
                          noSession: "1",
                          time: slotid);
                      print(data);
                      Appointmentorder.diomwthod(data, context, widget.mediaurl,
                          widget.data, "1", widget.type, "Schedule");
                    }

                    // }else{
                    //   toast("Please select session");
                    // }
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  minWidth: SizeConfig.screenWidth,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Color(backgroundColorBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white70,
              title: Text("Add Events"),
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                      } else {
                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                      }
                      prefs.setString(
                          "events", json.encode(encodeMap(_events)));
                      _eventController.clear();
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }
  dynamic myslots=new List();

  void getdatafromserver() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/counsellor/slots?counsellor_id=${widget.data['id']}'));
      print("bjkb" + response.body.toString());
      print("bjkb" + response.request.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
        value=[];
        for(int i =0; i<responseJson['slots'].length;i++){
          if(responseJson['slots'][i]['date']==selectdate.toString().substring(0,10)){
            print("jfvjnfvjnl");
            print(responseJson['slots'][i]);
            setState(() {
              myslots=responseJson['slots'][i];

            });

            setState(() {
              myslots.keys.forEach((key) {
                value.add(key);
                print(value);

              });
            });
          }
          else{
            setState(() {

            });
          }
        }
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
    }}
  List<Widget> slotarray() {

    print(value.length);
    List<Widget> slotlist = new List();
    for (int i = 0; i < value.length; i++) {
      print('INdex:${(i / 2) == 0}');
      print("knejknp" + value[i].length.toString());
      if (i.isEven) {
        slotlist.add(
          value[i].length < 3
              ? GestureDetector(
            onTap: () {
            setState(() {
                    _onSelected(i);

                    slotid =
                        slot[int.parse(value[i])];
                    print(slotid);
                  });
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.2,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedIndex != null &&
                      _selectedIndex == i
                      ? Color(backgroundColorBlue)
                      : Colors.white,
                  border: Border.all(
                    color: _selectedIndex != null &&
                        _selectedIndex == i
                        ? Color(backgroundColorBlue)
                        : Colors.grey,
                  )),
              child: Text(moodstaticList[int.parse(value[i])].toString(), style: TextStyle(
                            color: _selectedIndex != null &&
                                    _selectedIndex == i
                                ? Colors.white
                                : Colors.grey,),

            ),
              alignment: Alignment.center,
          ))
              : Container(),
        );
      }
    }
    return slotlist;
  }
}
