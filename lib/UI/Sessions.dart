import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart' hide midnightBlue;
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Appointmentorder.dart';
import 'package:sal_user/models/appointmentmode.dart';

class Sessions extends StatefulWidget {
   dynamic getData;
  final String mediaUrl;
  var date;
  var slot;
  Sessions({Key key, this.getData, this.mediaUrl,this.slot,this.date}) : super(key: key);

  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  bool isLoading=false;
  bool isError=false;
  var appointmentslotid;
  var counsellor_id;
  AppointmentModel appointmentModel=AppointmentModel();
  final List<AppointmentModel> addnotesList = [];
  @override
  void initState() {
    getClientid();
   // gettherapist();
   // getCouncilorfromserver();
    // TODO: implement initState
    super.initState();
  }
  int sessionRadio = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Choose Sessions",
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
      backgroundColor: Colors.white,
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
                child: Text("Select number of sessions",style: TextStyle(
                    color: Color(fontColorSteelGrey),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 2.5
                ),),
              ),
              Container(
                width: SizeConfig.screenWidth,
                child: Text("Pay now choose date and schedule anytime",
                  style: TextStyle(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2
                    ),
                    child: RadioListTile(value: 1, groupValue: sessionRadio, onChanged: (value){
                      setState(() {
                        sessionRadio = value;
                      });
                    },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4
                      ),
                      title: Text("1 session for Rs 500",style: TextStyle(
                          color: Color(sessionRadio == 1 ? backgroundColorBlue : fontColorGray),
                          fontWeight: FontWeight.w600
                      ),),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 1 ? backgroundColorBlue : fontColorGray)
                        ),
                      ),),
                  ),
                  if(sessionRadio == 1)
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)
                          ),
                          border: Border.all(
                              color: Color(fontColorGray)
                          )
                      ),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Text("Coupon",style: TextStyle(
                                  color: Color(fontColorGray),
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
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
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.blockSizeVertical * 1.75),
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Base Amount",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),),
                                  Text("Rs 500",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),)
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax(18%)",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),),
                                  Text("Rs 108",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),)
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(fontColorGray),
                              thickness: 1.0,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Payable Amount",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Text("Rs 608",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600
                                    ),)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2
                    ),
                    child: RadioListTile(value: 2, groupValue: sessionRadio, onChanged: (value){
                      setState(() {
                        sessionRadio = value;
                      });
                    },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4
                      ),
                      title: Text("3 sessions for Rs 1000",style: TextStyle(
                          color: Color(sessionRadio == 2 ? backgroundColorBlue : fontColorGray),
                          fontWeight: FontWeight.w600
                      ),),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 2 ? backgroundColorBlue : fontColorGray)
                        ),
                      ),),
                  ),
                  if(sessionRadio == 2)
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)
                          ),
                          border: Border.all(
                              color: Color(fontColorGray)
                          )
                      ),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Text("Coupon",style: TextStyle(
                                  color: Color(fontColorGray),
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
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
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.blockSizeVertical * 1.75),
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Base Amount",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),),
                                  Text("Rs 500",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),)
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax(18%)",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),),
                                  Text("Rs 108",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),)
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(fontColorGray),
                              thickness: 1.0,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Payable Amount",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Text("Rs 608",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600
                                    ),)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2
                    ),
                    child: RadioListTile(value: 3, groupValue: sessionRadio, onChanged: (value){
                      setState(() {
                        sessionRadio = value;
                      });
                    },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4
                      ),
                      title: Text("5 sessions for Rs 2000",style: TextStyle(
                          color: Color(sessionRadio == 3 ? backgroundColorBlue : fontColorGray),
                          fontWeight: FontWeight.w600
                      ),),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 3 ? backgroundColorBlue : fontColorGray)
                        ),
                      ),),
                  ),
                  if(sessionRadio == 3)
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)
                          ),
                          border: Border.all(
                              color: Color(fontColorGray)
                          )
                      ),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Text("Coupon",style: TextStyle(
                                  color: Color(fontColorGray),
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
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
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.blockSizeVertical * 1.75),
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Base Amount",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),),
                                  Text("Rs 500",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),)
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax(18%)",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),),
                                  Text("Rs 108",
                                    style: TextStyle(
                                        color: Color(fontColorGray)
                                    ),)
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(fontColorGray),
                              thickness: 1.0,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Payable Amount",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Text("Rs 608",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600
                                    ),)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 10,
                ),
                child: MaterialButton(onPressed: () async {
                  if(sessionRadio > 0){
                    var data;
                    SharedPreferences prefs =await SharedPreferences.getInstance();
                    print( prefs.getString("cleintid"));
                    data=   AppointmentModel(clientId: prefs.getString("cleintid"),counsellorId:widget.getData['id'] ,couponCode:"" ,date:  widget.date.toString(),noSession: "1",time: widget.slot);
                    Appointmentorder.diomwthod( data,context,widget.mediaUrl,widget.getData,sessionRadio);

                  }else{
                    toast("Please select session");
                  }
                },
                  child: Text("PROCEED TO PAYMENT",
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
    ));
  }
  void bookappointment() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs =await SharedPreferences.getInstance();
    print( prefs.getString("cleintid"));

    try {
      final response = await post(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/counsellor/order'),body: {
        "client_id": "g29bg6fntbmqa",
        "counsellor_id":widget.getData['id'],
        "coupon_code": "",
        "date": widget.date.toString(),
        "no_session": "1",
        "time": widget.slot
      });
      print("bjkb" + response.body.toString());
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SummaryPayment(mediaUrl: widget.mediaUrl,getData: widget.getData,sessionNumbers: sessionRadio.toString(),)));


        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
        // for(int i=0;i<dishfromserver.length;i++){
        //   searcharray.add( dishfromserver[i]['name']);
        //   print(searcharray.toString());
        // }

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
    }
  }
  Future<void> getClientid() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
   print( prefs.getString("clientid"));
  }
}
