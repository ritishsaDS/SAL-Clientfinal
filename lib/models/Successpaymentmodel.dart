// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    this.orderId,
    this.paymentId,
    this.paymentMethod,
  });

  String orderId;
  String paymentId;
  String paymentMethod;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    orderId: json["order_id"],
    paymentId: json["payment_id"],
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "payment_id": paymentId,
    "payment_method": paymentMethod,
  };
}
