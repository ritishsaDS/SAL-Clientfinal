

//"https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/agoratoken?appointment_id=bem1njo3cjg7&session=1&type=1"
import 'package:sal_user/models/GetAgoraToken.dart';
import 'package:http/http.dart' as http;
import 'package:sal_user/data/repo/CallAgora.dart';
class AgoraRepo {
  static Future<GetAgoraToken> getAgoraToken(String appointmentId, String session, String type) async {
    String url = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/agoratoken?appointment_id=$appointmentId&session=$session&type=$type';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return getAgoraTokenModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  static Future<CallAgora> startCallAgora(String appointmentId) async {
    String url = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/start?appointment_id=$appointmentId';
    try {
      http.Response response = await http.put(url);
      if (response.statusCode == 200) {
        return getCallAgoraFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<CallAgora> endCallAgora(String appointmentId) async {
    String url = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/end?appointment_id=$appointmentId';
    try {
      http.Response response = await http.put(url);
      if (response.statusCode == 200) {
        return getCallAgoraFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}