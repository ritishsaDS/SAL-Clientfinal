import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sal_user/Utils/Colors.dart';

var getBusinessValue;

class ActionSheet {
  static Widget actionSheet({Function onCameraTap,Function onGalleryTap}) {
    return CupertinoActionSheet(
      title: Text(
        'Select Profile Pic',
        style: secondaryTextStyle(),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: onCameraTap,
          child: Text('Camera', style: primaryTextStyle(size: 18)),
          isDefaultAction: true,
        ),
        CupertinoActionSheetAction(
          onPressed: onGalleryTap,
          child: Text('Gallery', style: primaryTextStyle(size: 18)),
          isDefaultAction: true,
        ),
        // type != "profile"
        //     ? CupertinoActionSheetAction(
        //         onPressed: () {
        //           onDocument();
        //           finish(context);
        //         },
        //         child: Text('Documents', style: primaryTextStyle(size: 18)),
        //         isDefaultAction: true,
        //       )
        //     : SizedBox(),
      ],
      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style:
                primaryTextStyle(color: Color(backgroundColorBlue), size: 18),
          )),
    );
  }
}
