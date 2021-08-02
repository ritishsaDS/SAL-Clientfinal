import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class Sessions extends StatefulWidget {
  const Sessions({Key key}) : super(key: key);

  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {

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
                child: Text("Pay now choose date and schedule anytime",style: TextStyle(
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
                child: MaterialButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SummaryPayment()));
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
}
