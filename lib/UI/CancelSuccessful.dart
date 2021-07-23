import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'Connect.dart';

class CancelSuccessful extends StatefulWidget {
  const CancelSuccessful({Key key}) : super(key: key);

  @override
  _CancelSuccessfulState createState() => _CancelSuccessfulState();
}

class _CancelSuccessfulState extends State<CancelSuccessful> {

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Connect();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.3
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icons/circle bg.png'),
                        fit: BoxFit.cover
                    ),
                    shape: BoxShape.circle
                ),
                width: SizeConfig.screenWidth * 0.5,
                height: SizeConfig.screenHeight * 0.3,
                padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/blue circle bg.png'),
                            fit: BoxFit.cover
                        ),
                        shape: BoxShape.circle
                    ),
                    child: Image.asset('assets/icons/done.png',
                      scale: SizeConfig.blockSizeVertical * 0.5,)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              width: SizeConfig.screenWidth,
              child: Text("Successfully Cancelled",style: GoogleFonts.openSans(
                  fontSize: SizeConfig.blockSizeVertical * 3.5,
                  fontWeight: FontWeight.bold,
                  color: Color(fontColorSteelGrey)
              ),),
            ),
          ],
        ),
      ),
    ));
  }
}
