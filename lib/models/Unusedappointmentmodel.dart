// To parse this JSON data, do
//
//     final unusedappointmodel = unusedappointmodelFromJson(jsonString);

import 'dart:convert';

Unusedappointmodel unusedappointmodelFromJson(String str) => Unusedappointmodel.fromJson(json.decode(str));

String unusedappointmodelToJson(Unusedappointmodel data) => json.encode(data.toJson());

class Unusedappointmodel {
  Unusedappointmodel({
    this.appointmentSlots,
    this.counsellors,
    this.mediaUrl,
    this.meta,
  });

  List<AppointmentSlot> appointmentSlots;
  Counsellors counsellors;
  String mediaUrl;
  Meta meta;

  factory Unusedappointmodel.fromJson(Map<String, dynamic> json) => Unusedappointmodel(
    appointmentSlots: List<AppointmentSlot>.from(json["appointment_slots"].map((x) => AppointmentSlot.fromJson(x))),
    counsellors: Counsellors.fromJson(json["counsellors"]),
    mediaUrl: json["media_url"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "appointment_slots": List<dynamic>.from(appointmentSlots.map((x) => x.toJson())),
    "counsellors": counsellors.toJson(),
    "media_url": mediaUrl,
    "meta": meta.toJson(),
  };
}

class AppointmentSlot {
  AppointmentSlot({
    this.appointmentSlotId,
    this.clientId,
    this.counsellorId,
    this.createdAt,
    this.createdBy,
    this.id,
    this.modifiedAt,
    this.modifiedBy,
    this.orderId,
    this.slotsBought,
    this.slotsRemaining,
    this.status,
  });

  String appointmentSlotId;
  String clientId;
  String counsellorId;
  DateTime createdAt;
  String createdBy;
  String id;
  String modifiedAt;
  String modifiedBy;
  String orderId;
  String slotsBought;
  String slotsRemaining;
  String status;

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) => AppointmentSlot(
    appointmentSlotId: json["appointment_slot_id"],
    clientId: json["client_id"],
    counsellorId: json["counsellor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    id: json["id"],
    modifiedAt: json["modified_at"],
    modifiedBy: json["modified_by"],
    orderId: json["order_id"],
    slotsBought: json["slots_bought"],
    slotsRemaining: json["slots_remaining"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_slot_id": appointmentSlotId,
    "client_id": clientId,
    "counsellor_id": counsellorId,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "id": id,
    "modified_at": modifiedAt,
    "modified_by": modifiedBy,
    "order_id": orderId,
    "slots_bought": slotsBought,
    "slots_remaining": slotsRemaining,
    "status": status,
  };
}

class Counsellors {
  Counsellors({
    this.ab4Tyku62T,
  });

  Ab4Tyku62T ab4Tyku62T;

  factory Counsellors.fromJson(Map<String, dynamic> json) => Counsellors(
    ab4Tyku62T: Ab4Tyku62T.fromJson(json["ab4tyku62t"]),
  );

  Map<String, dynamic> toJson() => {
    "ab4tyku62t": ab4Tyku62T.toJson(),
  };
}

class Ab4Tyku62T {
  Ab4Tyku62T({
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

  factory Ab4Tyku62T.fromJson(Map<String, dynamic> json) => Ab4Tyku62T(
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
