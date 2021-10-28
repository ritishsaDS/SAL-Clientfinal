import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/UI/CousellorProfile.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/NavigationBar.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/data/repo/getTherapistDetailRepo.dart';
import 'package:sal_user/models/getTherapistDetailModal.dart';

import 'SearchResult.dart';

class Connect extends StatefulWidget {
  const Connect({Key key}) : super(key: key);

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  bool isError = true;
  bool isLoading = false;
  bool isloding = false;
  String topic;
  int _selectedIndex = 0;
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
    "23:30",
    "24:00"
  ];

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  var topictype;
  String languageid;
  String language;
  bool expand = false;
  int checkboxValue = 0;
  var passlist = [];
  double price = 0;
  DateTime selectedDate = DateTime.now();
  var getHomeContentModal = GetCounsellor();
  var getprofilecontent = GetTherapistDetailRepo();
  TextEditingController date = TextEditingController();
  var type = [
    'Anxiety Management',
    'anger',
    "stress",
    "depression",
    "relationship",
    "parenting",
    "grief",
    "motivation",
    "life",
    "others",
  ];
  var connectforid = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    date.text = DateFormat.yMd().format(selectedDate);
  }

  int _selectedIndexs = 0;
  var therapist;

  _onSelectedslot(int index, therapistid) {
    setState(() {
      _selectedIndexs = index;
      therapist = therapistid;
    });
  }

  @override
  void initState() {
    gettherapist();
    getCouncilorfromserver();
    getdatafromserver();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Filter Search",
              style: TextStyle(
                color: Color(midnightBlue),
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Text(
                      "Connect for",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(fontColorGray)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(fontColorGray)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(fontColorGray)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(fontColorGray)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(fontColorGray)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(fontColorGray)),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                      ),
                      items: category.map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem<String>(
                          value: item['id'] + "," + item["category"],
                          child: Text(
                            item['category'],
                            style: TextStyle(
                                color: Color(midnightBlue),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select a Topic",
                        style: TextStyle(
                            color: Color(fontColorGray),
                            fontSize: SizeConfig.blockSizeVertical * 1.75,
                            fontWeight: FontWeight.w400),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(fontColorGray),
                      ),
                      value: topic,
                      onChanged: (value) {
                        setState(() {
                          topictype = value;
                          print(topic);
                          passlist.add(value.toString().substring(2));
                        });
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (expand == false)
                        setState(() {
                          expand = true;
                        });
                      else
                        setState(() {
                          expand = false;
                        });
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Advance Filter",
                            style: TextStyle(
                                color: Color(midnightBlue),
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0XFFE0EDF6),
                            ),
                            child: Icon(
                              expand == false ? Icons.add : Icons.remove,
                              color: Color(backgroundColorBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (expand == true)
                    Column(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Connect with",
                                style: TextStyle(
                                    color: Color(backgroundColorBlue),
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.info_outline,
                                color: Color(fontColorGray),
                              )
                            ],
                          ),
                        ), // Connect with
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth * 0.4,
                                    child: RadioListTile(
                                      title: Text(
                                        "Counsellor",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(fontColorGray)),
                                      ),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: Color(backgroundColorBlue),
                                      value: 1,
                                      groupValue: checkboxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          checkboxValue = value;
                                          passlist.add("Counsellor");
                                          print(checkboxValue);
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.4,
                                    child: RadioListTile(
                                      title: Text(
                                        "Listener",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(fontColorGray)),
                                      ),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: Color(backgroundColorBlue),
                                      value: 2,
                                      groupValue: checkboxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          passlist.add("Listener");
                                          checkboxValue = value;
                                          print(checkboxValue);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth * 0.8,
                                    child: RadioListTile(
                                      title: Text(
                                        "Alternative Therapist",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(fontColorGray)),
                                      ),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: Color(backgroundColorBlue),
                                      value: 4,
                                      groupValue: checkboxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          passlist.add("Alternative Therapist");
                                          checkboxValue = value;
                                          print(checkboxValue);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ), // Radios
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                color: Color(backgroundColorBlue),
                                fontWeight: FontWeight.w600),
                          ),
                        ), // Date
                        Container(
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Select Date",
                              hintStyle: TextStyle(
                                  color: Color(fontColorGray),
                                  fontSize: SizeConfig.blockSizeVertical * 1.75,
                                  fontWeight: FontWeight.w400),
                              suffixIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(fontColorGray),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(12),
                            ),
                            readOnly: true,
                            controller: date,
                            onTap: () {
                              selectDate(context);
                            },
                          ),
                        ), //Calendar
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "₹ ${price.round().toString()} - ₹ 2500",
                                    style: TextStyle(
                                        color: Color(fontColorSteelGrey),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbColor: Colors.white,
                                  activeTrackColor: Color(backgroundColorBlue),
                                  inactiveTrackColor: Color(fontColorGray),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 2500,
                                  value: price,
                                  divisions: 50,
                                  label: price.round().toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      price = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Text(
                            "Language",
                            style: TextStyle(
                                color: Color(backgroundColorBlue),
                                fontWeight: FontWeight.w600),
                          ),
                        ), // Date
                        Container(
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(fontColorGray)),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(12),
                            ),
                            items: languages.map<DropdownMenuItem<String>>((
                                item) {
                              return DropdownMenuItem<String>(
                                value: item['id'] + "," + item["language"],
                                child: Text(
                                  item['language'],
                                  style: TextStyle(
                                      color: Color(midnightBlue),
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.blockSizeVertical *
                                          2),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select a Language",
                              style: TextStyle(
                                  color: Color(fontColorGray),
                                  fontSize: SizeConfig.blockSizeVertical * 1.75,
                                  fontWeight: FontWeight.w400),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(fontColorGray),
                            ),
                            value: language,
                            onChanged: (value) {
                              setState(() {
                                language = value;
                                print(language.toString().substring(2));
                                passlist.add(language.toString().substring(2));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Color(fontColorGray),
                            ),
                          ),
                          child: Text(
                            "CLEAR",
                            style: TextStyle(color: Color(fontColorGray)),
                          ),
                          minWidth: SizeConfig.screenWidth * 0.4,
                        ),
                        MaterialButton(
                          onPressed: () {
                            //print(checkboxValue.toString()+"  "+topic+""+price.round().toString()+""+language+""+selectedDate.toString().substring(0,10));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchResult(
                                            list: passlist,
                                            type: checkboxValue,
                                            topic: topictype,
                                            language: language,
                                            date: selectedDate
                                                .toString()
                                                .substring(0, 10),
                                            price: price.round().toString())));
                          },
                          color: Color(backgroundColorBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "SEARCH",
                            style: TextStyle(color: Colors.white),
                          ),
                          minWidth: SizeConfig.screenWidth * 0.4,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.45,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: Councilorwidget(),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 20,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: eventlength.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.center,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _onSelected(index);
                                  });
                                  print(eventlength[index]);
                                  getCouncilorpagefromserver(
                                      eventlength[index]);
                                },
                                child: Center(
                                    child: eventlength.last <= index
                                        ? Text(
                                        (eventlength[index] + 1).toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _selectedIndex != null &&
                                              _selectedIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ))
                                        : Text(
                                      (eventlength[index] + 1).toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _selectedIndex != null &&
                                            _selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ))),
                            decoration: BoxDecoration(
                                color: _selectedIndex != null &&
                                    _selectedIndex == index
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            index: 1,
          ),
        ));
  }

  void gettherapist() {
    getprofilecontent
        .getTherapistDetail(
      context: context,
      //  therapistId: prefs.getString("therapistid")
    )
        .then((value) async {
      if (value != null) {
        print(value.meta.status);
        if (value.meta.status == "200") {
          setState(() {
            isloding = false;
            print(value.counsellors);
            // print(value.meta.messageType);
            getHomeContentModal = value;
            // print(getHomeContentModal.counsellors[5].firstName);
          });
        } else {
          setState(() {
            isloding = false;
          });
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      } else {
        setState(() {
          isloding = false;
        });
        showAlertDialog(
          context,
          value.meta.message,
          "",
        );
      }
    }).catchError((error) {
      setState(() {
        isloding = false;
      });
      showAlertDialog(
        context,
        error.toString(),
        "",
      );
    });
  }

  dynamic Therapist = new List();
  dynamic mediaurl = new List();
  dynamic category = new List();
  dynamic languages = new List();
  dynamic slots = new List();
  var pages;
  var eventlength = [];

  void getCouncilorfromserver() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        mediaurl = responseJson['media_url'];
        Therapist = responseJson['counsellors'];
        pages = responseJson['no_pages'];
        slots = responseJson['slots'];
        List<String> cddc = List<String>.generate(int.parse(pages), (counter) {
          // print("item" + counter.toString());
          eventlength.add(counter);
        });
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

  void getCouncilorpagefromserver(page) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search?page=${page}'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        setState(() {
          mediaurl = responseJson['media_url'];
          Therapist = responseJson['counsellors'];
          pages = responseJson['no_pages'];
          eventlength.clear();
          List<String> cddc =
          List<String>.generate(int.parse(pages), (counter) {
            // print("item" + counter.toString());

            eventlength.add(counter);
          });
        });
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

  void getdatafromserver() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/meta'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        languages = responseJson['languages'];
        category = responseJson['content_categories'];

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

  List<Widget> Councilorwidget() {
    List<Widget> councilorlist = new List();
    for (int i = 0; i < Therapist.length; i++) {
      councilorlist.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: SizeConfig.screenWidth * 0.25,
                  height: SizeConfig.screenHeight * 0.1,
                  margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 0.8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Therapist[i]['photo'] == null
                        ? Image.asset(
                      'assets/bg/person.png',
                      fit: BoxFit.cover,
                    )
                        : Therapist[i]['photo'] == ""
                        ? Image.asset(
                      'assets/bg/person.png',
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      mediaurl + Therapist[i]['photo'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      top: SizeConfig.blockSizeVertical * 0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            Therapist[i]['first_name'],
                            style: TextStyle(
                                color: Color(fontColorSteelGrey),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                          Container(
                            child: Image.asset(
                              'assets/icons/dot.png',
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 2),
                          ),
                          Row(
                            children: [
                              Text(
                                Therapist[i]['average_rating'],
                                style: TextStyle(
                                    color: Color(fontColorSteelGrey),
                                    fontSize:
                                    SizeConfig.blockSizeVertical * 1.50),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0XFFF0CA03),
                                size: SizeConfig.blockSizeVertical * 2,
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            Therapist[i]['type'] == "1"
                                ? "Counsellor"
                                : Therapist[i]['type'] == "2"
                                ? "Listener"
                                : "Therapist",
                            style: TextStyle(
                                color: Color(fontColorSteelGrey),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                          Container(
                            child: Image.asset(
                              'assets/icons/dot.png',
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 2),
                          ),
                          Text(
                            Therapist[i]['price'],
                            style: TextStyle(
                                color: Color(fontColorSteelGrey),
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                        ],
                      ),
                      Text(
                        "7+ Years",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(fontColorSteelGrey)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin:
              EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
              child: Text(
                "Next available Today",
                style: TextStyle(
                    color: Color(fontColorSteelGrey),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                height: SizeConfig.blockSizeVertical * 6,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                  slotarray(slots[Therapist[i]['id']], Therapist[i]['id']),
                )),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: MaterialButton(
                onPressed: () {
                  print('SLOT :${slots[Therapist[i]['id']]}');
                  print('SLOT DATA :${Therapist[i]['id']}');


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CounsellorProfile(
                                  getData: Therapist[i],
                                  mediaUrl: mediaurl,
                                  slot: slots[Therapist[i]['id']].isEmpty
                                      ? {}
                                      : slots[Therapist[i]['id']][0],
                                  type: Therapist[i]['type'])));
                },
                child: Text(
                  "BOOK APPOINTMENT",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(backgroundColorBlue),
                minWidth: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 6,
              ),
            ),
          ],
        ),
      );
    }
    return councilorlist;
  }

  List<Widget> slotarray(id, therapistid) {
    print('SLOT:..$slots');
    print('SLOT:..TyPE ${slots.runtimeType}');
    print("jnwejoen$id}");

    if (id == null) {
      List<Widget> slotlist = new List();
      {
        slotlist.add(Text("No Slot Available for today"));
      }
      return slotlist;
    } else if (id.isEmpty) {
      List<Widget> slotlist = new List();
      {
        slotlist.add(Text("No Slot Available for today"));
      }
      return slotlist;
    } else {
      var value = [];
      print(id);
      id[0].keys.forEach((key) {
        value.add(key);
      });
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
                _onSelectedslot(i, therapistid);
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.2,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _selectedIndexs != null &&
                        _selectedIndexs == i &&
                        therapist == (therapistid)
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
                child: Text(moodstatic[int.parse(value[i])].toString()),
                alignment: Alignment.center,
              ),
            )
                : Container(),
          );
        }
      }
      return slotlist;
    }
  }
}
