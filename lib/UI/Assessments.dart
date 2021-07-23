import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'Assesmentdetail.dart';

class Assessments extends StatefulWidget {
  const Assessments({Key key}) : super(key: key);

  @override
  _AssessmentsState createState() => _AssessmentsState();
}

class _AssessmentsState extends State<Assessments> {
  List<String> imagesAssessments = [
    'https://getthematic.com/insights/content/images/wordpress/2018/04/shutterstock_730381336.jpg',
    'https://media.istockphoto.com/photos/silhouette-of-troubled-person-head-picture-id1064027420?k=6&m=1064027420&s=612x612&w=0&h=vRTOtWXLm89Ez3mxyJOOG7wJ4XqiGN-0eUUWpiIs48M=',
    'https://images.unsplash.com/photo-1569437061241-a848be43cc82?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bWVudGFsJTIwaGVhbHRofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1569437061241-a848be43cc82?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bWVudGFsJTIwaGVhbHRofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'
  ];

  List<String> cardTitle = [
    'Self resilience survey',
    'Perceived stress scale-\nStress in general',
    'Self resilience survey',
    'Self resilience survey'
  ];

  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75)
  ];

  List<String> time = ['3-5', '10-15', '3-5', '10-15'];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Assessments",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssesmantDetail()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical),
                      width: SizeConfig.screenWidth * 0.4,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image:
                                Image.network(imagesAssessments[index]).image,
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.25,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.02,
                              right: SizeConfig.screenWidth * 0.02),
                          height: SizeConfig.blockSizeVertical * 8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cardTitle[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                time[index] + " mins",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                itemCount: imagesAssessments.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
