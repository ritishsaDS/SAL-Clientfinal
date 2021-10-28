// To parse this JSON data, do
//
//     final addMoodResponse = addMoodResponseFromJson(jsonString);

import 'dart:convert';

AddMoodResponse addMoodResponseFromJson(String str) => AddMoodResponse.fromJson(json.decode(str));

String addMoodResponseToJson(AddMoodResponse data) => json.encode(data.toJson());

class AddMoodResponse {
  AddMoodResponse({
    this.meta,
    this.moodResultId,
  });

  Meta meta;
  String moodResultId;

  factory AddMoodResponse.fromJson(Map<String, dynamic> json) => AddMoodResponse(
    meta: Meta.fromJson(json["meta"]),
    moodResultId: json["mood_result_id"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "mood_result_id": moodResultId,
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
