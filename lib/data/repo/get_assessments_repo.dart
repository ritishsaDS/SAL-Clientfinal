import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sal_user/UI/Assessment2.dart';
import 'package:sal_user/models/get_assessment_result_response_model.dart';
import 'package:sal_user/models/get_assessments_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sal_user/models/get_assessment_result_response_model.dart';
import 'package:sal_user/models/Getresultresponse.dart';

class GetAssessmentsRepo {
  static Future<GetAssessmentsResponseModel> getAssessment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String clientId = pref.getString('cleintid');
    print("gsdgdggdgdg${clientId}");
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/assessments?client_id=$clientId';
    // String url =
    //     'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/assessments';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return getAssessmentsResponseModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<GetAssessmentsResultsResponseModel> getAssessmentResult() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String clientId = pref.getString('cleintid');
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/assessment/history?client_id=$clientId';
    // String url =
    //
    //     'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/assessments';
   print(url);
   dynamic respnsejson=new List();
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        respnsejson=json.decode(response.body);
        assesmentresult=respnsejson['assessment'];
        print(assesmentresult);
        return getAssessmentsResultsResponseModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
