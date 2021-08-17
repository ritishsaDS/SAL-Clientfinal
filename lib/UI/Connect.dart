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

class Connect extends StatefulWidget {
  const Connect({Key key}) : super(key: key);

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
bool  isError = true;
bool isLoading = false;
bool isloding = false;
  String topic;
  String language;
  bool expand = false;
  int checkboxValue = 0;
  double price = 0;
  DateTime selectedDate = DateTime.now();
var getHomeContentModal = GetCounsellor();
var getprofilecontent = GetTherapistDetailRepo();
  TextEditingController date = TextEditingController();


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
@override
  void initState() {
  gettherapist();
  getCouncilorfromserver();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Filter Search",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: SizeConfig.blockSizeVertical
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                child: Text("Connect for",
                style: TextStyle(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.w600
                ),),
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
                  items: <String>['Topic 1', 'Topic 2', 'Topic 3']
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
                      topic = value;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: (){
                  if(expand == false)
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
                    vertical: SizeConfig.blockSizeVertical
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Advance Filter",
                        style: TextStyle(
                            color: Color(midnightBlue),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFFE0EDF6),
                        ),
                        child: Icon(expand == false ? Icons.add : Icons.remove,color: Color(backgroundColorBlue),),
                      ),
                    ],
                  ),
                ),
              ),
              if(expand == true )
                Column(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Connect with",
                          style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600
                          ),),
                          Icon(Icons.info_outline,color: Color(fontColorGray),)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.4,
                                child: RadioListTile(
                                  title: Text("Counsellor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(fontColorGray)
                                  ),),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Color(backgroundColorBlue),
                                  value: 1,
                                  groupValue: checkboxValue,
                                  onChanged: (value){
                                    setState(() {
                                      checkboxValue = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.4,
                                child: RadioListTile(
                                  title: Text("Listener",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(fontColorGray)
                                    ),),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Color(backgroundColorBlue),
                                  value: 2,
                                  groupValue: checkboxValue,
                                  onChanged: (value){
                                    setState(() {
                                      checkboxValue = value;
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
                                  title: Text("Alternative Therapist",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(fontColorGray)
                                    ),),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Color(backgroundColorBlue),
                                  value: 3,
                                  groupValue: checkboxValue,
                                  onChanged: (value){
                                    setState(() {
                                      checkboxValue = value;
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
                      child: Text("Date",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600
                        ),),
                    ), // Date
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Select Date",
                          hintStyle: TextStyle(
                              color: Color(fontColorGray),
                              fontSize: SizeConfig.blockSizeVertical * 1.75,
                              fontWeight: FontWeight.w400),
                          suffixIcon: Icon(Icons.arrow_forward_ios,color: Color(fontColorGray),),
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
                        readOnly: true,
                        controller: date,
                        onTap: (){
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price",
                                style: TextStyle(
                                    color: Color(backgroundColorBlue),
                                    fontWeight: FontWeight.w600
                                ),),
                              Text("₹ 0 - ₹ 650",
                              style: TextStyle(
                                color: Color(fontColorSteelGrey),
                                fontWeight: FontWeight.w600
                              ),)
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
                              max: 650,
                              value: price,
                              divisions: 300,
                              label: price.round().toString(),
                              onChanged: (value){
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
                      child: Text("Language",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600
                        ),),
                    ), // Date
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
                        items: <String>['English', 'Hindi', 'Punjabi','Language 1','Language 2']
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
                          });
                        },
                      ),
                    ),
                  ],
                ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(onPressed:(){},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Color(fontColorGray),
                      ),
                    ),
                    child: Text("CLEAR",style: TextStyle(
                      color: Color(fontColorGray)
                    ),),
                    minWidth: SizeConfig.screenWidth * 0.4,),
                    MaterialButton(onPressed:(){
                      Navigator.of(context).pushNamed('/SearchResult');
                    },
                      color: Color(backgroundColorBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("SEARCH",style: TextStyle(
                          color: Colors.white
                      ),),
                    minWidth: SizeConfig.screenWidth * 0.4,),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight*0.4,
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: Councilorwidget(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 1,),
    ));
  }
 void gettherapist(){
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

void getCouncilorfromserver() async {
  setState(() {
    isLoading=true;
  });

  try {
    final response = await get(Uri.parse('https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search'));
    print("bjkb" + response.statusCode.toString());
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      mediaurl=responseJson['media_url'];
      Therapist=responseJson['counsellors'];
print(Therapist);

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

List <Widget> Councilorwidget (){
List <Widget> councilorlist= new List();
for(int i =0; i<Therapist.length;i++){
  councilorlist.add(Column(
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
            margin:EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 0.8
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(mediaurl+Therapist[i]['photo'],fit: BoxFit.cover,),
            ),
          ),
          Container(
            margin:EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
                top: SizeConfig.blockSizeVertical * 0.5
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(Therapist[i]['first_name'],
                      style: TextStyle(
                          color: Color(fontColorSteelGrey),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 2
                      ),),
                    Container(
                      child: Image.asset('assets/icons/dot.png',width: SizeConfig.blockSizeHorizontal,),
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),),
                    Row(
                      children: [
                        Text(Therapist[i]['average_rating'],
                          style: TextStyle(
                              color: Color(fontColorSteelGrey),
                              fontSize: SizeConfig.blockSizeVertical * 1.50
                          ),),
                        Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,)
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Counsellor",
                      style: TextStyle(
                          color: Color(fontColorSteelGrey),
                          fontSize: SizeConfig.blockSizeVertical * 2
                      ),),
                    Container(
                      child: Image.asset('assets/icons/dot.png',width: SizeConfig.blockSizeHorizontal,),
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),),
                    Text(Therapist[i]['price'],
                      style: TextStyle(
                          color: Color(fontColorSteelGrey),
                          fontSize: SizeConfig.blockSizeVertical * 2
                      ),),
                  ],
                ),
                Text("7+ Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(fontColorSteelGrey)
                  ),)
              ],
            ),
          ),
        ],
      ),
      Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical
        ),
        child: Text("Next available Today",
          style: TextStyle(
              color: Color(fontColorSteelGrey),
              fontWeight: FontWeight.w600
          ),),
      ),
      Container(
          margin:EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical
          ),
          height: SizeConfig.blockSizeVertical * 6,
          child: ListView.builder(itemBuilder: (context, int index){
            return Container(
              width: SizeConfig.screenWidth * 0.2,
              padding:EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(fontColorGray),
                ),
              ),
              child: Text("9:00"),
              alignment: Alignment.center,
            );
          },
            primary: false,
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
          )
      ),
      Container(
        margin:EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 2
        ),
        child: MaterialButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CounsellorProfile()));
          },
          child: Text("BOOK APPOINTMENT",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
            ),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(backgroundColorBlue),
          minWidth: SizeConfig.screenWidth,
          height: SizeConfig.blockSizeVertical * 6,
        ),
      ),
    ],
  ),);
}
return councilorlist;
}
}


