import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/data/repo/get_assessments_repo.dart';
import 'package:sal_user/models/get_assessments_response_model.dart';
import 'package:sal_user/models/Getresultresponse.dart';

class AssessmentResultScreen extends StatefulWidget {
  Assessment assessment;

  AssessmentResultScreen({Key key, this.assessment}) : super(key: key);

  @override
  _AssessmentResultScreenState createState() => _AssessmentResultScreenState();
}

class _AssessmentResultScreenState extends State<AssessmentResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
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
                Container(
                  margin: EdgeInsets.only(left: 14, right: 12),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: Text(
                            widget.assessment.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                      Expanded(flex: 1, child: Icon(Icons.download_rounded)),
                      Expanded(flex: 1, child: Icon(Icons.share)),
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
                          image: NetworkImage(
                            'https://sal-prod.s3.ap-south-1.amazonaws.com/' +
                                widget.assessment.photo,
                          ),
                          fit: BoxFit.fitWidth)),
                ),
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
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                      itemCount: result.assessmentsResultList.length,
                      itemBuilder: (BuildContext context, int index) {
                        AssessmentResultList _assessmentResult =
                        result.assessmentsResultList[index];
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                            (DateFormat("yyyy-MM-dd HH:mm:ss")
                                                .parse(_assessmentResult.created_at, true)
                                                .toLocal()
                                                .toString()
                                                .substring(0, 16)))),
                                    Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                            onTap: () {},
                                            child:
                                            Icon(Icons.download_rounded))),
                                    Expanded(flex: 1, child: Icon(Icons.share)),
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
                          ),
                        );
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
    );
  }

/*Future<void> createPdf(AssessmentResultList assessmentResultList) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics
        .drawString("Result", PdfStandardFont(PdfFontFamily.helvetica, 30));
    page.graphics.drawString(
        "\r\r\rName    :    ${assessmentResultList.name}\r\rAge    :    ${assessmentResultList.age}\r\rGender    :    ${assessmentResultList.gender}\r\rFinalScore    :    ${assessmentResultList.final_score}",
        PdfStandardFont(PdfFontFamily.helvetica, 20));

    List<int> bytes = document.save();
    document.dispose();
    saveAndopen(bytes, "Output.pdf");
  }

  Future<void> saveAndopen(List<int> bytes, String filename) async {
    final path = (await getExternalStorageDirectory()).path;
    final file = File("$path/$filename");
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open("$path/$filename");
  }*/
}
// To parse this JSON data, do
//
//     final getAssessmentsResultResponseModel = getAssessmentsResultResponseModelFromJson(jsonString);
