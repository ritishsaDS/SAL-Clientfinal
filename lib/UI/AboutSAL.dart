import 'package:flutter/material.dart';
import 'package:sal_user/UI/webview.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class AboutSAL extends StatefulWidget {
  const AboutSAL({Key key}) : super(key: key);

  @override
  _AboutSALState createState() => _AboutSALState();
}

class _AboutSALState extends State<AboutSAL> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded,color: Color(midnightBlue),),
        ),
        centerTitle: true,
        title: Text("About SAL",
          style: TextStyle(
              color: Color(midnightBlue),
              fontWeight: FontWeight.w600
          ),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical,
                horizontal: SizeConfig.screenWidth * 0.02
              ),
              alignment: Alignment.centerLeft,
              child: Text("Heading",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(backgroundColorBlue)
              ),),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02
              ),
              alignment: Alignment.centerLeft,
              child: Text( "Salubrium Private Limited (SAL) was formed with the purpose of providing emotional well-being solutions for the people. Our constant endeavour is to educate people and reduce stigma around mental health through our various initiatives."
            "\n"
            "\n" " We equip people to deal with situations in their life and help them in preventing mental health issues. In the process, our goal is to elevate their emotional wellbeing by providing all such free & paid services under one roof by a team of Listener volunteers & Therapist, respectively."
            "\n"
            "\n"
            "We hold that hand that’s slipping out, say a kind word to those in distress or just hear them out so that people can feel better by managing their emotions in a confidential environment.",
              style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(fontColorSteelGrey),
                ),
              textAlign: TextAlign.justify,),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02
              ),
              alignment: Alignment.centerLeft,
              child: Text("Connect with SAL",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(backgroundColorBlue)
                ),),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02
              ),
              alignment: Alignment.center,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(title: Text("SAL Email Id",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(fontColorSteelGrey),
                  fontSize: SizeConfig.blockSizeVertical * 1.5
                ),),
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: 0
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewClass(link:"https://sal-foundation.com/about-sal")));
              },
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02
                ),
                alignment: Alignment.centerLeft,
                child: ExpansionTile(title: Text("SAL Website",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(fontColorSteelGrey),
                      fontSize: SizeConfig.blockSizeVertical * 1.5
                  ),),
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                  ),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02
              ),
              alignment: Alignment.centerLeft,
              child: Text("Legal",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(backgroundColorBlue)
                ),),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewClass(link:"https://sal-foundation.com/about-sal")));
              },
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02
                ),
                alignment: Alignment.center,
                child: ListTile(title: Text("Terms",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(fontColorSteelGrey),
                      fontSize: SizeConfig.blockSizeVertical * 1.5
                  ),),trailing: Icon(Icons.arrow_forward_ios),onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewClass(link:"https://sal-foundation.com/about-sal")));
                } ,)
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewClass(link:"https://sal-foundation.com/app_pp")));
              },
              child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02
                  ),
                  alignment: Alignment.center,
                  child: ListTile(title: Text("Privacy Policy",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5
                    ),),trailing: Icon(Icons.arrow_forward_ios),onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewClass(link:"https://sal-foundation.com/app_pp")));
                  } ,)
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
