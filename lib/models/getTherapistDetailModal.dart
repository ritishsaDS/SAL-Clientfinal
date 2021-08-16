// To parse this JSON data, do
//
//     final getCounsellor = getCounsellorFromJson(jsonString);

import 'dart:convert';

GetCounsellor getCounsellorFromJson(String str) => GetCounsellor.fromJson(json.decode(str));

String getCounsellorToJson(GetCounsellor data) => json.encode(data.toJson());

class GetCounsellor {
  GetCounsellor({
    this.counsellors,
    this.counsellorsCount,
    this.mediaUrl,
    this.meta,
    this.noPages,
    this.slots,
  });

  List<Counsellor> counsellors;
  String counsellorsCount;
  String mediaUrl;
  Meta meta;
  String noPages;
  Map<String, List<Slot>> slots;

  factory GetCounsellor.fromJson(Map<String, dynamic> json) => GetCounsellor(
    counsellors: List<Counsellor>.from(json["counsellors"].map((x) => Counsellor.fromJson(x))),
    counsellorsCount: json["counsellors_count"],
    mediaUrl: json["media_url"],
    meta: Meta.fromJson(json["meta"]),
    noPages: json["no_pages"],
    slots: Map.from(json["slots"]).map((k, v) => MapEntry<String, List<Slot>>(k, List<Slot>.from(v.map((x) => Slot.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "counsellors": List<dynamic>.from(counsellors.map((x) => x.toJson())),
    "counsellors_count": counsellorsCount,
    "media_url": mediaUrl,
    "meta": meta.toJson(),
    "no_pages": noPages,
    "slots": Map.from(slots).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
  };
}

class Counsellor {

  String about;
  String averageRating;
  String education;
  String experience;
  String firstName;
  String id;
  String lastName;
  String photo;
  String price;
  String slotType;
  String totalRating;
  String type;
  Counsellor({
    this.about,
    this.averageRating,
    this.education,
    this.experience,
    this.firstName,
    this.id,
    this.lastName,
    this.photo,
    this.price,
    this.slotType,
    this.totalRating,
    this.type,
  });

  factory Counsellor.fromJson(Map<String, dynamic> json) => Counsellor(
    about: json["about"],
    averageRating: json["average_rating"],
    education: json["education"],
    experience: json["experience"],
    firstName: json["first_name"],
    id: json["id"],
    lastName: json["last_name"],
    photo: json["photo"],
    price: json["price"],
    slotType: json["slot_type"],
    totalRating: json["total_rating"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "about": about,
    "average_rating": averageRating,
    "education": education,
    "experience": experience,
    "first_name": firstName,
    "id": id,
    "last_name": lastName,
    "photo": photo,
    "price": price,
    "slot_type": slotType,
    "total_rating": totalRating,
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

class Slot {
  Slot({
    this.the30,
    this.the41,
    this.date,
    this.the24,
    this.the39,
    this.the42,
  });

  String the30;
  String the41;
  DateTime date;
  String the24;
  String the39;
  String the42;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    the30: json["30"] == null ? null : json["30"],
    the41: json["41"] == null ? null : json["41"],
    date: DateTime.parse(json["date"]),
    the24: json["24"] == null ? null : json["24"],
    the39: json["39"] == null ? null : json["39"],
    the42: json["42"] == null ? null : json["42"],
  );

  Map<String, dynamic> toJson() => {
    "30": the30 == null ? null : the30,
    "41": the41 == null ? null : the41,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "24": the24 == null ? null : the24,
    "39": the39 == null ? null : the39,
    "42": the42 == null ? null : the42,
  };
}
