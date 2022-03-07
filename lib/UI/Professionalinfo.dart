import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/Signup.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/models/get_topics_response_model.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'Myprofile.dart';

enum Status { LOADING, ERROR, COMPLETE }
List<String> selectedInterestList = [];
List<String> selectedInterestListid = [];

class ProfessionalInfo1 extends StatefulWidget {
  bool signup;
  var phone;
  String phonenumber;
  String screen;
  dynamic data;
  dynamic mediaurl;
  String type;
  var dob;
  var gender;

  ProfessionalInfo1(
      {this.phonenumber,
        this.screen,
        this.type,
        this.data,
        this.gender,
        this.dob,
        this.mediaurl,
   Key key,this.signup,this.phone}) : super(key: key);

  @override
  _ProfessionalInfo1State createState() => _ProfessionalInfo1State();
}

class _ProfessionalInfo1State extends State<ProfessionalInfo1> {
  GetTopicsResponseModel result;
  Status status = Status.LOADING;
  List<String> selectedList = [];
  List<String> selectedListid = [];

  Future<void> getTopics() async {
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/topic';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        GetTopicsResponseModel data =
            getTopicsResponseModelFromJson(response.body);
        print('Response :${response.body}');
        print('Response Meta:${data.meta?.status}');
        if (data.meta.status == '200') {
          result = data;
          status = Status.COMPLETE;
          selectedList=selectedInterestList;
          setState(() {});
          return;
        }
        result = null;
        status = Status.ERROR;
      } else {
        result = null;
        status = Status.ERROR;
      }
    } catch (e) {
      print('get topic error :$e');
      result = null;
      status = Status.ERROR;
    }

    setState(() {});
  }

  @override
  void initState() {
    selectedInterestListid.clear();
    selectedInterestList.clear();
    getTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              child: Text(
                "What's Bring You To SAL?",
                style: GoogleFonts.openSans(
                    fontSize: SizeConfig.blockSizeVertical * 4,
                    fontWeight: FontWeight.bold,
                    color: Color(fontColorSteelGrey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "Choose topics to focus On",
                style: TextStyle(color: Color(fontColorGray)),
              ),
            ),
            status == Status.ERROR
                ? Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text('Server Error'),
                    ),
                  )
                : status == Status.LOADING
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 10,
                          children: result.topics
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      if (selectedList.contains(e.topic)) {
                                        selectedList.remove(e.topic);
                                        selectedListid.remove(e.id);

                                      } else {
                                        selectedList.add(e.topic);
                                        selectedListid.add(e.id);
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 0),
                                      child: Text(
                                        e.topic ?? 'N/A',
                                        style: GoogleFonts.openSans(
                                            color: selectedList.isEmpty
                                                ? Color(fontColorGray)
                                                : selectedList.contains(e.topic)
                                                    ? Colors.white
                                                    : Color(fontColorGray),
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2),
                                        textAlign: TextAlign.center,
                                      ),
                                      // alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: selectedList.isEmpty
                                              ? Colors.white
                                              : selectedList.contains(e.topic)
                                                  ? Colors.blue
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: selectedList.isEmpty
                                                  ? Color(fontColorGray)
                                                  : selectedList
                                                          .contains(e.topic)
                                                      ? Colors.blue
                                                      : Color(fontColorGray),
                                              width: 1.0)),
                                      height: SizeConfig.blockSizeVertical * 5,
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        backgroundColor: selectedList.isNotEmpty ? Colors.blue : Colors.grey,
        onPressed: () {

          if (selectedList.isNotEmpty) {
            if(widget.signup==false){
              selectedInterestList = selectedList;
              selectedInterestListid = selectedListid;
              Get.offAll(SignUp(phone:widget.phone,screen:widget.screen,mediaurl: widget.mediaurl,data: widget.data,type: widget.type,));
            }
            else{
              selectedInterestList = selectedList;
              selectedInterestListid = selectedListid;
              Get.offAll(HomeMain());
            }

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomeMain()));
          } else {
            toast("Please Select Value first");
          }
        },
      ),
    ));
  }
}
