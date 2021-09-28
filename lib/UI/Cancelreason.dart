import 'package:flutter/material.dart';
import 'package:sal_user/UI/AppointmentCancel.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class Cancelreason extends StatefulWidget{
  @override
  _CancelreasonState createState() => _CancelreasonState();
}

class _CancelreasonState extends State<Cancelreason> {
  int sessionRadio = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Cancel Appointment",
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
                child: Text("Please Tell us the reason for cancelling the appointment",style: TextStyle(
                    color: Color(fontColorSteelGrey),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 2.5
                ),),
              ),
              Container(
                width: SizeConfig.screenWidth,
                child: Text("15% cancellation fees applicable ",
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
                      title: Text("I found help elsewhere",style: TextStyle(
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
                  // if(sessionRadio == 1)
                  //   Container(
                  //     width: SizeConfig.screenWidth,
                  //     margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(10),
                  //             bottomLeft: Radius.circular(10)
                  //         ),
                  //         border: Border.all(
                  //             color: Color(fontColorGray)
                  //         )
                  //     ),
                  //     child: Container(
                  //       width: SizeConfig.screenWidth,
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: SizeConfig.blockSizeVertical
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Text("Coupon",style: TextStyle(
                  //                 color: Color(fontColorGray),
                  //                 fontWeight: FontWeight.w600
                  //             ),),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: TextFormField(
                  //               textInputAction: TextInputAction.next,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 disabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedErrorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 errorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 isDense: true,
                  //                 contentPadding: EdgeInsets.all(12),
                  //                 hintText: "Enter Code",
                  //                 hintStyle: TextStyle(
                  //                     color: Color(fontColorGray),
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: SizeConfig.blockSizeVertical * 1.75),
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Base Amount",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):  Text("${widget.bill['billing']['actual_amount']}",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Tax",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):   Text(widget.bill['billing']['tax'],
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(
                  //             color: Color(fontColorGray),
                  //             thickness: 1.0,
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Total Payable Amount",
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):    Text(widget.bill['billing']['paid_amount'],
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
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
                      title: Text("I want a different counsellor",style: TextStyle(
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
                  // if(sessionRadio == 1)
                  //   Container(
                  //     width: SizeConfig.screenWidth,
                  //     margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(10),
                  //             bottomLeft: Radius.circular(10)
                  //         ),
                  //         border: Border.all(
                  //             color: Color(fontColorGray)
                  //         )
                  //     ),
                  //     child: Container(
                  //       width: SizeConfig.screenWidth,
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: SizeConfig.blockSizeVertical
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Text("Coupon",style: TextStyle(
                  //                 color: Color(fontColorGray),
                  //                 fontWeight: FontWeight.w600
                  //             ),),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: TextFormField(
                  //               textInputAction: TextInputAction.next,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 disabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedErrorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 errorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 isDense: true,
                  //                 contentPadding: EdgeInsets.all(12),
                  //                 hintText: "Enter Code",
                  //                 hintStyle: TextStyle(
                  //                     color: Color(fontColorGray),
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: SizeConfig.blockSizeVertical * 1.75),
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Base Amount",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):  Text("${widget.bill['billing']['actual_amount']}",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Tax",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):   Text(widget.bill['billing']['tax'],
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(
                  //             color: Color(fontColorGray),
                  //             thickness: 1.0,
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Total Payable Amount",
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):    Text(widget.bill['billing']['paid_amount'],
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
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
                      title: Text("I want to change date and time",style: TextStyle(
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
                  // if(sessionRadio == 1)
                  //   Container(
                  //     width: SizeConfig.screenWidth,
                  //     margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(10),
                  //             bottomLeft: Radius.circular(10)
                  //         ),
                  //         border: Border.all(
                  //             color: Color(fontColorGray)
                  //         )
                  //     ),
                  //     child: Container(
                  //       width: SizeConfig.screenWidth,
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: SizeConfig.blockSizeVertical
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Text("Coupon",style: TextStyle(
                  //                 color: Color(fontColorGray),
                  //                 fontWeight: FontWeight.w600
                  //             ),),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: TextFormField(
                  //               textInputAction: TextInputAction.next,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 disabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedErrorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 errorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 isDense: true,
                  //                 contentPadding: EdgeInsets.all(12),
                  //                 hintText: "Enter Code",
                  //                 hintStyle: TextStyle(
                  //                     color: Color(fontColorGray),
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: SizeConfig.blockSizeVertical * 1.75),
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Base Amount",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):  Text("${widget.bill['billing']['actual_amount']}",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Tax",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):   Text(widget.bill['billing']['tax'],
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(
                  //             color: Color(fontColorGray),
                  //             thickness: 1.0,
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Total Payable Amount",
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):    Text(widget.bill['billing']['paid_amount'],
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2
                    ),
                    child: RadioListTile(value: 4, groupValue: sessionRadio, onChanged: (value){
                      setState(() {
                        sessionRadio = value;
                      });
                    },
                      activeColor: Color(backgroundColorBlue),
                      dense: true,
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4
                      ),
                      title: Text("Other",style: TextStyle(
                          color: Color(sessionRadio == 4 ? backgroundColorBlue : fontColorGray),
                          fontWeight: FontWeight.w600
                      ),),
                      controlAffinity: ListTileControlAffinity.trailing,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color(sessionRadio == 4 ? backgroundColorBlue : fontColorGray)
                        ),
                      ),),
                  ),
                  // if(sessionRadio == 1)
                  //   Container(
                  //     width: SizeConfig.screenWidth,
                  //     margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(10),
                  //             bottomLeft: Radius.circular(10)
                  //         ),
                  //         border: Border.all(
                  //             color: Color(fontColorGray)
                  //         )
                  //     ),
                  //     child: Container(
                  //       width: SizeConfig.screenWidth,
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: SizeConfig.blockSizeVertical
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Text("Coupon",style: TextStyle(
                  //                 color: Color(fontColorGray),
                  //                 fontWeight: FontWeight.w600
                  //             ),),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: TextFormField(
                  //               textInputAction: TextInputAction.next,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 disabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 focusedErrorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 errorBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: BorderSide(color: Color(fontColorGray)),
                  //                 ),
                  //                 isDense: true,
                  //                 contentPadding: EdgeInsets.all(12),
                  //                 hintText: "Enter Code",
                  //                 hintStyle: TextStyle(
                  //                     color: Color(fontColorGray),
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: SizeConfig.blockSizeVertical * 1.75),
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Base Amount",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):  Text("${widget.bill['billing']['actual_amount']}",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Tax",
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):   Text(widget.bill['billing']['tax'],
                  //                   style: TextStyle(
                  //                       color: Color(fontColorGray)
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(
                  //             color: Color(fontColorGray),
                  //             thickness: 1.0,
                  //           ),
                  //           Container(
                  //             width: SizeConfig.screenWidth,
                  //             margin: EdgeInsets.symmetric(
                  //               vertical: SizeConfig.blockSizeVertical,
                  //               horizontal: SizeConfig.screenWidth * 0.05,
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Total Payable Amount",
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),),
                  //                 widget.type=="2"?Text("Free"):    Text(widget.bill['billing']['paid_amount'],
                  //                   style: TextStyle(
                  //                       color: Color(backgroundColorBlue),
                  //                       fontWeight: FontWeight.w600
                  //                   ),)
                  //               ],
                  //             ),
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 10,
                ),
                child: Row(

                  children: [
                    MaterialButton(
                      onPressed: () async {
Navigator.pop(context);
                      },
                      child: Text("Dont",
                        style: TextStyle(
                            color: Color(fontColorSteelGrey),
                            fontWeight: FontWeight.w600
                        ),),
                      minWidth: SizeConfig.screenWidth*0.42,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(fontColorSteelGrey))
                      ),

                      ),
                    SizedBox(width: 10,),
                    MaterialButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointmentcancel()));

                      },
                      child: Text("Cancel",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                      minWidth: SizeConfig.screenWidth*0.42,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      color: Color(backgroundColorBlue),),
                  ],
                ),
              ),
              // Stack(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.symmetric(
              //           vertical: SizeConfig.blockSizeVertical * 2
              //       ),
              //       child: RadioListTile(value: 2, groupValue: sessionRadio, onChanged: (value){
              //         setState(() {
              //           sessionRadio = value;
              //         });
              //       },
              //         activeColor: Color(backgroundColorBlue),
              //         dense: true,
              //         contentPadding: EdgeInsets.only(
              //             left: SizeConfig.blockSizeHorizontal * 4
              //         ),
              //         title: Text("3 sessions for Rs ${widget.bill['prices']==null?"600":widget.bill['prices']['price_3']}",style: TextStyle(
              //             color: Color(sessionRadio == 2 ? backgroundColorBlue : fontColorGray),
              //             fontWeight: FontWeight.w600
              //         ),),
              //         controlAffinity: ListTileControlAffinity.trailing,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           side: BorderSide(
              //               color: Color(sessionRadio == 2 ? backgroundColorBlue : fontColorGray)
              //           ),
              //         ),),
              //     ),
              //     if(sessionRadio == 2)
              //       Container(
              //         width: SizeConfig.screenWidth,
              //         margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.only(
              //                 bottomRight: Radius.circular(10),
              //                 bottomLeft: Radius.circular(10)
              //             ),
              //             border: Border.all(
              //                 color: Color(fontColorGray)
              //             )
              //         ),
              //         child: Container(
              //           width: SizeConfig.screenWidth,
              //           margin: EdgeInsets.symmetric(
              //               vertical: SizeConfig.blockSizeVertical
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Text("Coupon",style: TextStyle(
              //                     color: Color(fontColorGray),
              //                     fontWeight: FontWeight.w600
              //                 ),),
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: TextFormField(
              //                   textInputAction: TextInputAction.next,
              //                   decoration: InputDecoration(
              //                     border: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     disabledBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     focusedBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     focusedErrorBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     errorBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     enabledBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     isDense: true,
              //                     contentPadding: EdgeInsets.all(12),
              //                     hintText: "Enter Code",
              //                     hintStyle: TextStyle(
              //                         color: Color(fontColorGray),
              //                         fontWeight: FontWeight.w400,
              //                         fontSize: SizeConfig.blockSizeVertical * 1.75),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("Base Amount",
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),),
              //                     widget.type=="2"?Text("Free"):   Text(widget.bill['prices']==null?"600":widget.bill['prices']['price_3'].toString(),
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),)
              //                   ],
              //                 ),
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("Tax(18%)",
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),),
              //                     widget.type=="2"?Text("Free"):    Text("Rs 108",
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),)
              //                   ],
              //                 ),
              //               ),
              //               Divider(
              //                 color: Color(fontColorGray),
              //                 thickness: 1.0,
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("Total Payable Amount",
              //                       style: TextStyle(
              //                           color: Color(backgroundColorBlue),
              //                           fontWeight: FontWeight.w600
              //                       ),),
              //                     widget.type=="2"?Text("Free"):    Text("Rs 1608",
              //                       style: TextStyle(
              //                           color: Color(backgroundColorBlue),
              //                           fontWeight: FontWeight.w600
              //                       ),)
              //                   ],
              //                 ),
              //               ),
              //
              //             ],
              //           ),
              //         ),
              //       ),
              //   ],
              // ),
              // Stack(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.symmetric(
              //           vertical: SizeConfig.blockSizeVertical * 2
              //       ),
              //       child: RadioListTile(value: 3, groupValue: sessionRadio, onChanged: (value){
              //         setState(() {
              //           sessionRadio = value;
              //         });
              //       },
              //         activeColor: Color(backgroundColorBlue),
              //         dense: true,
              //         contentPadding: EdgeInsets.only(
              //             left: SizeConfig.blockSizeHorizontal * 4
              //         ),
              //         title: Text("5 sessions for Rs ${widget.bill['prices']==null?"1799":widget.bill['prices']['price_5']}",style: TextStyle(
              //             color: Color(sessionRadio == 3 ? backgroundColorBlue : fontColorGray),
              //             fontWeight: FontWeight.w600
              //         ),),
              //         controlAffinity: ListTileControlAffinity.trailing,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           side: BorderSide(
              //               color: Color(sessionRadio == 3 ? backgroundColorBlue : fontColorGray)
              //           ),
              //         ),),
              //     ),
              //     if(sessionRadio == 3)
              //       Container(
              //         width: SizeConfig.screenWidth,
              //         margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.only(
              //                 bottomRight: Radius.circular(10),
              //                 bottomLeft: Radius.circular(10)
              //             ),
              //             border: Border.all(
              //                 color: Color(fontColorGray)
              //             )
              //         ),
              //         child: Container(
              //           width: SizeConfig.screenWidth,
              //           margin: EdgeInsets.symmetric(
              //               vertical: SizeConfig.blockSizeVertical
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Text("Coupon",style: TextStyle(
              //                     color: Color(fontColorGray),
              //                     fontWeight: FontWeight.w600
              //                 ),),
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: TextFormField(
              //                   textInputAction: TextInputAction.next,
              //                   decoration: InputDecoration(
              //                     border: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     disabledBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     focusedBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     focusedErrorBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     errorBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     enabledBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                       borderSide: BorderSide(color: Color(fontColorGray)),
              //                     ),
              //                     isDense: true,
              //                     contentPadding: EdgeInsets.all(12),
              //                     hintText: "Enter Code",
              //                     hintStyle: TextStyle(
              //                         color: Color(fontColorGray),
              //                         fontWeight: FontWeight.w400,
              //                         fontSize: SizeConfig.blockSizeVertical * 1.75),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("Base Amount",
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),),
              //                     widget.type=="2"?Text("Free"): Text(widget.bill['prices']==null?"1799":widget.bill['prices']['price_5'],
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),)
              //                   ],
              //                 ),
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("Tax(18%)",
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),),
              //                     widget.type=="2"?Text("Free"):       Text("Rs 360",
              //                       style: TextStyle(
              //                           color: Color(fontColorGray)
              //                       ),)
              //                   ],
              //                 ),
              //               ),
              //               Divider(
              //                 color: Color(fontColorGray),
              //                 thickness: 1.0,
              //               ),
              //               Container(
              //                 width: SizeConfig.screenWidth,
              //                 margin: EdgeInsets.symmetric(
              //                   vertical: SizeConfig.blockSizeVertical,
              //                   horizontal: SizeConfig.screenWidth * 0.05,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("Total Payable Amount",
              //                       style: TextStyle(
              //                           color: Color(backgroundColorBlue),
              //                           fontWeight: FontWeight.w600
              //                       ),),
              //                     widget.type=="2"?Text("Free"):   Text("Rs 2360",
              //                       style: TextStyle(
              //                           color: Color(backgroundColorBlue),
              //                           fontWeight: FontWeight.w600
              //                       ),)
              //                   ],
              //                 ),
              //               ),
              //
              //             ],
              //           ),
              //         ),
              //       ),
              //   ],
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //     top: SizeConfig.blockSizeVertical * 10,
              //   ),
              //   child: MaterialButton(
              //     onPressed: () async {
              //       if(sessionRadio > 0){
              //         var numbersession;
              //         numbersession=sessionRadio==2?numbersession=3:sessionRadio==3?numbersession=5:sessionRadio==1?numbersession=1:numbersession=1;
              //         print(sessionRadio);
              //         var data;
              //         SharedPreferences prefs =await SharedPreferences.getInstance();
              //         print( prefs.getString("cleintid"));
              //         data=   AppointmentModel(clientId: prefs.getString("cleintid"),counsellorId:widget.getData['id'] ,couponCode:"" ,date:  widget.date.toString(),noSession: "1",time: widget.slot);
              //
              //         Appointmentorder.diomwthod( data,context,widget.mediaUrl,widget.getData,numbersession,widget.type,"Session",);
              //
              //       }
              //       else{
              //         toast("Please select session");
              //       }
              //     },
              //     child: Text("PROCEED TO PAYMENT",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600
              //       ),),
              //     minWidth: SizeConfig.screenWidth,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8)
              //     ),
              //     color: Color(backgroundColorBlue),),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}