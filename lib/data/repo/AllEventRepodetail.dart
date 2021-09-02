import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/models/AllAssesmentmodel.dart';
import 'package:sal_user/models/AllEventsdetailmodel.dart';
import 'package:sal_user/models/Availableeventmodel.dart';
import 'package:sal_user/models/bookedappointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllEventdetailrepo extends BaseRepository {
  Future<AllEventsdetailmodel> upcomingAppointmentRepo(
      BuildContext context,
      id
      ) async {

    final uri = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/event?order_id=${id}';
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
        final passEntity = AllEventsdetailmodel.fromJson(response.data);
        return passEntity;
      } else {
        return AllEventsdetailmodel(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}

