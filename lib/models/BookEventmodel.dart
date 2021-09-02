// To parse this JSON data, do
//
//     final bookeventmodel = bookeventmodelFromJson(jsonString);

import 'dart:convert';

Bookeventmodel bookeventmodelFromJson(String str) => Bookeventmodel.fromJson(json.decode(str));

String bookeventmodelToJson(Bookeventmodel data) => json.encode(data.toJson());

class Bookeventmodel {
  Bookeventmodel({
    this.couponCode,
    this.eventOrderId,
    this.userId,
  });

  String couponCode;
  String eventOrderId;
  String userId;

  factory Bookeventmodel.fromJson(Map<String, dynamic> json) => Bookeventmodel(
    couponCode: json["coupon_code"],
    eventOrderId: json["event_order_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_code": couponCode,
    "event_order_id": eventOrderId,
    "user_id": userId,
  };
}
