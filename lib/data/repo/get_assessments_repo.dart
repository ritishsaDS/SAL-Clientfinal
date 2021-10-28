import 'package:sal_user/models/get_assessments_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetAssessmentsRepo {
  static Future<GetAssessmentsResponseModel> getAssessment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String clientId = pref.getString('cleintid');
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
}
