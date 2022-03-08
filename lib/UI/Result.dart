import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/PdfRepo.dart';
import 'package:sal_user/models/get_assessment_result_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:sal_user/models/pdfdownload.dart';

import 'Home.dart';
import 'ViewPdf.dart';

class Result extends StatefulWidget {
  final String assessmentId;
  final String clientId;
  final String text;
   var time;
   var title;
   var resultid;

   Result({Key key,this.text,this.resultid,this.title,this.time, this.assessmentId, this.clientId}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var sharelink="";
  Future<GetAssessmentsResultResponseModel> getResult() async {
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/assessment/history?assessment_id=${widget.assessmentId}&client_id=${widget.clientId}';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        GetAssessmentsResultResponseModel result =
            getAssessmentsResultResponseModelFromJson(response.body);
        if (result.meta.status == '200') {
          return result;
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      print('Get Result ERROR :$e');
      return null;
    }
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
          "Result",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
        // actions: [
        //   Row(
        //     children: [
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         child: Image.asset(
        //           'assets/icons/download.png',
        //           height: SizeConfig.blockSizeVertical * 3,
        //         ),
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         child: Image.asset(
        //           'assets/icons/share.png',
        //           height: SizeConfig.blockSizeVertical * 3,
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
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

      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: MaterialButton(
          color: Color(0xff0066B3),
          height: 48,
          minWidth: Get.width,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeMain()));
            // postAssessment();
          },
          child: Text(
            'Done',
            style:
            TextStyle(color: Colors.white, letterSpacing: 0.5),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey),
            Container(
              margin: EdgeInsets.only(left: 14, right: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                      GestureDetector(
                        onTap: () async {
                          await _downloadPdf(widget.resultid,"download");
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/icons/download.png',
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _downloadPdf(widget.resultid,"Share");
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/icons/share.png',
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: SizeConfig.screenWidth,
                      height:
                      SizeConfig.screenHeight * 0.15,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                          SizeConfig.screenWidth *
                              0.05,
                          vertical: SizeConfig
                              .blockSizeVertical *
                              2),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig
                            .blockSizeHorizontal *
                            5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/bg/result tile.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        "${widget.text}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig
                                .blockSizeVertical *
                                3),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            // Container(
            //     width: SizeConfig.screenWidth,
            //     height: SizeConfig.screenHeight * 0.15,
            //     margin: EdgeInsets.symmetric(
            //         horizontal: SizeConfig.screenWidth * 0.05,
            //         vertical: SizeConfig.blockSizeVertical * 2),
            //     alignment: Alignment.center,
            //     padding: EdgeInsets.symmetric(
            //       horizontal: SizeConfig.blockSizeHorizontal * 5,
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       image: DecorationImage(
            //           image: AssetImage('assets/bg/result tile.png'),
            //           fit: BoxFit.cover),
            //     ),
            //     child: Text(
            //       "You can handle stress at work well!",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //           fontSize: SizeConfig.blockSizeVertical * 3),
            //       textAlign: TextAlign.center,
            //     )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(8),
            //       child: Image.asset(
            //         'assets/icons/download.png',
            //         height: SizeConfig.blockSizeVertical * 3,
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(8),
            //       child: Image.asset(
            //         'assets/icons/share.png',
            //         height: SizeConfig.blockSizeVertical * 3,
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   width: SizeConfig.screenWidth,
            //   margin: EdgeInsets.symmetric(
            //       horizontal: SizeConfig.screenWidth * 0.05,
            //       vertical: SizeConfig.blockSizeVertical),
            //   child: Text(
            //     "Past Assessment Result",
            //     style: TextStyle(
            //         color: Color(midnightBlue),
            //         fontWeight: FontWeight.w600,
            //         fontSize: SizeConfig.blockSizeVertical * 2.5),
            //   ),
            // ),
            // FutureBuilder<GetAssessmentsResultResponseModel>(
            //     future: getResult(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text('Server Error'),
            //         );
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       GetAssessmentsResultResponseModel result = snapshot.data;
            //       return Column(
            //         children: result.assessmentResults
            //             .map((e) => Container(
            //                   width: SizeConfig.screenWidth,
            //                   margin: EdgeInsets.symmetric(
            //                     horizontal: SizeConfig.screenWidth * 0.05,
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Theme(
            //                         data: Theme.of(context).copyWith(
            //                             dividerColor: Colors.transparent),
            //                         child: ExpansionTile(
            //                           title: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 DateFormat('dd/MM/yyy')
            //                                     .format(e.createdAt),
            //                                 style: TextStyle(
            //                                   color: Color(fontColorSteelGrey),
            //                                 ),
            //                               ),
            //                               Container(
            //                                 alignment: Alignment.center,
            //                                 height:
            //                                     SizeConfig.blockSizeVertical *
            //                                         3,
            //                                 margin: EdgeInsets.symmetric(
            //                                     horizontal: SizeConfig
            //                                             .blockSizeHorizontal *
            //                                         5),
            //                                 child: Image.asset(
            //                                   'assets/icons/dot.png',
            //                                   width: SizeConfig
            //                                       .blockSizeHorizontal,
            //                                 ),
            //                               ),
            //                               Text(
            //                                 DateFormat("yyyy-MM-dd HH:mm:ss").parse((e.createdAt).toString(), true).toLocal().toString().substring(0,16),
            //                                 style: TextStyle(
            //                                   color: Color(fontColorSteelGrey),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           children: [
            //                             Container(
            //                                 width: SizeConfig.screenWidth,
            //                                 height:
            //                                     SizeConfig.screenHeight * 0.15,
            //                                 margin: EdgeInsets.symmetric(
            //                                     horizontal:
            //                                         SizeConfig.screenWidth *
            //                                             0.05,
            //                                     vertical: SizeConfig
            //                                             .blockSizeVertical *
            //                                         2),
            //                                 alignment: Alignment.center,
            //                                 padding: EdgeInsets.symmetric(
            //                                   horizontal: SizeConfig
            //                                           .blockSizeHorizontal *
            //                                       5,
            //                                 ),
            //                                 decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(10),
            //                                   image: DecorationImage(
            //                                       image: AssetImage(
            //                                           'assets/bg/result tile.png'),
            //                                       fit: BoxFit.cover),
            //                                 ),
            //                                 child: Text(
            //                                   "${widget.text}",
            //                                   style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontWeight: FontWeight.w600,
            //                                       fontSize: SizeConfig
            //                                               .blockSizeVertical *
            //                                           3),
            //                                   textAlign: TextAlign.center,
            //                                 )),
            //                             // Row(
            //                             //   mainAxisAlignment:
            //                             //       MainAxisAlignment.end,
            //                             //   children: [
            //                             //     Container(
            //                             //       padding: EdgeInsets.all(8),
            //                             //       child: Image.asset(
            //                             //         'assets/icons/download.png',
            //                             //         height: SizeConfig
            //                             //                 .blockSizeVertical *
            //                             //             3,
            //                             //       ),
            //                             //     ),
            //                             //     Container(
            //                             //       padding: EdgeInsets.all(8),
            //                             //       child: Image.asset(
            //                             //         'assets/icons/share.png',
            //                             //         height: SizeConfig
            //                             //                 .blockSizeVertical *
            //                             //             3,
            //                             //       ),
            //                             //     ),
            //                             //   ],
            //                             // ),
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ))
            //             .toList(),
            //       );
            //     }),

            // Container(
            //   width: SizeConfig.screenWidth,
            //   margin: EdgeInsets.symmetric(
            //       horizontal: SizeConfig.screenWidth * 0.05,
            //       vertical: SizeConfig.blockSizeVertical),
            //   child: MaterialButton(
            //     onPressed: () {},
            //     height: SizeConfig.blockSizeVertical * 6,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     color: Color(backgroundColorBlue),
            //     child: Text(
            //       "Try Again",
            //       style: TextStyle(
            //           color: Colors.white, fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ));
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
      await Share.file('SAL Result', 'Result.pdf', bytes, 'document/pdf');
    } catch (e) {
      print('error: $e');
    }
  }

}
