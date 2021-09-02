// To parse this JSON data, do
//
//     final avalableeventModel = avalableeventModelFromJson(jsonString);

import 'dart:convert';

AvalableeventModel avalableeventModelFromJson(String str) => AvalableeventModel.fromJson(json.decode(str));

String avalableeventModelToJson(AvalableeventModel data) => json.encode(data.toJson());

class AvalableeventModel {
  AvalableeventModel({
    this.events,
    this.meta,
  });

  List<Event> events;
  Meta meta;

  factory AvalableeventModel.fromJson(Map<String, dynamic> json) => AvalableeventModel(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Event {
  Event({
    this.actualAmount,
    this.counsellorId,
    this.createdAt,
    this.createdBy,
    this.date,
    this.description,
    this.duration,
    this.id,
    this.invoiceId,
    this.modifiedAt,
    this.modifiedBy,
    this.orderId,
    this.paidAmount,
    this.paidAmountRazorpay,
    this.photo,
    this.price,
    this.status,
    this.tax,
    this.time,
    this.title,
    this.topicId,
    this.type,
  });

  String actualAmount;
  String counsellorId;
  DateTime createdAt;
  String createdBy;
  DateTime date;
  String description;
  String duration;
  String id;
  String invoiceId;
  DateTime modifiedAt;
  String modifiedBy;
  String orderId;
  String paidAmount;
  String paidAmountRazorpay;
  String photo;
  String price;
  String status;
  String tax;
  String time;
  String title;
  String topicId;
  String type;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    actualAmount: json["actual_amount"],
    counsellorId: json["counsellor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    date: DateTime.parse(json["date"]),
    description: json["description"],
    duration: json["duration"],
    id: json["id"],
    invoiceId: json["invoice_id"],
    modifiedAt: DateTime.parse(json["modified_at"]),
    modifiedBy: json["modified_by"],
    orderId: json["order_id"],
    paidAmount: json["paid_amount"],
    paidAmountRazorpay: json["paid_amount_razorpay"],
    photo: json["photo"],
    price: json["price"],
    status: json["status"],
    tax: json["tax"],
    time: json["time"],
    title: json["title"],
    topicId: json["topic_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "actual_amount": actualAmount,
    "counsellor_id": counsellorId,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "description": description,
    "duration": duration,
    "id": id,
    "invoice_id": invoiceId,
    "modified_at": modifiedAt.toIso8601String(),
    "modified_by": modifiedBy,
    "order_id": orderId,
    "paid_amount": paidAmount,
    "paid_amount_razorpay": paidAmountRazorpay,
    "photo": photo,
    "price": price,
    "status": status,
    "tax": tax,
    "time": time,
    "title": title,
    "topic_id": topicId,
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
