import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/models/Calendarmodel.dart';
import 'package:sal_user/models/forYouResponseModel.dart';
import 'package:sal_user/models/bookedappointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calendarrepo extends BaseRepository {
  Future<Calendarmodel> upcomingAppointmentRepo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Client Id :${prefs.getString("cleintid")}');
    String clientId = prefs.getString("cleintid") ?? 'demo';
    DateTime now = DateTime.now();

    String monthStartDate =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));

    String monthEndDate =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 1, 0));

    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/mood/history?client_id=$clientId&dates=$monthStartDate%2C$monthEndDate';
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print('Get Mood History Response :${response.data}');
      if (response.statusCode == 200) {
        final passEntity = Calendarmodel.fromJson(response.data);

        return passEntity;
      } else {
        return null;
      }
    } catch (error) {
      print('ERROR :$error');
      return null;
    }
  }

  Future<ForYouResponse> forYouRepo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Client Id :${prefs.getString("cleintid")}');
    String clientId = prefs.getString("cleintid") ?? 'demo';

    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/home?client_id=$clientId';
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print('Get FOR YOU Response :${response.data}');
      if (response.statusCode == 200) {
        final passEntity = ForYouResponse.fromJson(response.data);

        return passEntity;
      } else {
        return null;
      }
    } catch (error) {
      print('get for you ERROR :$error');
      return null;
    }
  }
}
