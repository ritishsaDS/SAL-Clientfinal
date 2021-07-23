import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class SummaryPayment extends StatefulWidget {
  const SummaryPayment({Key key}) : super(key: key);

  @override
  _SummaryPaymentState createState() => _SummaryPaymentState();
}

class _SummaryPaymentState extends State<SummaryPayment> {

  int paymentRadio = 0;
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
                            child: Image.asset('assets/bg/person.png',fit: BoxFit.cover,),
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
                              Text("Sushmita Sinha",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeConfig.blockSizeVertical * 2
                                ),),
                              Text("Counsellor",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 2
                                ),),
                              Text("10th July,2020 at 8 AM",
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
                        Text("1",style: TextStyle(
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
                        Text("Rs 608",style: TextStyle(
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
                showDialog(context: context, builder: (context){
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: SizeConfig.screenWidth * 0.9,
                      height: SizeConfig.screenHeight * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical * 2
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your Appointment has been successfully scheduled!",
                          style: TextStyle(
                            color: Color(fontColorSteelGrey),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2.5
                          ),),
                          Container(
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Susan Smith",
                                  style: GoogleFonts.openSans(
                                    color: Color(fontColorSteelGrey),
                                  ),),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal,
                                ),
                                Image.asset('assets/bg/circle.png',
                                  height: SizeConfig.blockSizeVertical * 0.5,),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal,
                                ),
                                Text("Listener", style: GoogleFonts.openSans(
                                  color: Color(fontColorSteelGrey),
                                ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("TIME",
                                style: TextStyle(
                                  color: Color(fontColorGray),
                                  fontWeight: FontWeight.w600
                                ),),
                                Text("DATE",
                                  style: TextStyle(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w600
                                  ),)
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("8:00 AM",
                                  style: TextStyle(
                                      color: Color(fontColorGray),
                                  ),),
                                Text("10 July",
                                  style: TextStyle(
                                      color: Color(fontColorGray),
                                  ),),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 6,
                            ),
                            child: MaterialButton(onPressed: (){},
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
                  );
                });
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
