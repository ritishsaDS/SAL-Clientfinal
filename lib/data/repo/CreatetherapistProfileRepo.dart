import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/UI/Myprofile.dart';
import 'package:sal_user/UI/Professionalinfo.dart';
import 'package:sal_user/base/BaseRepository.dart';
import 'package:sal_user/data/api/ApiHitter.dart';
import 'package:sal_user/models/CreateTherapistprofilemodel.dart';


class CreateTherapistProfileRepo extends BaseRepository {

  Future<CreateTherapistProfileModal> createCounsellor({
    String age,
    BuildContext context,
String timezone,
    String device_id,
    String location,
    String email,
    String experience,
    String first_name,
    String gender,
    String last_name,
    String phone,
  }) async {
    print('BODY:${{
      "age": age,
      "device_id": device_id,
      "email": email,
      "first_name": first_name,
      "gender": gender,
      "last_name": last_name,
      "location": location,
      "phone": phone,
      "timezone": "UTC+5:30",
      "topic_ids":selectedInterestListid.toString().replaceAll("]", "").replaceAll("[", "")
    }}');
    ApiResponse apiResponse = await apiHitter
        .getPostApiResponse("https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client",
        context: context, headers: {
          "Content-Type": "application/json",
          "accept": "application/json"
        },
        data: {
          "age": age,
          "device_id": device_id,
          "email": email,
          "first_name": first_name,
          "gender": gender,
          "last_name": last_name,
          "location": location,
          "phone": phone,
          "timezone": "UTC+5:30",
          "topic_ids":selectedInterestListid.toString().replaceAll("]", "").replaceAll("[", "")
        }

        );
    {
      try {
        print('SUCCESS:${apiResponse.status}');
        if (apiResponse.status) {
          print('RESPONSE:${apiResponse.response.data}');
          final passEntity = CreateTherapistProfileModal.fromJson(apiResponse.response.data);
          return passEntity;
        } else {
          return CreateTherapistProfileModal(meta: apiResponse.response.data);
        }
      } catch (error, stacktrace) {
        return CreateTherapistProfileModal();
      }
    }
  }

}
