import 'package:flutter/material.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/AllAssesmentrepo.dart';
import 'package:sal_user/models/AllAssesmentmodel.dart';
import 'AssesmentInstruction.dart';
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
  var upcomintAppointments = AllAssesmentrepo();
  bool isloading = false;
  List<Assessment> appointments = new List();
  List<AllAssesmentmodel> media = new List();
  var url;
  //Map<String, Counsellor> counsellor ;
  @override
  void initState() {
    super.initState();
    isloading = true;
    upcomintAppointments
        .upcomingAppointmentRepo(
      context,
    )
        .then((value) {
      print("value");
      print(value);
      if (value != null) {
        if (value.meta.status == "200") {
          setState(() {
            isloading = false;
          });
          print("jnjnjonaeno");

         url=value.mediaUrl;
         print(url);
          appointments.addAll(value.assessments);
          print(appointments.length);

          //toast(value.meta.message);
          /*  SharedPreferencesTest().checkIsLogin("0");
                                          SharedPreferencesTest()
                                              .saveToken("set", value: value.token);*/

          /*  Navigator.push(context,
              MaterialPageRoute(
                  builder: (conext) {
                    return OTPScreen(
                      phoneNumber: mobileController.text,
                    );
                  }));*/
        } else {
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      } else {
        showAlertDialog(
          context,
          "No data found",
          "",
        );
      }
    }).catchError((error) {
      showAlertDialog(
        context,
        error.toString(),
        "",
      );
    });
  }
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
      body:Container(
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.02,
              vertical: SizeConfig.blockSizeVertical * 2
          ),
          child:appointments != null && appointments.length > 0  ?  ListView.builder(itemBuilder: (context, index){
            return appointments != null && appointments.length > 0 ?
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AssesmantInstruction(
//title:appointments.elementAt(index).title,
                  id:appointments.elementAt(index).assessmentId,
                  title:appointments.elementAt(index).title,
                  subtitle:appointments.elementAt(index).subtitle
                )));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical
                ),
                width: SizeConfig.screenWidth * 0.4,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: Image.network("${url}""${appointments.elementAt(index).photo}").image,
                      fit: BoxFit.cover
                  ),
                ),
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.25,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.02,
                        right: SizeConfig.screenWidth * 0.02
                    ),
                    height: SizeConfig.blockSizeVertical * 8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(appointments.elementAt(index).title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            Text(appointments.elementAt(index).type,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 1.5
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ): Container(
              child: Center(child: Text("No Assessments", style:  TextStyle(color: Colors.black),)),
            );
          }, itemCount: appointments.length,): Container(
            child: Center(child: Text("No Assessments", style:  TextStyle(color: Colors.black),)),
          )

      ),
    ));
  }
}
