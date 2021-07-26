import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/data/api/ApiEndPoint.dart';
import 'package:sal_user/models/sendOtpModel.dart';


class SendOtptoPhoneRepo extends BaseRepository {


  Future<SendOtp> sendOtp({String phone,
  BuildContext context,
  }) async {
    final uri = '${ApiEndpoint.BaseUrl + ApiEndpoint.sendOtp}';
    var response = await Dio().get(uri,
        queryParameters:
             {'phone': phone, },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },

          followRedirects: false,
        ));
    try {
      if (response.data != null) {
        final passEntity = SendOtp.fromJson(response.data);
        return passEntity;
      } else {
        return SendOtp(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}
