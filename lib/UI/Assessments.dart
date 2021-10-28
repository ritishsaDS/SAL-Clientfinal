import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sal_user/data/repo/get_assessments_repo.dart';
import 'package:sal_user/models/get_assessments_response_model.dart';

import 'AssesmentInstruction.dart';

class Assessments extends StatelessWidget {
  String imgBasePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assessments',
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
          onTap: () {
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<GetAssessmentsResponseModel>(
          future: GetAssessmentsRepo.getAssessment(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Server Error'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            GetAssessmentsResponseModel result = snapshot.data;
            if (result.meta.status != '200') {
              return Center(
                child: Text(result.meta.message ?? 'Assessment not found'),
              );
            }
            return ListView(
              children: result.assessments
                  .map((e) => GestureDetector(
                        onTap: () {
                          Get.to(AssessmentInstruction(
                            data: e,
                          ));
                        },
                        child: Container(
                          height: 170,
                          margin: EdgeInsets.only(bottom: 10),
                          width: Get.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imgBasePath + e.photo),
                                  fit: BoxFit.fill),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.title ?? 'N/A',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '3-5 mins',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

// class Assessments extends StatefulWidget {
//   const Assessments({Key key}) : super(key: key);
//
//   @override
//   _AssessmentsState createState() => _AssessmentsState();
// }
//
// class _AssessmentsState extends State<Assessments> {
//   List<String> imagesAssessments = [
//     'https://getthematic.com/insights/content/images/wordpress/2018/04/shutterstock_730381336.jpg',
//     'https://media.istockphoto.com/photos/silhouette-of-troubled-person-head-picture-id1064027420?k=6&m=1064027420&s=612x612&w=0&h=vRTOtWXLm89Ez3mxyJOOG7wJ4XqiGN-0eUUWpiIs48M=',
//     'https://images.unsplash.com/photo-1569437061241-a848be43cc82?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bWVudGFsJTIwaGVhbHRofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
//     'https://images.unsplash.com/photo-1569437061241-a848be43cc82?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bWVudGFsJTIwaGVhbHRofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'
//   ];
//
//   List<String> cardTitle = [
//     'Self resilience survey',
//     'Perceived stress scale-\nStress in general',
//     'Self resilience survey',
//     'Self resilience survey'
//   ];
//
//   List<Color> colors = [
//     Color.fromRGBO(42, 138, 163, 0.75),
//     Color.fromRGBO(48, 37, 33, 0.75),
//     Color.fromRGBO(42, 138, 163, 0.75),
//     Color.fromRGBO(0, 90, 100, 0.75),
//     Color.fromRGBO(0, 90, 100, 0.75),
//     Color.fromRGBO(0, 90, 100, 0.75)
//   ];
//
//   List<String> time = ['3-5', '10-15', '3-5', '10-15'];
//   var upcomintAppointments = AllAssesmentrepo();
//   bool isloading = false;
//   List<Assessment> appointments = new List();
//   List<AllAssesmentmodel> media = new List();
//   var url;
//   //Map<String, Counsellor> counsellor ;
//   @override
//   void initState() {
//     super.initState();
//     isloading = true;
//     upcomintAppointments
//         .upcomingAppointmentRepo(
//       context,
//     )
//         .then((value) {
//       print("value");
//       print(value);
//       if (value != null) {
//         if (value.meta.status == "200") {
//           setState(() {
//             isloading = false;
//           });
//           print("jnjnjonaeno");
//
//          url=value.mediaUrl;
//          print(url);
//           appointments.addAll(value.assessments);
//           print(appointments.length);
//
//           //toast(value.meta.message);
//           /*  SharedPreferencesTest().checkIsLogin("0");
//                                           SharedPreferencesTest()
//                                               .saveToken("set", value: value.token);*/
//
//           /*  Navigator.push(context,
//               MaterialPageRoute(
//                   builder: (conext) {
//                     return OTPScreen(
//                       phoneNumber: mobileController.text,
//                     );
//                   }));*/
//         } else {
//           showAlertDialog(
//             context,
//             value.meta.message,
//             "",
//           );
//         }
//       } else {
//         showAlertDialog(
//           context,
//           "No data found",
//           "",
//         );
//       }
//     }).catchError((error) {
//       showAlertDialog(
//         context,
//         error.toString(),
//         "",
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           "Assessments",
//           style: TextStyle(
//             color: Color(midnightBlue),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Color(midnightBlue),
//           ),
//         ),
//       ),
//       body:Container(
//           margin: EdgeInsets.symmetric(
//               horizontal: SizeConfig.screenWidth * 0.02,
//               vertical: SizeConfig.blockSizeVertical * 2
//           ),
//           child:appointments != null && appointments.length > 0  ?  ListView.builder(itemBuilder: (context, index){
//             return appointments != null && appointments.length > 0 ?
//             InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AssesmantInstruction(
// //title:appointments.elementAt(index).title,
//                   id:appointments.elementAt(index).assessmentId,
//                   title:appointments.elementAt(index).title,
//                   subtitle:appointments.elementAt(index).subtitle
//                 )));
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                     vertical: SizeConfig.blockSizeVertical
//                 ),
//                 width: SizeConfig.screenWidth * 0.4,
//                 alignment: Alignment.bottomCenter,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                       image: Image.network("${url}""${appointments.elementAt(index).photo}").image,
//                       fit: BoxFit.cover
//                   ),
//                 ),
//                 child: Container(
//                   width: SizeConfig.screenWidth,
//                   height: SizeConfig.screenHeight * 0.25,
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     width: SizeConfig.screenWidth,
//                     padding: EdgeInsets.only(
//                         left: SizeConfig.screenWidth * 0.02,
//                         right: SizeConfig.screenWidth * 0.02
//                     ),
//                     height: SizeConfig.blockSizeVertical * 8,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: colors[index],
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(20),
//                           bottomLeft: Radius.circular(20),
//                         )
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(appointments.elementAt(index).title,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600
//                               ),),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//
//
//                             Text(appointments.elementAt(index).type,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: SizeConfig.blockSizeVertical * 1.5
//                               ),),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ): Container(
//               child: Center(child: Text("No Assessments", style:  TextStyle(color: Colors.black),)),
//             );
//           }, itemCount: appointments.length,): Container(
//             child: Center(child: Text("No Assessments", style:  TextStyle(color: Colors.black),)),
//           )
//
//       ),
//     ));
//   }
// }
