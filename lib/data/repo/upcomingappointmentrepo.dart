import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/models/bookedappointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingAppointmentRepo extends BaseRepository {
  Future<Appointmentbook> upcomingAppointmentRepo(
      BuildContext context,
      ) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
   print( prefs.getString("cleintid"));
    final uri = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/upcoming?client_id=${prefs.getString("cleintid")}';
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print("hweinnowen");
      print(response.data);
      if (response.data != null) {
        final passEntity = Appointmentbook.fromJson(response.data);
        return passEntity;
      } else {
        return Appointmentbook(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}

