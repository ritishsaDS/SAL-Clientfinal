import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/models/getTherapistDetailModal.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Addmoodrepo extends BaseRepository {

   addmood({String therapistId,
    BuildContext context,moodid
  }) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    var body = {

      "age": "20",
      "client_id": prefs.getString("cleintid"),
      "date": DateTime.now().toString().substring(0,10),
      "gender": "Male",
      "mood_id": moodid,
      "name": prefs.getString("name"),

      "phone":  prefs.getString("phone"),
    };


    final uri = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/mood';
print(jsonEncode(body));
    var response = await Dio().post(uri,data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print('RESPONSE:${response.data}');
      if(response.statusCode=="200"){
        if (response.data != null) {
          print(response.data);
          final passEntity = GetCounsellor.fromJson(response.data);
          print(passEntity);
          return passEntity;

        }
      }

      else {
        return GetCounsellor(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}

