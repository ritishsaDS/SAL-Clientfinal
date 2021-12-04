// To parse this JSON data, do
//
//     final verify = verifyFromJson(jsonString);

import 'dart:convert';

Verify verifyFromJson(String str) => Verify.fromJson(json.decode(str));

String verifyToJson(Verify data) => json.encode(data.toJson());

class Verify {
  Verify({
    this.meta,
  });

  Meta meta;

  factory Verify.fromJson(Map<String, dynamic> json) => Verify(
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
  };
}

class Meta {
  Meta({
    this.message,
    this.messageType,
    this.status,
  });

  String message;
  String messageType;
  String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    message: json["message"],
    messageType: json["message_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "message_type": messageType,
    "status": status,
  };
}
