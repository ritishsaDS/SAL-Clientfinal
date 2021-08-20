import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/models/getTherapistDetailModal.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetTherapistDetailRepo extends BaseRepository {

  Future<GetCounsellor> bookAppointment({String therapistId,
    BuildContext context,
  }) async {
    var body = {

        "appointment_slot_id": "kqd66abcsx",
        "date": "2021-08-26",
        "time": "08:00",
      };


    final uri = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment';

    var response = await Dio().post(uri,data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      if (response.data != null) {
        final passEntity = GetCounsellor.fromJson(response.data);
        print(therapistId);
        return passEntity;

      } else {
        return GetCounsellor(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}

