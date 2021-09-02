import 'dart:convert';

import 'package:flutter/material.dart';
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
   SearchResult({this.list,this.topic,this.type,this.language,this.date,this.price}) ;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var languages=[
  {
  "id": "6",
  "language": "bengali"
  },
  {
  "id": "1",
  "language": "english"
  },
  {
  "id": "9",
  "language": "gujarati"
  },
  {
  "id": "2",
  "language": "hindi"
  },
  {
  "id": "5",
  "language": "kannada"
  },
  {
  "id": "7",
  "language": "malayalam"
  },
  {
  "id": "8",
  "language": "marathi"
  },
  {
  "id": "10",
  "language": "punjabi"
  },
  {
  "id": "3",
  "language": "tamil"
  },
  {
  "id": "4",
  "language": "telugu"
  }
  ];
  bool   isLoading=true;
  var getHomeContentModal = GetCounsellor();
  var getprofilecontent = GetTherapistDetailRepo();
  bool isError=true;
  @override
  void initState() {
    print(widget.list);
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
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Search Results",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),),
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded,color: Color(midnightBlue),),
        ),
      ),
      floatingActionButton: Container(
        width: SizeConfig.screenWidth * 0.2,
        height: SizeConfig.blockSizeVertical * 9,
        child: FloatingActionButton(
          child: ImageIcon(AssetImage('assets/icons/sort.png'),
          color: Colors.white,
          size: SizeConfig.blockSizeVertical * 4,),
          backgroundColor: Color(backgroundColorBlue),
          onPressed: (){
            showModalBottomSheet(context: context, builder: (BuildContext context)=> Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                    offset: Offset(1,1),
                  )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.screenWidth * 0.4
                    ),
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
                      horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Sort",
                    style: TextStyle(
                      color: Color(midnightBlue),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 3
                    ),),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Price",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.75
                      ),),
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
                      items: <String>['Price 1', 'Price 2', 'Price 3']
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
                        });
                      },
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Rating",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.75
                      ),),
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
                      items: <String>['5', '4', '3','2','1']
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
                        });
                      },
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Experience",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.75
                      ),),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.white,
                      activeTrackColor: Color(backgroundColorBlue),
                      inactiveTrackColor: Color(fontColorGray),
                    ),
                    child: StatefulBuilder(
                      builder: (context, setState){
                        return Slider(
                          min: 0,
                          max: 20,
                          value: experience,
                          divisions: 20,
                          label: experience.round().toString(),
                          onChanged: (value){
                            setState(() {
                              experience = value;
                            });
                          },
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.05,
              top: SizeConfig.blockSizeVertical,
              bottom: SizeConfig.blockSizeVertical
            ),
            height: SizeConfig.blockSizeVertical * 5,
            child: ListView.builder(itemBuilder: (context,int index){
              return Container(
                decoration: BoxDecoration(
                  color: Color(backgroundColorBlue),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(widget.list[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),
                    Icon(Icons.clear,color: Colors.white,size: SizeConfig.blockSizeVertical * 2,),
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
            itemCount: widget.list.length,
            physics: BouncingScrollPhysics(),
            primary: false,),
          ),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight*0.85,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                horizontal: SizeConfig.screenWidth * 0.05
              ),
              child: Therapist.length==0||null?Column(children: [
                Text("No Record Found")
              ],):ListView(children:
               Councilorwidget()
    ,)


            ),
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

  void getCouncilorfromserver() async {
    setState(() {
      isLoading=true;
    });

    try {
      final response = await get(Uri.parse('https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/search?type=${widget.type}&topic=${widget.topic}&language=${widget.language}&price=${widget.price==0||null?20:widget.price},650&date=${widget.date}&time=42'));
      print("bjkb" + response.request.toString());
      print("bjkb" + response.body.toString());

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        mediaurl=responseJson['media_url'];
        Therapist=responseJson['counsellors'];
print(Therapist.length);
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      }
      else {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CounsellorProfile(getData: Therapist[i],mediaUrl: mediaurl,)));
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
