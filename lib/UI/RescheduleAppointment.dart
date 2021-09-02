import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Rescheduleanbookingrepo.dart';
import 'package:sal_user/models/appointmentmode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class RescheduleAppointmet extends StatefulWidget{
  var type;
  var appointment;
  RescheduleAppointmet({this.appointment,this.type});
  @override
  _RescheduleAppointmetState createState() => _RescheduleAppointmetState();
}

class _RescheduleAppointmetState extends State<RescheduleAppointmet> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  var slotid="0";
  var selectdate=DateTime.now();

  var moodstatic = [
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
    "23:30"
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
    "44"
        "45"
        "46"
        "47"
  ];
  @override
  void initState() {
    super.initState();
    //print(widget.data);
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    prefsData();
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              TableCalendar(
                events: _events,
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  highlightToday: false,
                  weekendStyle: TextStyle(color: Colors.black),
                  //outsideWeekendStyle: TextStyle(color: Colors.white60),
                  // outsideStyle: TextStyle(color: Colors.white60),
                  // outsideWeekendStyle:TextStyle(color: Colors.black) ,
                  /// todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  // todayStyle: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 18.0,
                  //     color: Colors.white)),
                ),
                headerStyle: HeaderStyle(
                  headerMargin: EdgeInsets.symmetric(vertical: 5),
                  formatButtonVisible: false,
                  decoration: BoxDecoration(
                    //color: Colors.blue,
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  centerHeaderTitle: true,
                  leftChevronIcon:
                  Icon(Icons.arrow_back_ios, size: 15, color: Colors.blue),
                  rightChevronIcon:
                  Icon(Icons.arrow_forward_ios, size: 15, color: Colors.blue),
                  titleTextStyle: TextStyle(
                      color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events,holidays) {
                  setState(() {
                    _selectedEvents = events;
                    selectdate=date;
                    print(selectdate);
                  });
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin:  EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
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
              ..._selectedEvents.map((event) => Padding(
                padding:  EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Center(
                      child: Text(event,
                        style: TextStyle(color: Colors.blue,
                            fontWeight: FontWeight.bold,fontSize: 16),)
                  ),
                ),
              )),
              Divider(

                height: 20,thickness: 1.6,
                color: Colors.grey[300],
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: SizeConfig.screenHeight*0.54,
                  child: GridView.count(
                    childAspectRatio: 3.5/2,
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(moodstatic.length, (index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            _onSelected(index);

                            slotid=slot[index];
                            print(slotid);
                          });
                        },
                        child: Container(

                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: _selectedIndex != null && _selectedIndex == index
                              ? Colors.blue
                              : Colors.white,border: Border.all(color: _selectedIndex != null && _selectedIndex == index
                              ? Colors.blue
                              : Colors.grey,)),
                          child: Center(
                            child: Text(
                              moodstatic[index],
                              style: TextStyle(color: _selectedIndex != null && _selectedIndex == index
                                  ?Colors.white
                                  :  Color(midnightBlue), ),
                              // style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      );
                    }),
                  )

              ),
              Container(
                margin: EdgeInsets.all(10),
                child: MaterialButton(onPressed: () async {
                  // if(sessionRadio > 0){

                  var data;
                  SharedPreferences prefs =await SharedPreferences.getInstance();
                  print( prefs.getString("cleintid"));
                 // data=   AppointmentModel(clientId: prefs.getString("cleintid") ,couponCode:"" ,date:  selectdate.toString(),noSession: "1",time: slotid);
                  Reschedulebooking.diomwthod( widget.appointment,slotid,selectdate,context);


                  // }else{
                  //   toast("Please select session");
                  // }
                },
                  child: Text("Reschedule an Appointment",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                  minWidth: SizeConfig.screenWidth,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  color: Color(backgroundColorBlue),),
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
              child: Text("Save",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
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
                  prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });

              },
            )
          ],
        ));
  }

}