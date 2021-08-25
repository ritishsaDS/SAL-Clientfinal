// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Appointmentbook paymentFromJson(String str) => Appointmentbook.fromJson(json.decode(str));

String paymentToJson(Appointmentbook data) => json.encode(data.toJson());

class Appointmentbook {
  Appointmentbook({
    this.appointments,
    this.counsellors,
    this.mediaUrl,
    this.meta,
  });

  List<Appointment> appointments;
  Map<String, Counsellor> counsellors;
  String mediaUrl;
  Meta meta;

  factory Appointmentbook.fromJson(Map<String, dynamic> json) => Appointmentbook(
    appointments: List<Appointment>.from(json["appointments"].map((x) => Appointment.fromJson(x))),
    counsellors: Map.from(json["counsellors"]).map((k, v) => MapEntry<String, Counsellor>(k, Counsellor.fromJson(v))),
    mediaUrl: json["media_url"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "appointments": List<dynamic>.from(appointments.map((x) => x.toJson())),
    "counsellors": Map.from(counsellors).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "media_url": mediaUrl,
    "meta": meta.toJson(),
  };
}

class Appointment {
  Appointment({
    this.appointmentId,
    this.cancellationReason,
    this.clientId,
    this.comment,
    this.counsellorId,
    this.createdAt,
    this.createdBy,
    this.date,
    this.id,
    this.modifiedAt,
    this.modifiedBy,
    this.orderId,
    this.rating,
    this.ratingComment,
    this.ratingTypes,
    this.status,
    this.time,
    this.timesRescheduled,
  });

  String appointmentId;
  String cancellationReason;
  String clientId;
  String comment;
  String counsellorId;
  DateTime createdAt;
  String createdBy;
  DateTime date;
  String id;
  String modifiedAt;
  String modifiedBy;
  String orderId;
  String rating;
  String ratingComment;
  String ratingTypes;
  String status;
  String time;
  String timesRescheduled;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    appointmentId: json["appointment_id"],
    cancellationReason: json["cancellation_reason"],
    clientId: json["client_id"],
    comment: json["comment"],
    counsellorId: json["counsellor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    date: DateTime.parse(json["date"]),
    id: json["id"],
    modifiedAt: json["modified_at"],
    modifiedBy: json["modified_by"],
    orderId: json["order_id"],
    rating: json["rating"],
    ratingComment: json["rating_comment"],
    ratingTypes: json["rating_types"],
    status: json["status"],
    time: json["time"],
    timesRescheduled: json["times_rescheduled"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId,
    "cancellation_reason": cancellationReason,
    "client_id": clientId,
    "comment": comment,
    "counsellor_id": counsellorId,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "id": id,
    "modified_at": modifiedAt,
    "modified_by": modifiedBy,
    "order_id": orderId,
    "rating": rating,
    "rating_comment": ratingComment,
    "rating_types": ratingTypes,
    "status": status,
    "time": time,
    "times_rescheduled": timesRescheduled,
  };
}

class Counsellor {
  Counsellor({
    this.firstName,
    this.id,
    this.lastName,
    this.photo,
    this.type,
  });

  String firstName;
  String id;
  String lastName;
  String photo;
  String type;

  factory Counsellor.fromJson(Map<String, dynamic> json) => Counsellor(
    firstName: json["first_name"],
    id: json["id"],
    lastName: json["last_name"],
    photo: json["photo"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "id": id,
    "last_name": lastName,
    "photo": photo,
    "type": type,
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
