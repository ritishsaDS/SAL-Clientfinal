import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notificationModal.dart';



class NotificationRepo extends BaseRepository {

  Future<NotificationModal> notificationRepo(
    BuildContext context,
  ) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    final uri = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/notification?therapist_id=${prefs.getString("cleintid")}';
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      if (response.data != null) {
        final passEntity = NotificationModal.fromJson(response.data);
        return passEntity;
      } else {
        return NotificationModal(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}

