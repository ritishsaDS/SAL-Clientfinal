import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/bookAppointmentRepo.dart';
import 'package:sal_user/models/getTherapistDetailModal.dart';

import 'CousellorProfile.dart';

class SearchResult extends StatefulWidget {
  var list;
  var type;
  var topic;
  var price;
  var date;
  var language;
  SearchResult(
      {this.list, this.topic, this.type, this.language, this.date, this.price});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var languages = [
    {"id": "6", "language": "bengali"},
    {"id": "1", "language": "english"},
    {"id": "9", "language": "gujarati"},
    {"id": "2", "language": "hindi"},
    {"id": "5", "language": "kannada"},
    {"id": "7", "language": "malayalam"},
    {"id": "8", "language": "marathi"},
    {"id": "10", "language": "punjabi"},
    {"id": "3", "language": "tamil"},
    {"id": "4", "language": "telugu"}
  ];
  int _selectedIndexs = 0;
  var therapist;
  var filters=[];
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
  _onSelectedslot(int index, therapistid) {
    setState(() {
      _selectedIndexs = index;
      therapist = therapistid;
    });
  }
  bool isLoading = true;
  var getHomeContentModal = GetCounsellor();
  var getprofilecontent = GetTherapistDetailRepo();
  bool isError = true;
  var url;
  @override
  void initState() {

    print(widget.type);
    setState(() {
      filters=widget.list;
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search?${widget.type==null?"":"type=${widget.type}"}&${widget.topic==null?"":"topic=${widget.topic.toString().split(",")[0]}"}&language=${widget.language==null?"":widget.language.toString().split(",")[0]}${widget.price==null?"":"&price=""${widget.price},2500"}";
    });
    // gettherapist();
    getCouncilorfromserver();

    // TODO: implement initState
    super.initState();
  }

  String price;
  String rating;
  double experience = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Search Results",
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
      floatingActionButton: Container(
        width: SizeConfig.screenWidth * 0.2,
        height: SizeConfig.blockSizeVertical * 9,
        child: FloatingActionButton(
          child: ImageIcon(
            AssetImage('assets/icons/sort.png'),
            color: Colors.white,
            size: SizeConfig.blockSizeVertical * 4,
          ),
          backgroundColor: Color(backgroundColorBlue),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                      offset: Offset(1, 1),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.screenWidth * 0.4),
                      alignment: Alignment.center,
                      child: Divider(
                        color: Color(backgroundColorBlue),
                        thickness: 2.0,
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.screenWidth * 0.05),
                      child: Text(
                        "Sort",
                        style: TextStyle(
                            color: Color(midnightBlue),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 3),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05),
                      child: Text(
                        "Price",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 1.75),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical,
                          horizontal: SizeConfig.screenWidth * 0.05),
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
                        items: <String>['High to Low', 'Low to High']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Color(midnightBlue),
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Sort By Price",
                          style: TextStyle(
                              color: Color(fontColorGray),
                              fontSize: SizeConfig.blockSizeVertical * 1.75,
                              fontWeight: FontWeight.w400),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(fontColorGray),
                        ),
                        value: price,
                        onChanged: (value) {
                          setState(() {
                            price = value;
                            print(price);

                            url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search?type=${widget.type}&topic=${widget.topic.toString().split(",")[0]}&language=${widget.language==null?"":widget.language.toString().split(",")[0]}&sort_by=1&order_by${price=='High to Low'?"=1":"=2"}';
                            getCouncilorfromserver();
                            Navigator.pop(context);
                            print(url);
                          });
                        },
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05),
                      child: Text(
                        "Rating",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 1.75),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical,
                          horizontal: SizeConfig.screenWidth * 0.05),
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
                        items: <String>['Sort By Rating High to Low',]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Color(midnightBlue),
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Sort By Rating",
                          style: TextStyle(
                              color: Color(fontColorGray),
                              fontSize: SizeConfig.blockSizeVertical * 1.75,
                              fontWeight: FontWeight.w400),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(fontColorGray),
                        ),
                        value: rating,
                        onChanged: (value) {
                          setState(() {
                            rating = value;


                            url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search?${widget.type==null?"":"type=${widget.type}"}&${widget.topic==null?"":"topic=${widget.topic.toString().split(",")[0]}"}&language=${widget.language==null?"":widget.language.toString().split(",")[0]}&sort_by=2&order_by=1';
                            getCouncilorfromserver();
                            Navigator.pop(context);
                            print(url);
                          });
                        },
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05),
                      child: Text(
                        "Experience",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 1.75),
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.white,
                        activeTrackColor: Color(backgroundColorBlue),
                        inactiveTrackColor: Color(fontColorGray),
                      ),
                      child: StatefulBuilder(builder: (context, setState) {
                        return Slider(
                          min: 0,
                          max: 20,
                          value: experience,
                          divisions: 20,
                          label: experience.round().toString(),
                          onChanged: (value) {
                            setState(() {
                              experience = value;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filters.length==0?SizedBox():Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical,
                  bottom: SizeConfig.blockSizeVertical),
              height: SizeConfig.blockSizeVertical * 5,
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(backgroundColorBlue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(
                          filters[index],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        IconButton(icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: SizeConfig.blockSizeVertical * 2,
                        ),onPressed: (){
                          print(filters[index]);
                          setState(() {
                            filters.remove(filters[index]);
                            print(filters);
                            if(filters.length==0){
                              setState(() {

                                url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search";
                              });
                            }
                            else{
                              setState(() {

                                url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search?${widget.type==null?"":"type=${widget.type}"}&${widget.topic==null?"":"topic=${widget.topic.toString().split(",")[0]}"}&language=${widget.language==null?"":widget.language.toString().split(",")[0]}";
                              });
                            }
                          });
                        },)
                      ],
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal,
                    ),
                    padding: EdgeInsets.all(8),
                    height: SizeConfig.blockSizeVertical * 2,
                  );
                },
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: filters.length,
                physics: BouncingScrollPhysics(),
                primary: false,
              ),
            ),
            Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.85,
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical,
                    horizontal: SizeConfig.screenWidth * 0.05),
                child: Therapist.length == 0||Therapist==null
                    ? Column(
                        children: [Text("No Record Found")],
                      )
                    : ListView(
                        children: Councilorwidget(),
                      )),
          ],
        ),
      ),
    ));
  }

  // void gettherapist(){
  //   getprofilecontent
  //       .getTherapistDetail(
  //     context: context,
  //     //  therapistId: prefs.getString("therapistid")
  //   )
  //       .then((value) async {
  //     if (value != null) {
  //       print(value.meta.status);
  //       if (value.meta.status == "200") {
  //         setState(() {
  //           isLoading = false;
  //           print(value.counsellors);
  //           // print(value.meta.messageType);
  //           getHomeContentModal = value;
  //           // print(getHomeContentModal.counsellors[5].firstName);
  //
  //
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         showAlertDialog(
  //           context,
  //           value.meta.message,
  //           "",
  //         );
  //       }
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       showAlertDialog(
  //         context,
  //         value.meta.message,
  //         "",
  //       );
  //     }
  //   }).catchError((error) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showAlertDialog(
  //       context,
  //       error.toString(),
  //       "",
  //     );
  //   });
  // }
  dynamic Therapist = new List();
  dynamic mediaurl = new List();
  dynamic slots=new List();
  void getCouncilorfromserver() async {
print("jndi");
    // setState(() {
    //   isLoading = true;
    // });

    try {
      final response = await get(Uri.parse(
         url));
      print("bjkb" + response.request.toString());
      print("bjkb" + response.body.toString());

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
       setState(() {
         mediaurl = responseJson['media_url'];
         Therapist = responseJson['counsellors'];
         slots = responseJson['slots'];
         print(Therapist.length);
       });
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        showAlertDialog(
          context,
          response.body.toString(),
          "",
        );
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
                    child: Image.network(
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
                            "Counsellor",
                            style: TextStyle(
                                color: Color(fontColorSteelGrey),
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

                  if(slots[Therapist[i]['id']].isEmpty==true){
                    Get.showSnackbar(GetBar(
                      message: 'No Slot Avialable',
                      duration: Duration(seconds: 2),
                    ));}
                  else{
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
                  }
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
