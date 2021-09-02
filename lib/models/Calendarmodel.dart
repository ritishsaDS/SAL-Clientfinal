// To parse this JSON data, do
//
//     final calendarmodel = calendarmodelFromJson(jsonString);

import 'dart:convert';

Calendarmodel calendarmodelFromJson(String str) => Calendarmodel.fromJson(json.decode(str));

String calendarmodelToJson(Calendarmodel data) => json.encode(data.toJson());

class Calendarmodel {
  Calendarmodel({
    this.meta,
    this.moodResults,
  });

  Meta meta;
  List<MoodResult> moodResults;

  factory Calendarmodel.fromJson(Map<String, dynamic> json) => Calendarmodel(
    meta: Meta.fromJson(json["meta"]),
    moodResults: List<MoodResult>.from(json["mood_results"].map((x) => MoodResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "mood_results": List<dynamic>.from(moodResults.map((x) => x.toJson())),
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

class MoodResult {
  MoodResult({
    this.date,
    this.moodId,
  });

  DateTime date;
  String moodId;

  factory MoodResult.fromJson(Map<String, dynamic> json) => MoodResult(
    date: DateTime.parse(json["date"]),
    moodId: json["mood_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "mood_id": moodId,
  };
}
