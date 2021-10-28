import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/models/AddMoodResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addmoodrepo extends BaseRepository {
  Future<AddMoodResponse> addmood(
      {String therapistId,
      BuildContext context,
      String moodid,
      String notes}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = {
      "age": "20",
      "client_id": prefs.getString("cleintid") ?? 'demo',
      "date": DateTime.now().toString().substring(0, 10),
      "gender": "Male",
      "mood_id": moodid,
      "notes": notes ?? "",
      "name": prefs.getString("name"),
      "phone": prefs.getString("phone"),
    };

    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/mood';
    print(jsonEncode(body));
    var response = await Dio().post(uri,
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print('RESPONSE:${response.data} ${response.statusCode}');
      if (response.statusCode == 200) {
        if (response.data != null) {
          final passEntity = AddMoodResponse.fromJson(response.data);
          print('res:$passEntity}');
          if (passEntity.meta.status == '200') {
            return passEntity;
          }
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      print('eor:$error');
      return null;
    }
  }
}
