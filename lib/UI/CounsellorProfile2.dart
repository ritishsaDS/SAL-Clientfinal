import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:sal_user/UI/RescheduleAppointment.dart';
import 'package:sal_user/UI/webview.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/UI/ViewPdf.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/data/repo/PdfRepo.dart';
import 'package:sal_user/models/pdfdownload.dart';

import 'AppointmentCancel.dart';
import 'Articledetail.dart';
import 'Cancelreason.dart';
import 'Connect.dart';
import 'Schedulescreen.dart';

class CounsellorProfile2 extends StatefulWidget {
  var type;
  var id;
  var appointment;
  var lname;
  var name;
  var time;
  var date;
  var slotbought;
  var amount;
  var slotremaing;
  var created_at;
  var counsellor_id;

  CounsellorProfile2(
      {this.counsellor_id,
        this.created_at,
        this.slotremaing,
        this.amount,
        this.slotbought,
        this.id,
        this.appointment,
        this.type,
        this.name,
        this.lname,
        this.time,
        this.date});

  //const CounsellorProfile2({Key key}) : super(key: key);

  @override
  _CounsellorProfile2State createState() => _CounsellorProfile2State();
}

class _CounsellorProfile2State extends State<CounsellorProfile2> {
  bool isError = false;
  bool isLoading = false;
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
var sharelink="";
  var moodstatic = [
    "12:00 AM",
    "12:30 AM",
    "1:00 AM",
    "1:30 AM",
    "2:00 AM",
    "2:30 AM",
    "3:00 AM",
    "3:30 AM",
    "4:00 AM",
    "4:30 AM",
    "5:00 AM",
    "5:30 AM",
    "6:00 AM",
    "6:30 AM",
    "7:00 AM",
    "7:30 AM",
    "8:00 AM",
    "8:30 AM",
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
    "1:30 PM",
    "2:00 PM",
    "2:30 PM",
    "3:00 PM",
    "3:30 PM",
    "4:00 PM",
    "4:30 PM",
    "5:00 PM",
    "5:30 PM",
    "6:00 PM",
    "6:30 PM",
    "7:00 PM",
    "7:30 PM",
    '8:00 PM',
    '8:30 PM',
    "9:00 PM",
    "9:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "12:00 AM"
  ];
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
  ];

  @override
  void initState() {
    print(widget.date);
    getCounsellordetail();
    getappointmentdetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomSheet: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      offset: Offset(1, 1),
                      blurRadius: 5.0,
                      spreadRadius: 3.0)
                ],
                borderRadius: BorderRadius.circular(10)),
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.1,
            padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    print(widget.appointment);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Cancelreason(
                                    id: widget.appointment,
                                    cancel: widget.slotremaing != null
                                        ? "CANCEL ALL"
                                        : "CANCEL")));
                  },
                  color: Colors.white,
                  child: Text(
                    widget.slotremaing != null ? "CANCEL ALL" : "CANCEL",
                    style: TextStyle(
                      color: Color(fontColorGray),
                    ),
                  ),
                  minWidth: SizeConfig.screenWidth * 0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(fontColorGray)),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    print(widget.id);
                    if (widget.slotbought != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (conetxt) =>
                                  Connect(
                                    // appointment: widget.appointment,
                                    //
                                    // data:overview,
                                    // // name:widget.name.toString(),
                                    // type: widget.type,
                                    //
                                    // id:widget.id,

                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (conetxt) =>
                                  RescheduleAppointment(
                                    appointment: widget.appointment,

                                    data: overview,
                                    // name:widget.name.toString(),
                                    type: widget.type,

                                    id: widget.id,
                                  )));
                    }

                    // Navigator.of(context).pushNamed('/ClientDetails');
                  },
                  color: Color(backgroundColorBlue),
                  child: Text(
                    widget.slotbought != null ? "SCHEDULE" : "RESCHEDULE",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  minWidth: SizeConfig.screenWidth * 0.4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bg/my profile bg.png'),
                            fit: BoxFit.cover),
                      ),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.4,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBar(
                            leading: InkWell(
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            elevation: 0.0,
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                            title: Text(
                              "Counsellor Profile",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),

    actions: [
      widget.slotbought == null?Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        print("ofji"+order["invoice_id"]);
                                        await _downloadPdf(order["invoice_id"],"download");
                                        /*String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                          //String fullPath = tempDir.path + "/boo2.pdf'";
                                          String fullPath = "$path/test.pdf";
                                          print('full path ${fullPath}');
                                          var dio = Dio();
                                          download(dio, "https://sal-prod.s3.ap-south-1.amazonaws.com/receipt/fffb5d774402bec14cbfefb10169669a.pdf", fullPath);
*/
                                      },
                                      child: Icon(Icons.download_sharp)
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                      onTap: () async {
                                        print("ofji");
                                        await _downloadPdf(order["invoice_id"],"Share");

                                        /*String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                                          //String fullPath = tempDir.path + "/boo2.pdf'";
                                          String fullPath = "$path/test.pdf";
                                          print('full path ${fullPath}');
                                          var dio = Dio();
                                          download(dio, "https://sal-prod.s3.ap-south-1.amazonaws.com/receipt/fffb5d774402bec14cbfefb10169669a.pdf", fullPath);
*/
                                      },
                                      child: Icon(Icons.share)
                                  ),
                                  SizedBox(width: 10,),
                                ],
                              ):Container(),
                        ],
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.15),
                              width: SizeConfig.screenWidth * 0.25,
                              height: SizeConfig.screenHeight * 0.12,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                // child: image.path != null && image.path != "" ? Image.file(
                                //     File(image.path)):
                                child: Image.asset('assets/bg/profile.png'),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            child: Text(
                              "Dr ${widget.name}",
                              style: GoogleFonts.openSans(
                                  color: Color(backgroundColorBlue),
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Counsellor",
                                  style: GoogleFonts.openSans(
                                    color: Color(fontColorSteelGrey),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal,
                                ),
                                Image.asset(
                                  'assets/bg/circle.png',
                                  height: SizeConfig.blockSizeVertical * 0.5,
                                ),


                                /*Image.asset(
                              'assets/icons/star.png',
                              height: SizeConfig.blockSizeVertical * 2,
                            ),*/
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal,
                                ),
                                Text(
                                  "4.5",
                                  style: GoogleFonts.openSans(
                                    color: Color(fontColorSteelGrey),
                                  ),
                                ),
                                Image.asset(
                                  'assets/icons/star.png',
                                  height: SizeConfig.blockSizeVertical * 2,
                                )
                              ],
                            ),
                          ),
                          DefaultTabController(
                              length: 3, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: <Widget>[
                                    Container(
                                      child: TabBar(
                                        labelColor: Color(backgroundColorBlue),
                                        unselectedLabelColor:
                                        Color(fontColorSteelGrey),
                                        labelStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                        tabs: [
                                          Tab(text: 'BOOKING'),
                                          Tab(text: 'OVERVIEW'),
                                          Tab(
                                            text: 'REVIEW',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: SizeConfig.screenHeight * 0.6,
                                        //height of TabBarView
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5))),
                                        child: TabBarView(children: <Widget>[
                                          Container(
                                            width: SizeConfig.screenWidth,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                SizeConfig.screenWidth * 0.05,
                                                vertical:
                                                SizeConfig.blockSizeVertical),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      widget.date == null
                                                          ? Container()
                                                          : Text(
                                                        "Appointment Date & Time",
                                                        style: TextStyle(
                                                            color: Color(
                                                                backgroundColorBlue),
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                      widget.date == null
                                                          ? Container()
                                                          : Text(
                                                        "${widget.date
                                                            .toString().split(
                                                            "-")[2] + " " +
                                                            months[int.parse(
                                                                widget.date
                                                                    .toString()
                                                                    .split(
                                                                    "-")[1]
                                                                    .substring(
                                                                    1)) - 1] +
                                                            " " + widget.date
                                                            .toString().split(
                                                            "-")[0] + " " +
                                                            "at " +
                                                            moodstatic[int
                                                                .parse(
                                                                widget.time)]}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                fontColorGray)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Sessions Bought",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    backgroundColorBlue),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          Text(
                                                            "${widget
                                                                .slotbought !=
                                                                null
                                                                ? widget
                                                                .slotbought
                                                                .toString()
                                                                : '1'}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    fontColorGray)),
                                                          )
                                                        ],
                                                      ),
                                                      widget.slotbought != null
                                                          ? Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Sessions Used",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    backgroundColorBlue),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          Text(
                                                            "${widget
                                                                .slotremaing !=
                                                                null
                                                                ? widget
                                                                .slotremaing
                                                                .toString()
                                                                : appointment_slots['slots_remaining']}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    fontColorGray)),
                                                          )
                                                        ],
                                                      )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Booking Amount",
                                                        style: TextStyle(
                                                            color: Color(
                                                                backgroundColorBlue),
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                      Text(
                                                        "${widget.amount == null
                                                            ? order['paid_amount']
                                                            : widget.amount}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                fontColorGray)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Booking Date",
                                                        style: TextStyle(
                                                            color: Color(
                                                                backgroundColorBlue),
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                      widget.created_at == null
                                                          ? Text(
                                                        "${order['created_at']
                                                            .toString()
                                                            .split("-")[2]
                                                            .split(" ")[0] +
                                                            " " +
                                                            months[int.parse(
                                                                order['created_at']
                                                                    .toString()
                                                                    .split(
                                                                    "-")[1]) -
                                                                1] + " " +
                                                            order['created_at']
                                                                .toString()
                                                                .split(
                                                                "-")[0]}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                fontColorGray)),
                                                      )
                                                          : Text(
                                                        "${widget.created_at
                                                            .toString().split(
                                                            "-")[2].split(
                                                            " ")[0] + " " +
                                                            months[int.parse(
                                                                widget
                                                                    .created_at
                                                                    .toString()
                                                                    .split(
                                                                    "-")[1]) -
                                                                1] + " " +
                                                            widget.created_at
                                                                .toString()
                                                                .split(
                                                                "-")[0]}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                fontColorGray)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Transaction ID",
                                                        style: TextStyle(
                                                            color: Color(
                                                                backgroundColorBlue),
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                      // Text("${order['invoice_id']==null?"":order['invoice_id']}",
                                                      //   style: TextStyle(
                                                      //       color: Color(fontColorGray)
                                                      //   ),)
                                                      Text(
                                                        "pay_IS5JQsar3Uvo8T",
                                                        style: TextStyle(
                                                            color: Color(
                                                                fontColorGray)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Payment Mode",
                                                        style: TextStyle(
                                                            color: Color(
                                                                backgroundColorBlue),
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                      Text(
                                                        "Card Payment",
                                                        style: TextStyle(
                                                            color: Color(
                                                                fontColorGray)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig.screenWidth *
                                                  0.025,
                                              top: SizeConfig
                                                  .blockSizeVertical * 3,
                                              right: SizeConfig.screenWidth *
                                                  0.025,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "About",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          backgroundColorBlue),
                                                    ),
                                                  ),
                                                  Text(
                                                    overview['about'],
                                                    style: TextStyle(
                                                      color: Color(
                                                          fontColorGray),
                                                    ),
                                                    textAlign: TextAlign
                                                        .justify,
                                                  ),
                                                  Container(
                                                    width: SizeConfig
                                                        .screenWidth,
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        8,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                              .screenWidth *
                                                              0.1,
                                                          height: SizeConfig
                                                              .blockSizeVertical *
                                                              3.5,
                                                          padding:
                                                          EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/bg/minusBg.png'),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          child: Image.asset(
                                                              'assets/icons/minus.png'),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: SizeConfig
                                                                  .screenWidth *
                                                                  0.05),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "Experience",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: Color(
                                                                      backgroundColorBlue),
                                                                ),
                                                              ),
                                                              Text(
                                                                "${overview['experience']}",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: Color(
                                                                      fontColorGray),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: SizeConfig
                                                        .screenWidth,
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        8,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                              .screenWidth *
                                                              0.1,
                                                          height: SizeConfig
                                                              .blockSizeVertical *
                                                              3.5,
                                                          padding:
                                                          EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/bg/minusBg.png'),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          child: Image.asset(
                                                              'assets/icons/minus.png'),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: SizeConfig
                                                                  .screenWidth *
                                                                  0.05),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "Speciality",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: Color(
                                                                      backgroundColorBlue),
                                                                ),
                                                              ),
                                                              Text(
                                                                "${overview['education']}",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: Color(
                                                                      fontColorGray),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: SizeConfig
                                                        .screenWidth,
                                                    height: SizeConfig
                                                        .blockSizeVertical *
                                                        8,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                              .screenWidth *
                                                              0.1,
                                                          height: SizeConfig
                                                              .blockSizeVertical *
                                                              3.5,
                                                          padding:
                                                          EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/bg/minusBg.png'),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          child: Image.asset(
                                                              'assets/icons/minus.png'),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: SizeConfig
                                                                  .screenWidth *
                                                                  0.05),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "Languages",
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: Color(
                                                                      backgroundColorBlue),
                                                                ),
                                                              ),
                                                              Text(
                                                                theraplang.length==0?"":theraplang[0]['language'],
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: Color(
                                                                      fontColorGray),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                SizeConfig.screenWidth * 0.05,
                                                vertical:
                                                SizeConfig.blockSizeVertical),
                                            child: ListView.builder(
                                              itemBuilder: (context,
                                                  int index) {
                                                return Container(
                                                  width: SizeConfig.screenWidth,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .blockSizeVertical),
                                                  child: reviews.length == 0
                                                      ? Text("No review ")
                                                      : Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      CircleAvatar(
                                                        child: Image.asset(
                                                          'assets/icons/user.png',
                                                          color: Color(
                                                              backgroundColorBlue),
                                                          height: SizeConfig
                                                              .blockSizeVertical *
                                                              3,
                                                        ),
                                                        backgroundColor:
                                                        Color(0XFFE0EDF6),
                                                      ),
                                                      Container(
                                                        width: SizeConfig
                                                            .screenWidth *
                                                            0.7,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Ankita Rathi",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          fontColorSteelGrey),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                Text(
                                                                  "19 Feb,20",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          fontColorGray),
                                                                      fontSize:
                                                                      SizeConfig
                                                                          .blockSizeVertical *
                                                                          1.5),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0XFFF0CA03),
                                                                  size: SizeConfig
                                                                      .blockSizeVertical *
                                                                      2,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0XFFF0CA03),
                                                                  size: SizeConfig
                                                                      .blockSizeVertical *
                                                                      2,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0XFFF0CA03),
                                                                  size: SizeConfig
                                                                      .blockSizeVertical *
                                                                      2,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0XFFF0CA03),
                                                                  size: SizeConfig
                                                                      .blockSizeVertical *
                                                                      2,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0XFFF0CA03),
                                                                  size: SizeConfig
                                                                      .blockSizeVertical *
                                                                      2,
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  SizeConfig
                                                                      .blockSizeVertical *
                                                                      0.5),
                                                              child: Text(
                                                                "“Dr Sushmita is an extremely great counsellor who was highly patient and understanding. I would be definitely be booking a session again.”",
                                                                style:
                                                                TextStyle(
                                                                  color: Color(
                                                                      fontColorGray),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        margin:
                                                        EdgeInsets.only(
                                                          left: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              primary: false,
                                              itemCount: reviews.length,
                                              shrinkWrap: true,
                                            ),
                                          ),
                                        ]))
                                  ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  dynamic overview = new List();
  dynamic reviews = new List();
  dynamic content = new List();
  dynamic theraplang = new List();
  dynamic appointment = new List();
  dynamic appointment_slots = new List();
  dynamic order = new List();

  void getappointmentdetail() async {
    setState(() {
      isLoading = true;
    });
    print(widget.appointment);

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment?appointment_id=${widget
              .appointment}'));
      print("bjkb" + response.body.toString());
      print("bjkb" + response.request.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        setState(() {
          appointment = responseJson['appointment'];
          appointment_slots = responseJson['appointment_slots'];
          order = responseJson['order'];
         // print("InVoice id =======>>>>>>>${order["invoice_id"]}");
          isError = false;
          isLoading = false;
          print('setstate' + reviews.length.toString());
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

  void getCounsellordetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/therapist?therapist_id=xg3zx'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        setState(() {
          content = responseJson['contents'];
          reviews = responseJson['reviews'];
          overview = responseJson['therapist'];
          theraplang=responseJson['languages'];
          isError = false;
          isLoading = false;
          print('setstate' + reviews.length.toString());
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

  /* Future<void> downloadFile(String url) async {
    bool downloading = false;
    var progress = "";
    var path = "No Data";
    var platformVersion = "Unknown";
    Random random = Random();
    Dio dio = Dio();
    bool checkPermission1 = true;
    // print(checkPermission1);
    if (checkPermission1 == false) {

    }
    if (checkPermission1 == true) {
      String dirloc = "";
     *//* if (Platform.isAndroid) {
        dirloc = "/sdcard/download2/";
      } else {

      }*//*
      dirloc = (await getApplicationDocumentsDirectory()).path;

      var randid = random.nextInt(10000);

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(url, dirloc+"/" + randid.toString() + ".pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {
              setState(() {
                downloading = true;
                progress =
                    ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) +
                        "%";
              });
            });
      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = dirloc + randid.toString() + ".pdf";
      });
    } else {
      setState(() {
        progress = "Permission Denied!";
        *//*_onPressed = () {
          downloadFile();
        };*//*
      });
    }
  }*/

  Future download(Dio dio, String url, String savePath,type) async {
print(url);
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      if((response.data as List).isNotEmpty) {
        File file = File(savePath);
       // var raf = file.openSync(mode: FileMode.write);//
        // response.data is List<int> type
       // raf.writeFromSync(response.data);
        print(response.data);
        Navigator.of(loginLoader.currentContext, rootNavigator: true)
            .pop();
        setState(() {
          sharelink=url;
        });

type=="Share"?  share():Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfView(url: url,)));
      // toast("File Downloaded , Please check in File manager");
        //await raf.close();
      }

    } catch (e) {
      print(e);
    }
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  _downloadPdf(invoiceId,type) async{
    Dialogs.showLoadingDialog(context, loginLoader);
    PdfDownload pdfDownload =await DownloadPdfRepo.downloadPdf(invoiceId);
    await _fileWriteCode(pdfDownload,type);
  }
  _fileWriteCode(PdfDownload pdfDownload,type) async{
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    Random random = new Random();
    String fullPath = "$path/${random.nextInt(10000)}.pdf";
    var dio = Dio();
    await download(dio,pdfDownload.mediaUrl+pdfDownload.fileName, fullPath,type);
  }
  void _loadFromUrl() async {
    PDF.network(
      'https://google-developer-training.github.io/android-developer-fundamentals-course-concepts/en/android-developer-fundamentals-course-concepts-en.pdf',
      height: 300,
      width: 200,
      placeHolder: Image.asset("assets/images/pdf.png",
          height: 200, width: 100),
    );
}
  Future<void> share() async {
    _shareImageFromUrl();
    //   await FlutterShare.share(
    //       title: 'My Invoice From SAL',
    //       text: 'My Invoice From SAL',
    //       linkUrl: sharelink,
    //       chooserTitle: 'Invoice Share');
    // }
  }
  Future<void> _shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          sharelink));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('SAL Invoice', 'Invoice.pdf', bytes, 'document/pdf');
    } catch (e) {
      print('error: $e');
    }
  }
}