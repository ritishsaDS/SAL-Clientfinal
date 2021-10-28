// To parse this JSON data, do
//
//     final verifyOtpModal = verifyOtpModalFromJson(jsonString);

import 'dart:convert';

VerifyOtpModal verifyOtpModalFromJson(String str) => VerifyOtpModal.fromJson(json.decode(str));

String verifyOtpModalToJson(VerifyOtpModal data) => json.encode(data.toJson());

class VerifyOtpModal {
  VerifyOtpModal({
    this.accessToken,
    this.client,
    this.mediaUrl,
    this.meta,
    this.refreshToken,
  });

  String accessToken;
  Therapist client;
  String mediaUrl;
  Meta meta;
  String refreshToken;

  factory VerifyOtpModal.fromJson(Map<String, dynamic> json) => VerifyOtpModal(
    accessToken: json["access_token"],
    client: Therapist.fromJson(json["client"]),
    mediaUrl: json["media_url"],
    meta: Meta.fromJson(json["meta"]),
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "client": client.toJson(),
    "media_url": mediaUrl,
    "meta": meta.toJson(),
    "refresh_token": refreshToken,
  };
}

class Therapist {
  Therapist({
    this.clientId,
    this.createdAt,
    this.createdBy,
    this.dateOfBirth,
    this.deviceId,
    this.email,
    this.firstName,
    this.gender,
    this.id,
    this.lastLoginTime,
    this.lastName,
    this.location,
    this.modifiedAt,
    this.modifiedBy,
    this.phone,
    this.photo,
    this.status,
    this.timezone,
    this.topicIds,
  });

  String clientId;
  DateTime createdAt;
  String createdBy;
  String dateOfBirth;
  String deviceId;
  String email;
  String firstName;
  String gender;
  String id;
  DateTime lastLoginTime;
  String lastName;
  String location;
  String modifiedAt;
  String modifiedBy;
  String phone;
  String photo;
  String status;
  String timezone;
  String topicIds;

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
    clientId: json["client_id"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    dateOfBirth: json["date_of_birth"],
    deviceId: json["device_id"],
    email: json["email"],
    firstName: json["first_name"],
    gender: json["gender"],
    id: json["id"],
    lastLoginTime: DateTime.parse(json["last_login_time"]),
    lastName: json["last_name"],
    location: json["location"],
    modifiedAt: json["modified_at"],
    modifiedBy: json["modified_by"],
    phone: json["phone"],
    photo: json["photo"],
    status: json["status"],
    timezone: json["timezone"],
    topicIds: json["topic_ids"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "date_of_birth": dateOfBirth,
    "device_id": deviceId,
    "email": email,
    "first_name": firstName,
    "gender": gender,
    "id": id,
    "last_login_time": lastLoginTime.toIso8601String(),
    "last_name": lastName,
    "location": location,
    "modified_at": modifiedAt,
    "modified_by": modifiedBy,
    "phone": phone,
    "photo": photo,
    "status": status,
    "timezone": timezone,
    "topic_ids": topicIds,
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
