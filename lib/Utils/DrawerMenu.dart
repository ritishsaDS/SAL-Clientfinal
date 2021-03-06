import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/UI/AboutSAL.dart';
import 'package:sal_user/UI/Connect.dart';
import 'package:sal_user/UI/Help.dart';
import 'package:sal_user/UI/MySessions.dart';
import 'package:sal_user/UI/Settings.dart';
import 'package:sal_user/UI/SummaryPayment.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'Colors.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.28,
              color: Color(backgroundColorBlue),
              child: Column(
                children: [
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.only(
                  //     top: SizeConfig.blockSizeVertical * 3,
                  //   ),
                  //   child: CircleAvatar(
                  //     radius: SizeConfig.blockSizeVertical * 5,
                  //     backgroundImage: AssetImage('assets/bg/profile.png'),
                  //   ),
                  // ),
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.only(
                  //       top: SizeConfig.blockSizeVertical * 2
                  //   ),
                  //   child: Text("",
                  //     style: GoogleFonts.openSans(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: SizeConfig.blockSizeVertical * 2
                  //     ),),
                  // ),
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.only(
                  //     top: SizeConfig.blockSizeVertical * 1.5,
                  //   ),
                  //   child: Text("Profile complete",
                  //     style: GoogleFonts.openSans(
                  //       color: Colors.white,
                  //       fontSize: SizeConfig.blockSizeVertical * 1.5,
                  //     ),),
                  // ),
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.only(
                  //     top: SizeConfig.blockSizeVertical * 1.5,
                  //     left: SizeConfig.screenWidth * 0.2,
                  //     right: SizeConfig.screenWidth * 0.2,
                  //   ),
                  //   child: LinearProgressIndicator(
                  //     backgroundColor: Color(midnightBlue),
                  //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  //     value: 0.6,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            ListTile(
              title: Text("My Profile"),
              leading: ImageIcon(Image.asset('assets/icons/user.png').image),
              onTap: (){
                Navigator.of(context).pushNamed('/MyProfile');
              },
            ),
            ListTile(
              title: Text("Explore All"),
              leading: ImageIcon(Image.asset('assets/icons/availability.png').image),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Connect()));
              },
            ),
            ListTile(
              title: Text("My Content"),
              leading: ImageIcon(Image.asset('assets/icons/content.png').image),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MySessions()));
              },
            ),
            ListTile(
              title: Text("Assessments"),
              leading: ImageIcon(Image.asset('assets/icons/assessments.png').image),
              onTap: (){
                Navigator.of(context).pushNamed('/Assessments');
              },
            ),
            ListTile(
              title: Text("Payments"),
              leading: ImageIcon(Image.asset('assets/icons/payment.png').image),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SummaryPayment()));
              },
            ),
            ListTile(
              title: Text("Help"),
              leading: ImageIcon(Image.asset('assets/icons/help.png').image),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Help()));
              },
            ),
            ListTile(
              title: Text("About SAL"),
              leading: ImageIcon(Image.asset('assets/icons/about.png').image),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutSAL()));
              },
            ),
            ListTile(
              title: Text("Settings"),
              leading: ImageIcon(Image.asset('assets/icons/settings.png').image),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
