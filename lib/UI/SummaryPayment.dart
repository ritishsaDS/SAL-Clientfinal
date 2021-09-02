import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'Razorpay.dart';

class SummaryPayment extends StatefulWidget {
  final dynamic getData;
  final String mediaUrl;final String sessionNumbers;
  String client_id;String counsellor_id;String appointment_id;
  dynamic billing;var order;
  var type;
  var date;
  var slot;
  dynamic bill;
   SummaryPayment({Key key,this.date,this.slot, this.getData, this.billing,this.order,this.mediaUrl,this.type,this.bill, this.sessionNumbers,this.appointment_id,this.client_id,this.counsellor_id}) : super(key: key);

  @override
  _SummaryPaymentState createState() => _SummaryPaymentState();
}

class _SummaryPaymentState extends State<SummaryPayment> {
  int paymentRadio = 0;
  @override
  void initState() {
    print(widget.getData.toString());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.35,
              color: Color(backgroundColorBlue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(
                      "Summary",
                      style: TextStyle(
                        color: Colors.white,
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: SizeConfig.screenWidth * 0.2,
                          height: SizeConfig.screenHeight * 0.1,
                          margin:EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 0.5
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: widget.getData['photo']  != null && widget.getData['photo'] != "" ? Image.network(widget.mediaUrl+ widget.getData['photo'],fit: BoxFit.cover,) : Image.asset('assets/bg/person.png',fit: BoxFit.cover,) ,
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 4,
                              top: SizeConfig.blockSizeVertical * 0.5
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.getData['first_name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeConfig.blockSizeVertical * 2
                                ),),
                              Text(widget.type=="1"?"Counsellor":widget.type=="2"?"Listener":"Therapist",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 2
                                ),),
                              Text(widget.date.toString().substring(0,10),
                                style: TextStyle(
                                    color: Colors.white
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Number Of Sessions",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                          Text(widget.sessionNumbers,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Payable Amount",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                        Text("₹ ${widget.bill['billing']==null?widget.sessionNumbers:widget.bill['billing']['paid_amount']}",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical
              ),
              child: Text("Select a payment option:",style: TextStyle(
                color: Color(midnightBlue),
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2
              ),),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical
              ),
                child: RadioListTile(value: 1, groupValue: paymentRadio, onChanged: (value){
                  setState(() {
                    paymentRadio = value;
                  });
                },
                  activeColor: Color(backgroundColorBlue),
                  dense: true,
                  contentPadding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 4
                  ),
                  title: Text("Card Payment",style: TextStyle(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w600
                  ),),
                  controlAffinity: ListTileControlAffinity.trailing,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Color(fontColorGray)
                    ),
                  ),)),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical
                ),
                child: RadioListTile(value: 2, groupValue: paymentRadio, onChanged: (value){
                  setState(() {
                    paymentRadio = value;
                  });
                },
                  activeColor: Color(backgroundColorBlue),
                  dense: true,
                  contentPadding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 4
                  ),
                  title: Text("Razor Pay",style: TextStyle(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w600
                  ),),
                  controlAffinity: ListTileControlAffinity.trailing,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Color(fontColorGray)
                    ),
                  ),)),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.3,
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05
              ),
              child: MaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Razor(payment:widget.billing,order:widget.order,data:widget.getData,date:widget.date,type:widget.type)));


                // showDialog(context: context, builder: (context){
                //   return Dialog(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)
                //     ),
                //     backgroundColor: Colors.transparent,
                //     child: Container(
                //       width: SizeConfig.screenWidth * 0.9,
                //       height: SizeConfig.screenHeight * 0.4,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.white,
                //       ),
                //       padding: EdgeInsets.symmetric(
                //         horizontal: SizeConfig.screenWidth * 0.05,
                //         vertical: SizeConfig.blockSizeVertical * 2
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text("Your Appointment has been successfully scheduled!",
                //           style: TextStyle(
                //             color: Color(fontColorSteelGrey),
                //             fontWeight: FontWeight.w600,
                //             fontSize: SizeConfig.blockSizeVertical * 2.5
                //           ),),
                //           Container(
                //             width: SizeConfig.screenWidth,
                //             alignment: Alignment.center,
                //             margin: EdgeInsets.symmetric(
                //               vertical: SizeConfig.blockSizeVertical
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [
                //                 Text("Susan Smith",
                //                   style: GoogleFonts.openSans(
                //                     color: Color(fontColorSteelGrey),
                //                   ),),
                //                 SizedBox(
                //                   width: SizeConfig.blockSizeHorizontal,
                //                 ),
                //                 Image.asset('assets/bg/circle.png',
                //                   height: SizeConfig.blockSizeVertical * 0.5,),
                //                 SizedBox(
                //                   width: SizeConfig.blockSizeHorizontal,
                //                 ),
                //                 Text("Listener", style: GoogleFonts.openSans(
                //                   color: Color(fontColorSteelGrey),
                //                 ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text("TIME",
                //                 style: TextStyle(
                //                   color: Color(fontColorGray),
                //                   fontWeight: FontWeight.w600
                //                 ),),
                //                 Text("DATE",
                //                   style: TextStyle(
                //                       color: Color(fontColorGray),
                //                       fontWeight: FontWeight.w600
                //                   ),)
                //               ],
                //             ),
                //           ),
                //           Container(
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text("8:00 AM",
                //                   style: TextStyle(
                //                       color: Color(fontColorGray),
                //                   ),),
                //                 Text("10 July",
                //                   style: TextStyle(
                //                       color: Color(fontColorGray),
                //                   ),),
                //               ],
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.only(
                //               top: SizeConfig.blockSizeVertical * 6,
                //             ),
                //             child: MaterialButton(onPressed: (){
                //
                //             },
                //               child: Text("CONTINUEss",
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w600
                //                 ),),
                //               minWidth: SizeConfig.screenWidth,
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(8)
                //               ),
                //               color: Color(backgroundColorBlue),),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );

              },
                child: Text("CONTINUE",
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
    ));
  }
}
