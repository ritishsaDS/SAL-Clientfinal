import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/UI/ViewPdf.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/PdfRepo.dart';
import 'package:sal_user/data/repo/get_assessments_repo.dart';
import 'package:sal_user/models/Getresultresponse.dart';
import 'package:sal_user/models/get_assessments_response_model.dart';
import 'package:sal_user/UI/AssesmentResultscreen.dart';
import 'package:sal_user/models/pdfdownload.dart';
import 'AssesmentInstruction.dart';
dynamic assesmentresult=new List();
class Assessments2 extends StatefulWidget {
  const Assessments2({Key key}) : super(key: key);

  @override
  _Assessments2State createState() => _Assessments2State();
}

class _Assessments2State extends State<Assessments2> {
  String imgBasePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';
@override
  void initState() {

    super.initState();
  }
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var sharelink="";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            bottom: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Taken",
                )
              ],
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
          ),
          body: TabBarView(
            children: [
              Padding(
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
                        child:
                        Text(result.meta.message ?? 'Assessment not found'),
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
                                  image: NetworkImage(
                                      imgBasePath + e.photo),
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<GetAssessmentsResultsResponseModel>(
                  future: GetAssessmentsRepo.getAssessmentResult(
                  ),
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
                    GetAssessmentsResultsResponseModel result = snapshot.data;
                    if (result==null) {
                      return Center(
                        child: Text(result ?? 'Assessment not found'),
                      );
                    }
                    if (result.meta.status != '200') {
                      return Center(
                        child: Text(result.meta.message ?? 'Assessment not found'),
                      );
                    }

                    return Column(
                      children: [

                        Divider(color: Colors.grey),
                        Container(
                          width: double.infinity,
                          margin:
                          EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                          child: Text(
                            "Past Assessment Result",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Expanded(
                          flex: 9,
                          child: ListView.builder(
                              itemCount: result.assessmentsResultList.length,
                              itemBuilder: (BuildContext context, int index) {
                                AssessmentResultList _assessmentResult =
                                result.assessmentsResultList[index];
                                return Container(
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children:
                                  homewidget( result.assessmentsResultList[index].assessmentId)

                                ),
                                    children: [Column(
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 12, right: 12),
                                          child: Row(
                                            children: [

                                              Expanded(
                                                  flex: 8,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                     // Column(children: homewidget( result.assessmentsResultList[index].assessmentId),),
                                                    // Text([index]['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),maxLines: 2,),
                                                      Text(
                                                          (DateFormat("yyyy-MM-dd HH:mm:ss")
                                                              .parse(_assessmentResult.created_at, true)
                                                              .toLocal()
                                                              .toString()
                                                              .substring(0, 16))),
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        _downloadPdf(_assessmentResult.assessment_result_id,"download");
                                                      },
                                                      child:
                                                      Icon(Icons.download_rounded))),
                                              Expanded(flex: 1, child: GestureDetector(
                                                  onTap: (){
                                                    _downloadPdf(_assessmentResult.assessment_result_id,"Share");
                                                  },
                                                  child: Icon(Icons.share))),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(15),
                                          width: MediaQuery.of(context).size.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/bg/Frame.png",
                                                  ),
                                                  fit: BoxFit.fitWidth)),
                                          child: Center(
                                              child: Text(
                                                result.resultList[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                        ),
                                      ],
                                    )],
                                  ),
                                ));
                              }),
                          /*ListView(
                    children: result.assessmentsResultList
                        .map((e) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 8, child: Text((DateFormat("yyyy-MM-dd HH:mm:ss").parse(e.created_at, true).toLocal().toString().substring(0,16)))),
                                    Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                            onTap: () {

                                            },
                                            child: Icon(Icons.download_rounded))),
                                    Expanded(
                                        flex: 1, child: Icon(Icons.share)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/bg/Frame.png",
                                        ),
                                        fit: BoxFit.fitWidth)),
                                child: Center(
                                    child: Text(
                                      "You Can Handel Stress work \nat well!!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ),
                            ],
                          ),
                        )))
                        .toList(),
                  )*/
                        ),
                      ],
                    );
                  },
                ),
              ),
              /* Column(
                children: [
                  Text(
                    "Past Assessment Results",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder<GetAssessmentsResponseModel>(
                      future: GetAssessmentsRepo.getAssessment(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Server Error'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        GetAssessmentsResponseModel result = snapshot.data;
                        if (result.meta.status != '200') {
                          return Center(
                            child: Text(
                                result.meta.message ?? 'Assessment not found'),
                          );
                        }
                        return ListView(
                          children: result.assessments
                              .map((e) =>
                              GestureDetector(
                                onTap: () {
                                  Get.to(AssessmentInstruction(
                                    data: e,
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      e.title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.normal),
                                    ),
                                    Text("16/03/21"),
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              8.0),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/bg/Frame.png",
                                              ),
                                              fit: BoxFit.fitWidth)),
                                      child: Center(
                                          child: Text(
                                            "You Can Handel Stress work \nat well!!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                    ),
                                  ],
                                ) */ /*Container(
                                      height: 170,
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  imgBasePath + e.photo),
                                              fit: BoxFit.fill),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius: BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                    )*/ /*
                                ,
                              ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),*/
            ],
          )),
    );
  }
  List<Widget> homewidget(assesmentid) {
  print("hsdibakcd"+assesmentresult[assesmentid].length.toString());
    List<Widget> homitemlist = new List();
    for (int i = 0; i < assesmentresult[assesmentid].length; i++) {
      homitemlist.add(
        Text(
            assesmentresult[assesmentid][i]['title'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
        )
      );
    }
return homitemlist;
}
  _downloadPdf(invoiceId,type) async{
    Dialogs.showLoadingDialog(context, loginLoader);
    Welcome pdfDownload =await AssesDownloadPdfRepo.downloadPdf(invoiceId);
    print(pdfDownload.pdfName+pdfDownload.mediaUrl);
    await _fileWriteCode(pdfDownload,type);
  }
  _fileWriteCode(Welcome pdfDownload,type) async{
    String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    Random random = new Random();
    String fullPath = "$path/${random.nextInt(10000)}.pdf";
    var dio = Dio();
    await download(dio,pdfDownload.mediaUrl+pdfDownload.pdfName, fullPath,type);
  }
  Future download(Dio dio, String url, String savePath,type) async {
    print(url);
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      if((response.data as List).isNotEmpty) {
        File file = File(savePath);
        // var raf = file.openSync(mode: FileMode.write);//
        // response.data is List<int> type
        // raf.writeFromSync(response.data);
        print(response.data);
        Navigator.of(loginLoader.currentContext, rootNavigator: true)
            .pop();
        setState(() {
          sharelink=url;
        });

        type=="Share"?  share():Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfView(url: url,)));

        // toast("File Downloaded , Please check in File manager");
        //await raf.close();
      }

    } catch (e) {
      print(e);
    }
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  Future<void> share() async {
    _shareImageFromUrl();
    //   await FlutterShare.share(
    //       title: 'My Invoice From SAL',
    //       text: 'My Invoice From SAL',
    //       linkUrl: sharelink,
    //       chooserTitle: 'Invoice Share');
    // }
  }
  Future<void> _shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          sharelink));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('SAL Invoice', 'Result.pdf', bytes, 'document/pdf');
    } catch (e) {
      print('error: $e');
    }
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
