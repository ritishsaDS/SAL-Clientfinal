import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart' hide midnightBlue;
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/UI/paymentclass.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/Appointmentorder.dart';
import 'package:sal_user/models/Appointmentlistener.dart';
import 'package:sal_user/models/Appointmenttherapistmodel.dart';
import 'package:sal_user/models/appointmentmode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions extends StatefulWidget {
  dynamic getData;
  final String mediaUrl;
  var date;
  var slot;
  var type;
  dynamic bill;

  Sessions(
      {Key key,
      this.getData,
      this.mediaUrl,
      this.slot,
      this.date,
      this.type,
      this.bill})
      : super(key: key);

  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  bool isLoading = false;
  bool isError = false;
  var appointmentslotid;
  var coupon3;
  var counsellor_id;
  AppointmentModel appointmentModel = AppointmentModel();
  final List<AppointmentModel> addnotesList = [];
TextEditingController coupon=TextEditingController();
  @override
  void initState() {
    print("widget.bill");
    print(widget.bill['prices']);
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
    return SafeArea(
        child: Scaffold(
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
              vertical: SizeConfig.blockSizeVertical),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                child: Text(
                  "Select number of sessions",
                  style: TextStyle(
                      color: Color(fontColorSteelGrey),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 2.5),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                child: Text(
                  "Pay now choose date and schedule anytime",
                  style: TextStyle(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ),
              Stack(
                children: [
                  if (sessionRadio == 1)

                    Container(
                      width: SizeConfig.screenWidth,
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          border: Border.all(color: Color(fontColorGray))),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Text(
                                "Coupon",
                                style: TextStyle(
                                    color: Color(fontColorGray),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onChanged: (val){
                                  setState(() {
                                    coupon3=val;
                                  });
                                },
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(

                                        onTap: () async {
                                          if (sessionRadio > 0) {
                                            var numbersession;
                                            numbersession = sessionRadio == 2
                                                ? numbersession = 3
                                                : sessionRadio == 3
                                                ? numbersession = 5
                                                : sessionRadio == 1
                                                ? numbersession = 1
                                                : numbersession = 1;
                                            print(sessionRadio);
                                            var data;
                                            SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                            print("prefs.getString()");
                                            data = AppointmentModel(
                                                clientId: prefs.getString("cleintid"),
                                                counsellorId: widget.getData['id'],
                                                couponCode: coupon.text,
                                                date: widget.date.toString(),
                                                noSession: "1",
                                                time: widget.slot);

                                            diomwthod(
                                              data,
                                              context,
                                              widget.mediaUrl,
                                              widget.getData,
                                              numbersession,
                                              widget.type,
                                              "Session",
                                            );
                                          } else {
                                            toast("Please select session");
                                          }
                                        },

                                      child: Container(width:40,alignment:Alignment.centerRight,child: Text("Apply  ",style: TextStyle(color: Color(0xff0066B3),fontWeight: FontWeight.w800),))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.75),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Base Amount",
                                    style:
                                        TextStyle(color: Color(fontColorGray)),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                          "${widget.bill['prices']['price']}",
                                          style: TextStyle(
                                              color: Color(fontColorGray)),
                                        )
                                ],
                              ),
                            ),
                            // Container(
                            //   width: SizeConfig.screenWidth,
                            //   margin: EdgeInsets.symmetric(
                            //     vertical: SizeConfig.blockSizeVertical,
                            //     horizontal: SizeConfig.screenWidth * 0.05,
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         "Tax",
                            //         style:
                            //             TextStyle(color: Color(fontColorGray)),
                            //       ),
                            //       widget.type == "2"
                            //           ? Text("Free")
                            //           : Text(
                            //               widget.bill['billing']['tax'],
                            //               style: TextStyle(
                            //                   color: Color(fontColorGray)),
                            //             )
                            //     ],
                            //   ),
                            // ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    discount==''?"":"Discount",
                                    style:
                                    TextStyle(color: Color(fontColorGray)),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                    "${discount}",
                                    style: TextStyle(
                                        color: Color(fontColorGray)),
                                  )
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Payable Amount",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                    discount==''?"${int.parse(widget.bill['prices']['price'])}":"${paidamount}",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal:  SizeConfig.screenWidth * 0.05),
                              child: Text(
                                '(All inclusive)',
                                style: TextStyle(
                                    color: Color(0xff77849C), fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 5,),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xff0066B3))),
                    child: RadioListTile(
                      value: 1,
                      groupValue: sessionRadio,
                      onChanged: (value) {
                        setState(() {
                          sessionRadio = value;
                        });
                      },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4),
                      title: widget.type == "2"
                          ? Text("Free")
                          : Text(
                              "1 session for Rs.${widget.bill['prices']['price']}",
                              style: TextStyle(
                                  color: Color(sessionRadio == 1
                                      ? backgroundColorBlue
                                      : fontColorGray),
                                  fontWeight: FontWeight.w600),
                            ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 1
                                ? backgroundColorBlue
                                : fontColorGray)),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  if (sessionRadio == 2)
                    Container(
                      width: SizeConfig.screenWidth,
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          border: Border.all(color: Color(fontColorGray))),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Text(
                                "Coupon",
                                style: TextStyle(
                                    color: Color(fontColorGray),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: TextFormField(
                                controller: coupon,
                                onChanged: (val){
                                  setState(() {
                                    coupon3=val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                      onTap: () async {
                                        if (sessionRadio > 0) {
                                          var numbersession;
                                          numbersession = sessionRadio == 2
                                              ? numbersession = 3
                                              : sessionRadio == 3
                                              ? numbersession = 5
                                              : sessionRadio == 1
                                              ? numbersession = 1
                                              : numbersession = 1;
                                          print(sessionRadio);
                                          var data;
                                          SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                          print("prefs.getString()");
                                          data = AppointmentModel(
                                              clientId: prefs.getString("cleintid"),
                                              counsellorId: widget.getData['id'],
                                              couponCode: coupon.text,
                                              date: widget.date.toString(),
                                              noSession: "1",
                                              time: widget.slot);

                                         diomwthod(
                                            data,
                                            context,
                                            widget.mediaUrl,
                                            widget.getData,
                                            numbersession,
                                            widget.type,
                                            "Session",
                                          );
                                        } else {
                                          toast("Please select session");
                                        }
                                      },
                                      child: Container( width:40,alignment:Alignment.centerRight,child: Text("Apply  ",style: TextStyle(color: Color(0xff0066B3),fontWeight: FontWeight.w800),))),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                     color: Color(fontColorGray),
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.75),
                                ),
                              ),
                            ),
                           Container(
                               margin: EdgeInsets.only(left: 20),
                               child: Text(text,style: TextStyle(color: Colors.green),)),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Base Amount",
                                    style:
                                        TextStyle(color: Color(fontColorGray)),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                          widget.bill['prices'] == null
                                              ? "600"
                                              : widget.bill['prices']['price_3']
                                                  .toString(),
                                          style: TextStyle(
                                              color: Color(fontColorGray)),
                                        )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    discount==''?"":"Discount",
                                    style:
                                        TextStyle(color: Color(fontColorGray)),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                          "${discount}",
                                          style: TextStyle(
                                              color: Color(fontColorGray)),
                                        )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Payable Amount",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                      discount==''?"${int.parse(widget.bill['prices']['price_3'])}":"${paidamount}",
                                          style: TextStyle(
                                              color: Color(backgroundColorBlue),
                                              fontWeight: FontWeight.w600),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xff0066B3))),
                    child: RadioListTile(
                      value: 2,
                      groupValue: sessionRadio,
                      onChanged: (value) {
                        setState(() {
                          sessionRadio = value;
                        });
                      },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4),
                      title: Text(
                        "3 sessions for Rs ${widget.bill['prices'] == null ? "600" : widget.bill['prices']['price_3']}",
                        style: TextStyle(
                            color: Color(sessionRadio == 2
                                ? backgroundColorBlue
                                : fontColorGray),
                            fontWeight: FontWeight.w600),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 2
                                ? backgroundColorBlue
                                : fontColorGray)),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  if (sessionRadio == 3)
                    Container(
                      width: SizeConfig.screenWidth,
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          border: Border.all(color: Color(fontColorGray))),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Text(
                                "Coupon",
                                style: TextStyle(
                                    color: Color(fontColorGray),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(onTap: () async {
                                    if (sessionRadio > 0) {
                                      var numbersession;
                                      numbersession = sessionRadio == 2
                                          ? numbersession = 3
                                          : sessionRadio == 3
                                          ? numbersession = 5
                                          : sessionRadio == 1
                                          ? numbersession = 1
                                          : numbersession = 1;
                                      print(sessionRadio);
                                      var data;
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      print("prefs.getString()");
                                      data = AppointmentModel(
                                          clientId: prefs.getString("cleintid"),
                                          counsellorId: widget.getData['id'],
                                          couponCode: coupon3,
                                          date: widget.date.toString(),
                                          noSession: "1",
                                          time: widget.slot);

                                      diomwthod(
                                        data,
                                        context,
                                        widget.mediaUrl,
                                        widget.getData,
                                        numbersession,
                                        widget.type,
                                        "Session",
                                      );
                                    } else {
                                      toast("Please select session");
                                    }
                                  },child: Container(width:40,alignment:Alignment.centerRight,child: Text("Apply  ",style: TextStyle(color: Color(0xff0066B3),fontWeight: FontWeight.w800),))),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(fontColorGray)),
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.75),
                                ),
                                onChanged: (val){
                                  setState(() {
                                    coupon3=val;
                                  });
                                },
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(text,style: TextStyle(color: Colors.green),)),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Base Amount",
                                    style:
                                        TextStyle(color: Color(fontColorGray)),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                          widget.bill['prices'] == null
                                              ? "1799"
                                              : widget.bill['prices']
                                                  ['price_5'],
                                          style: TextStyle(
                                              color: Color(fontColorGray)),
                                        )
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    discount==''?"":"Discount",
                                    style:
                                    TextStyle(color: Color(fontColorGray)),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                    "${discount}",
                                    style: TextStyle(
                                        color: Color(fontColorGray)),
                                  )
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Payable Amount",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  widget.type == "2"
                                      ? Text("Free")
                                      : Text(
                                    discount==''?"${int.parse(widget.bill['prices']['price_3'])}":"${paidamount}",
                                    style: TextStyle(
                                        color: Color(backgroundColorBlue),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xff0066B3))),
                    child: RadioListTile(
                      value: 3,
                      groupValue: sessionRadio,
                      onChanged: (value) {
                        setState(() {
                          sessionRadio = value;
                        });
                      },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4),
                      title: Text(
                        "5 sessions for Rs ${widget.bill['prices'] == null ? "1799" : widget.bill['prices']['price_5']}",
                        style: TextStyle(
                            color: Color(sessionRadio == 3
                                ? backgroundColorBlue
                                : fontColorGray),
                            fontWeight: FontWeight.w600),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 3
                                ? backgroundColorBlue
                                : fontColorGray)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 10,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    if (sessionRadio > 0) {
                      var numbersession;
                      numbersession = sessionRadio == 2
                          ? numbersession = 3
                          : sessionRadio == 3
                              ? numbersession = 5
                              : sessionRadio == 1
                                  ? numbersession = 1
                                  : numbersession = 1;
                      print(sessionRadio);
                      var data;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      print(prefs.getString("cleintid"));
                      data = AppointmentModel(
                          clientId: prefs.getString("cleintid"),
                          counsellorId: widget.getData['id'],
                          couponCode: "",
                          date: widget.date.toString(),
                          noSession: "1",
                          time: widget.slot);
                      if(text!=''){
                        print("jksdjnsdvko");
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>payment(mediaUrl: widget.mediaUrl,getData:widget.getData,
                            date:widget.date,slot:widget.slot    ,sessionNumbers: numbersession.toString(),billing:razorpayamount,order:orderid,type:widget.type,bill:loginwithserver)));

                      }
                      else{
                        Appointmentorder.diomwthod(
                          data,
                          context,
                          widget.mediaUrl,
                          widget.getData,
                          numbersession,
                          widget.type,
                          "Session",
                        );
                      }

                    }


                    else {
                      toast("Please select session");
                    }
                  },
                  child: Text(
                    "PROCEED TO PAYMENT",
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
    ));
  }

  void bookappointment() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("cleintid"));
    var type;
    if (widget.type == '1') {
      type = "counsellor";
    } else if (widget.type == "2") {
      type = "listener";
    } else if (widget.type == '4') {
      type = 'therapist';
    }
    try {
      final response = await post(
          Uri.parse(
              'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/$type/order'),
          body: {
            "client_id": "g29bg6fntbmqa",
            "${type}_id": widget.getData['id'],
            "coupon_code": "",
            "date": widget.date.toString(),
            "no_session": "1",
            "time": widget.slot
          });
      print("bjkb" + response.body.toString());
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        //  Navigator.push(context,MaterialPageRoute(builder: (context)=>payment(mediaUrl: widget.mediaUrl,getData: widget.getData,sessionNumbers: sessionRadio.toString(),)));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => payment()));

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("clientid"));
  }
  var text='';
  var paidamount='';
  var discount='';
  var razorpayamount='';
  var orderid='';
  dynamic loginwithserver=new List();
 void diomwthod(AppointmentModel adddishmodel,context,mediaurl,data,session,type,screen) async {

    var types;
    var model;
    if(type=='1'){
      types="counsellor";
      model = AppointmentModel(clientId:adddishmodel.clientId,counsellorId: adddishmodel.counsellorId,couponCode: coupon3,date:adddishmodel.date.toString().substring(0,10),noSession: session.toString(),time: adddishmodel.time  );

    }
    else if(type=="2"){
      types="listener";
      model = Appointmentlistener(clientId:adddishmodel.clientId,listenerid: adddishmodel.counsellorId,couponCode: coupon3,date:adddishmodel.date.toString().substring(0,10),noSession: session.toString(),time: adddishmodel.time  );

    }
    else if(type=='4'){
      types='therapist';
      model = AppointmentTherapist(clientId:adddishmodel.clientId,therapistId: adddishmodel.counsellorId,couponCode: coupon3,date:adddishmodel.date.toString().substring(0,10),noSession: session.toString(),time: adddishmodel.time  );

    }


    // print(adddishmodel.toJson());
    print('REQUEST BODY :${json.encode(model)}');
    try {
      final response = await post(Uri.parse("https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/$types/order"),


          body:json.encode(model));
      print('RESPONSE Status Code:${response.statusCode}');
      print('RESPONSE :${response.body}');
      // print("bjkb" + response.request.toString());
      // print("bjkb" + model.toJson().toString());
      // showToast("Dish Added Successfully");

      if (response.statusCode == 200)
      {
        final responseJson = json.decode(response.body);

        loginwithserver = responseJson;

        if(loginwithserver['meta']['message']=="Incorrect coupon code"){
print("jnkjnkdfb");
setState(() {
  text="Incorrect coupon code";
  discount='';

});
        }
        else{
          text="Coupon Applied Succesfully";
          paidamount=loginwithserver['billing']["paid_amount"];
          discount=loginwithserver['billing']['discount'];
          razorpayamount=loginwithserver['paid_amount_razorpay'];
          orderid=loginwithserver['order_id'];
          print(razorpayamount);
          // showAlertDialog(
          //   context,
          //   loginwithserver['meta']['message'],
          //   "",
          // );
        }

        // print(loginwithserver['data']['email']);
        print(loginwithserver);

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // preferences.setString("token", loginwithserver['token']['original']['access_token']);
        // preferences.setInt("chefid", loginwithserver['data'][0]['id']);
        // // preferences.setString("token", loginwithserver['token']['original']['access_token']);
        // print(preferences.getInt("chefid"));
        // print( preferences.getString("token"));
        // showToast("Login Successfully");
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyBottomBarDemo()));
        // preferences.setString("login", "cook");


        // showToast("");
        //savedata();

      } else {
        print("bjkb" + response.statusCode.toString());
        //showToast("Mismatch Credentials");

      }
    } catch (e) {
      print(e);

    }
  }
}

